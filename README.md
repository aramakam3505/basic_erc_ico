# <b>Basic ERC-20 token with an ICO</b>

<i><b> FEATURES IMPLEMENTED </b></i>

<b>1.Token smart contract</b>__
Implemented a token smart contract with all required function that meets erc-20 standard.__

<b>2.Crowdsale smart contract</b>__
crowdsale smart contract is created with all required features such as it will start specified time and end at specified time.__
ICO is success if it is able to raise funds more than softcap__
Client/Owner can change the price of token at any time and the value of token is given in dollars__
Provable(formerly known as oraclize) is used to get current price of ether in dollars__
<i>Logic used to convert dollars to wei is:-</i>__
eg:-1ETH=Xdollars(value from provable) , 1ETH=10^18 wei, 1dollar=(10^18)/X __
if the price of token is 'Z' dollars then its corresponding value in wei is Z*((10^18)/X)__
<i>Logic behind time:-</i>__
"now" in solidity returns the number of seconds since the unix epoch created(1970 Jan 1).It doesen't count leap seconds.__
Crowdsale starts at JULY 1 2021 so , directly hardcoded the value , starttime=number of seconds from (1970 Jan 1) to (JULY 1 2021) - leap seconds__
in the same way end time is harcoded(sep 30 2021)__

<b>3.Whitelisting of investors</b>__
Only whitelisted users can buy tokens.This is implemented using whitelist() and is_whitelisted() functions__

<b>4.Bonus Structure</b>__
Private Sale 25%__
Pre-Sale 20%__
CrowdSale 15% 1st week, 10% 2nd week, 5% 3rd week, 0% 4th week__


