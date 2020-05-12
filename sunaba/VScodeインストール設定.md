# VScode設定関連

### やりたいこと
* windows10でmarkdownを扱いたい
* VScodeを設定して、汎用性をあげるためにPDFで出力したい
* 設定を弄りすぎて戻し方が分からないから、設定をリセットしたい

### 目次
1. インストール
1. 日本語設定
1. markdown→PDF変換の拡張機能設定
1. アンインストール（初期化）

### 実施
1. インストール
    * [公式HP](https://code.visualstudio.com/)
    * →Windows x64/User Installer/Stableからインストール  
    　※insiderは最新機能を試したい人向け
1. 日本語設定
    * 参照：[Visual Studio Codeで日本語化する方法](https://qiita.com/nanamesincos/items/5c48ff88a4eeef0a8631)
    1. Visual Studio Codeを開く
    1. 上部メニュー viewを選択
    1. command palette を選択
    1. configure display languageを選択
    1. install additional laugageを選択
    1. 左に拡張言語パックが出てくるのでJapanese Language Pack for Visual Studio Codeを探してインストール
    1. すべてが終わったらVScodeを再起動する  
    （普通にポップアップが出てくるのでそれに従ってVScodeを再起動すればいい）
1. markdown→PDF変換の拡張機能設定
    1. 左下の歯車マークをクリック
    1. 「拡張機能」を選択
    1. 表示された上部の検索BOXに「Markdown PDF」で検索
    1. 作成者が「yzane」のものを選択してインストール  

    **※知っ得情報**  
    * PDF出力時に改ページを設定したい  
    →改ページ箇所に`<div style="page-break-before:always"></div>`を挿入

1. アンインストール（初期化）
    1. コントロールパネルから「VScode」をアンインストール
    1. `C:\Users\ユーザー名\.vscode`ディレクトリ（設定ディレクトリ）を削除
    1. 必要に応じて再インストール・再設定

