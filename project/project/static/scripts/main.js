
let body = document.body;
let lecs = document.getElementById("lecs");
let downArrow = document.querySelector(".down");
let cards = document.querySelector(".lecs .row .cards");
let allCards = cards.querySelectorAll(".card");
let back = document.querySelector(".lecs .back");
let next = document.querySelector(".lecs .next");
let menuBar = document.querySelector("nav .menuBar");
let closeMark = document.querySelector("nav .close");
let olNav = document.querySelector("nav ol");
let liNav = document.querySelectorAll("nav ol a");
let lecLinks = document.querySelectorAll("#lecLink");

const bodyOverlay = document.querySelector(".bodyOverlay");

// down section 
downArrow.addEventListener("click", e => {
    lecs.scrollIntoView();
});

// scrollbar-x in cards 
//to back
back.addEventListener("click", e => {
    cards.scrollTo(cards.scrollLeft - cards.offsetWidth, 0);
});
// to next
next.addEventListener("click", e => {
    cards.scrollTo(cards.scrollLeft + cards.offsetWidth, 0);
});
// menuBar
menuBar.addEventListener("click", e => {
    fullNav();
    body.appendChild(bodyOverlay);
});
closeMark.addEventListener("click", e => {
    fullNav();
});
liNav.forEach(e => {
    e.addEventListener("click", el => {
        if (menuBar.classList.contains("none")) {
            fullNav();
        }
    });
});
bodyOverlay.addEventListener("click", e => {
    fullNav();
});

function fullNav() {
    menuBar.classList.toggle("none");
    closeMark.classList.toggle("active");
    bodyOverlay.classList.toggle("active");
    olNav.classList.toggle("show");
}

// in folder lecs

// HTTP requset
function send_req(url) {
    let data = [];
    const requset = new XMLHttpRequest();
    requset.open("GET", url, false);
    requset.send(null);
    if (requset.status == 200) {
        data = JSON.parse(requset.responseText);
    } else {
        throw new Error('Request failed: ' + requset.statusText);
    }
    return data;
}

let names = send_req("respon");

names.forEach((e, i) => { names[i] = e["name"] });

let hrefNames = [];
names.forEach(e=>{
    hrefNames.push(e.replaceAll(" ","_"));
});


lecLinks.forEach((e,i)=>{
    e.href=hrefNames[i];
});

// names.forEach(e => { createDoc(e); });
console.log(1);



//test node js
// http = require('http')
// const PORT = 8000;

// // server create
// const server = http.createServer((req, res) => {
//    if (req.url === "/") {
//       res.write("This is home page.");
//       res.end();
//    } else if (req.url === "/about" && req.method === "GET") {
//       res.write("This is about page.");
//       res.end();
//    } else {
//       res.write("Not Found!");
//       res.end();
//    }
// });

// // server listen port
// server.listen(PORT);

// console.log(`Server is running on PORT: ${PORT}`);

// Content to write into the file
var fileContent = "This is the content of the file.";

// Create a Blob with the content
var blob = new Blob([fileContent], { type: 'text/plain' });

// Create a file name
var fileName = 'example.txt';

// Create a link element
var a = document.createElement('a');
a.href = window.URL.createObjectURL(blob);
a.download = fileName;

// Append the link to the body
document.body.appendChild(a);

// Click the link to trigger the download
a.click();

// Cleanup
window.URL.revokeObjectURL(a.href);
document.body.removeChild(a);
