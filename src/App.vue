<script setup>
import { ref } from "vue"
import login from './components/login.vue'
import register from "./components/register.vue"
import home from "./components/home.vue"

const message = ref("Hello")

// 控制目前顯示哪個畫面：home、login、register
const currentPage = ref("home")

// 三個切換方法
function showLogoPage() {
  currentPage.value = "home";
}
function showLoginPage() {
  currentPage.value = "login";
}
function showRegisterPage() {
  currentPage.value = "register";
}



</script>

<template>
   <div class="container">
        <nav class="menu">
            <div class="logo" @click="showLogoPage">二手書系統</div>
            <ul>
                <li class="menu_item">購物車</li>
                <li class="menu_item" @click="showLoginPage">登入</li>
                <li class="menu_item" @click="showRegisterPage">註冊</li>
            </ul>
        </nav>
    </div>

  <home v-if="currentPage === 'home'" />  
  <login v-else-if="currentPage === 'login'" />
  <register v-else-if="currentPage === 'register'" />

  <h1>{{ message }}</h1>
  <h1>{{ message }}</h1>


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