<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<!--구글차트를 이용한다.-->
<!-- 비동기 방식으로...-->
<head>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript">
		google.charts.load('current', {
			'packages': ['corechart']
		});
		google.charts.setOnLoadCallback(drawChart);


		async function drawChart() {
			//[{'Admin':1},{'Accounting':2},...]
			console.log("1");
			let outAry = [];
			outAry.push(['dept', 'cnt per dept']);
			let promise1 = await fetch('chartAjax.do') // promise 타입의 객체 : 성공하면 then이라는 곳의, 실패하면 catch라고 하는 곳의 함수를 실행시킴
			let promise2 = promise1.json() // promise1이 가지고 있는 값을 json포맷으로 바꾼 객체 <- 결과값은 배열형태 [{}, {}, ...]
			console.log("1-1")
			promise2.forEach(dept => {
				let ary = [];
				for(let prop in dept){
					ary[0] = prop;
					ary[1] = dept[prop]; // dept의 속성의 값들
				}
				outAry.push(ary)
			})
			console.log("1-2")
			var data = google.visualization.arrayToDataTable(outAry);

			var options = { title: 'Person By Department' };
			var chart = new google.visualization.PieChart(document.getElementById('piechart'));
			chart.draw(data, options);	
			
			console.log("2");
		}
	</script>
</head>

<body>
	<div id="piechart" style="width: 900px; height: 500px;"></div>
</body>

</html>