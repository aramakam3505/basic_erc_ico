pragma solidity ^0.4.0;
import "./erctoken.sol";
import "github.com/provable-things/ethereum-api/provableAPI_0.4.25.sol";


contract ico is usingProvable {
    uint256 price=4200000000000; //hardcoded to 0.01 dollar
    uint256 totaltokens=12500000000; //25% of total tokens
    uint256 starttime;
    uint256 endtime;
    uint256 tokens_raised;
    bool started=false;
    address owner;
    address token_address;
    address fundstobetransfered;
    erctoken token; 
    mapping(address => bool) allowed;
    string public ETHUSD;
   event LogConstructorInitiated(string nextStep);
   event LogPriceUpdated(string price);
   event LogNewProvableQuery(string description);
   uint256 total_wei_raised=0;
    
    //the erctoken address and the address where the funds to be tranfered are the arguments
    //specifying starttime as 1July 2021 and endtime as 30September 2021
    //hardcoded the starttime and endtime 
    constructor(address _tokenaddress, address _fundstobetransfered) public {
        starttime=1625101200;
        endtime=1633046340;
        fundstobetransfered=_fundstobetransfered;
        tokens_raised=0;
        token_address=_tokenaddress;
        token = erctoken(_tokenaddress);
        owner=msg.sender;
    }
    
    //The owner should start the sale to buy tokens
    function start() public {
        require(msg.sender==owner);
        require(now>=starttime && now<endtime);
        started=true;
    }
    
    
    //ico should be started and tokens to be available to buy.
    //whitelisted users can but the tokens
    function buy() public payable{
        require(started==true,"Its takes time to start the sale");
        require((value/price)<=(totaltokens-tokens_raised),"No enough tokens");
        require(now<=endtime);
        require(token.is_whitelisted(msg.sender)==true);
        //require(allowed[msg.sender]==true);
        uint256 value=msg.value;
        total_wei_raised+=value;
        uint256 numoftokens=value/price;
        uint256 b=calculateBonus();
        numoftokens=((100+b)*numoftokens)/100;
        token.transfer(msg.sender,numoftokens);
        fundstobetransfered.transfer(value);
    }
    
    //calculating the bonus structure relatively in terms of seconds
    //eg:- if it's 12 days since the contract deployed the present time is (starttime + (12*24*60*60))
    function calculateBonus() internal returns(uint256 num){
        if(now< starttime + (15*24*60*60))
        {
            return 25;
        }
        else if(now< starttime + (30*24*60*60)){
            return 20;
        }
        else if(now< starttime + (37*24*60*60)){
            return 15;
        }
        else if(now< starttime + (44*24*60*60)){
            return 10;
        }
        else if(now< starttime + (51*24*60*60)){
            return 5;
        }
        else{
            return 0;
        }
    }
    
    
   
    
    
    function __callback(bytes32 myid, string result) {
       if (msg.sender != provable_cbAddress()) revert();
       ETHUSD = result;
       LogPriceUpdated(result);
   }
   
   /*
   As price of token is variable the owner can plug in the price when required.
   the plugged price will be in usd, to be converted into wei.
   As the ether price will be fluctuating we need some to get the present price , oracles solve our problem
   We use provable service(formerly known as oraclize) , Where we need to pass our query as URL and it will get result of query and will call the callback function defined
   We receive the result in string format and it is converted into uint...
   */
   function updatePrice(uint256 _price) payable {
       require(msg.sender==owner);
       if (provable_getPrice("URL") > this.balance) {
           emit LogNewProvableQuery("Provable query was NOT sent, please add some ETH to cover for the query fee");
       } else {
           emit LogNewProvableQuery("Provable query was sent, standing by for the answer..");
           provable_query("URL", "json(https://api.pro.coinbase.com/products/ETH-USD/ticker).price");
           
       }
       bytes memory _bytesValue = bytes(ETHUSD);
        uint j = 1;
        uint ret=0;
        for(uint i = _bytesValue.length-1; i >= 0 && i <7 ; i--) {
            if(uint8(_bytesValue[i]) >= 48 && uint8(_bytesValue[i]) <= 57){
            ret += (uint8(_bytesValue[i]) - 48)*j;
            j*=10;}
        }
       price=(_price*(10^^20)/ret);
    
       
   }
   
   //ICO is success if we are able to raise a minimum of 5000000 USD(softcap)
   function is_ico_success() public returns(bool){
       require(endtime<now && msg.sender==owner);
       require((total_wei_raised*(price/(10^^18))>5000000) , "unable to raise minimum funds");
       return true;
       
   }
    
   
}
