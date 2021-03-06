//remix.ethereum.orgでコンパイルした場合の修正
//solidity0.4.19指定でコンパイル

//******

//FILE "erc721.sol"
//トークン・コントラクトERC721規格

pragma solidity ^0.4.19;

contract ERC721 {
	event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
	event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);

	function balanceOf(address _owner) public view returns (uint256 _balance);
	function ownerOf(uint256 _tokenId) public view returns (address _owner);
	function transfer(address _to, uint256 _tokenId) public;
	function approve(address _to, uint256 _tokenId) public;
	function takeOwnership(uint256 _tokenId) public;
}



//******

//FILE "safemath.sol"
//SafeMathライブラリ
//オーバーフローとアンダーフロー回避のために実装


//ライブラリ
//usingというキーワードで実装することで、自動的にライブラリの全メソッドを別のデータ型に追加可能
//+-*/で計算する代わりにadd,sub,mul,divで計算させることでオーバー/アンダーフローを防ぐ


pragma solidity ^0.4.19;

//**
// * @title SafeMath
// * @dev Math operations with safety checks that throw on error
// */



////////for uint256////////

//SafeMathライブラリをbitサイズごとに用意しないといけなかったので修正・追加
//"SafeMath"→"SafeMath256"


library SafeMath256 {

//**
// * @dev Multiplies two numbers, throws on overflow.
// */

	function mul(uint256 a, uint256 b) internal pure returns (uint256) {
	
		if (a == 0) {
			return 0;
		}
		
		uint256 c = a * b;
		assert(c / a == b);
			//()の中身が偽ならエラーを返す
			//エラーでもガスを消費
			
		return c;
	
	}

//**
// * @dev Integer division of two numbers, truncating the quotient.
// */

	function div(uint256 a, uint256 b) internal pure returns (uint256) {
				// assert(b > 0); // Solidity automatically throws when dividing by 0
		uint256 c = a / b;
				// assert(a == b * c + a % b); // There is no case in which this doesn't hold
		return c;
	}
//**
// * @dev Substracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
// */
  
	function sub(uint256 a, uint256 b) internal pure returns (uint256) {
		assert(b <= a);
		return a - b;
	}
//**
// * @dev Adds two numbers, throws on overflow.
// */
	function add(uint256 a, uint256 b) internal pure returns (uint256) {
		uint256 c = a + b;
		assert(c >= a);
		return c;
		
				//1 = 7+(-6)のようなことはない
				//a,bともにuint=正負の符号がない=実質正の数同士
}
}
////////for uint32////////
////"SafeMath32"追加
library SafeMath32 {
//**
// * @dev Multiplies two numbers, throws on overflow.
// */
	function mul(uint32 a, uint32 b) internal pure returns (uint32) {
	
		if (a == 0) {
			return 0;
		}
		
		uint32 c = a * b;
		assert(c / a == b);
			//()の中身が偽ならエラーを返す
			//エラーでもガスを消費
			
		return c;
	
	}
//**
// * @dev Integer division of two numbers, truncating the quotient.
// */
	function div(uint32 a, uint32 b) internal pure returns (uint32) {
				// assert(b > 0); // Solidity automatically throws when dividing by 0
		uint32 c = a / b;
				// assert(a == b * c + a % b); // There is no case in which this doesn't hold
		return c;
	}

//**
// * @dev Substracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
// */
  
	function sub(uint32 a, uint32 b) internal pure returns (uint32) {
		assert(b <= a);
		return a - b;
	}

//**
// * @dev Adds two numbers, throws on overflow.
// */

	function add(uint32 a, uint32 b) internal pure returns (uint32) {
		uint32 c = a + b;
		assert(c >= a);
		return c;
		
				//1 = 7+(-6)のようなことはない
				//a,bともにuint=正負の符号がない=実質正の数同士
}

}


////////for uint16////////
////"SafeMath16"追加


library SafeMath16 {

//**
// * @dev Multiplies two numbers, throws on overflow.
// */

	function mul(uint16 a, uint16 b) internal pure returns (uint16) {
	
		if (a == 0) {
			return 0;
		}
		
		uint16 c = a * b;
		assert(c / a == b);
			//()の中身が偽ならエラーを返す
			//エラーでもガスを消費
			
		return c;
	
	}

//**
// * @dev Integer division of two numbers, truncating the quotient.
// */

	function div(uint16 a, uint16 b) internal pure returns (uint16) {
				// assert(b > 0); // Solidity automatically throws when dividing by 0
		uint16 c = a / b;
				// assert(a == b * c + a % b); // There is no case in which this doesn't hold
		return c;
	}
//**
// * @dev Substracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
// */
  
	function sub(uint16 a, uint16 b) internal pure returns (uint16) {
		assert(b <= a);
		return a - b;
	}
//**
// * @dev Adds two numbers, throws on overflow.
// */
	function add(uint16 a, uint16 b) internal pure returns (uint16) {
		uint16 c = a + b;
		assert(c >= a);
		return c;
		
				//1 = 7+(-6)のようなことはない
				//a,bともにuint=正負の符号がない=実質正の数同士
}
}
//******
//FILE "ownable.sol"
//Ownableコントラクタ
//コントラクトが最初に作成された時に、1度だけ実行される
contract Ownable {
	address public owner;
	event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
	//ownerを、このコンストラクタを実行した人のスマコンアドレスに設定する
	function Ownable() public {
		owner = msg.sender;
	}
   //その関数の実行者がownerであれば内容を実行
   
	modifier onlyOwner() {
		require(msg.sender == owner);
		_;
	}
	//引数に入力されたアドレスにオーナー権を譲渡する
	
	function transferOwnership(address newOwner) public onlyOwner {
	
		require(newOwner != address(0));
		OwnershipTransferred(owner, newOwner);
		owner = newOwner;
	}
}
//******
FILE "Zombiefactory.sol"
pragma solidity ^0.4.19;
//このコントラクトの作成者（オーナー）だけが関数を使用できるようにする
import "./ownable.sol";
//SafeMathライブラリを使う宣言を最初にしておく
import "./safemath.sol";
//function Ownable()を継承したコンストラクタにする
//ゾンビ工場構造体
contract ZombieFactory is Ownable {
	
	using SafeMath256 for uint256;
			//uint256型の変数に対して、SafeMathライブラリを使う宣言
			
	using SafeMath32 for uint32;
			//uint256型の変数に対して、SafeMathライブラリを使う宣言
			
	using SafeMath16 for uint16;
			//uint256型の変数に対して、SafeMathライブラリを使う宣言
			
    event NewZombie(uint zombieId, string name, uint dna);
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
	uint cooldownTime = 1 days;
    struct Zombie {
        string name;
        uint dna;
		uint32 level;
        uint32 readyTime;
        uint16 winCount;
        uint16 lossCount;
    }
    Zombie[] public zombies;
    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;
    function _createZombie(string _name, uint _dna) internal {
        uint id = zombies.push(Zombie(_name, _dna, 1, uint32(now + cooldownTime), 0, 0)) - 1;
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender] = ownerZombieCount[msg.sender].add(1);
        		//SafeMathライブラリのメソッドに修正
        NewZombie(id, _name, _dna);
    }
    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }
    function createRandomZombie(string _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        randDna = randDna - randDna % 100;
        _createZombie(_name, randDna);
    }
}
//******
//FILE "zombiefeeding.sol"
//実際の開発環境だと別タブになる
pragma solidity ^0.4.19;
import "./zombiefactory.sol";
//餌の子猫のインターフェースコントラクト
contract KittyInterface {
	function getKitty(uint256 _id) external view returns (
		bool isGestating,
		bool isReady,
		uint256 cooldownIndex,
		uint256 nextActionAt,
		uint256 siringWithId,
		uint256 birthTime,
		uint256 matronId,
		uint256 sireId,
		uint256 generation,
		uint256 genes
  );
}
//ゾンビに餌をあげるコントラクト
contract ZombieFeeding is ZombieFactory {
		KittyInterface kittyContract;	//kittyContractはKittyInterfaceの名前です
		
		
	//特定のゾンビを使用するアカウントが、そのゾンビのオーナーかどうか判定するよ！
		modifier onlyOwnerOf(uint _zombieId) {
		
			require(msg.sender == zombieToOwner[_zombieId]);
			_;
					
		}
		
		
//KittyInterfaceを作成
		function setKittyContractAddress(address _address) external onlyOwner {
			kittyContract = KittyInterface(_address);
			
		}
//クールタイム用の関数を定義
	function _triggerCooldown(Zombie storage _zombie) internal {
		_zombie.readyTime = uint32(now + cooldownTime);
	}
//クールタイムを過ぎてるか否かの判別関数
	function _isReady(Zombie storage _zombie) internal view returns (bool) {
		return (_zombie.readyTime <= now);
	}
//捕食・増加ファンクション
	function feedAndMultiply(uint _zombieId, uint _targetDna, string _species) internal onlyOwnerOf(_zombieId) {
		Zombie storage myZombie = zombies[_zombieId];
		
		require(_isReady(myZombie));
		_targetDna = _targetDna % dnaModulus;
		uint newDna = (myZombie.dna + _targetDna) / 2;
			if (keccak256(_species) == keccak256("kitty")) {
				newDna = newDna - newDna % 100 + 99;
		    }
		
		_createZombie("NoName", newDna);
		_triggerCooldown(myZombie);
	}
	function feedOnKitty(uint _zombieId, uint _kittyId) public {
		uint kittyDna;
		(,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
		feedAndMultiply(_zombieId, kittyDna, "kitty");
	}
}
//******
//FILE "zombiehelper.sol"
//ヘルパーメソッドとしてzombiehelper.solコントラクトを作成
//zombiefeedingコントラクトを継承したコンストラクト
pragma solidity ^0.4.19;
import "./zombiefeeding.sol";
contract ZombieHelper is ZombieFeeding {
	//レベルアップに必要な手数料(ether)を宣言
	uint levelUpFee = 0.001 ether;
	
	//渡したレベル以上なら関数の中身を実行できる修飾子
	
	modifier aboveLevel(uint _level, uint _zombieId) {
		require(zombies[_zombieId].level >= _level);
		_;
	}
	
	
	//Etherをコントラクトから引き出す
	
	
	function withdraw() external onlyOwner {
		
		owner.transfer(this.balance);
	
	}
	
	
	//コントラクト所有者がレベルアップ手数料を設定でるようにする
	
	function setLevelUpFee(uint _fee) external onlyOwner {
				
		levelUpFee = _fee;
	
	}
	
	
	
	
	//レベルアップする関数
	
	function levelUp(uint _zombieId) external payable {
	
		require(msg.value == levelUpFee);
		zombies[_zombieId].level = zombies[_zombieId].level.add(1);
				//SafeMathライブラリのメソッドに修正
	
	}
	
	
	//一定レベル以上なら名前を変えられる
	
	function changeName(uint _zombieId, string _newName) external aboveLevel(2, _zombieId) onlyOwnerOf(_zombieId) {
		zombies[_zombieId].name = _newName;
		
	}
	
	
	//一定レベル以上ならDNAを変えられる
	
	function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) onlyOwnerOf(_zombieId) {
		
		zombies[_zombieId].dna = _newDna;
	
	}
	
	//手持ちのゾンビ軍団一覧を見る関数
	
	function getZombiesByOwner(address _owner) external view returns (uint[]) {
		
		uint[] memory result = new uint[](ownerZombieCount[_owner]);
		uint counter = 0;
		
		for (uint i = 0; i < zombies.length; i++){
			if (zombieToOwner[i] == _owner) {
				
				result[counter] = i;
				counter++;
			
			}
			
		}
			
		return result;
	}
	
}
//FILE "zombieattack.sol"
//バトル機能用のファイル・コントラクトを作成
pragma solidity ^0.4.19;
import "./zombiehelper.sol";
//ZombieHelperコントラクトを継承
contract ZombieAttack is ZombieHelper {
	
	uint randNonce = 0;
	uint attackVictoryProbability = 70;
	
	
//ランダムに数値を生成する
	
	function randMod (uint _modulus) internal returns (uint) {
		
		randNonce = randNonce.add(1);
				//SafeMathライブラリのメソッドに修正
		return uint(keccak256(now, msg.sender, randNonce)) % _modulus;
	
	}
	
	
//ゾンビが攻撃する関数
	
	function attack(uint _zombieId, uint _targetId) external onlyOwnerOf(_zombieId) {
	
		Zombie storage myZombie = zombies[_zombieId];
		Zombie storage enemyZombie = zombies[_targetId];
		
		uint rand = randMod(100);
		
		//勝敗の確認
		
		if (rand <= attackVictoryProbability) {
		
			myZombie.winCount = myZombie.winCount.add(1);
					//SafeMathライブラリのメソッドに修正
			
			myZombie.level = myZombie.level.add(1);
					//SafeMathライブラリのメソッドに修正
			enemyZombie.lossCount = enemyZombie.lossCount.add(1);
					//SafeMathライブラリのメソッドに修正
			
			//勝ったからゾンビを増やす
			
			feedAndMultiply(_zombieId, enemyZombie.dna, "zombie");
		} else {
		
			myZombie.lossCount = myZombie.lossCount.add(1);
					//SafeMathライブラリのメソッドに修正
			enemyZombie.winCount = enemyZombie.winCount.add(1);
					//SafeMathライブラリのメソッドに修正
				
		}	
		
		_triggerCooldown(myZombie);
	
	}
}
//******
//******
//FILE "zombieownership.sol"
//トークン
pragma solidity ^0.4.19;
import "./zombieattack.sol";
		//zombieattack.solをインポート
		
import "./erc721.sol";
		//erc721.solをインポート
/// @title ゾンビ所有権の移転を管理するコントラクト
/// @author SS
/// @dev OpenZeppelinのERC721ドラフト実装に準拠
	//@dev:開発者向けのさらなる詳細の説明
	//@param:何のパラメータかの説明
	//@return:戻り値の説明
//Zombieattackコントラクトを継承
	//ZombieBattleでは……？
//ERC721コントラクトも継承
	
contract ZombieOwnership is ZombieAttack, ERC721 {
	mapping (uint => address) zombieApprovals;
		//approve時に使う送り先登録容器を定義
		//ラベル：トークンID
		//中身：アドレス
	function balanceOf(address _owner) public view returns (uint256 _balance) {
				//オーナーのアドレスを引数にして
				//256バイトuint型_balanceを返す
				//uint256=uint（※規格をコピペしてるからuint256表記）
				
				//_balance:受け取ったアドレスのトークン保有量
				//ここではゾンビの所有数
				
		return ownerZombieCount[_owner];
				//オーナーのアドレスがラベルのownerZombieCountの中身（ゾンビの所有数）
				
	}
	function ownerOf(uint256 _tokenId) public view returns (address _owner) {
				//トークンIDを受け取って、オーナーのアドレスを返す
				
				//"ZombieFeeding"コントラクトでも同名ownerOfのmodiferを用いている
				//ERC721のownerOfは既定の規格のため変更不可（他のコントラクトとの共通規格）
				//→"ZombieFeeding"コントラクトの方を変える
				
				//トークンID＝ゾンビIDを受け取ってその所有者のアドレスを返す
				
				
		return zombieToOwner[_tokenId];
				//_tokenId（ゾンビID）がラベルの、zombieToOwnerの中身＝所有者のアドレス
	
	}
//所有者が能動的に送るとき
	function _transfer(address _from, address _to, uint256 _tokenId) private {
				//送り元_from
				//送り先_to
				//送りたいトークン_tokenID
	
		ownerZombieCount[_to]++;
				//送り先のアドレスがラベルになっているownerZombieCountの中身を増やす
				
		ownerZombieCount[_from]--;
				//送り元のアドレスがラベルになっているownerZombieCountの中身を減らす
				
		zombieToOwner[_tokenId] = _to;
				//移動するトークン（ゾンビ）のIDがラベルのzombieToOwnerの中身（送り元のアドレス）を
				//送り先のアドレスに上書き
		
		
		//mappingに保管した所有数・所有者情報を書き換えたので、転送イベント
		//event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
		
		Transfer(_from, _to, _tokenId);
		
	
	
	}
	function transfer(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
			//ゾンビの所有者以外に勝手に転送されたら困るので
			//送りたいゾンビの所有者IDと関数実行者IDを照合するonlyOwnerOf修飾子を足す
			
			_transfer(msg.sender, _to, _tokenId);
					//送り主＝この関数の実行者＝msg.sender
			
	}
	
	
	
//所有者が登録しておいて、譲渡先が任意のタイミングで回収するとき
	//情報を登録
	function approve(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
			//ゾンビの所有者以外に勝手に転送登録されたら困るので
			//送りたいゾンビの所有者IDと関数実行者IDを照合するonlyOwnerOf修飾子を足す
			
		zombieApprovals[_tokenId] = _to;
			//送り先のアドレスを、送りたいゾンビIDをラベルにした箱に入れる
		
		
		//設定が終わったからイベントを起こす
		//event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);
		
		Approval(msg.sender, _to, _tokenId);
				//送り主＝この関数の実行者＝msg.sender
					
	}
	//譲渡先による回収
	//登録アドレスと回収者のアドレスが一致したら
	//所有情報も書き換える_transferをすればOK
	
	function takeOwnership(uint256 _tokenId) public {
	
		require(zombieApprovals[_tokenId] == msg.sender);
				//関数の引数に入力されたトークンIDがラベルのzombieApprovalsの中身のアドレスが
				//関数の実行者のアドレスを一致すれば
				//この関数の実行者が送り先と判断可能
		
		address owner = ownerOf(_tokenId);
				//送り元のアドレスをトークンIDから返すownerOf(_tokenId)
				
		//一致してるのでトークンを送る
		
		_transfer(owner, msg.sender, _tokenId);
				//送り元のアドレス↑で定義したowner
				//送り先のアドレス＝関数実行者のアドレス
				//受け取りたいトークンID
				
	}
}
