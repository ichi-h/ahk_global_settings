#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

extern crate clipboard_win;
use clipboard_win::Clipboard;

use std::env;

fn main() {
    let args: Vec<String> = env::args().collect();
    
    let clipboard = &args[1];
    let input_key = &args[2].to_string();
    let before_left_clip = &args[3];

    println!("{:?}", args);
    // std::thread::sleep(std::time::Duration::from_secs(5));

    let cursor_pos = before_left_clip.chars().count() as usize;

    let both_ends = get_both_ends(input_key.to_string());

    let mut left_clip = clipboard.chars().take(cursor_pos).collect::<String>();
    left_clip = left_clip.chars().rev().collect::<String>();
    let mut right_clip = clipboard.chars().skip(cursor_pos).take(clipboard.chars().count()).collect::<String>();

    let right_clip_len = right_clip.chars().count() as usize;

    left_clip = trim_strings(left_clip, cursor_pos, &both_ends[0]);
    right_clip = trim_strings(right_clip, right_clip_len, &both_ends[1]);

    left_clip = left_clip.chars().rev().collect::<String>();

    let clipboard = left_clip + &*right_clip;

    Clipboard::new().unwrap().set_string(&*clipboard);
}

fn get_both_ends(input_key: String) -> [String; 2] {
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
    let mut res: String = "".to_string();

    for i in 0..end {
        if clipboard.chars().skip(i).take(1).collect::<String>() == *target {
            res = clipboard.chars().skip(i).take(clipboard.chars().count()).collect::<String>();
            break
        }
    }

    res
}
