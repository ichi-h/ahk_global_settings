# AutoHotkeySettings
AutoHotkeyでWindowsのショートカット周りを整える


## AutoHotkeyって何？
> AutoHotkeyはホットキーへの機能の割り当てなど常駐ソフトの作成に特化したスクリプトエンジン。多彩なコマンドが用意されており、GUIを持ったプログラムの作成も可能。  
> 任意のキーの割り当て変更、マクロ、ウインドウ操作 ...  
> オープンソースの簡易プログラム言語、Windows用フリーソフト。  

[AutoHotkey Wiki](http://ahkwiki.net/Top)  

**AutoHotkey** の使い方とか、細かい説明は割愛します  


## Windowsはショートカットの変更がしにくい
例えば、**Alt + F4** を変えたいと思ったとき  
ウィンドウを閉じるショートカットでありますが、AltからF4なんて手がかなりデカくないと届かないわけで、ぶっちゃけクソ不便です  
なので、別のショートカットに置き換えジャー！　としたいところなんですが、Windowsでこういう変更は基本的にできません  
（やろうと思えばできるらしいですが、レジストリいじったりしにゃならないそうでめんどい & 事故った時が怖い）

なんで、**AutoHotkey** を使って、楽にWindowsのショートカット周りを整えようぜっていうお話です


## 今回のセッティング
前提として、私の環境では諸事情で **CapsLockキー** を **AppsKey** （右クリックをキーボードでするやつ）に変更しています  
ソースコードに **AppsKey** と書いてあるやつは、キーの配置的に **CapsLock** を指しているのでご注意ください  

### main.ahk
下５つの.ahkを `Include` し、まとめて実行します  
ショートカットを作って、スタートアップに登録しておくと便利  

### general.ahk
基本的な動作のショートカットキーを決めます  

### apps.ahk
ショートカットキーでアプリを起動するための設定です  

### copy_path.ahk
**Ctrl + Shift + C** で選択したファイルや現在のフォルダーのパスをコピーします  

### terminal.ahk
**CapsLock + C** でGit Bushを起動します  
Git Bushを使う理由は、UNIX系コマンドを使用したいから  

### vim.ahk
vim風のコマンドを追加します


## 今後の予定
- Vim風コマンドの拡張・修正


## ライセンス
Copyright (c) 2020 Ippee  
本アプリは GNU General Public License v2.0 の基で公開されています

- https://github.com/ippee/AutoHotkeySettings/blob/master/LICENSE
- https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html
