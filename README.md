# 🍳 Recipe Service Project (JSP & Spring Boot)

> **Spring Boot와 JSP를 활용한 사용자 맞춤형 레시피 공유 플랫폼입니다.**</br>
> HTML 프로젝트를 JSP로 마이그레이션하며 구조를 재설계했고, 특히 스크립트 위주의 비동기 로딩을 구현하는 데 집중했습니다.

## 🛠 Tech Stack
- **Backend:** Java 21, Spring Boot, Spring Data JPA, Spring Security
- **Frontend:** JSP, JavaScript, HTML/CSS
- **Database:** Oracle
- **Server:** Tomcat 10.1

---

## 🚀 Key Features & Implementation Details

### 1. 효율적인 데이터 모델링 (JPA)
- **Entity 설계 최적화:** 비즈니스 로직을 분석하여 **DB 정규화**를 진행하고, 데이터 무결성을 확보했습니다.
- **연관관계 관리:** JPA의 **지연 로딩(Lazy Loading)** 전략을 사용하여 불필요한 데이터 조회를 방지하고 성능 최적화를 고려했습니다.

### 2. 사용자 중심 UI/UX 구현 (JSP)
- **JSP 기반 동적 렌더링:** 서버 사이드 렌더링을 통해 레시피 데이터와 사용자 정보를 동적으로 화면에 구성했습니다.
- **비동기 데이터 처리:** JavaScript를 활용하여 효율적인 데이터 요청 및 사용자 인터랙션을 처리했습니다.

---

## 📝 Project Review & Growth
초기 설계의 복잡성을 **DB 정규화와 JPA 최적화**를 통해 해결하며, 데이터베이스 설계가 시스템 유지보수에 미치는 영향을 깊이 체화했습니다. 이를 통해 데이터 무결성을 고려하는 개발자로 성장했습니다.

---

### 📂 Directory Structure
```text
src/main/
├── java/.../config/     # Spring Security 보안 설정
├── java/.../controller/ # 레시피 및 사용자 요청 처리
├── java/.../entity/     # JPA 기반 데이터 모델링
├── java/.../repository/ # DB 접근 로직 (Spring Data JPA)
└── webapp/WEB-INF/views/ # JSP 기반 화면 구성
