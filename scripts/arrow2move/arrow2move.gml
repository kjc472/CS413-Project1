// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function arrow2move(){
	//Phase 1
	with(inst_arrow2.head){
		TweenEasyMove(x,y,x,y-64,0,30,EaseInSine);
	}
	with(inst_arrow2.head.downRef){
		TweenEasyMove(x,y,x,y-64,0,30,EaseInSine);
	}
	with(inst_arrow2.head.upRef){
		TweenEasyMove(x,y,x,y-64,0,30,EaseInSine);
	}
	with(inst_fake2){
		TweenEasyMove(x,y,x,y-64,0,30,EaseInSine);
	}
	//Phase 2
	with(inst_arrow2.head){
		TweenEasyMove(x,y,96,160,30,1,EaseInSine);
	}

	with(inst_arrow2){
		head = head.downRef;
	}
	with(inst_fake2){
		TweenEasyMove(x,y,96,224,0,1,EaseInSine);	
		sprite_index = inst_arrow2.head.sprite_index;
	}
	//Phase 3
	with(inst_arrow2){
		head.rightRef.leftRef = head.downRef;
		head.leftRef.rightRef = head.downRef;
		head.upRef.rightRef.leftRef = head;
		head.upRef.leftRef.rightRef = head;
		head.downRef.rightRef.leftRef = head.upRef;
		head.downRef.leftRef.rightRef = head.upRef;
		
		head.rightRef = inst_arrow3.head;
		head.leftRef = inst_arrow1.head;
		head.downRef.rightRef = inst_arrow3.head.downRef;
		head.downRef.leftRef = inst_arrow1.head.downRef;
		head.upRef.rightRef = inst_arrow3.head.upRef;
		head.upRef.leftRef = inst_arrow1.head.upRef;
	}
	isSolved(inst_room1);
}