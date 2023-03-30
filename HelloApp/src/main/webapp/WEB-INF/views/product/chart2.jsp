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

		// 비동기방식
		function drawChart() {
			//[{'Admin':1},{'Accounting':2},...]
			fetch('chartAjax.do')
				.then(resolve => resolve.json())
				.then(result => {
					//console.log(result);
					let outAry = [];
					outAry.push(['dept', 'cnt per dept']); // 타이틀 역할을 만들어주기위한 첫번째 데이터를 넣어줌
					result.forEach(dept => {
						//console.log(dept)
						let ary = []

						for (prop in dept) {
							ary[0] = prop;
							ary[1] = dept[prop]
						}
						//console.log(ary);
						outAry.push(ary); // 가공
					})
					console.log(outAry);
					var data = google.visualization.arrayToDataTable(outAry);
					/*  var data = google.visualization.arrayToDataTable([
					   ['Task', 'Hours per Day'], // 첫번째 데이터는 타이틀 역할을 함
					   ['Work',     11], // 두번째 부터는 값
					   ['Eat',      2],
					   ['Commute',  2],
					   ['Watch TV', 2],
					   ['Sleep',    7],
					   ['Game',    7]
					 ]); // 배열값으로 값을 넣어줌 */

					var options = {
						title: 'Person By Department'
					};
					var chart = new google.visualization.PieChart(document.getElementById('piechart'));
					chart.draw(data, options);
				})
				.catch(reject => console.error(reject));

		}
	</script>
</head>

<body>
	<div id="piechart" style="width: 900px; height: 500px;"></div>
</body>

</html>