import "Account.sol";

contract FinancialInstitution
{
    // identity of the Financial Institution.
    // Only calls from this identy will be able to update the data in this structure. eg the accounts and their assiciated identities
    address private _financialInstitutionIdentity;
    
    string private _BICFI;
    string private _name;  // name of the Financial Institution
    // TODO move to an address struct
    string private _postalAddress; // postal address of the Financial Institution
    
    // constructor
    function FinancialInstitution(string BICFI, string name, string postalAddress)
    {
        // set the FI's identity to the externally owned account that created this contract
        _financialInstitutionIdentity = msg.sender;
        
        _BICFI = BICFI;
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
    
    event AccountAdded(Account);
    event AccountRemoved(Account);
    event AccountGet(Account);
    
    function addAccount(Account account) returns (bool success)
    {
        // TODO check that the account has not already been added
        
        // only the Financial Institution that created this contract can add new accounts
        if (_financialInstitutionIdentity != msg.sender ||
            !account.isCallerFIHoldingAccount() )
        {
            success = false;
            return;
        }
        
        // TODO the compiler is complaining: type tuple() is not implicitly convertible to expected type string memory.
        //_accounts[account.getIdentifier()] = account;
        
        AccountAdded(account);
    }
    
    function getAccount(string accountIdentifier) returns (bool success, Account returnAccount)
    {
        // get the account using the identity (externally owned account) from the map of accounts for this FI
        Account account = _accounts[accountIdentifier];
        
        // TODO need to handle if the account has not been mapped by the FI
        
        if (account.isCallerAnAccountOwner() || account.isCallerFIHoldingAccount() )
        {
            success = true;
            returnAccount = account;
        }
        else
        {
            success = false;
        }
    }
    
    // return ether if someone sends to this contract's address
    function() { throw; }
}