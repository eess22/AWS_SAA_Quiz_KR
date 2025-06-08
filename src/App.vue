<template>
  <div class="header">
    <h1>
      AWS Solution Architect Associate
    </h1>
  </div>
  <div>
    <progress :value="current + 1" :max="questions.length"></progress>
    <p>진행률: {{ current + 1 }} / {{ questions.length }}</p>
    <div v-if="question">
      <p>{{ question.question }}</p>
      <div v-for="(text, key) in question.choices" :key="key">
        <button
          :class="buttonClass(key)"
          @click="toggleChoice(key)"
        >
          {{ key }}. {{ text }}
        </button>
      </div>

      <div v-if="showAnswer">
        <p><strong>정답:</strong> {{ question.answers.join(', ') }}</p>
        <button @click="showExplanation = true">해설 보기</button>
      </div>

      <div v-if="showExplanation" style="margin-top: 1rem;">
        <p v-for="(exp, i) in question.explanations" :key="i">• {{ exp }}</p>
      </div>

      <div style="margin-top: 1.5rem; display: flex; gap: 1rem;">
        <button @click="prevQuestion" :disabled="current === 0">이전 문제</button>
        <button @click="nextQuestion" :disabled="current + 1 === questions.length">
          다음 문제
        </button>
      </div>
    </div>

    <div style="margin-top: 2rem;">
      <h3>문제 번호 이동:</h3>
      <input type="number" v-model.number="jumpNumber" placeholder="번호 입력" min="1" :max="questions.length" style="width: 100px; margin-right: 0.5rem;" />
      <button @click="jumpTo">이동</button>
    </div>

    <div style="margin-top: 2rem;">
      <h3>틀린 문제 번호:</h3>
      <p>{{ wrongAnswers.join(', ') || '없음' }}</p>
      <button v-if="wrongAnswers.length" @click="viewWrongOnly = !viewWrongOnly">
        {{ viewWrongOnly ? '전체 문제 보기' : '틀린 문제만 보기' }}
      </button>
    </div>
  </div>
</template>

<script>
import questions from './questions.json'

export default {
  data() {
    const savedWrong = localStorage.getItem('wrongAnswers')
    return {
      fullQuestions: questions,
      viewWrongOnly: false,
      questions: questions,
      current: 0,
      selectedChoices: [],
      showAnswer: false,
      showExplanation: false,
      wrongAnswers: savedWrong ? JSON.parse(savedWrong) : [],
      jumpNumber: null
    }
  },
  computed: {
    question() {
      return this.questions[this.current]
    }
  },
  methods: {
    toggleChoice(choice) {
      if (this.showAnswer) return

      const correctCount = this.question.answers.length

      if (this.selectedChoices.includes(choice)) {
        this.selectedChoices = this.selectedChoices.filter(c => c !== choice)
      } else {
        if (this.selectedChoices.length >= correctCount) return
        this.selectedChoices.push(choice)
      }

      if (this.selectedChoices.length === correctCount) {
        this.submitAnswer()
      }
    },
    submitAnswer() {
      this.showAnswer = true
      const selectedSorted = [...this.selectedChoices].sort().join(',')
      const correctSorted = [...this.question.answers].sort().join(',')

      if (selectedSorted !== correctSorted) {
        if (!this.wrongAnswers.includes(this.question.id)) {
          this.wrongAnswers.push(this.question.id)
          localStorage.setItem('wrongAnswers', JSON.stringify(this.wrongAnswers))
        }
      }
    },
    buttonClass(choice) {
      if (!this.showAnswer) return this.selectedChoices.includes(choice) ? 'selected' : ''
      const isCorrect = this.question.answers.includes(choice)
      const isSelected = this.selectedChoices.includes(choice)
      if (isCorrect) return 'correct'
      if (isSelected && !isCorrect) return 'incorrect'
      return ''
    },
    nextQuestion() {
      if (this.current + 1 < this.questions.length) {
        this.current++
        this.resetState()
      }
    },
    prevQuestion() {
      if (this.current > 0) {
        this.current--
        this.resetState()
      }
    },
    goTo(index) {
      this.current = index
      this.resetState()
    },
    jumpTo() {
      if (this.jumpNumber && this.jumpNumber >= 1 && this.jumpNumber <= this.questions.length) {
        this.goTo(this.jumpNumber - 1)
      } else {
        alert("올바른 문제 번호를 입력하세요.")
      }
    },
    resetState() {
      this.selectedChoices = []
      this.showAnswer = false
      this.showExplanation = false
    }
  },
  watch: {
    viewWrongOnly(newVal) {
      this.questions = newVal
        ? this.fullQuestions.filter(q => this.wrongAnswers.includes(q.id))
        : this.fullQuestions
      this.current = 0
      this.resetState()
    }
  }
}
</script>

<style scoped>
button.selected {
  border: 2px solid #3b82f6;
  background-color: #e0f2fe;
}
button.correct {
  background-color: #d1fae5;
  border: 2px solid #10b981;
}
button.incorrect {
  background-color: #fee2e2;
  border: 2px solid #ef4444;
}
</style>