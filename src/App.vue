<script setup>
import { ref } from "vue"
import Login from './components/Menue/login.vue'
import Register from "./components/Menue/register.vue"
import Home from "./components/Menue/home.vue"
import Shopping_cart from "./components/Menue/shopping_cart.vue"
import Buyer_menue from "./components/Buyer/menue.vue"
import Seller_menue from "./components/Seller/menue.vue"

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

//購物車
function showShoppingCartPage() {
  currentPage.value = "shopping_cart";
}


//會員專區
function showMemberAreaPage(){
  currentPage.value = "Member_Area";
}

function handleSwitchPage(page) {
  currentPage.value = page
}
</script>

<template>
  <div class="container">
    <nav class="menu">
      <div class="logo" @click="showHomePage">二手書系統</div>
      <ul>
        

        <!-- 如果已登入，顯示登出 -->
        <template v-if="isLoggedIn">
          <li @click="showShoppingCartPage">購物車</li>
          <li @click="logout">登出</li>
          <li @click="showMemberAreaPage">會員專區</li>
        </template>

        <!-- 如果沒登入，顯示登入、註冊 -->
        <template v-else class="menu_item">
          <li @click="showLoginPage">登入</li>
          <li @click="showRegisterPage">註冊</li>
        </template>
      </ul>
    </nav>
  </div>

  <!-- 根據 currentPage 顯示不同畫面 -->
  <Home v-if="currentPage === 'home'" />  
  <Shopping_cart v-if="currentPage === 'shopping_cart'" />
  <Buyer_menue 
    v-if="currentPage === 'Member_Area'" 
    @switchPage="handleSwitchPage"
  />  
  <Seller_menue 
    v-if="currentPage === 'seller'" 
    @switchPage="handleSwitchPage"/>
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
.container .menu {
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
.container .logo{
    color: black;
    font-size: 50px;
    padding: 10px 0px;
}
.container .logo:hover,.container li:hover{
  color: aliceblue;
}

.container ul{
    display: flex; 
    gap: 10px;
}


/* ------------------------------------------ */




</style>