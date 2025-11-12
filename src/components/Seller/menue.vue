<script setup>
import history from './history.vue'
import order from './order.vue'

// 目前顯示哪個頁面
import { ref } from 'vue'
const currentPage = ref('order') // 預設顯示訂單交易

// 切換頁面
function switchPage(page) {
  currentPage.value = page
}

// 切換回買家專區
const emit = defineEmits(['switchPage'])
function showBuyerPage() {
  emit('switchPage', 'Member_Area')
}
</script>

<template>
  <div class="container2">
    <nav class="menu2">
      <ul>
        <h3>賣家專區</h3>
        <li class="menu_item" @click="switchPage('order')">訂單交易</li>
        <li class="menu_item" @click="switchPage('history')">交易歷史</li>
        <li class="menu_item" @click="showBuyerPage">買家專區</li>
      </ul>
    </nav>

    <!-- 主內容區 -->
    <div class="content">
      <order v-show="currentPage === 'order'" />
      <history v-show="currentPage === 'history'" />
    </div>
  </div>
</template>

<style scoped>
.container2 {
  display: flex;
}

.menu2 {
  background: rgb(211, 211, 211);
  padding: 10px;
  width: 120px;
  text-align: center;
}

.menu_item {
  border: 1px solid plum;
  margin: 5px 0;
  padding: 10px;
  cursor: pointer;
}

.menu_item:hover {
  background-color: pink;
}

.content {
  flex: 1;
  padding: 20px;
}
</style>