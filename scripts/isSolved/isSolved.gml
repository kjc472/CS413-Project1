// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function isSolved(node)
{
	global.solvedRooms+=1;	
	var leftDoor = node.hasLeft;
	var rightDoor = node.hasRight;
	var upDoor = node.hasUp;
	var downDoor = node.hasDown;
	var startingDoor = node.x == 96 && node.y == 160;
	
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
	if(upDoor && node.isColHead)
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