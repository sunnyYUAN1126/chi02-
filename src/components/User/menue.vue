<script setup>
import SellerOrder from './SellorOrder.vue'
import product from './product.vue'
import AddBook from './AddBook.vue'
import order from './BuyerOrder.vue'




import { ref } from 'vue'
const currentPage = ref('AddBook')

function switchPage(page) {
  currentPage.value = page
}
</script>

<template>
  <div class="buyer_container">
    <nav class="menu2">
      <ul>    
        <h3>賣書</h3>
        <li class="menu_item" @click="switchPage('AddBook')">新增書籍</li>
        <li class="menu_item" @click="switchPage('product')">書籍管理</li>
        <li class="menu_item" @click="switchPage('sellerOrder')">訂單管理</li>

        <h3>買書</h3>
        <li class="menu_item" @click="switchPage('order')">訂單查詢</li>
      </ul>
    </nav>

    <div class="content">
      <order v-show="currentPage === 'order'" />
      <AddBook v-show="currentPage === 'AddBook'" />
      <product v-show="currentPage === 'product'" />
      <SellerOrder v-show="currentPage === 'sellerOrder'" />
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




</style>