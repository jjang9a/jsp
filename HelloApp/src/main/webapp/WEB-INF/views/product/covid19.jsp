<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <!-- 시도 : <input type="text" id="sido"> -->
    시도선택 : <select id="sidoList">
                    <!-- <option value="서울특별시">서울특별시</option>
                    <option value="인천광역시">인천광역시</option>
                    <option value="대전광역시">대전광역시</option> -->
               </select>
    <button id="sidoBtn">찾기</button>

    <table border="1px">
        <thead>
            <tr><th>아이디</th><th>센터명</th><th>주소</th><th>연락처</th><th>시도</th></tr>
        </thead>
        <tbody id="centerList"></tbody>
    </table>

    <script>
        let showFields = ['id', 'centerName', 'address', 'phoneNumber', 'sido'] // 보여줄 필드

        // row 생성하는 기능
        function makeTr(center={}){ // 객체타입의 center를 변수로 받는 함수
            // tr생성 > td*여러개
            let tr = document.createElement('tr');
            
            // tr에 지도 띄우는 이벤트 생성 : 이벤트로 해도 되고 <a href>도 가능
            tr.setAttribute('data-lng', center.lng);
            tr.setAttribute('data-lat', center.lat);
            tr.addEventListener('click', openMapFnc);
            
            // td 생성
            showFields.forEach(function(prop){
                let td = document.createElement('td');
                td.innerText = center[prop];
                tr.append(td);
            })
            return tr;
        }

        // 전체목록
        let totalList; // 밖에 빼 두는 목적 : 다른함수에서도 활용하기 위함
        // 목록 가져오는 부분
        let url = `https://api.odcloud.kr/api/15077586/v1/centers?page=1&perPage=284&serviceKey=FH8wVb0%2Fec8aVYcjYbxtGwm%2FL3O5j8OkJf%2Fo3xtEjm%2BaOJRtz%2FsN61go4x6O2ip6t6tZ0HD1%2BRKW3s%2BNTiyrvw%3D%3D`
        fetch(url)
        .then(resolve => resolve.json())
        .then(result => {
            console.log(result);
            let aryData = result.data; // result가 가지고 있는 data라는 속성
            totalList = aryData; // 처리결과를 totalList에 담아둠
            aryData.forEach(function(center){ // forEach : 배열의 갯수만큼 함수를 실행
                let tr = makeTr(center); // center정보를 가지고 만들어진 tr정보
                document.querySelector('#centerList').append(tr);
            });

            // 시도 배열
            
            // totalList; <- 객체를 담고 있는 배열 : {id, centerName, address, .. , sido} - sido : 존재하지만 중복되는값
            // ㄴ 얘가 fetch밖에있으면 totalList는 그저 빈껍데기일뿐... fetch괄호 안으로 들어와야함 (왜냠:비동기방식)
            // 배열안에 값이 있는지 없는지 check <- indexOf 활용
            // 배열 : 추가 push, 빼고싶다 pop, 맨앞에 넣고싶다 unshift, 맨뒤에넣고싶다 shift
            let sidoAry = [];
            totalList.forEach(function(info){ // function(info){ 를 info => { 로 갈음하여 사용가능
                let sido = info.sido
                if(sidoAry.indexOf(sido) == -1){
                    sidoAry.push(sido)
                }
            })
            // let sidoAry = ['서울특별시', '인천광역시', '대전광역시']
            sidoAry.forEach(function(sido){ // sidoAry의 갯수만큼 돌면서
                let opt = document.createElement('option'); // 옵션태그를 만들겠다
                opt.value = sido;
                opt.innerText = sido;
                document.querySelector('#sidoList').append(opt); // 만든 옵션태그를 sidoList에 집어넣겠다
            })
        })
        .catch(reject => console.error(reject));


        // 찾기 버튼
        document.querySelector('#sidoBtn').addEventListener('click', findSidoFnc);
        function findSidoFnc(){
            // 검색으로 만들어진 새로운 정보를 표시하기 전에 화면에 띄워진 이전의 정보들을 지워줌
            document.querySelector('#centerList').innerHTML = '';

            // 전체목록. 검색조건 filter한 결과를 다시 tbody의 하위목록으로 출력
            let searchWord = document.getElementById('sidoList').value;
            let filterAry = totalList.filter(function(center){
                console.log(center);
                return center.sido == searchWord;
            });
            console.log(filterAry);
            //forEach와의 차이점 : 값(새로운 배열)을 리턴해줌. 리턴값이 true이면 배열에 값을 넣어주고 false이면 안넣어줌

            filterAry.forEach(center => { // 이 center정보를 활용하여 새 tr을 생성
                document.querySelector('#centerList').append(makeTr(center));
            })
        }


        // 지도 띄우는 이벤트
        function openMapFnc(){
            let tr = this; // event target
            let lng = tr.dataset.lng; // tr.getAttribute('data-lng')로도 가능
            let lat = tr.dataset.lat; // tr.getAttribute('data-lat')로도 가능
            let name = tr.children[1].innerText;
            location.href = 'map.do?lng='+lng+'&lat='+lat+'&name='+name;
        }
    </script>
</body>
</html>