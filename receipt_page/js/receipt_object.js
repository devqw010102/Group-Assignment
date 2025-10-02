/*
    -객체 설명-

    {
    image : 이미지, 파일은 images폴더 안에, food-{i}.jpg 로 저장
    ingredient : 재료, [재료이름 : 수량] 배열 형식으로 작성할 것
    cook : 조리방법, "조리 방법" 작성할 것
    }

    ps) 
    1. 첫 요소는 예시, 참고할 것
    2. 작성 완료시 Git 개인 폴더에 업로드 요망
    3. 이미지는 `개인폴더/images` 에 업로드 요망
    4. 레시피 출처는 메모장에 링크 작성후 메모장도 같이 Git에 업로드
*/

export const tabContents = [
  {
    image: "images/food-1.jpg",
    ingredient : ["미니새송이버섯 : 1팩", "버터 : 20g", "굴소스 : 1T", "진간장 : 0.5T", "통깨 약간"],
    cook : "새송이버섯은 길게 편 썰기, 팬을 달군 후 버터 20그램을 녹인다. 버터가 녹으면 새송이 버섯을 넣고 볶는다. 버섯이 반쯤 익었을 때 굴소스 1스푼 넣는다. 진간장도 0.5T 넣는다. 통깨도 넣어서 섞는다."
  },
  {
    image: "images/food-2.jpg",
    ingredient: ["Dog", "Cat", "Bird"],
    cook: ["Fish", "Rabbit", "Hamster"]
  },
  {
    image: "https://via.placeholder.com/150?text=Image+3",
    list1: ["HTML", "CSS", "JS"],
    list2: ["React", "Vue", "Angular"]
  },
  {
    image: "https://via.placeholder.com/150?text=Image+4",
    list1: ["Korea", "Japan", "USA"],
    list2: ["China", "UK", "Germany"]
  },
  {
    image: "https://via.placeholder.com/150?text=Image+5",
    list1: ["Sun", "Moon", "Star"],
    list2: ["Earth", "Mars", "Venus"]
  },
  {
    image: "https://via.placeholder.com/150?text=Image+6",
    list1: ["Car", "Bike", "Bus"],
    list2: ["Train", "Plane", "Boat"]
  },
  {
    image: "https://via.placeholder.com/150?text=Image+7",
    list1: ["Coffee", "Tea", "Juice"],
    list2: ["Water", "Milk", "Soda"]
  },
  {
    image: "https://via.placeholder.com/150?text=Image+8",
    list1: ["Book", "Pen", "Paper"],
    list2: ["Eraser", "Ruler", "Notebook"]
  },
  {
    image: "https://via.placeholder.com/150?text=Image+9",
    list1: ["Rock", "Pop", "Jazz"],
    list2: ["Classical", "Hip-hop", "EDM"]
  },
  {
    image: "https://via.placeholder.com/150?text=Image+10",
    list1: ["Dog Food", "Leash", "Toy"],
    list2: ["Bed", "Brush", "Treats"]
  }
];