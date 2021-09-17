// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function moveUp(arrowRef)
{
	//Make temporary variables to store current info about room position and adjacencies
	var roomOne = arrowRef.head;
	var roomTwo = roomOne.downRef;
	var roomThree = roomTwo.downRef;

	
	var roomOneLeft = roomOne.leftRef;
	var roomOneRight = roomOne.rightRef;
	var roomTwoLeft = roomTwo.leftRef;
	var roomTwoRight = roomTwo.rightRef;
	var roomThreeLeft = roomThree.leftRef;
	var roomThreeRight = roomThree.rightRef;

	//Reassign adjacencies
	roomOne.leftRef = roomThreeLeft;
	roomOne.rightRef = roomThreeRight;
	roomThree.leftRef = roomTwoLeft;
	roomThree.rightRef = roomTwoRight;
	roomTwo.leftRef = roomOneLeft;
	roomTwo.rightRef = roomOneRight;

	//Reassign row/column head to roomTwo, as it is now in the top spot
	arrowRef.head = roomTwo;
	isSolved(arrowRef.head);
	if(global.solvedRooms == 9)
	{
        room_goto(rm_win);
    }



}