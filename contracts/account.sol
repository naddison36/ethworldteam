contract Account
{ 
    string AccountType;  // TODO move to an enum
    string currency; //TODO move to an enum or reference data
    string name;  // name of the account
    
    // List of account owner's identifies (addresses)
    // An Account Owner(s) can't link their aliases to the account unless their identities are in this list
    address[] accountOwnerIdentities;
    
    // if identity in list of accountOwnerIdentities return true
    // else return false
    function isIdentityAccountOwner(address identity) returns (bool success)
    {
        // TODO implement method 
        success = true;
    }
}