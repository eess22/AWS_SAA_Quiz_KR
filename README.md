# AWS Certification Quiz App (Docker)

이 프로젝트는 AWS 자격증 시험(SAA-C03)을 준비하기 위한 퀴즈 앱입니다. Docker를 통해 손쉽게 실행할 수 있도록 구성되어 있습니다.

---

## 🐳 Docker로 실행하기

### 1. Docker 이미지 빌드

/

```bash
docker build -t aws-quiz-app .
```

---

### 2. Docker 컨테이너 실행

```bash
docker run -p 5173:5173 aws-quiz-app
```

### 3. 접속

http://localhost:5173 
