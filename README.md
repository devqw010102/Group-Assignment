# 🍳 Recipe Service Project (JSP & Spring Boot)

> **Spring Boot와 JSP를 활용한 사용자 맞춤형 레시피 공유 플랫폼입니다.**
> HTML 프로젝트를 JSP로 마이그레이션하며 구조를 재설계했고, 특히 스크립트 위주의 비동기 로딩을 구현하는 데 집중했습니다.
> 직접 JDBC를 제어하며 로직을 구현해보고, 이를 통해 객체지향 설계와 시스템 최적화의 중요성을 체감한 프로젝트입니다.

## 🛠 Tech Stack
- **Backend:** Java 21, Spring Boot, Spring Data JPA, Spring Security
- **Frontend:** JSP, JavaScript, HTML/CSS
- **Database:** Oracle
- **Server:** Tomcat 10.1

---

## 🚀 Key Features & Implementation Details

### 1. Vanilla JS 기반의 동적 UI 및 최적화
- **Client-side Filtering:** 서버 통신 횟수를 최소화하기 위해 메모리에 데이터를 캐싱하여 즉각적인 카테고리 필터링을 구현했습니다.
- **사용자 경험(UX) 고려:** 한 화면에 정보를 나열하는 대신 '이미지/재료/조리법' 탭 시스템을 도입하여 정보의 계층화를 실현했습니다.
- **비동기 흐름 제어:** `async/await`를 활용해 세션 정보 확보 후 데이터를 로딩하는 순차 제어로 데이터 정합성을 확보했습니다.

---

## 🔍 Trouble Shooting & Growth (기술적 성찰)

### 1. 데이터 접근 로직의 파편화와 기술적 부채 인지
- **Issue:** 각 페이지별로 독립적인 JDBC 로직을 구현하다 보니, 동일 기능이 서로 다른 알고리즘과 중복 코드로 작성되어 유지보수성이 저하되었습니다.
- **Solution & Learning:** - **계층형 아키텍처:** 로직을 공통 **DAO/Service 레이어**로 분리하여 관리하는 구조적 설계의 중요성을 체감했습니다.
  - **DBCP(Database Connection Pool):** 매 요청마다 Connection을 생성하는 비효율을 인지하고, 성능 최적화를 위한 커넥션 풀 도입의 원리를 학습했습니다.

### 2. JSP 내 비즈니스 로직 비대화 해결 방안
- **Issue:** JSP 파일 하나에 DB 접속, 데이터 가공(문자열 split 등), UI 렌더링이 혼재되어 강한 결합도 문제가 발생했습니다.
- **Improvement:** - **DTO(Data Transfer Object)**를 통한 데이터 전달 체계화.
  - 문자열 파싱 로직을 유틸리티 클래스로 분리하여 **관심사의 분리(SoC)**를 실천하는 설계 역량을 길렀습니다.

---

## 📝 Project Review
이번 프로젝트는 단순히 기능을 완성하는 것을 넘어, **"어디에 코드를 배치하느냐"**가 시스템의 수명을 결정한다는 것을 깨닫는 계기가 되었습니다. 직접 JDBC와 JSP를 제어하며 겪은 시행착오를 바탕으로, 현재는 **MVC 패턴 준수와 성능 최적화(DBCP)**를 최우선으로 고려하는 개발자로 성장하고 있습니다.
