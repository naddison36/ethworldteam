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
    
    event AliasAdded(string alias, Account account);
    event AliasDeleted(string alias, Account account);
    
    // mapping of alias to Account
    // alias could be just the alias string or
    // a hash of the alias string and type
    mapping(string => Account) private aliases;
    
    // TODO need to receive an Alias struct rather than string
    // currently returning bytes32 as it can implicity convert between storage and memory
    function getAccountDetails(string alias) returns (bytes32 BICFI, bytes32 accountIdentifier)
    {
        Account account = aliases[alias];
        
        // TODO need to convert storage string to memory string
        //  If structs or arrays (including bytes and string) are assigned from a state variable to a local variable, the local variable holds a reference to the original state variable.
        BICFI = account.getBICFI();
        accountIdentifier = account.getIdentifier();
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
            
            AliasAdded(alias, account);
        }
    }
    
    function deleteAlias(string alias) returns (bool success)
    {
        Account deletedAccount = aliases[alias];
        
        // TODO how to check if an alias was not mapped?
        // if (!deletedAccount)
        // {
        //     return false;
        // }
        
        //TODO how to remove a mapping?
        //aliases[alias] = x0;
        
        AliasAdded(alias, deletedAccount);
            
        return true;
    }
    
    // return ether if someone sends to this contract's address
    function() { throw; }
}