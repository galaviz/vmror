function Tagger(id, feedback,position_x,position_y,width,height){
	this.feedback = document.getElementById(feedback);
	this.feedback.style.position = "absolute";
	this.element = document.getElementById(id);
	this.element.style.position = "relative";
	this.isMouseDown=false;
	this.element.onmousedown=this.wrap(this,"mouseDown");

	this.position_x_field = document.getElementById(position_x);
	this.position_y_field= document.getElementById(position_y);
	this.width_field = document.getElementById(width);
	this.height_field = document.getElementById(height);
}

Tagger.prototype.wrap=function(obj,method){
	return function(event){
		obj[method](event);
	}
}

Tagger.prototype.mouseDown=function(event){
	console.log("Mouse Down");
	this.oldMoveHandler=document.body.onmousemove;
	document.onmousemove=this.wrap(this,"mouseMove");
	this.oldUpHandler=document.body.onemouseup;
	document.onmouseup=this.wrap(this,"mouseUp");
	this.oldX=event.pageX;
	this.oldY=event.pageY;
	this.isMouseDown=true;
}

Tagger.prototype.mouseMove=function(event){
	if(!this.isMouseDown){
		return;
	}
	//find coordinates of parent
	var parentPos = findPos(this.element);
	var parentX = parentPos[0]; 
	var parentY = parentPos[1];
	var parentHeight = this.element.offsetHeight;
	var parentWidth = this.element.offsetWidth;
	
	this.newX = fitToBounds(event.pageX,parentX,parentX+parentWidth);
	this.newY = fitToBounds(event.pageY,parentY,parentY+parentHeight);
	
	this.feedback.style.width = Math.abs(this.newX-this.oldX)+"px";
	this.feedback.style.height = Math.abs(this.newY-this.oldY)+"px";
	this.feedback.style.left = (Math.min(this.newX,this.oldX)-parentX)+"px";
	this.feedback.style.top = (Math.min(this.newY,this.oldY)-parentY)+"px";
	this.updateFormFields();
			
}

Tagger.prototype.updateFormFields = function(){
	this.position_x_field.value = parseInt(this.feedback.style.left);
	this.position_y_field.value = parseInt(this.feedback.style.top);
	this.width_field.value = parseInt(this.feedback.style.width);
	this.height_field.value = parseInt(this.feedback.style.height);
}

function fitToBounds(x,lowerBound,upperBound){
	if (x<lowerBound) return lowerBound;
	if (x>upperBound) return upperBound;
	return x;
}

function findPos(obj) {
	var curleft = curtop = 0;
	if (obj.offsetParent) {
		do {
			curleft += obj.offsetLeft;
			curtop += obj.offsetTop;
		} while (obj = obj.offsetParent);
		return [curleft,curtop];
	}
}

Tagger.prototype.mouseUp=function(event){
	this.isMouseDown=false;
	document.onmousemove=this.oldMoveHandler;
	document.onmouseup=this.oldUpHandler;
}
;
