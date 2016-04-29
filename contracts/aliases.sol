import "account.sol";
import "financialInstitutions.sol";

contract Aliases
{
    // Used to hold the address of the FinancialInstitutions contract
    FinancialInstitutions private _fis;
    
    enum AliasTypes { Email, Mobile, BIC, Facebook, Bitcoin, Ethereum }
    
    struct Alias
    {
        string identifier;  // this is the email address, mobile number, BIC, facebook username, bitcoin address....
        AliasTypes AliasType;
    }
    
    // Constructor that instantiates the FinancialInstitutions variable using the Contract's address
    function Aliases(address financialInstitutionsInstance)
    {
        _fis = FinancialInstitutions(financialInstitutionsInstance);
    }
    
    // TODO need to get events compiling. Compiler complaining the paramers are of internal type
    // event AliasAdded(Alias alias, Account account);
    // event AliasDeleted(Alias alias, Account account);
    
    // mapping of alias to Account
    // alias could be just the alias string or
    // a hash of the alias string and type
    mapping(string => Account) private aliases;
    
    // TODO need to receive an Alias struct rather than string
    function getAccountDetails(string alias) returns (string BICFI, string accountIdentifier)
    {
        Account account = aliases[alias];
        
        // TODO need to convert storage string to memory string
        //BICFI = account.getBICFI();
        //accountIdentifier = account.getIdentifier();
    }
    
    // TODO ideally a Alias struct would be passed in
    function createAlias(string alias, string BICFI, string accountIdentifier) returns (bool success)
    {
        Account account;
        
        // TODO what values should the value and gas be set to?
        (success, account) = _fis.getAccount.value(10).gas(800)(BICFI, accountIdentifier);
        
        if (success)
        {
            aliases[alias] = account;
        }
    }
    
    function deleteAlias(string alias) returns (bool success)
    {
        
    }
    
    // return ether if someone sends to this contract's address
    function() { throw; }
}