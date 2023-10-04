/**
 * 
 */
$(function() {
	
	// 게시글 쓰기 - 등록하기 버튼 클릭시
	// $('#writeForm').submit(function() {} );
	$('#writeForm').on("submit", function() {
		
		// let writer = document.getElementById('writer').value;
		if($('#writer').val().length <= 0) {
			alert("작성자를 입력해주세요");
			$('#writer').focus(); // 커서 이동
			return false; // 다음 동작을 멈춰라, submit 멈춤
		}
		if($('#pass').val().length <= 0) {
			alert("비밀번호를 입력해주세요");
			$('#pass').focus();
			return false;
		}
		if($('#title').val().length <= 0) {
			alert("제목을 입력해주세요");
			$('#title').focus();
			return false;
		}
		if($('#content').val().length <= 0) {
			alert("내용을 입력해주세요");
			$('#content').focus();
			return false;
		}
		
	});
	
	
	// 게시글 상세보기 - 수정하기 버튼 클릭시
	$('#detailUpdate').on("click", function() {
		
		let pass = $('#pass').val();
		
		if(pass.length <=0) {
			alert("게시글을 수정하려면 비밀번호를 입력하세요");
			return ;
		}
		
		$('#rPass').val(pass);
		$('#checkForm').attr("action", "updateForm.jsp").attr("method", "post");
		$('#checkForm').submit();
		
	});
	
	
	// 게시글 수정
	$('#updateForm').on("submit", function() {

		if($('#writer').val().length <= 0) {
			alert("작성자를 입력해주세요");
			$('#writer').focus(); // 커서 이동
			return false; // 다음 동작을 멈춰라, submit 멈춤
		}
		if($('#pass').val().length <= 0) {
			alert("비밀번호를 입력해주세요");
			$('#pass').focus();
			return false;
		}
		if($('#title').val().length <= 0) {
			alert("제목을 입력해주세요");
			$('#title').focus();
			return false;
		}
		if($('#content').val().length <= 0) {
			alert("내용을 입력해주세요");
			$('#content').focus();
			return false;
		}
		
	});
	
	
});