<script setup>
import product from './product.vue';

</script>

<template>
       <div class="container2" >
        <nav class="menu2">
          <h3>商品分類</h3>
            <ul>
                <li class="menu_item">所有</li>
                <li class="menu_item">語言</li>
                <li class="menu_item">社會</li>
                <li class="menu_item">理工</li>
                <li class="menu_item">自然</li>
            </ul>
        </nav>
        
        
        <product />
        
    </div>
     


</template>

<style scoped>
*{
    padding: 0;
    margin: 0;
    list-style: none;
}

.container2{
  display: flex;
}
.menu3{
  margin: 10px;
  display: flex;
  
}
.menu3 div{
  border: 1px solid gray;
  width: 200px;

  background: rgb(243, 239, 239);
  border-radius: 10px;
  margin: 30px;
}
/* ------- */

.menu2{
  background: rgb(211, 211, 211);
  padding: 2px;
  width: 100px;
  text-align: center;
}
.menu2>ul>.menu_item{
  border: 1px solid plum;
}
.menu2>ul>.menu_item:hover {
  background-color: pink; /* 滑鼠移過來會變色 */
}
.menu_item{
    /* width: 200px; */
    color: black;
    line-height: 60px;
    font-size: 20px;
}
/* ------------------------------------------ */




</style>