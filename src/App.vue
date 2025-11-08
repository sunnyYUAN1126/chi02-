<script setup>
import { ref } from "vue"
import Login from './components/login.vue'
import Register from "./components/register.vue"
import Home from "./components/home.vue"

const currentPage = ref("home") // 預設顯示首頁
const isLoggedIn = ref(false)   // 是否登入的狀態（false=未登入）

// 三個切換方法
function showHomePage() {
  currentPage.value = "home";
}
function showLoginPage() {
  currentPage.value = "login";
}
function showRegisterPage() {
  currentPage.value = "register";
}
// 登出
function logout() {
  isLoggedIn.value = false;  
  currentPage.value = "home";
}
</script>

<template>
  <div class="container">
    <nav class="menu">
      <div class="logo" @click="showHomePage">二手書系統</div>
      <ul>
        <li class="menu_item">購物車</li>

        <!-- 如果已登入，顯示登出 -->
        <li v-if="isLoggedIn" class="menu_item" @click="logout">登出</li>

        <!-- 如果沒登入，顯示登入、註冊 -->
        <template v-else>
          <li class="menu_item" @click="showLoginPage">登入</li>
          <li class="menu_item" @click="showRegisterPage">註冊</li>
        </template>
      </ul>
    </nav>
  </div>

  <!-- 根據 currentPage 顯示不同畫面 -->
  <Home v-if="currentPage === 'home'" />  
  <Login 
    v-else-if="currentPage === 'login'" 
    @login-success="isLoggedIn = true; currentPage = 'home';" 
  />
  <Register v-else-if="currentPage === 'register'"
  @register-success="currentPage = 'login'"  />
</template>

<style scoped>
*{
    padding: 0;
    margin: 0;
    list-style: none;
}

.container{
    background: plum;
    padding: 0 50px;
}
.menu {
    /* width: 100%;
    height: 100px; */
    background: plum;
    display: flex;
    flex-direction: row; 
    flex-wrap: wrap; 
    justify-content: space-between; /*主軸*/
    padding: 0 20px;
    align-items: center; /*控制垂直對其*/
}
.logo{
    color: black;
    font-size: 50px;
    padding: 10px 0px;
}
.logo:hover,.container .menu_item:hover{
  color: aliceblue;
}

.menu>ul{
    display: flex; 
    /* align-items:flex-end;  */
    gap: 20px;
}
.menu_item{
    /* width: 200px; */
    color: black;
    line-height: 60px;
    font-size: 20px;
}

/* ------------------------------------------ */




</style>