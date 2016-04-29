
import "account.sol";
import "financialInstitution.sol";

contract FinancialInstitutions
{
    // Maps Business Identification Codes for each Financial Institution (BICFI) to the FI structure. eg name and accounts
    mapping(string => FinancialInstitution) private _financialInstitutions;
    
    // creates a new FinancialInstitution contract and adds it to the list of FI's
    function createFinancialInstitution(string BICFI, string name, string postalAddress)
    {
        // TODO need multi sig that the identity (external account) creating the FI belongs to the FI being created
        
        // TODO need to create new FI contract. See replicator.sol example for how to do this
        // _financialInstitutions[BICFI] = FinancialInstitution(name, postalAddress);
    }
    
    enum AliasTypes { Email, Mobile, BIC, Facebook, Bitcoin, Ethereum }
    
    struct Alias
    {
        AliasTypes AliasType;  // TODO move to an enum
        Account account;
    }
    
    // mapping of aliases to Accounts
    // alias could be just the alias string or
    // a hash of the alias string and type
    mapping(string => Account) private _aliases;
    
    /**
     * Creates an alias mapped to an account if the following conditions are met
     * 1. The BICFI can be found in the financialInstitutions map
     * 2. The accountIdentifier is in the FI's accounts map
     * 3. The caller (External Account) has previously been associated with the account by the financial institution
     */
    function createAlias(string alias, string BICFI, string accountIdentifier) returns (bool success)
    {
        // get Financial Institution using the Business Identification Code for the Financial Institution
        FinancialInstitution fi = _financialInstitutions[BICFI];
        
        // try and get the account using the identity of the caller
        Account account;
        (success, account) = fi.getAccount(accountIdentifier);
        
        if (success)
        {
            _aliases[alias] = account;
        }
    }
    
    //function getAccount(string alias) returns (bool success, Account account)
    function getAccount(string BICFI, string accountIdentifier) returns (bool success, Account account)
    {
        FinancialInstitution fi = _financialInstitutions[BICFI];
        
        // TODO check if an fi was returned
        
        (success, account) = fi.getAccount(accountIdentifier);
        
        // TODO check if an account was returned
        success = true;
    }
    
    // return ether if someone sends to this contract's address
    function() { throw; }
}
