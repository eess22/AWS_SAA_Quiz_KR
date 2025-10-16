# AWS Certification Quiz App (Docker)

AWS 자격증 시험(SAA-C03)을 준비하기 위한 퀴즈 앱입니다. 

---

## setup.sh


```bash
git clone https://github.com/eess22/AWS_SAA_Quiz_KR.git
cd AWS_SAA_Quiz_KR
docker build -t aws-quiz-app .
docker run -p 5173:5173 aws-quiz-app
```

## 요약
- 문제
- 선지
- 해설 확인
- 이전, 다음 문제, 문제번호 이동
- 틀린문제 - localstorage
- 틀린문제만 풀기

### 3. 접속

http://localhost:5173 

---
합격을 기원합니다.
