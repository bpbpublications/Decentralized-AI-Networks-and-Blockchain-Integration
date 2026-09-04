// Book Title: Decentralized AI Networks and Blockchain Integration
// This code is provided as a companion reference for the publication above.
// Chapter 4: AI access control RBAC
// Code example of AI access control for a role-based access control system with hierarchical permissions for AI model governance is as follows:
contract AIAccessControl {
    bytes32 public constant MODEL_OWNER_ROLE = keccak256("MODEL_OWNER");
    bytes32 public constant DATA_SCIENTIST_ROLE = keccak256("DATA_SCIENTIST");
    bytes32 public constant VALIDATOR_ROLE = keccak256("VALIDATOR");
    bytes32 public constant CONSUMER_ROLE = keccak256("CONSUMER");
    mapping(bytes32 => mapping(address => bool)) public hasRole;
    mapping(bytes32 => bytes32) public roleAdmin;
    
    modifier onlyRole(bytes32 role) {
        require(hasRole[role][msg.sender], "AccessControl: insufficient permissions");
        _;
    }
    
    function grantRole(bytes32 role, address account) public onlyRole(roleAdmin[role]) {
        hasRole[role][account] = true;
        emit RoleGranted(role, account, msg.sender);
    }
    event RoleGranted(bytes32 indexed role, address indexed account, address indexed sender);
}
