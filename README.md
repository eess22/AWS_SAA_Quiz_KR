# AWS Certification Quiz App (Docker)

이 프로젝트는 AWS 자격증 시험(SAA-C03)을 준비하기 위한 퀴즈 앱입니다. 
다들 1트 하셨으면 좋겠습니다.

---

## 🐳 Docker로 실행하기


```bash
docker build -t aws-quiz-app .
docker run -p 5173:5173 aws-quiz-app
```

### 3. 접속

http://localhost:5173 
