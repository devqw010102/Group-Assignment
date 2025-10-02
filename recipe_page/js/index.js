// 이미지, 재료, 조리방법 파일 분리해서 관리(receipt_object.js)
import { tabContents } from "./recipe_object.js";

// import Object Test - success
console.log(tabContents[0]);

// Make box
const container = document.getElementById('boxs');

tabContents.forEach((data, i) => {
    const box = document.createElement('div');
    box.className = 'box';

    // tab button
    const tabs = document.createElement('div');
    tabs.className = 'tabs';

    const tab1 = document.createElement('button');
    tab1.className = 'tab active';
    tab1.innerText = '이미지';

    const tab2 = document.createElement('button');
    tab2.className = 'tab';
    tab2.innerText = '재료';

    const tab3 = document.createElement('button');
    tab3.className = 'tab';
    tab3.innerText = '레시피';

    tabs.append(tab1, tab2, tab3);

    // Tab1
    const content1 = document.createElement('div');
    content1.className = 'tab-content active';

    // 이미지 Div
    const imageRow = document.createElement('div');
    imageRow.style.display = 'flex';
    imageRow.style.alignItems = 'center';
    imageRow.style.gap = '20px';
    // 이미지
    const img = document.createElement('img');
    img.src = data.image;
    // img.alt = `요리 이미지 ${i + 1}`;
    img.style.width = '300px';
    img.style.height = '250px';
    img.style.borderRadius = '8px';

    const category = document.createElement('div');
    category.innerText = `카테고리: ${data.category || '없음'}`;
    category.style.fontSize = '16px';
    category.style.fontWeight = 'bold';

    imageRow.appendChild(img);
    imageRow.appendChild(category);
    content1.appendChild(imageRow);

    // Tab2 웨않뒈
    const content2 = document.createElement('div');
    content2.className = 'tab-content';
    const ul = document.createElement('ul');
    data.ingredient.forEach(item => {
        const li = document.createElement('li');
        li.textContent = item;
        ul.appendChild(li);
    });
    content2.appendChild(ul);

    // Tab3
    const content3 = document.createElement('div');
    content3.className = 'tab-content';
    content3.innerHTML = data.cook.replace(/\n/g, "<br>"); // 줄바꿈 처리

    tab1.addEventListener('click', () => {
        setActiveTab(tab1, [tab1, tab2, tab3], content1, [content1, content2, content3]);
    });
    tab2.addEventListener('click', () => {
        setActiveTab(tab2, [tab1, tab2, tab3], content2, [content1, content2, content3]);
    });
    tab3.addEventListener('click', () => {
        setActiveTab(tab3, [tab1, tab2, tab3], content3, [content1, content2, content3]);
    });

    // Append
    box.appendChild(tabs);
    box.appendChild(content1);
    box.appendChild(content2);
    box.appendChild(content3);
    container.appendChild(box);
});

function setActiveTab(activeTab, allTabs, activeContent, allContents) {
    allTabs.forEach(tab => tab.classList.remove('active'));
    allContents.forEach(content => content.classList.remove('active'));
    activeTab.classList.add('active');
    activeContent.classList.add('active');
}