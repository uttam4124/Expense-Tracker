const daysEl=document.getElementById('days')
const hoursEl=document.getElementById('hours')
const minutesEl=document.getElementById('minutes')
const secondsEl=document.getElementById('seconds')
const newyear = "1 Jan 2023";
function countdown() {
  const newyeardate = new Date(newyear);
  const currentDate = new Date();
  const totalseconds = (newyeardate - currentDate) / 1000;

  const days = Math.floor(totalseconds / 3600 / 24);
  const hours=Math.floor(totalseconds/3600)%24;
  const minutes=Math.floor(totalseconds/60)%60;
  const seconds=Math.floor(totalseconds)%60;
  console.log(days,hours,minutes,seconds);

  daysEl.innerHTML=days;
  hoursEl.innerHTML=hours;
  minutesEl.innerHTML=minutes;
  secondsEl.innerHTML=seconds;

}

countdown();
setInterval(countdown, 1000);
