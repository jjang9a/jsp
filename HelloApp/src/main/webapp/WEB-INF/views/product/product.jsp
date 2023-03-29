<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- Product section-->
<section class="py-5">
	<div class="container px-4 px-lg-5 my-5">
		<div class="row gx-4 gx-lg-5 align-items-center">
			<div class="col-md-6">
				<img class="card-img-top mb-5 mb-md-0" src="./images/${info.image }" alt="..." />
			</div>
			<div class="col-md-6">
				<div class="small mb-1">${info.productCode }</div>
				<h1 class="display-5 fw-bolder">${info.productName }</h1>
				<div class="fs-5 mb-5">
					<span class="text-decoration-line-through">${info.originPrice }</span> <span>${info.salePrice }</span>
				</div>
				<p class="lead">
					${info.productDesc }</p>
				<div class="d-flex">
					<input class="form-control text-center me-3" id="inputQuantity"
						type="num" value="1" style="max-width: 3rem" />
					<button class="btn btn-outline-dark flex-shrink-0" type="button">
						<i class="bi-cart-fill me-1"></i> Add to cart
					</button>
				</div>
			</div>
		</div>
	</div>
</section>

<!-- 댓글 영억 -->
<input type="text" id="writer" value="user02">
<input type="text" id="content">
<button id="addContent">댓글등록</button>

<table class="table">
	<thead>
		<tr>
			<th>댓글번호</th>
			<th>작성자</th>
			<th>댓글내용</th>
			<th>삭제</th>
		</tr>
	</thead>
	<tbody id="list">
		<!-- <tr>
			<td>1</td>
			<td>user01</td>
			<td>reply test</td>
			<td><button>삭제</button></td>
		</tr> -->
	</tbody>
</table>

<div>
<table>
	<tr id="template">
		<td class="replyNo"></td>
		<td class="replyWriter"></td>
		<td><input class="replyContent" type="text"></td>
		<td><button onclick="updateReply(this)">저장</button></td>
		<!-- <td><button onclick="updateReply(event)">저장</button></td> 이벤트를 변수에 담을수 있음 -->
	</tr>
</table>
</div>

<script>

// 목록 데이터 가져오기
// fetch에서 리턴해주는 값은 promise라고 하는 객체임
/* let promiseResult = fetch('');
promiseResult.then(function(){ })*/
fetch('replyListAjax.do?code=${info.productCode}')
/* .then(function (resolve){
	return resolve.json();
}) */
// 위의 구문을 화살표 함수로 변경하면(뺄 수 있는거 다 빼면 됨) 아래의 모습과 같이 됨. 매개변수가 하나밖에 없을때는 resolve쪽의 괄호도 제거 가능
.then(resolve => resolve.json())
		// [json 타입 {"id":"user1", "name":"사용자1", ... } -> js 오브젝트 타입]
.then(result => {
	console.log(result);
	// 값을 이용해서 tr 생성
	// result가 배열 타입이기때문에 배열내 반복 forEach 사용 가능
	result.forEach(function(reply){ 
		let tr = makeRow(reply);
		document.getElementById('list').append(tr);
	});
})
.catch(reject => console.error(reject));

let showProps = ['replyNo', 'replyWriter','replyContent']
function makeRow(reply={}){
	let tr = document.createElement('tr');
	tr.addEventListener('dblclick', modifyTr);
	// td 생성
	showProps.forEach(function(prop) {
		let td = document.createElement('td')
		td.innerText = reply[prop];
        tr.append(td);
		tr.setAttribute('id', reply.replyNo);
	})
	// 항목 외에 추가하는 기능
	let btn = document.createElement('button');
	btn.innerText = '삭제';
    btn.addEventListener('click', removeReply); // 삭제처리
	// 만약에 removeReply()가 되있으면 불러오면서 일단 실행됨. 클릭했을때만 실행하고싶다면 괄호 적지말것.
    let td = document.createElement('td');
    td.append(btn);
    tr.append(td);
    // document.getElementById('list').append(tr)
    // makeRow를 호출하는 영역에서 처리하도록 tr을 반환
    return tr;
}

// 화면 수정할 수 있도록 처리
function modifyTr(){
	console.log(this);
	let id = this.id;
	let oldTr = this;
	
	// 댓글 한건 조회
	fetch('replySearchAjax.do?replyNo='+id)
	.then(resolve => resolve.json())
	.then(result => {
		console.log(result);
		let data = result;
		// makeEditRow(data);
		// oldTr.innerHTML = makeEditRow2(data);
		let tr = makeEditRow3(data);
		document.getElementById('list').replaceChild(tr, oldTr);
	})
	.catch(reject => console.error(reject));
}

function makeEditRow(){
	let newTr = document.createElement('tr');
	let td = document.createElement('td');
	td.innerText = data.replyNo;
	newTr.append(td);

	td = document.createElement('td');
	td.innerText = data.replyWrite;
	newTr.append(td);

	td = document.createElement('td');
	let input = document.createElement('input');
	input.value = data.replyContent;
	td.append(input);
	newTr.append(td);

	td = document.createElement('td');
	let btn = document.createElement('button');
	btn.innerText = '저장';
	btn.addEventListener('click', updateReply);
	td.append(btn);
	newTr.append(td);

	console.log(newTr);
	document.getElementById('list').replaceChild(newTr, oldTr);
}

function makeEditRow2(data){
	// <td>10</td><td>user03</td><td><input value=""></td><td><button>저장</button></td>
	let str = "";
	str += "<td>"+data.replyNo+"</td>"
	str += "<td>"+data.replyWriter+"</td>"
	str += "<td><input value="+data.replyContent+"></td>"
	str += "<td><button onclick='updateReply()'>저장</button></td>";
	console.log(str)
	return str;
}

function makeEditRow3(data){
	let cloneTr = document.getElementById('template').cloneNode(true); // cloneNode는 그 Element를 복사하는 명령어
	cloneTr.querySelector('.replyNo').innerText = data.replyNo;
	cloneTr.querySelector('.replyWriter').innerText = data.replyWriter;
	cloneTr.querySelector('.replyContent').value = data.replyContent;
	//cloneTr.querySelector('button').onclick='updateReply('+data.replyNo+')'
	console.log(cloneTr);
	return cloneTr;
}

function updateReply(a){
	console.log(this);
	// 위에서 (event했을 경우) a.target(이벤트의 타겟=버튼).parentElement.parentElement;
	let oldTr = a.parentElement.parentElement;
	let no = oldTr.querySelector('.replyNo').innerText
	let writer = oldTr.querySelector('.replyWriter').innerText
	let content = oldTr.querySelector('.replyContent').value

	fetch('replyUpdateAjax.do', {
		method : 'post',
		headers : {'Content-Type' : 'application/x-www-form-urlencoded'},
		body : 'replyNo='+no+'&replyWriter='+writer+'&replyContent='+content
	})
	.then(resolve => resolve.json())
	.then(result => {
		console.log(result)
		if(result.retCode == 'Success'){
			alert('성공')
			let newTr = makeRow(result.reply)
			console.log('궁금한거 : ',document.getElementById('list'))
			console.log('궁금한거2 : ',a)
			console.log('궁금한거3 : ',newTr)
			document.getElementById('list').replaceChild(newTr, oldTr);
		}else if(result.retCode == 'Fail'){
			alert('실패')
		}else{
			alert('retCode를 확인하세요')
		}
	})
	.catch(reject => console.error(reject));
}
// function updateReply(){
// 	let oldTr = this.parentElement.parentElement;
// 	let data = {replyNo : 8, replyWriter : 'user02', replyContent:'change test'}
// 	let newTr = makeRow2(data);
// 	document.getElementById('list').replaceChild(newTr,oldTr);
// }

// 댓글 삭제
function removeReply(){
	let id = this.parentElement.parentElement.id
	fetch('replyRemoveAjax.do?replyId='+id)
	.then(resolve => resolve.json())
	.then(result => {
		console.log(result)
		if(result.retCode == 'Success'){
			alert('성공')
			document.getElementById(id).remove();	
		}else if(result.retCode == 'Fail'){
			alert('실패')
		}else{
			alert('retCode값을 확인하세요!')
		}
	})
	.catch(reject => console.error(reject));
}

// 댓글 등록
document.querySelector('#addContent').addEventListener('click', addReply);

function addReply(){
	// writer, content의 value
	let writer = document.querySelector('#writer').value;
	let content = document.querySelector('#content').value;
	fetch('replyAddAjax.do', { // 넘겨야 할 값이 여러개이므로 옵션값을 객체타입으로 넘김
		method : 'post', // 값이 여러개일때는 넘어가는 값이 많아서 대체적으로 post방식을 이용
		headers : {'Content-Type' : 'application/x-www-form-urlencoded'},
		body : 'writer='+writer+'&content='+content+'&pcode=${info.productCode}'
	})
	.then(resolve => resolve.json())
	.then(result => {
		console.log(result)
		if(result.retCode == 'Success'){
			alert('성공');
			let tr = makeRow(result.reply);
			document.getElementById('list').append(tr);
			
			// 댓글 입력부분 초기화
			document.querySelector('#content').value='';
		}else if(result.retCode == 'Fail'){
			alert('실패');
		}else{
			alert("retCode를 확인하세요")
			// returnCode 줄여서 retCode로 쓴거임
		}
	})
	.catch(reject => console.error(reject))
}


</script>


<!-- Related items section-->
<section class="py-5 bg-light">
	<div class="container px-4 px-lg-5 mt-5">
		<h2 class="fw-bolder mb-4">Related products</h2>
		<div
			class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
			
			<c:forEach var="vo" items="${reco }">
				<div class="col mb-5">
					<div class="card h-100">
						<!-- Sale badge-->
						<div class="badge bg-dark text-white position-absolute"
							style="top: 0.5rem; right: 0.5rem">Sale</div>
						<!-- Product image-->
						<img class="card-img-top"
							src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
						<!-- Product details-->
						<div class="card-body p-4">
							<div class="text-center">
								<!-- Product name-->
								<h5 class="fw-bolder">Special Item</h5>
								<!-- Product reviews-->
								<div
									class="d-flex justify-content-center small text-warning mb-2">
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
								</div>
								<!-- Product price-->
								<span class="text-muted text-decoration-line-through">$20.00</span>
								$18.00
							</div>
						</div>
						<!-- Product actions-->
						<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
							<div class="text-center">
								<a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>

		</div>
	</div>
</section>