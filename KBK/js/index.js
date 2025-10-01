
// let testBox = document.querySelector('#testBox');
// let testBox2 = document.querySelector('#testBox2');
// let text = document.querySelector(".text");
// let text1 = document.querySelector(".text1");
// let testBox3 = document.querySelector("#testBox3");
// let flag = true;

let boxs = document.querySelectorAll(".box");
const boxCount = boxs.length;
console.log(boxCount);

for (let i = 1; i <= boxCount; i++) {
    const box = document.getElementById(`box${i}`);
    const text = document.getElementById(`text${i}`);

    box.addEventListener('click', function() {
        box.classList.toggle('expanded');
        if (text) {
            text.classList.toggle('visible');
        }
    });
}




// testBox.addEventListener('click', function() {

//     if(flag) {
//         testBox.style.width = '100%';
//         text.style.display = 'block';
//         flag = false;
//     }
//     else {
//         testBox.style.width = '30%';
//         text.style.display = 'none  ';
//         flag = true;
//     }
// });

// testBox2.addEventListener('click', function() {

//     if(flag) {
//         testBox2.style.width = '100%';
//         flag = false;
//     }
//     else {
//         testBox2.style.width = '30%';
//         flag = true;
//     }
// });

// testBox3.addEventListener('click', function() {

//     if(flag) {
//         testBox3.style.width = '100%';
//         text1.style.display = 'block';
//         flag = false;
//     }
//     else {
//         testBox3.style.width = '30%';
//         text1.style.display = 'none';
//         flag = true;
//     }
// });



