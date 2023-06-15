// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 < 0.9.0;
contract eventContract{
struct Event{
    address organizer;
    string name;
    uint date;
    uint price;
    uint ticketCount;
    uint ticketRemaining;
}
mapping (uint => Event) public events;
mapping (address =>mapping(uint => uint)) public tickets;
uint public nextId;
function createEvent(string memory _name,uint _date,uint _price,uint _ticketCount) public {
    require(_date>block.timestamp,"Organize event for future date");
    
    events[nextId] = Event(msg.sender,_name,_date,_price,_ticketCount,_ticketCount);
    nextId++;
}
function buyTickets(uint id,uint quantity) public payable{
require(events[id].date!=0,"Event doesnt exist");
require(events[id].date>block.timestamp,"Event has already occured");
Event storage _event=events[id];
require(msg.value>=(_event.price*quantity),"Not enough money sent");
require(_event.ticketRemaining>=quantity,"not enough tickets available");
_event.ticketRemaining-=quantity;
tickets[msg.sender][id]+=quantity;
}
function transferTickets(uint id,uint quantity,address receiver) public {
require(events[id].date!=0,"Event doesnt exist");
require(events[id].date>block.timestamp,"Event has already occured");
require(tickets[msg.sender][id]>=quantity,"you do not have enough tickets");
tickets[msg.sender][id]-=quantity;
tickets[receiver][id]+=quantity;
}
}