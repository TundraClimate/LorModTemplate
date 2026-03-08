# 最初に1度だけやること

## Dotnet cliのインストール

1. Microsoft公式からインストーラーをダウンロード→[https://dotnet.microsoft.com/download](https://dotnet.microsoft.com/download)。
2. ダウンロードしたインストーラーを実行し、利用規則に同意してインストール。
3. PCを再起動。

## env.batの編集

1. env.batを探して見つけ、メモ帳等お好みのテキストエディタで開く。実行ではなく、**編集**。
2. `ID`、`WORKSHOP_TITLE`、`WORKSHOP_DESC`、`WORKSHOP_THUMBNAIL`をそれぞれ好きな内容に編集する。
   1. ただし、`ID`は空白を含んではいけない。アルファベット以外の文字を含んでもいけない。
   2. ただし、`WORKSHOP_THUMBNAIL`は`Invitation/`からの相対パスを指定すること。(困ったら`\thumbnail.png`とすればよい。)

## init.batの実行

1. `init.bat`を探して見つけ、ダブルクリックで実行。もしくは右クリック→実行をクリック。
2. `--ALL TASK COMPLETE--`と表示されればよろしい。
   1. 代わりに`Error:`から始まる文章が出た場合、それはエラーメッセージであるので修正が必要。

# 使い方

`dev.bat`を実行すれば

- `.dll`の作成と再配置
- MODの読み込み

が自動で行われる。途中で実行を止めないように。  
実行が終了すれば、出てきたウィンドウは消してしまってもよろしい。(適当なキーを打ち込めば消える)

Library of RuinaをWith MODで起動する。利用可能なMODのリストに`WORKSHOP_TITLE`に指定した名前のMODが並んでいれば成功。
