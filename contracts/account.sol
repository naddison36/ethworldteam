contract Account
{
    string public BICFI;
    string public identifier;
    
    string public AccountType;  // TODO move to an enum
    string public currency; //TODO move to an enum or reference data
    string public name;  // name of the account
    
    // List of account owner's identifies (addresses)
    // An Account Owner(s) can't link their aliases to the account unless their identities are in this list
    address[] private _accountOwnerIdentities;
    
    address private _FI_identity;
    
    // publishes an event when an account owner's identity has been successfully been added to an account
    // TODO this might not be a good idea. Can anyone filter for this event?
    // Or can it be restricted to just the FI that holds the account?
    event addedIdentity(Account account, address addedAccountOwnerIdentity);
    
    function Account(
        address FI_identity)
    {
        _FI_identity = FI_identity;
    }
    
    // if identity in list of accountOwnerIdentities return true
    // else return false
    function isCallerAnAccountOwner() returns (bool success)
    {
        // TODO need to look though list as there can be more than one account owner
        success = (_accountOwnerIdentities[0] == msg.sender);
    }
    
    // add's an account owners identity to this account
    // this can only be done by the Financial Institution that owns the account
    function addIdentity(address accountOwnerIdentity) returns (bool success)
    {
        // check the identity of the caller matches the Financial Institution that holds this account
        if (_FI_identity != msg.sender)
        {
            success = false;
            return;
        }
        
        // add new account owners identity to list of identities
        // TODO need to check that the address has not already been added
        _accountOwnerIdentities.push(accountOwnerIdentity);
        
        // emit event for adding identity to this account
        addedIdentity(this, accountOwnerIdentity);
        
        success = false;
    }
}