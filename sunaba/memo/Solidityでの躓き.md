* 情報を登録する窓口になる関数はpublicにせよ  
  変な人に登録されないようにと思ってinternalやprivateにしたらそもそも登録できない  
  
* 呼び出した関数が複数の時  
  戻り値をそれぞれ変数に格納すると使える
  ```
  function fukusuu() return(uint, string memory, bool){
    return(1, "AAA", true);
  }
  
  function() {
  
  (uint _uint, string memory _string, bool _bool) = fukusuu();
  
  }
  ```
