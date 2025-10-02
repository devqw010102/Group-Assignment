// 이미지, 재료, 조리방법 파일 분리해서 관리(receipt_object.js)
import { tabContents } from "./receipt_object.js";

console.log(tabContents[0]);

// Make box
const boxs = document.getElementById('boxs');

// 박스 개수 수정 필요시 i 범위 조정
for(let i = 0; i < 10; i++) {

    // Box, tabs, tab
    const box = document.createElement('div');
    box.className = 'box';

    const tabs = document.createElement('div');
    tabs.className = 'tabs';

    const tab1 = document.createElement('button');
    tab1.className = 'tab active';
    tab1.innerText = 'Tab 1';

    const tab2 = document.createElement('button');
    tab2.className = 'tab';
    tab2.innerText = 'Tab 2';

    const tab3 = document.createElement('button');
    tab3.className = 'tab';
    tab3.innerText = 'Tab 3';
    
    tabs.appendChild(tab1);
    tabs.appendChild(tab2);
    tabs.appendChild(tab3);

    // Content
    const content1 = document.createElement('div');
    content1.className = 'tab-content active';
    content1.innerText = `Box ${i + 1} - Content 1`;

    const content2 = document.createElement('div');
    content2.className = 'tab-content';
    content2.innerText = `Box ${i + 1} - Content 2`;

    const content3 = document.createElement('div');
    content3.className = 'tab-content';
    content3.innerText = `Box ${i + 1} - Content 3`;

    // Tab Event
    tab1.addEventListener('click', () => {
        tab1.classList.add('active');
        tab2.classList.remove('active');
        tab3.classList.remove('active');
        content1.classList.add('active');
        content2.classList.remove('active');
        content3.classList.remove('active');
    });

    tab2.addEventListener('click', () => {
        tab2.classList.add('active');
        tab1.classList.remove('active');
        tab3.classList.remove('active');
        content2.classList.add('active');
        content1.classList.remove('active');
        content3.classList.remove('active');
    });

    tab3.addEventListener('click', () => {
        tab3.classList.add('active');
        tab1.classList.remove('active');
        tab2.classList.remove('active');
        content3.classList.add('active');
        content1.classList.remove('active');
        content2.classList.remove('active');
    });    

    box.appendChild(tabs);
    box.appendChild(content1);
    box.appendChild(content2);
    box.appendChild(content3);

    boxs.appendChild(box);
}