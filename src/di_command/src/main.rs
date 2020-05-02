#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

/*
    # main.rs
    括弧内の文字を消す

    ## ライセンス
    Copyright (c) 2020 Ippee
    本アプリは GNU General Public License v2.0 の基で公開されています
    GitHub: https://github.com/ippee/AutoHotkeySettings/blob/master/LICENSE
*/

extern crate clipboard_win;
use clipboard_win::Clipboard;

use std::env;

fn main() {
    let args: Vec<String> = env::args().collect();
    
    let input_key = &args[1].to_string(); // diXの "X" を取得
    let cursor_pos = args[2].parse::<usize>().unwrap(); // カーソル位置を取得

    // println!("{:?}", args);
    // std::thread::sleep(std::time::Duration::from_secs(5));

    // let cursor_pos = before_left_clip.chars().count() as usize;

    let mut clipboard = String::new();
    Clipboard::new().unwrap().get_string(&mut clipboard).unwrap(); // クリップボードを取得

    let both_ends = get_both_ends(input_key.to_string()); // input_keyから両端のターゲットを取得

    // クリップボードをカーソル位置を基準として左右に分割する
    let mut left_clip = clipboard.chars().take(cursor_pos).collect::<String>();
    left_clip = left_clip.chars().rev().collect::<String>(); // 左端のターゲットを検索しやすいよう文字列を逆順にする
    let mut right_clip = clipboard.chars().skip(cursor_pos).take(clipboard.chars().count()).collect::<String>();

    let right_clip_len = right_clip.chars().count() as usize; // 右側のクリップボードの長さを取得

    // ターゲット内部の文字列を削除する
    left_clip = trim_strings(left_clip, cursor_pos, &both_ends[0]);
    right_clip = trim_strings(right_clip, right_clip_len, &both_ends[1]);

    left_clip = left_clip.chars().rev().collect::<String>(); // 逆順を元に戻す

    let clipboard = left_clip + &*right_clip; // 左右のクリップボードをくっつける

    Clipboard::new().unwrap().set_string(&*clipboard); // クリップボードに保存
}

fn get_both_ends(input_key: String) -> [String; 2] {
    // 両端のターゲットを取得する

    let list = match &*input_key {
        "34" => ["\"".to_string(), "\"".to_string()],
        "39" => ["'".to_string(), "'".to_string()],
        "41" => ['('.to_string(), ')'.to_string()],
        "62" => ["<".to_string(), ">".to_string()],
        "93" => ['['.to_string(), ']'.to_string()],
        "116" => ['>'.to_string(), '<'.to_string()],
        "125" => ['{'.to_string(), '}'.to_string()],
        _ => ["".to_string(), "".to_string()],
    };

    list
}

fn trim_strings(clipboard: String, end: usize, target: &String) -> String {
    // 片端のターゲットを取得し、そこより手前の文字列を削除する
    let mut res: String = "".to_string();

    for i in 0..end {
        if clipboard.chars().skip(i).take(1).collect::<String>() == *target {
            res = clipboard.chars().skip(i).take(clipboard.chars().count()).collect::<String>();
            break
        }
    }

    res
}
