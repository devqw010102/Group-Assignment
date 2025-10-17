// 이미지, 재료, 조리방법 파일 분리해서 관리(receipt_object.js)
import { tabContents } from "./recipe_object.js";

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

    // Image Div + Text Div
    const imageRow = document.createElement('div');
    imageRow.style.display = 'flex';
    imageRow.style.alignItems = 'center';
    imageRow.style.gap = '20px';

    // Image
    
    const img = document.createElement('img');
    img.src = data.image;
    img.alt = `요리 이미지 ${i + 1}`;
    img.style.width = '250px';
    img.style.height = '230px';
    img.style.borderRadius = '8px';

    // Text Div
    const textInfo = document.createElement('div');
    textInfo.style.display = 'flex';
    textInfo.style.flexDirection = 'column';
    textInfo.style.gap = '10px';

    // Category
    const category = document.createElement('div');
    category.innerText = `카테고리: ${data.category || '없음'}`;
    category.style.fontSize = '1.2em';
    category.style.fontWeight = 'bold';

    // name

    const name = document.createElement('div');
    name.innerText = `이름 : ${data.name || '없음'}`;
    name.style.fontSize = '1.2em';
    name.style.fontWeight = 'bold';

    // append 2 Div
    textInfo.appendChild(category);
    textInfo.appendChild(name);

    imageRow.appendChild(img);
    imageRow.appendChild(textInfo);
    content1.appendChild(imageRow);

    // Tab2 
    const content2 = document.createElement('div');
    
    content2.className = 'tab-content';
    const ul = document.createElement('ul');
    ul.style.display = 'flex';
    ul.style.flexWrap = 'wrap';
    ul.style.gap = '10px';
    ul.style.paddingTop = '10px';
    
    // Ingredient
    data.ingredient.forEach(item => {
        const li = document.createElement('li');
        li.textContent = item;
        li.style.padding = '5px';
        li.style.border = '1px solid black';
        ul.appendChild(li);
    });
    content2.appendChild(ul);
    // Finish structure(ul, li) 

    // Tab3 Object
    // Todo : 조리법 텍스트 많을때 박스 짤림 어떻게 해결? ex) 페이징 처리?
    const content3 = document.createElement('div');
    content3.className = 'tab-content';
    const cookUl = document.createElement('ul');
    cookUl.style.display = 'flex';
    cookUl.style.flexWrap = 'wrap';
    cookUl.style.gap = '10px';
    cookUl.style.padding = '10px';

    // Cook
    data.cook.forEach(item => {
        const cookLi = document.createElement('li');
        cookLi.textContent = item;
        cookLi.style.listStyle = 'decimal';
        cookLi.style.listStylePosition = 'inside';
        cookLi.style.padding = '5px';
        cookLi.style.border = '1px solid black';
        cookUl.appendChild(cookLi);
    });
    content3.appendChild(cookUl);
    // Finish structure(ul, li) 

    // Connect Tab Click Event
    tab1.addEventListener('click', () => {
        setActiveTab(tab1, [tab1, tab2, tab3], content1, [content1, content2, content3]);
    });
    tab2.addEventListener('click', () => {
        setActiveTab(tab2, [tab1, tab2, tab3], content2, [content1, content2, content3]);
    });
    tab3.addEventListener('click', () => {
        setActiveTab(tab3, [tab1, tab2, tab3], content3, [content1, content2, content3]);
    });

    // Append all element
    box.appendChild(tabs);
    box.appendChild(content1);
    box.appendChild(content2);
    box.appendChild(content3);
    container.appendChild(box);
});


// Function for enabled tap processing
function setActiveTab(activeTab, allTabs, activeContent, allContents) {
    allTabs.forEach(tab => tab.classList.remove('active'));
    allContents.forEach(content => content.classList.remove('active'));
    activeTab.classList.add('active');
    activeContent.classList.add('active');
}