// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function isSolved(node)
{
	global.solvedRooms+=1;	
	var leftDoor = node.hasLeft;
	var rightDoor = node.hasRight;
	var upDoor = node.hasUp;
	var downDoor = node.hasDown;
	var startingDoor = (node.x == 96 && node.y == 160);
	
	if(leftDoor && node.isRowHead)
	{
		global.solvedRooms=0;
		return;
	}
	if(rightDoor && node.rightRef.isRowHead)
	{
		global.solvedRooms=0;
		return;
	}
	if(upDoor && node.isColHead)
	{
		global.solvedRooms=0;
		return;
	}
	if(downDoor && !startingDoor)
	{
		global.solvedRooms=0;
		return;
	}
	if(leftDoor)
	{
		isSolved(node.leftRef);
	}
	if(rightDoor)
	{
		isSolved(node.rightRef);
	}
	if(upDoor)
	{
		isSolved(node.upRef);
	}
	if(downDoor && !startingDoor)
	{
		isSolved(node.downRef);
	}
	if(global.solvedRooms == 9)
	{
        room_goto(rm_win);
    }

}