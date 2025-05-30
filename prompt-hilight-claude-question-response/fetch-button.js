// highlight the fetch message.  we'll want to remove this
let btns = [...document.querySelectorAll('button')].filter(b => b.textContent.includes('Fetched')); 
btns.forEach(btn => { btn.style.border = '3px solid red'; btn.style.background = 'yellow'; }); 
setTimeout(() => { btns.forEach(btn => { btn.style.border = ''; btn.style.background = ''; }); }, 10000);
