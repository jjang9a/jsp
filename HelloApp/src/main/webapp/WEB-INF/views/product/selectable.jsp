<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
  <script src='full/dist/index.global.js'></script>
  <script>
    document.addEventListener('DOMContentLoaded', async function () {

      /*     let events = [
            {title : '서영이생일', start: '2023-03-09'},
            {title : '여행', start: '2023-03-09', end: '2023-03-13'},
          ] */

      let events = [];
      let promise1 = await fetch('calendarListAjax.do')
      let promise2 = await promise1.json()
      events = promise2;
      console.log('데이터:', events)




      var calendarEl = document.getElementById('calendar');

      var calendar = new FullCalendar.Calendar(calendarEl, {
        headerToolbar: {
          left: 'prev,next today',
          center: 'title',
          right: 'dayGridMonth,timeGridWeek,timeGridDay'
        },
        initialDate: '2023-01-12',
        navLinks: true, // can click day/week names to navigate views
        selectable: true,
        selectMirror: true,
        select: function (arg) {
          var title = prompt('일정등록:');
          if (title) {
            console.log(arg)

            fetch('calendarAddAjax.do?title=' + title + '&start=' + arg.startStr + '&end=' + arg.endStr)
              .then(resolve => resolve.json())
              .then(result => {
                console.log(result)
                if (result.retCode == 'Success') {
                  alert('성공')
                  calendar.addEvent({
                    title: title,
                    start: arg.start,
                    end: arg.end,
                    allDay: arg.allDay
                  })
                } else if (result.retCode == 'Fail') {
                  alert('실패')
                } else {
                  alert('retCode값을 확인하세요!')
                }
              })
              .catch(reject => console.error(reject));

            calendar.unselect()
          }
        },
        eventClick: function (arg) {
          if (confirm('Are you sure you want to delete this event?')) {
        	  console.log(arg.event)
        	  fetch('calendarDeleteAjax.do?title=' + arg.event.title + '&start=' + arg.event.startStr + '&end=' + arg.event.endStr)
            .then(resolve => resolve.json())
            .then(result => {
              if(result.retCode == 'Success'){
                console.log('결과:',result)
                alert('성공')
                arg.event.remove()
              }else if(result.retCode == 'Fail'){
                alert('실패')
              }else{
                alert('retCode를 확인하세요')
              }
            })
          }
        },
        editable: true,
        dayMaxEvents: true, // allow "more" link when too many events
        events: events
        //       events: [
        //    {
        //     title: 'Conference',
        //     start: '2023-01-11',
        //     end: '2023-01-13'
        //   } 
        // ]
      });

      calendar.render();
    });
  </script>
  <style>
    body {
      margin: 40px 10px;
      padding: 0;
      font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
      font-size: 14px;
    }

    #calendar {
      max-width: 1100px;
      margin: 0 auto;
    }
  </style>
</head>

<body>

  <div id='calendar'></div>

</body>

</html>