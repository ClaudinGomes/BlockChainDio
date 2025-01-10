// SPDX-License-Identifier: MIT

pragma solidity ^0.4.24;

// Safe Math Interface
contract SafeMath {

    // Function to safely add two unsigned integers
    function safeAdd(uint a, uint b) public pure returns (uint c) {
        c = a + b;
        require(c >= a); // Ensure no overflow occurs
    }

    // Function to safely subtract two unsigned integers
    function safeSub(uint a, uint b) public pure returns (uint c) {
        require(b <= a); // Ensure no underflow occurs
        c = a - b;
    }

    // Function to safely multiply two unsigned integers
    function safeMul(uint a, uint b) public pure returns (uint c) {
        c = a * b;
        require(a == 0 || c / a == b); // Ensure no overflow occurs
    }

    // Function to safely divide two unsigned integers
    function safeDiv(uint a, uint b) public pure returns (uint c) {
        require(b > 0); // Division by zero is not allowed
        c = a / b;
    }
}

// ERC Token Standard #20 Interface
contract ERC20Interface {
    function totalSupply() public constant returns (uint);
    function balanceOf(address tokenOwner) public constant returns (uint balance);
    function allowance(address tokenOwner, address spender) public constant returns (uint remaining);
    function transfer(address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);

    // Event triggered when tokens are transferred
    event Transfer(address indexed from, address indexed to, uint tokens);

    // Event triggered when an allowance is set
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

// Interface for contract to receive approval and execute a function in one call
contract ApproveAndCallFallBack {
    function receiveApproval(address from, uint256 tokens, address token, bytes data) public;
}

// =================================================================
// Meu contrato
// Desenvolvimento iniciado em 14/12/2024
// Ultima alteracao em:
// Por: Claudinei Diniz
// -----------------------------------------------------------------
// Actual token contract implementation
contract Andromeda is ERC20Interface, SafeMath {
    string public symbol;        // Token symbol
    string public name;          // Token name
    uint8 public decimals;       // Number of decimal places
    uint public _totalSupply;    // Total supply of tokens

    // Mapping to store token balances
    mapping(address => uint) balances;

    // Mapping to store allowances
    mapping(address => mapping(address => uint)) allowed;

    // Address of the contract owner
    address public owner;

    // Paused state
    bool public paused = false;

    // Events for additional functionality
    event Burn(address indexed burner, uint tokens);
    event Mint(address indexed minter, uint tokens);

    // Modifier to check if transfers are paused
    modifier whenNotPaused() {
        require(!paused, "Token transfers are currently paused.");
        _;
    }

    // Modifier to restrict access to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can perform this action.");
        _;
    }

    // Constructor to initialize the token contract
    constructor() public {
        owner = msg.sender;                        // Set the owner of the contract
        symbol = "ADO";                           // Setting the token symbol
        name = "Andromeda Coin";                  // Setting the token name
        decimals = 3;                              // Setting the decimal precision
        _totalSupply = 1000000;                    // Setting the total supply of tokens

        // Assigning the entire supply to the creator's wallet (replace with actual wallet address)
        balances[owner] = _totalSupply;

        // Emitting a transfer event for the initial token allocation
        emit Transfer(address(0), owner, _totalSupply);
    }

    // Function to return the total supply of tokens (excluding burned tokens)
    function totalSupply() public constant returns (uint) {
        return _totalSupply  - balances[address(0)];
    }

    // Function to get the token balance of a specific address
    function balanceOf(address tokenOwner) public constant returns (uint balance) {
        return balances[tokenOwner];
    }

    // Function to transfer tokens to another address
    function transfer(address to, uint tokens) public whenNotPaused returns (bool success) {
        balances[msg.sender] = safeSub(balances[msg.sender], tokens); // Deduct from sender
        balances[to] = safeAdd(balances[to], tokens);                 // Add to recipient
        emit Transfer(msg.sender, to, tokens);                       // Emit transfer event
        return true;
    }

    // Function to approve an allowance for another address to spend tokens
    function approve(address spender, uint tokens) public whenNotPaused returns (bool success) {
        allowed[msg.sender][spender] = tokens;                       // Set allowance
        emit Approval(msg.sender, spender, tokens);                 // Emit approval event
        return true;
    }

    // Function to transfer tokens on behalf of another address
    function transferFrom(address from, address to, uint tokens) public whenNotPaused returns (bool success) {
        balances[from] = safeSub(balances[from], tokens);            // Deduct from sender
        allowed[from][msg.sender] = safeSub(allowed[from][msg.sender], tokens); // Reduce allowance
        balances[to] = safeAdd(balances[to], tokens);                // Add to recipient
        emit Transfer(from, to, tokens);                            // Emit transfer event
        return true;
    }

    // Function to check the remaining allowance for a spender
    function allowance(address tokenOwner, address spender) public constant returns (uint remaining) {
        return allowed[tokenOwner][spender];
    }

    // Function to approve and call another contract in a single transaction
    function approveAndCall(address spender, uint tokens, bytes data) public whenNotPaused returns (bool success) {
        allowed[msg.sender][spender] = tokens;                       // Set allowance
        emit Approval(msg.sender, spender, tokens);                 // Emit approval event
        ApproveAndCallFallBack(spender).receiveApproval(msg.sender, tokens, this, data); // Call contract
        return true;
    }

    // Function to pause transfers
    function pause() public onlyOwner {
        paused = true;
    }

    // Function to unpause transfers
    function unpause() public onlyOwner {
        paused = false;
    }

    // Function to burn tokens from the sender's balance
    function burn(uint tokens) public whenNotPaused returns (bool success) {
        require(tokens <= balances[msg.sender], "Insufficient balance to burn tokens.");
        balances[msg.sender] = safeSub(balances[msg.sender], tokens); // Reduce sender's balance
        _totalSupply = safeSub(_totalSupply, tokens);                // Reduce total supply
        emit Burn(msg.sender, tokens);                              // Emit burn event
        return true;
    }

    // Function to mint new tokens (only contract owner)
    function mint(uint tokens) public onlyOwner returns (bool success) {
        _totalSupply = safeAdd(_totalSupply, tokens);               // Increase total supply
        balances[owner] = safeAdd(balances[owner], tokens);         // Add tokens to owner balance
        emit Mint(owner, tokens);                                  // Emit mint event
        emit Transfer(address(0), owner, tokens);                  // Emit transfer event
        return true;
    }

    // Fallback function to reject any ETH sent to the contract
    function () public payable {
        revert();
    }
}
