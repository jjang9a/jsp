<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h3>Tiles가 적용된 member 페이지</h3>
<div>
	<table class="table">
		<!-- <form> -->
			id : <input type="text" id="id"><br>
			name : <input type="text" id="name"><br>
			passwd : <input type="text" id="passwd"><br>
			email : <input type="text" id="email"><br>
			auth : <input type="text" id="auth"><br>
			<button id="addBtn">등록</button>
		<!-- </form> -->
	</table>
</div>


<div>
	<table class="table">
		<thead>
			<tr><th>Id</th><th>Name</th><th>Pass</th><th>Mail</th><th>Auth</th><th>삭제</th>
		<tbody id="list">
		</tbody>
	</table>
</div>

<script>
	fetch('memberListAjax.do') // jason 포멧으로 데이터가 잘 넘어오는지 확인
	.then(function(resolve){
//		console.log(resolve); // body: readablestream
		return resolve.json(); // json 포맷에 따라 javascript object 변경
	})
	.then(function(result){
		console.log(result); // result : [{}, {}, ... {}]
		for (let i=0; i<result.length; i++){
			let id = result[i].id;
			let tr = document.createElement('tr');
			// td만들기 (아이디, 이름, 비번, 메일, 권한)
			for(let prop in result[i]){ // for .. in .. object의 필드 개수만큼 반복
				let td = document.createElement('td');
				td.innerText = result[i][prop];
				tr.append(td); // tr의 자식으로 td를 집어넣음	
			}
			// 삭제 버튼
			let delBtn = document.createElement('button'); // <button>삭제</button>
			delBtn.innerText = '삭제';
			delBtn.addEventListener('click', function(){
				console.log(this); // this => 이벤트 대상
				console.log(this.parentElement.parentElement.children[0].innerText);
				let delId = this.parentElement.parentElement.children[0].innerText;
				// ajax 호출
				fetch('memberRemoveAjax.do', {
					method : 'post',
					headers : {'Content-Type' : 'application/x-www-form-urlencoded'}, // key=val&key=val 형식
					body : 'id='+delId
				})
				.then(resolve => resolve.json()) // resolve라는 값이 json타입 {"retCode" : "Success"}으로 넘어옴
				.then(result => {
					console.log(result); //
					if(result.retCode == 'Success'){
						alert('성공!');
						this.parentElement.parentElement.remove(); // 화면에서 지워주는 기능
					} else if(result.retCode == 'Fail'){
						alert('실패!');
					}
				})
				.catch(reject => console.log(reject));
			});
			let td = document.createElement('td');
			td.append(delBtn); // <td><button>삭제</button></td>
			tr.append(td); // <tr>...<td><button>삭제</button></td></tr>
			
			document.getElementById('list').append(tr);
		}
	})
	.catch(function (reject){
		console.error(reject);
	})
	
	// 등록버튼 클릭 이벤트
 	document.getElementById('addBtn').addEventListener('click', function(){
		let id = document.querySelector('#id').value;
		let nm = document.querySelector('#name').value;
		let pw = document.querySelector('#passwd').value;
		let ma = document.querySelector('#email').value;
		let au = document.querySelector('#auth').value;
		if( !id || !nm || !pw || !ma || !au ){
			alert('값을 입력 해 주세요!');
			return;
		}
		// ajax 호출
		fetch('memberAddAjax.do', {
			method : 'post',
			headers : {'Content-Type' : 'application/x-www-form-urlencoded'},
			body: 'id='+id+'&name='+nm+'&passwd='+pw+'&email='+ma+'&auth='+au
		
		})
		.then(resolve => resolve.json())
		.then(result => {
			console.log(result);
		})
		.catch(reject => console.error(reject));
	});
	

</script>