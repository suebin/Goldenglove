<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
	const mycanvas = document.getElementById("mycanvas");
	const mycontext = mycanvas.getContext("2d");
	const myimage = new Image();
	myimage.src = "playground.png";
	
	if(myimage.width > mycanvas.width) {
		mycanvas.width = myimage.width;		
	}
	if(myimage.height > mycanvas.height) {
		mycanvas.height = myimage.height;
	}
	
	myimage.onload = function() {
		mycontext.drawImage(myimage, 0, 0, myimage.width, myimage.height);
			mycontext.fillStyle = "white";
			
			mycontext.fillRect(45, 115, 60, 25); //lf
			if("${teamDTO.getLeftFielder().split(' ')[1]}" != ""){
				mycontext.fillRect(45, 145, 60, 25);
			}
			
			mycontext.fillRect(225, 60, 60, 25); //cf
			if("${teamDTO.getCenterFielder().split(' ')[1]}" != ""){
				mycontext.fillRect(225, 90, 60, 25);
			}
			
			mycontext.fillRect(400, 115, 60, 25); //rf
			if("${teamDTO.getRightFielder().split(' ')[1]}" != ""){
				mycontext.fillRect(400, 145, 60, 25);
			}
			
			mycontext.fillRect(170, 260, 60, 25); //ss
			if("${teamDTO.getShortStop().split(' ')[1]}" != ""){
				mycontext.fillRect(170, 290, 60, 25);
			}
			
			mycontext.fillRect(285, 250, 60, 25); //2루
			if("${teamDTO.getSecondBase().split(' ')[1]}" != ""){
				mycontext.fillRect(285, 280, 60, 25);
			}
			
			mycontext.fillRect(115, 330, 60, 25); // 3루
			if("${teamDTO.getThirdBase().split(' ')[1]}" != ""){
				mycontext.fillRect(115, 360, 60, 25);
			}
			
			mycontext.fillRect(235, 345, 60, 25); // p
			if("${teamDTO.getPitcher().split(' ')[1]}" != ""){
				mycontext.fillRect(235, 375, 60, 25);
			}
			
			mycontext.fillRect(355, 340, 60, 25); // 1
			if("${teamDTO.getFirstBase().split(' ')[1]}" != ""){
				mycontext.fillRect(355, 370, 60, 25);
			}
			
			mycontext.fillRect(285, 460, 60, 25); // c
			if("${teamDTO.getCatcher().split(' ')[1]}" != ""){
				mycontext.fillRect(350, 460, 60, 25);
			}
			
			mycontext.font = "bold 15px 비트로 프라이드 OTF";
			mycontext.fillStyle = "black";
			
			mycontext.fillText("${teamDTO.getLeftFielder().split(' ')[0]}",50,132);
			mycontext.fillText("${teamDTO.getLeftFielder().split(' ')[1]}",50,162);
			
			mycontext.fillText("${teamDTO.getCenterFielder().split(' ')[0]}",230,77);
			mycontext.fillText("${teamDTO.getCenterFielder().split(' ')[1]}",230,107);
			
			mycontext.fillText("${teamDTO.getRightFielder().split(' ')[0]}",405,132);
			mycontext.fillText("${teamDTO.getRightFielder().split(' ')[1]}",405,162);
			
			mycontext.fillText("${teamDTO.getShortStop().split(' ')[0]}",175,277);
			mycontext.fillText("${teamDTO.getShortStop().split(' ')[1]}",175,307);
			
			mycontext.fillText("${teamDTO.getSecondBase().split(' ')[0]}",290,267);
			mycontext.fillText("${teamDTO.getSecondBase().split(' ')[1]}",290,297);
			
			mycontext.fillText("${teamDTO.getThirdBase().split(' ')[0]}",120,347);
			mycontext.fillText("${teamDTO.getThirdBase().split(' ')[1]}",120,377);
			
			mycontext.fillText("${teamDTO.getPitcher().split(' ')[0]}",240,362);
			mycontext.fillText("${teamDTO.getPitcher().split(' ')[1]}",240,392);
			
			mycontext.fillText("${teamDTO.getFirstBase().split(' ')[0]}",360,357);
			mycontext.fillText("${teamDTO.getFirstBase().split(' ')[1]}",360,387);
			
			mycontext.fillText("${teamDTO.getCatcher().split(' ')[0]}",290,477);
			mycontext.fillText("${teamDTO.getCatcher().split(' ')[1]}",355,477);
		
	}
});
</script>
</head>
<body>
	<canvas id="mycanvas" width="500" height="500"></canvas>
</body>
</html>