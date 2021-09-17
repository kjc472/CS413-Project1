// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function arrow4move(){
	//Phase 1
	with(inst_arrow4.head){
		TweenEasyMove(x,y,x+64,y,0,30,EaseInSine);
	}
	with(inst_arrow4.head.leftRef){
		TweenEasyMove(x,y,x+64,y,0,30,EaseInSine);
	}
	with(inst_arrow4.head.rightRef){
		TweenEasyMove(x,y,x+64,y,0,30,EaseInSine);
	}
	with(inst_fake4){
		TweenEasyMove(x,y,x+64,y,0,30,EaseInSine);
	}
	//Phase 2
	with(inst_arrow4.head.leftRef){
		TweenEasyMove(x,y,32,32,30,1,EaseInSine);
	}

	with(inst_arrow4){
		head = head.leftRef;
	}

	with(inst_fake4){
		TweenEasyMove(x,y,-32,32,0,1,EaseInSine);	
		sprite_index = inst_arrow4.head.leftRef.sprite_index;
	}
	//Special Case
	with(inst_arrow1){
		head = inst_arrow4.head;
	}
		with(inst_arrow2){
		head = inst_arrow4.head.rightRef;
	}
		with(inst_arrow3){
		head = inst_arrow4.head.leftRef;
	}
	//Special Case 2
		with(inst_fake1){
		sprite_index = inst_arrow4.head.sprite_index;
	}
		with(inst_fake2){
		sprite_index = inst_arrow4.head.rightRef.sprite_index;
	}
		with(inst_fake3){
		sprite_index = inst_arrow4.head.leftRef.sprite_index;
	}
	//Phase 3
	with(inst_arrow4){
		head.upRef.downRef = head.leftRef;
		head.downRef.upRef = head.leftRef;
		head.leftRef.upRef.downRef = head.rightRef;
		head.leftRef.downRef.upRef = head.rightRef;
		head.rightRef.downRef.upRef = head;
		head.rightRef.upRef.downRef = head;
		
		head.downRef = inst_arrow5.head;
		head.upRef = inst_arrow6.head;
		head.rightRef.downRef = inst_arrow5.head.rightRef;
		head.rightRef.upRef = inst_arrow6.head.rightRef;
		head.leftRef.downRef = inst_arrow5.head.leftRef;
		head.leftRef.upRef = inst_arrow6.head.leftRef;
	}
	isSolved(inst_room1);
}