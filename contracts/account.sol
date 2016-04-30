contract Account
{
    // using bytes32 rather than string as it can implicity convert between storage and memory
    bytes32 private _BICFI;        // identifier of the financial institution that holds the account
    bytes32 private _identifier;   // account number
    
    string private _accountType;  // TODO move to an enum
    string private _currency; //TODO move to an enum or validate against reference data
    string private _name;  // name of the account
    
    function getBICFI() returns (bytes32 BICFI) {return _BICFI;}
    function getIdentifier() returns (bytes32 identifier) {return _identifier;}
    
    function getAccountType() returns (string accountType) {return _accountType;}
    function getCurrency() returns (string currency) {return _currency;}
    function getName() returns (string name) {return _name;}
    
    // List of account owner's identifies (addresses)
    // An Account Owner(s) can't link their aliases to the account unless their identities are in this list
    address[] private _accountOwnerIdentities;
    
    address private _FI_identity;
    
    // publishes an event when an account owner's identity has been successfully been added to an account
    // TODO this might not be a good idea. Can anyone filter for this event?
    // Or can it be restricted to just the FI that holds the account?
    event IdentityAdded(Account account, address addedAccountOwnerIdentity);
    
    function Account(address FI_identity,
        bytes32 BICFI,
        bytes32 identifier,
        string accountType,
        string currency,
        string name)
    {
        _FI_identity = FI_identity;
        
        _BICFI = BICFI;
        _identifier = identifier;
        _accountType = accountType;
        _currency = currency;
        _name = name;
    }
    
    // if identity in list of accountOwnerIdentities return true
    // else return false
    function isCallerAnAccountOwner() returns (bool success)
    {
        success = false;
        
        // look though list of registered identities as there can be more than one account owner
        for (uint i = 0; i < _accountOwnerIdentities.length; i++)
        {
            if (_accountOwnerIdentities[i] == msg.sender)
            {
                success = true;
                return;
            }
        }
    }
    
    function isCallerFIHoldingAccount() returns (bool success)
    {
        success = (_FI_identity == msg.sender);
    }
    
    // add's an account owners identity to this account
    // this can only be done by the Financial Institution that holds the account
    function addIdentity(address accountOwnerIdentity) returns (bool success)
    {
        // check the identity of the caller matches the Financial Institution that holds this account
        if (_FI_identity != msg.sender)
        {
            success = false;
            return;
        }
        
        // check that the address has not been previously added
        for (uint i = 0; i < _accountOwnerIdentities.length; i++)
        {
            if (_accountOwnerIdentities[i] == accountOwnerIdentity)
            {
                success = false;
                return;
            }
        }
        
        // add new account owners identity to list of identities
        _accountOwnerIdentities.push(accountOwnerIdentity);
        
        // emit event for adding identity to this account
        IdentityAdded(this, accountOwnerIdentity);
        
        success = false;
    }
    
    // return ether if someone sends to this contract's address
    function() { throw; }
}