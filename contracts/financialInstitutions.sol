
import "account.sol";

contract FinancialInstitutions
{
    struct FinancialInstitution
    {
        // identity of the Financial Institution.
        // Only calls from this identy will be able to update the data in this structure. eg the accounts and their assiciated identities
        address identity;
        
        string name;  // name of the Financial Institution
        // TODO move to an address struct
        string postalAddress; // postal address of the Financial Institution
        
        // Map of account identifiers to Account structures.
        // Example identifiers are 
        // * Australia: BSB and account number
        // * Europe: IBAN
        // * Canada: ?
        // * US: ?
        mapping(string => Account) accounts;
    }
    
    // Maps Business Identification Codes for each Financial Institution (BICFI) to the FI structure. eg name and accounts
    mapping(string => FinancialInstitution) private financialInstitutions;
    
    /**
     * return an Account if the following conditions are met
     * 1. The BICFI can be found in the financialInstitutions map
     * 2. The accountIdentifier is in the accounts map
     * 3. The accountOwnerIdentity (External Owner Account) has been associated with the account by the financial institution
     */
    function getAccount(string BICFI, string accountIdentifier, address accountOwnerIdentity) public returns (Account returnAccount)
    {
        FinancialInstitution fi = financialInstitutions[BICFI];
        
        // TODO need to handle if the BICFI has not been mapped
        // if (fi)
        // {
            // TODO need to handle if the account has not been mapped by the FI
            Account account = fi.accounts[accountIdentifier];
            
            if (account.isIdentityAccountOwner(accountOwnerIdentity) )
            {
                returnAccount = account;
            }
        // }
    }
}