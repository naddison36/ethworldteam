
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
        // could be % of registered FI's. Number of FI's. All FI's
        
        // Create new FI contract
        _financialInstitutions[BICFI] = new FinancialInstitution(BICFI, name, postalAddress);
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
