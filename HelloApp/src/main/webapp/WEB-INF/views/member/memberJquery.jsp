<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="./jQuery/jquery-3.6.4.min.js"></script>
    <script>
        // document 로딩 후 처리
        $(document).ready(function () {
            // fetch('url', {option})
            $.ajax({
                url: "memberListJquery.do", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
                data: {
                    name: "홍길동" // request.getParameter('name');
                        ,
                    id: 'user01' // request.getParameter('id');
                }, // HTTP 요청과 함께 서버로 보낼 데이터 (주로 조회, 입력 할 때 이용)
                method: "GET", // HTTP 요청 방식(GET, POST)
                dataType: "json", // 서버에서 보내줄 데이터의 타입 : JSON.parse() 실행
                success: function (result) { // 서버 요청 성공시 실행 할 함수
                    $(result).each(function (idx, member) {
                        // forEach : 첫번째가 요소, 두번째가 인덱스 - each : 첫번째가 인덱스, 두번째가 요소
                        console.log(idx, member);
                        $('#list').append(
                            // tr>td*4 생성
                            $('<tr id=' + member.memberId + ' />').append($('<td />')
                                .text(member.memberId),
                                $('<td />').text(member.memberName),
                                $('<td />').text(member.memberAddr),
                                $('<td />').text(member.memberTel),
                                $('<td />').text(member.memberPw),
                                $('<td />').append($('<button />').text('삭제').on(
                                    'click', rowDeleteFnc)),
                                $('<td />').append($('<input />').attr('type',
                                    'checkbox'))
                            )
                        );
                    });
                },
                error: function (err) { // 서버 요청 실패시 실행 할 함수
                    console.lot(err)
                }
            }) // ajax가 끝나는 부분

            function rowDeleteFnc() {
                // 여기서 this = 버튼
                // 버튼의 모든 부모요소들 중 tbody전까지(tr까지)
                $(this).parentsUntil('tbody').remove();
            }

            // 등록 기능
            $('#addBtn').on('click', function (e) {
                e.preventDefault(); // 전송 기능 차단
                // 사용자가 필수입력값을 입력했는지 validation하고
                if ($('#id').val() == '' || $('#name').val() == '' || $('#addr').val() == '' || $(
                        '#tel').val() == '' ||
                    $('#passwd').val() == '') {
                    alert('입력값이 부족합니다')
                    return
                }
                console.log($('#passwd').val())
                $.ajax({
                    url: "memberAddJquery.do",
                    data: {
                        id: $('#id').val(),
                        name: $('#name').val(),
                        addr: $('#addr').val(),
                        tel: $('#tel').val(),
                        pw: $('#passwd').val()
                    },
                    method: "post", // 대체적으로 추가할때는 post방식을 많이 이용 
                    dataType: "json",
                    // .done / .fail 도 가능
                    success: function (result) {
                        if (result.retCode == 'Success') {
                            alert('등록 성공!')
                            $('#list').append(
                                $('<tr id=' + member.memberId + ' />').append($(
                                        '<td />').text($('#id').val()),
                                    $('<td />').text($('#name').val()),
                                    $('<td />').text($('#addr').val()),
                                    $('<td />').text($('#tel').val()),
                                    $('<td />').text($('#passwd').val()),
                                    $('<td />').append($('<button />').text('삭제').on(
                                        'click', rowDeleteFnc)),
                                    $('<td />').append($('<input />').attr('type',
                                        'checkbox'))
                                )
                            );
                        } else if (result.retCode == 'Fail') {
                            alert('처리중 에러가 발생하였습니다')
                        } else {
                            alert('retCode를 확인하세요')
                        }
                    },
                    error: function (reject) {}
                })
            })

            // 선택 삭제
            $('#delSelected').on('click', function (e) {
                e.preventDefault();
                // $(":checked").parentsUntil('tbody').remove();
                // $(":checked").closest('tr').remove();
                let memberIdAray = {}
                $('#list input:checked').each(function (idx, item) {
                    // memberIdAray.push({'memberId': $(item).parent().parent().attr('id')})
                    // $(item).closest('tr').remove();
                    memberIdAray.memberId = $(item).parent().parent().attr('id');
                })
                console.log(memberIdAray);
            })

            // 전체 선택, 제거
            $('th>input[type="checkbox"]').on('change', function (e) {
                // $('td>input').attr('checked', 'checked')
                $('td>input').prop({
                    checked: this.checked
                })

                // ajax 호출
                $.ajax({
                    url: '', // 호출할 컨트롤
                    method: 'post',
                    data: memberIdAray, //memberId=user01&memberId=user02&...
                    success: function (result) {

                    },
                    error: function (reject) {

                    }
                })

            })

            // 전체 다 선택되면 위에도 선택되게끔
            // ajax호출의 결과로 만들어지는 부분. (아직 td가 만들어지기 전)
            // 이벤트 위임. 상위요소에 이벤트를 걸어놓고 실제 이벤트가 걸리는곳은 'change' 뒤에 배치
            $('#list').on('change', 'td>input[type="checkbox"]', function () {
                let checkCnt = $('td>input[type="checkbox"]:checked').length;
                let allCnt = $('td>input[type="checkbox"]').length;
                // 전체갯수 vs 선택된 갯수
                if (checkCnt == allCnt) {
                    $('th>input[type="checkbox"]').prop({
                        checked: true
                    })
                } else {
                    $('th>input[type="checkbox"]').prop({
                        checked: false
                    })
                }

            })
        });
    </script>
</head>

<body>
    <div>
        <table class="table">
            <form>
                <tr>
                    <td>Id : </td>
                    <td><input type="text" id="id"></td><br>
                <tr>
                    <td>Name : </td>
                    <td><input type="text" id="name"></td><br>
                <tr>
                    <td>Pass : </td>
                    <td><input type="text" id="passwd"></td><br>
                <tr>
                    <td>Addr : </td>
                    <td><input type="text" id="addr"></td><br>
                <tr>
                    <td>Tel : </td>
                    <td><input type="text" id="tel"></td><br>
                <tr align="center">
                    <td colspan="2"><button type="button" id="addBtn">등록</button>
                        <button type="button" id="delSelected">선택삭제</button></td>
                </tr>
            </form>
        </table>
    </div>

    <div>
        <table class="table" border="1">
            <thead>
                <tr>
                    <th>Id</th>
                    <th>Name</th>
                    <th>주소</th>
                    <th>연락처</th>
                    <th>Pass</th>
                    <th>삭제</th>
                    <th><input type="checkbox"></th>
            <tbody id="list">
            </tbody>
        </table>
    </div>
</body>

</html>