// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.7;

contract personascrypto{ 

// Declare a variable of address data type to store the owner address of the contract.
    address owner;

// Constructor function that sets the owner to the address of the contract deployer.
    constructor() {
        owner = msg.sender;
    }

// Define a struct to store data for each person in the contract.
    struct Persona {
        address payable DireccionBilletera; // Wallet address of the person.
        string Nombre; // First name of the person.
        string Apellido; // Last name of the person.
        uint TiempoEntrega; // Delivery time of the funds.
        uint Cantidad; // Quantity of funds stored in the contract for the person.
        bool PuedeRetirar; // Boolean value to determine if the person can withdraw their funds.
    }

// Declare a public array to store data for each person in the contract.
    Persona[] public personas;

// Declare a modifier to only allow the contract owner to add persons to the contract.
    modifier SoloOwner(){
        // Check if the msg.sender is equal to the owner. If not, revert the transaction and throw an error message.
        require(msg.sender == owner, "Solo el owner puede agregar personas");
        _;
    }

// Function to add a person to the contract by the contract owner.
    function AgregarPersonas(address payable DireccionBilletera, string memory Nombre,string memory Apellido,uint TiempoEntrega,uint Cantidad,bool PuedeRetirar) public SoloOwner {
        // Use the push function to add a new person to the personas array with the provided data.
        personas.push(Persona(
            DireccionBilletera,
            Nombre,
            Apellido,
            TiempoEntrega,
            Cantidad,
            PuedeRetirar
        ));
    } 

// View function to return the balance of the contract.
    function Fondos() public view returns(uint){
        return address(this).balance;
    }

// Function to allow a person to deposit funds into the contract.
    function depositar (address DireccionBilletera) payable public{
        // Call the private function AgregarPersonasDeposito with the address of the person depositing funds.
        AgregarPersonasDeposito(DireccionBilletera);
    }

// Private function to update the Cantidad for a person in the personas array when they deposit funds into the contract.
    function AgregarPersonasDeposito(address DireccionBilletera) private {
        // Loop through the personas array and compare the DireccionBilletera value of each person to the address provided as an argument.
        for (uint i=0; i< personas.length; i++){
            if (personas[i].DireccionBilletera == DireccionBilletera){
                // If a match is found, add the value of the deposit to the Cantidad of the person.
                personas[i].Cantidad += msg.value;

            }
        }

    }

//ObtenerIndex is a private function that finds the index of the person in the personas array who has the wallet address DireccionBilletera.
//If the person is found, the function returns the index i.
//If the person is not found, the function returns 999

    function ObtenerIndex(address DireccionBilletera) view private returns(uint){

        for (uint i=0; i< personas.length; i++){

            if (personas[i].DireccionBilletera== DireccionBilletera){

                return i;
            }
        }
        return 999;
    }
//ComprobarRetirar is a public function that checks if the person with wallet address DireccionBilletera can withdraw their funds.
//The function first finds the index of the person using ObtenerIndex.
//The function then checks if the current block.timestamp is greater than the TiempoEntrega of the person. If not, the function requires the call to revert and displays the message "Todavia no puedes retirar" (you can't withdraw yet).
//If the current time is greater than TiempoEntrega, the function sets PuedeRetirar to true and returns true
    
    function ComprobarRetirar(address DireccionBilletera) public returns(bool){

        uint i= ObtenerIndex(DireccionBilletera);
        require(block.timestamp > personas[i].TiempoEntrega,"Todavia no puedes retirar");
        if (block.timestamp > personas[i].TiempoEntrega){

            personas[i].PuedeRetirar= true;
            return true;
        }
        else{
            return false;
        }

    }

//RetirarPlata is a public function that allows the person with wallet address DireccionBilletera to withdraw their funds.
//The function first finds the index of the person using ObtenerIndex.
//The function then requires that the msg.sender is the same as the person's wallet address, with the error message "Debes ser el chico para retirar sus fondos" (you must be the person to withdraw their funds).
//The function then requires that PuedeRetirar is true, with the error message "Todavia no puedes retirar" (you can't withdraw yet).
    
    function RetirarPlata (address payable DireccionBilletera) payable public{

        uint i= ObtenerIndex(DireccionBilletera);
        require(msg.sender == personas[i].DireccionBilletera, "Debes ser el chico para retirar sus fondos");
        require(personas[i].PuedeRetirar==true, "Todavia no puedes retirar");
        personas[i].DireccionBilletera.transfer(personas[i].Cantidad);

    }

}