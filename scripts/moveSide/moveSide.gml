// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function moveSide(arrowRef)
{
	//Make temporary variables to store current info about room position and adjacencies
	var roomOne = arrowRef.head;
	var roomTwo = roomOne.rightRef;
	var roomThree = roomTwo.rightRef;
	
	var roomOneX = roomOne.x;
	var roomTwoX = roomTwo.x;
	var roomThreeX = roomThree.x;
	
	
	var roomOneLeft = roomOne.leftRef;
	var roomOneRight = roomOne.rightRef;
	var roomTwoLeft = roomTwo.leftRef;
	var roomTwoRight = roomTwo.rightRef;
	var roomThreeLeft = roomThree.leftRef;
	var roomThreeRight = roomThree.rightRef;

	//Move each room to new position
	roomOne.x = roomThreeX;
	roomOne.isRowHead = 0;
	roomThree.x = roomTwoX;
	roomTwo.x = roomOneX;
    roomTwo.isRowHead = 1;
	
	//Reassign adjacencies
	roomOne.leftRef = roomThreeLeft;
	roomOne.rightRef = roomThreeRight;
	roomThree.leftRef = roomTwoLeft;
	roomThree.rightRef = roomTwoRight;
	roomTwo.leftRef = roomOneLeft;
	roomTwo.rightRef = roomOneRight;

	//Reassign row/column head to roomTwo, as it is now in the top spot
	arrowRef.head = roomTwo;

	if(isSolved(arrowRef.head))
	{
        room_goto(rm_win);
    }



}