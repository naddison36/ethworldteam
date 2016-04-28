import "account.sol";
import "financialInstitutions.sol";

contract Aliases
{
    enum AliasTypes { Email, Mobile, BIC, Facebook, Bitcoin, Ethereum }
    
    struct Alias
    {
        AliasTypes AliasType;  // TODO move to an enum
        Account account;
    }
    
    // TODO need to get events compiling. Compiler complaining the paramers are of internal type
    // event AliasAdded(Alias alias, Account account);
    // event AliasDeleted(Alias alias, Account account);
    
    // mapping of alias to Account
    // alias could be just the alias string or
    // a hash of the alias string and type
    mapping(string => Account) private aliases;
    
    // TODO ideally a Alias struct would be passed in
    function createAlias(string alias, string BICFI, string accountIdentifier) returns (bool success)
    {
        /*
        Account account = FinancialInstitutions.getAccount(BICFI, accountIdentifier, msg.sender);
        
        if (account)
        {
            aliases[alias] = account;
            return true;
        }
        else
        {
            return false;
        }
        */
    }
    
    function deleteAlias(string alias) returns (bool success)
    {
        
    }
}