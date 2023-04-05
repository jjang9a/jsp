<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link href="//cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css" rel="stylesheet">
    <script src="./jQuery/jquery-3.6.4.min.js"></script>
    <script src="//cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function () {
            // 목록불러오기
            $('#example').DataTable({
                ajax: 'dataTableAjax.do',
            });

            var t = $('#example').DataTable();

            // 추가버튼
            $('#addRow').on('click', function () {
                $.ajax({
                    url: 'dataTableAdd.do',
                    method: 'post',
                    data: {
                        first: $('#first').val(),
                        last: $('#last').val(),
                        email: $('#email').val(),
                        hireDate: $('#hireDate').val(),
                        salary: $('#salary').val()
                    },
                    success: function (result) {
                        if (result.retCode == 'Success') {
                            t.row.add([result.emp.employeeId, $('#first').val(), $('#last')
                                .val(), $('#email').val(), $('#hireDate').val(), $(
                                    '#salary').val()
                            ]).draw(false);
                        } else
                            alert('error!!!')
                    },
                    error: function (reject) {}
                })
            });

            // 삭제
            $('#example tbody').on('click', 'tr', function () {
                if ($(this).hasClass('selected')) {
                    $(this).removeClass('selected');
                } else {
                    t.$('tr.selected').removeClass('selected');
                    $(this).addClass('selected');
                }
            });

            $('#button').click(function () {
                $.ajax({
                    url: 'dataTableDelete.do',
                    method: 'post',
                    data: 'empId=' + $('#example .selected').find(":eq(0)").text(),
                    success: function (result) {
                        if (result.retCode == 'Success') {
                            alert('성공!')
                            t.row('.selected').remove().draw(false);
                        } else
                            alert('error!!!')
                    },
                    error: function (reject) {}
                })
                console.log($('#example .selected').find(":eq(0)").text())
                //table.row('.selected').remove().draw(false);
            });
        });
    </script>
</head>

<body>
    <p>dataTable페이지입니다</p>
    <input type="text" id="first"><br>
    <input type="text" id="last"><br>
    <input type="email" id="email"><br>
    <input type="date" id="hireDate"><br>
    <input type="number" id="salary"><br>
    <button id="addRow">등록</button>
    <br>
    <button id="button">삭제</button><br><br>
    <table id="example" class="display" style="width:100%">
        <thead>
            <tr>
                <th>사원번호</th>
                <th>FirstName</th>
                <th>LastName</th>
                <th>Email</th>
                <th>HireDate</th>
                <th>Salary</th>
            </tr>
        </thead>
        <tbody></tbody>
        <tfoot>
            <tr>
                <th>사원번호</th>
                <th>FirstName</th>
                <th>LastName</th>
                <th>Email</th>
                <th>HireDate</th>
                <th>Salary</th>
            </tr>
        </tfoot>
    </table>
</body>

</html>