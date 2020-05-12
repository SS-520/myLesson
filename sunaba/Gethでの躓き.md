* [Ethereum入門 - スマートコントラクトを作成し実行する](https://book.ethereum-jp.net/first_use/contract)に沿って
スマートコントラクトの作成実行中
* トランザクション・myContractの送信時にエラー発生
* プログラミング初心者の方がハマるエラーだと思われる

* エラー
  ```
  var myContract = contract.new({ from: eth.accounts[0], data: bin})
        Error: invalid argument 0: json: cannot unmarshal hex string without 0x prefix into Go struct field SendTxArgs.data of type hexutil.Bytes
            at web3.js:6347:37(47)
            at web3.js:5081:62(37)
            at web3.js:3021:48(134)
            at <eval>:1:30(13)
  ```
* エラー内容
  * `invalid argument 0`：引数0番目が無効  
  * `cannot unmarshal hex string`：16進文字列（hex string）のマーシャルを解除できない
  * `without 0x prefix`：固定の0x（16進数のマーク）無しに
  * `into Go struct field`：構造体フィールドの中に
  * `SendTxArgs.data of type hexutil.Bytes`：16進数（hexutil.Bytes）型のSendTxArgsデータ
  * ⇒「16進数型のデータを扱うのに先頭（0番目）に"0x"がついてないから扱えない」
  
 * 解消法  
 binに値を格納時に、先頭に"0x"を挿入して格納  
 （参考ページも、よく確認したら格納時に0xが挿入されている）

以上
