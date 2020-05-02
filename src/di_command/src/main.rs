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
    
    let opt = &*args[1]; // 左右どちらかを選択するオプションの取得
    let input_key = &args[2]; // diXの "X" を取得

    // println!("{:?}", args);
    // std::thread::sleep(std::time::Duration::from_secs(5));

    let mut clipboard = String::new();
    {
        let clip_scope = &mut clipboard; // 借用
        Clipboard::new().unwrap().get_string(clip_scope).unwrap(); // クリップボードを取得
    }

    let mut target: usize = 0;
    match opt {
        "--left" => {
            clipboard = clipboard.chars().rev().collect::<String>(); // 左端のターゲットを検索しやすいよう文字列を逆順にする
            target = 0;
        },
        "--right" => {
            target = 1;
        },
        _ => {},
    };

    let mut clip_len: usize = 0;
    {
        let clip_scope = &mut clipboard; // 借用
        let clip_len_scope = &mut clip_len; // 借用

        *clip_len_scope = clip_scope.chars().count() as usize; // クリップボードの長さを取得
    }

    let both_ends = get_both_ends(input_key.to_string()); // input_keyから両端のターゲットを取得

    // ターゲット内部の文字列を削除する
    clipboard = trim_strings(clipboard, clip_len, &both_ends[target]);

    if opt == "--left" {
        clipboard = clipboard.chars().rev().collect::<String>(); // 逆順を元に戻す
    }

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
