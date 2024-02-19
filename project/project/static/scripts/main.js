
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
// function send_req(url) {
//     let data = [];
//     const requset = new XMLHttpRequest();
//     requset.open("GET", url, false);
//     requset.send(null);
//     if (requset.status == 200) {
//         data = JSON.parse(requset.responseText);
//     } else {
//         throw new Error('Request failed: ' + requset.statusText);
//     }
//     return data;
// }

// let names = send_req("respon");
// names = names["data"];

// names.forEach((e, i) => { names[i] = e["name"] });


// names.forEach(e => { createDoc(e); });