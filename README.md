# <b>Basic ERC-20 token with an ICO</b>

<i><b> FEATURES IMPLEMENTED </b></i>

<b>1.Token smart contract</b><\n>
Implemented a token smart contract with all required function that meets erc-20 standard.

<b>2.Crowdsale smart contract</b><\n>
crowdsale smart contract is created with all required features such as it will start specified time and end at specified time.
ICO is success if it is able to raise funds more than softcap
Client/Owner can change the price of token at any time and the value of token is given in dollars<\n>
Provable(formerly known as oraclize) is used to get current price of ether in dollars
<i>Logic used to convert dollars to wei is:-</i><\n>
eg:-1ETH=Xdollars(value from provable) , 1ETH=10^18 wei, 1dollar=(10^18)/X <\n>
if the price of token is 'Z' dollars then its corresponding value in wei is Z*((10^18)/X)<\n>
<i>Logic behind time:-</i><\n>
"now" in solidity returns the number of seconds since the unix epoch created(1970 Jan 1).It doesen't count leap seconds. 
Crowdsale starts at JULY 1 2021 so , directly hardcoded the value , starttime=number of seconds from (1970 Jan 1) to (JULY 1 2021) - leap seconds
in the same way end time is harcoded(sep 30 2021)

<b>3.Whitelisting of investors</b><\n>
Only whitelisted users can buy tokens.This is implemented using whitelist() and is_whitelisted() functions

<b>4.Bonus Structure</b><\n>
Private Sale 25%
Pre-Sale 20%
CrowdSale 15% 1st week, 10% 2nd week, 5% 3rd week, 0% 4th week


