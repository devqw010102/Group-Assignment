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