let boxs = document.querySelectorAll(".box");
const boxCount = boxs.length;
let btns = document.querySelectorAll('.zoom');

console.log(boxCount);

for (let i = 1; i <= boxCount; i++) {
    const box = document.getElementById(`box${i}`);
    const text = document.getElementById(`text${i}`);
    const btn = document.getElementById(`zoom${i}`);
    btn.addEventListener('click', function() {
        box.classList.toggle('expanded');
        if (text) {
            text.classList.toggle('visible');
        }
    });

}
