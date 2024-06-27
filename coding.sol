// SPDX-License-Identifier: MIT
pragma solidity ^0.4.24;

contract Coding is ERC20Interface, SafeMath {
    string public constant name = "Coding";
    string public constant symbol = "COD";
    uint8 public constant decimals = 18;
    uint256 private _totalSupply;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(uint256 initialSupply) public {
        _totalSupply = initialSupply * (10 ** uint256(decimals));
        _balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) public returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        require(_balances[sender] >= amount, "ERC20: transfer amount exceeds balance");

        _balances[sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
    }
}

contract SafeMath {
    function safeAdd(uint a, uint b) public pure returns (uint c) {
        c = a + b;
        require(c >= a);
    }
    function safeSub(uint a, uint b) public pure returns (uint c) {
        require(b <= a);
        c = a - b;
    }
    function safeMul(uint a, uint b) public pure returns (uint c) {
        c = a * b;
        require(a == 0 || c / a == b);
    }
    function safeDiv(uint a, uint b) public pure returns (uint c) {
        require(b > 0);
        c = a / b;
    }
}

contract ApproveAndCallFallBack {
    function receiveApproval(address from, uint256 tokens, address token, bytes data) public;
}

contract ERC20Interface {
    function totalSupply() public constant returns (uint);
    function balanceOf(address tokenOwner) public constant returns (uint balance);
    function allowance(address tokenOwner, address spender) public constant returns (uint remaining);
    function transfer(address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

//608060405234801561000f575f80fd5b5060405161063438038061063483398101604081905261002e91610098565b61003a6012600a6101a5565b61004490826101b7565b5f81815533808252600160205260408083208490555190927fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef9161008a91815260200190565b60405180910390a3506101ce565b5f602082840312156100a8575f80fd5b5051919050565b634e487b7160e01b5f52601160045260245ffd5b600181815b808511156100fd57815f19048211156100e3576100e36100af565b808516156100f057918102915b93841c93908002906100c8565b509250929050565b5f826101135750600161019f565b8161011f57505f61019f565b8160018114610135576002811461013f5761015b565b600191505061019f565b60ff841115610150576101506100af565b50506001821b61019f565b5060208310610133831016604e8410600b841016171561017e575081810a61019f565b61018883836100c3565b805f190482111561019b5761019b6100af565b0290505b92915050565b5f6101b08383610105565b9392505050565b808202811582820484141761019f5761019f6100af565b610459806101db5f395ff3fe608060405234801561000f575f80fd5b5060043610610060575f3560e01c806306fdde031461006457806318160ddd1461009f578063313ce567146100b057806370a08231146100ca57806395d89b41146100f2578063a9059cbb14610114575b5f80fd5b61008960405180604001604052806006815260200165436f64696e6760d01b81525081565b604051610096919061033a565b60405180910390f35b5f545b604051908152602001610096565b6100b8601281565b60405160ff9091168152602001610096565b6100a26100d83660046103a1565b6001600160a01b03165f9081526001602052604090205490565b6100896040518060400160405280600381526020016210d3d160ea1b81525081565b6101276101223660046103c1565b610137565b6040519015158152602001610096565b5f61014333848461014d565b5060015b92915050565b6001600160a01b0383166101b65760405162461bcd60e51b815260206004820152602560248201527f45524332303a207472616e736665722066726f6d20746865207a65726f206164604482015264647265737360d81b60648201526084015b60405180910390fd5b6001600160a01b0382166102185760405162461bcd60e51b815260206004820152602360248201527f45524332303a207472616e7366657220746f20746865207a65726f206164647260448201526265737360e81b60648201526084016101ad565b6001600160a01b0383165f9081526001602052604090205481111561028e5760405162461bcd60e51b815260206004820152602660248201527f45524332303a207472616e7366657220616d6f756e7420657863656564732062604482015265616c616e636560d01b60648201526084016101ad565b6001600160a01b0383165f90815260016020526040812080548392906102b59084906103fd565b90915550506001600160a01b0382165f90815260016020526040812080548392906102e1908490610410565b92505081905550816001600160a01b0316836001600160a01b03167fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef8360405161032d91815260200190565b60405180910390a3505050565b5f602080835283518060208501525f5b818110156103665785810183015185820160400152820161034a565b505f604082860101526040601f19601f8301168501019250505092915050565b80356001600160a01b038116811461039c575f80fd5b919050565b5f602082840312156103b1575f80fd5b6103ba82610386565b9392505050565b5f80604083850312156103d2575f80fd5b6103db83610386565b946020939093013593505050565b634e487b7160e01b5f52601160045260245ffd5b81810381811115610147576101476103e9565b80820180821115610147576101476103e956fea2646970667358221220a5ad3514708fa8d453872c434af0ceee962084cfa553f506992e5246687e77dd64736f6c63430008180033
//0x9903D2C077A9cDA26276D19d7808a0Aff65ee8a5
//k5l2jj99
///Users/quintino/Library/Ethereum/keystore/UTC--2024-02-07T02-38-15.506637000Z--9903d2c077a9cda26276d19d7808a0aff65ee8a5
