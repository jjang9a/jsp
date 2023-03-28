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

<script>
// 목록 데이터 가져오기
// fetch에서 리턴해주는 값은 promise라고 하는 객체임
/* let promiseResult = fetch('');
promiseResult.then(function(){ })*/
fetch('replyListAjax.do?code=CF0001')
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
		makeRow(reply)
	});
})
.catch(reject => console.error(reject));

let showProps = ['replyNo', 'replyWriter','replyContent']
function makeRow(reply={}){
	let tr = document.createElement('tr');
	tr.addEventListener('dblclick', modifyTr);
	showProps.forEach(function(prop,idx,array) {
		let td = document.createElement('td')
		td.innerText = reply[prop];
        tr.append(td);
		tr.setAttribute('id', reply.replyNo);
	})
	let btn = document.createElement('button');
	btn.innerText = '삭제';
    btn.addEventListener('click', removeReply);
	// 만약에 removeReply()가 되있으면 불러오면서 일단 실행됨. 클릭했을때만 실행하고싶다면 괄호 적지말것.
    let td = document.createElement('td');
    td.append(btn);
    tr.append(td);

    document.getElementById('list').append(tr)
}

// 수정 할때 쓸 코드
function makeRow2(reply = {}) {// tr>td*4
        let tr = document.createElement('tr');
        tr.addEventListener('dblclick', modifyTr);
        tr.id = reply.replyNo; // tr의 id의 attribute에 댓글 번호.
        showProps.forEach(function (prop) {
            let td = document.createElement('td');
            td.innerText = reply[prop]; console.log(reply[prop]);
            tr.append(td);
        })
        let td = document.createElement('td');
        let btn = document.createElement('button');
        btn.addEventListener('click', removeReply); // 삭제처리.
        btn.innerText = '삭제';
        td.append(btn);
        tr.append(td);
		
        return tr;
    }

function modifyTr(){
	console.log(this);
	let oldTr = this;
	let data = {replyNo : 8, replyWriter : 'user02', replyContent:'test'}
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

function updateReply(){
	let oldTr = this.parentElement.parentElement;
	let data = {replyNo : 8, replyWriter : 'user02', replyContent:'change test'}
	let newTr = makeRow2(data);
	document.getElementById('list').replaceChild(newTr,oldTr);
}

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
		body : 'writer='+writer+'&content='+content+'&pcode=CF0001'
	})
	.then(resolve => resolve.json())
	.then(result => {
		console.log(result)
		if(result.retCode == 'Success'){
			alert('성공');
			makeRow(result.reply);
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