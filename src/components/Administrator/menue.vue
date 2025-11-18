<script setup>
import review from './review.vue'

import { ref } from 'vue'
const currentPage = ref('review')

function switchPage(page) {
  currentPage.value = page
}
</script>

<template>
  <div class="buyer_container">
    <nav class="menu2">
      <ul>
        <h3>管理員</h3>
        <li class="menu_item" @click="switchPage('review')">書籍審核</li>
      </ul>
    </nav>

    <div class="content">
      <review v-show="currentPage === 'review'" />
    </div>
  </div>
</template>

<style scoped>
*{
    padding: 0;
    margin: 0;
    list-style: none;
}

.buyer_container{
  display: flex;
  margin: 100px 0 0 0;
}


.buyer_container .menu2{
  background: rgb(232, 240, 121);
  padding: 2px;
  width: 100px;
  text-align: center;
}
.buyer_container .menu2>ul>.menu_item{
  border: 1px solid plum;
}
.buyer_container .menu2>ul>.menu_item:hover {
  background-color: pink; /* 滑鼠移過來會變色 */
}
.buyer_container .menu_item{
    /* width: 200px; */
    color: black;
    line-height: 60px;
    font-size: 20px;
}
/* ------------------------------------------ */
</style >