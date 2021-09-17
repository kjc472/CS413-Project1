// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function arrow5move(){
	//Phase 1
	with(inst_arrow5.head){
		TweenEasyMove(x,y,x+64,y,0,30,EaseInSine);
	}
	with(inst_arrow5.head.leftRef){
		TweenEasyMove(x,y,x+64,y,0,30,EaseInSine);
	}
	with(inst_arrow5.head.rightRef){
		TweenEasyMove(x,y,x+64,y,0,30,EaseInSine);
	}
	with(inst_fake5){
		TweenEasyMove(x,y,x+64,y,0,30,EaseInSine);
	}
	//Phase 2
	with(inst_arrow5.head.leftRef){
		TweenEasyMove(x,y,32,96,30,1,EaseInSine);
	}

	with(inst_arrow5){
		head = head.leftRef;
	}
	with(inst_fake5){
		TweenEasyMove(x,y,-32,96,0,1,EaseInSine);	
		sprite_index = inst_arrow5.head.leftRef.sprite_index;
	}

	//Phase 3
	with(inst_arrow5){
		head.upRef.downRef = head.leftRef;
		head.downRef.upRef = head.leftRef;
		head.leftRef.upRef.downRef = head.rightRef;
		head.leftRef.downRef.upRef = head.rightRef;
		head.rightRef.downRef.upRef = head;
		head.rightRef.upRef.downRef = head;
		
		head.downRef = inst_arrow6.head;
		head.upRef = inst_arrow4.head;
		head.rightRef.downRef = inst_arrow6.head.rightRef;
		head.rightRef.upRef = inst_arrow4.head.rightRef;
		head.leftRef.downRef = inst_arrow6.head.leftRef;
		head.leftRef.upRef = inst_arrow4.head.leftRef;
	}
	isSolved(inst_room1);
}