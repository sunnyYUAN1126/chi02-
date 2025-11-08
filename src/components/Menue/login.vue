<script setup>
import { ref } from "vue"

// emit 是 Vue 3 用來發出事件的方法
const emit = defineEmits(["login-success"])

const username = ref("")
const password = ref("")

function handleLogin() {
  // 簡單模擬登入檢查
  if (username.value && password.value) {
    emit("login-success") // 通知父層登入成功
  } else {
    alert("請輸入帳號和密碼！")
  }
}
</script>

<template>
  <div class="login_container">
    <h2>會員登入</h2>
    <div>
      <p>帳號</p>
      <input type="text" v-model="username" />      
    </div>
    <div>
      <p>密碼</p>
      <input type="password" v-model="password" />       
    </div>
    <div>
      <button @click="handleLogin">登入</button>
    </div>
  </div>

  


</template>

<style scoped>
*{
    padding: 0;
    margin: 0;
    list-style: none;
}

.login_container div{
  display: flex;
  padding: 10px;
  margin: 20px;
}
.login_container p{
  width: 100px;
  background: palegoldenrod;
  text-align: center;
}
.login_container input{
  height: 20px;

}
.login_container button{
  width: 50px;
  height: 30px;
  border-radius: 20px;
}
.login_container button:hover{
  color: white;
  background: black;

}


</style>