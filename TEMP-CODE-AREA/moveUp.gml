function moveUp()
{
	//Make temporary variables to store current info about room position and adjacencies
	var roomOne = arrowRef.head;
	var roomTwo = roomOne.downRef;
	vat roomThree = roomTwo.downRef;
	
	var roomOneY = roomOne.y;
	var roomTwoY = roomTwo.y;
	var roomThreeY = roomThree.y;
	
	
	var roomOneLeft = roomOne.leftRef;
	var roomOneRight = roomOne.rightRef;
	var roomTwoLeft = roomTwo.leftRef;
	var roomTwoRight = roomTwo.rightRef;
	var roomThreeLeft = roomThree.leftRef;
	var roomThreeRight = roomThree.rightRef;

	//Move each room to new position
	roomOne.y = roomThreeY;
	roomOne.isColHead = 0;
	roomThree.y = roomTwoY;
	roomTwo.y = roomOneY;
    roomTwo.isColHead = 1;
	
	//Reassign adjacencies
	roomOne.leftRef = roomThreeLeft;
	roomOne.rightRef = roomThreeRight;
	roomThree.leftRef = roomTwoLeft;
	roomThree.rightRef = roomTwoRight;
	roomTwo.leftRef = roomOneLeft;
	roomTwo.rightRef = roomOneRight;

	//Reassign row/column head to roomTwo, as it is now in the top spot
	arrowRef.head = roomTwo;
	
	if(arrowRef == leftColArrowRef)
	{
        topRowArrowRef.head = roomTwo;
        midRowArrowRef.head = roomThree;
        botRowArrowRef.head = roomOne;
    }
	if(isSolved())
	{
        room_goto(rm_win);
    }

}

function isSolved(node)
{
	global.solvedRooms+=1;
	var col;
	var row;
	var colSize = 3;
	var rowSize = 3;
	
	var leftDoor = node.hasLeft;
	var rightDoor = node.hasRight;
	var upDoor = node.hasUp;
	var downDoor = node.hasDown;
	var startingDoor = node.downRef.isColHead && !(node.x == 96 && node.y == 160);
	
	if(leftDoor && node.isRowHead)
	{
		global.solvedRooms=0;
		return false;
	}
	if(rightDoor && node.rightRef.isRowHead)
	{
		global.solvedRooms=0;
		return false;
	}
	if(topDoor && node.isColHead)
	{
		global.solvedRooms=0;
		return false;
	}
	if(downDoor && !startingDoor)
	{
		global.solvedRooms=0;
		return false;
	}
	if(leftDoor)
	{
		return isSolved(node.leftRef);
	}
	if(rightDoor)
	{
		return isSolved(node.rightRef);
	}
	if(upDoor)
	{
		return isSolved(node.upRef);
	}
	if(downDoor && !startingDoor)
	{
		return isSolved(node.downRef);
	}
	if(global.solvedRooms = 9)
	{
		return true;
	}
	return false;

}