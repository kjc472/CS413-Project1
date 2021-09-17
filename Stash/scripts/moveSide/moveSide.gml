// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function moveSide(arrowRef)
{
	//Make temporary variables to store current info about room position and adjacencies
	var roomOne = arrowRef.head;
	var roomTwo = roomOne.rightRef;
	var roomThree = roomTwo.rightRef;
		
	var roomOneUp = roomOne.upRef;
	var roomOneDown = roomOne.downRef;
	var roomTwoUp = roomTwo.upRef;
	var roomTwoDown = roomTwo.downRef;
	var roomThreeUp = roomThree.upRef;
	var roomThreeDown = roomThree.downRef;
	
	//Reassign adjacencies
	roomOne.upRef = roomThreeUp;
	roomOne.downRef = roomThreeDown;
	roomThree.upRef = roomTwoUp;
	roomThree.downRef = roomTwoDown;
	roomTwo.upRef = roomOneUp;
	roomTwo.downRef = roomOneDown;

	//Reassign row/column head to roomTwo, as it is now in the top spot
	arrowRef.head = roomTwo;
	isSolved(arrowRef.head);

}