pragma solidity ^0.4.4;
contract erctoken {
    uint public constant _totalSupply = 50000000000;
	
	string public constant symbol = "ET";
	string public constant name = "erc token";
	address owner;
    mapping(address => uint256) balances;
	mapping(address => bool) allowed;
	mapping(address => mapping(address=>uint256)) allowed_onbehalf;
	bool tokensallocated=false;
	
	function erctoken(){
		balances[msg.sender] = _totalSupply;
		owner=msg.sender;
	}
	
	 //before the user can buy the tokens he should be added to whitlisted users by owner
    //so we use mapping address=>bool to maintain whitlisted users
    function whitelist(address a) public {
        require(msg.sender==owner);
        allowed[msg.sender]=true;
        allowed[a]=true;
    }
    
    
    
    function is_whitelisted(address a) public returns(bool){
        return allowed[a];
    }
	
	function balanceOf(address _owner) constant returns (uint balance){
		return balances[_owner];
	}
	
	function transfer(address _to, uint _value) returns (bool success){
		require(
			balances[owner] > _value && _value > 0
		);
		require(allowed[_to]==true);
		balances[owner] -= _value;
		balances[_to] += _value;
		emit Transfer(owner, _to, _value);
		return true;
	}
	 
	function transferFrom(address _from, address _to, uint _value) returns (bool success){
		require(
			allowed_onbehalf[_from][msg.sender] >= _value && balances[_from] >= _value && _value > 0
		);
		require(allowed[_to]==true && allowed[_from]==true);
		balances[_from] -= _value;
		balances[_to] += _value;
		allowed_onbehalf[_from][msg.sender] -= _value;
		emit Transfer(_from, _to, _value);
		return true;
	}
	
	//a address is Reserve Wallet address
	//b address is Interest Payout Wallet address
	//c address is Team Members HR Wallet address
	//d address is Company General Fund Wallet
	//e address is Bounties/Airdrops Wallet address
	//assuming crowdsale wallet address and msg.sender(owner) address are same, when we want transfer tokens as part of crowd crowdsale
	//we will transfer it from balanceOf[msg.sender]
	function divide_tokens(address a, address b, address c, address d, address e){
	    require(msg.sender == owner);
	    balances[a]=(30*50000000000)/100;
	    balances[b]=(20*50000000000)/100;
	    balances[c]=(10*50000000000)/100;
	    balances[d]=(13*50000000000)/100;
	    balances[e]=(2*50000000000)/100;
	    balances[msg.sender]-=(75*50000000000)/100;
	    
	}
	

		event Transfer(address _from, address _to, uint _value);
		

}
