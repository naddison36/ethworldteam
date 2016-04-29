import "account.sol";

contract FinancialInstitution
{
    // identity of the Financial Institution.
    // Only calls from this identy will be able to update the data in this structure. eg the accounts and their assiciated identities
    address private _identity;
    
    string private _name;  // name of the Financial Institution
    // TODO move to an address struct
    string private _postalAddress; // postal address of the Financial Institution
    
    function FinancialInstitution(string name, string postalAddress)
    {
        _identity = msg.sender;
        _name = name;
        _postalAddress = postalAddress;
    }
    
    // Map of account identifiers to Account structures.
    // Example identifiers are 
    // * Australia: BSB and account number
    // * Europe: IBAN
    // * Canada: ?
    // * US: ?
    mapping(string => Account) private _accounts;
    
    function getAccount(string accountIdentifier) returns (bool success, Account returnAccount)
    {
        // get the account using the identity (externally owned account) from the map of accounts for this FI
        Account account = _accounts[accountIdentifier];
        
        // TODO need to handle if the account has not been mapped by the FI
        
        if (account.isCallerAnAccountOwner() )
        {
            success = true;
            returnAccount = account;
        }
        else
        {
            success = false;
        }
    }
}