document.addEventListener("DOMContentLoaded", loadRecipes);

async function loadRecipes() {
    try {
        const response = await fetch("recipeList.jsp");
        const recipes = await response.json(); // 반드시 await 필요
        renderRecipes(recipes);
    } catch (err) {
        console.error(err);
    }
}

function renderRecipes(recipes) {
	// Make box
	const container = document.getElementById("boxs");
	container.innerHTML = "";
	
	recipes.forEach((item) => {
		const data = item.data;
		const id = item.id;
		
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
		tab3.innerText = '조리법';

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
		// img.alt = `요리 이미지 ${i + 1}`;
		img.style.width = '250px';
		img.style.height = '230px';
		img.style.borderRadius = '8px';

		// Text Div
		const textInfo = document.createElement('div');
		textInfo.style.display = 'flex';
		textInfo.style.flexDirection = 'column';
		textInfo.style.gap = '10px';

		// name
		const nameDiv = document.createElement('div');
		nameDiv.innerText = `이름 : ${data.name || '없음'}`;
		nameDiv.style.fontSize = '1.2em';
		nameDiv.style.fontWeight = 'bold';

		// Category
		const categoryDiv = document.createElement('div');
		categoryDiv.innerText = `카테고리: ${data.category || '없음'}`;
		 categoryDiv.style.fontSize = '1.2em';
		 categoryDiv.style.fontWeight = 'bold';

		// Button Div
		const btnContainer = document.createElement('div');
		btnContainer.style.display = 'flex';
		btnContainer.style.gap = '10px';
		// btnContainer.style.marginTop = '10px';

		// update, delete button
		// 추가 필요
		/*
		btnDelete.style.padding = '6px 12px';
		btnDelete.style.backgroundColor = 'white';
		btnDelete.style.border = '1px solid black';
		btnDelete.style.borderRadius = '4px';
		btnDelete.style.cursor = 'pointer';
		*/
		// Add Button OnClick Event
		// btnUpdate => recipeUpdate 로 이동
		//  -- 레시피 작성자와 로그인된 작성자가 같을때만 버튼 보이기
		// btnDelete => Start Delete Query 

		
		const btnUpdate = document.createElement('button');
		btnUpdate.textContent = '수정';
		btnUpdate.style.padding = '6px 12px';
		btnUpdate.style.backgroundColor = 'white';
		btnUpdate.style.border = '1px solid black';
		btnUpdate.style.borderRadius = '4px';
		btnUpdate.style.cursor = 'pointer';


		const btnDelete = document.createElement('button');
		btnDelete.textContent = '삭제';
		btnDelete.addEventListener("click", async () => {
			if(!confirm("삭제하시겠습니까?")) return;
			
			const res = await fetch("recipeDelete.jsp", {
				method : "POST",
				headers : {"Content-Type" : "application/json"},
				body : JSON.stringify({id})
			});
			
			const msg = await res.text();
			if(msg == "DELETE_OK") loadRecipes();
		});
		
		// append 2 Div
		btnContainer.appendChild(btnDelete);
		textInfo.append(categoryDiv, nameDiv, btnContainer);
		imageRow.append(img, textInfo);
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
		    const li = document.createElement('li');
		    li.textContent = item;
		    li.style.listStyle = 'decimal';
		    li.style.listStylePosition = 'inside';
		    li.style.padding = '5px';
		    li.style.border = '1px solid black';
		    cookUl.appendChild(li);
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
		box.append(tabs, content1, content2, content3);
		container.appendChild(box);
	})
	
}

// Function for enabled tap processing
function setActiveTab(activeTab, allTabs, activeContent, allContents) {
    allTabs.forEach(tab => tab.classList.remove('active'));
    allContents.forEach(content => content.classList.remove('active'));
    activeTab.classList.add('active');
    activeContent.classList.add('active');
}

// 수정 버튼 눌렀을 때 해당 index 값 주고받는 함수 (recipeUpdate)
// After dbconn