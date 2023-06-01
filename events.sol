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
}