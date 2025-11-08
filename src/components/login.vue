<script setup>
import { ref } from "vue"

const login_message = ref("Hello")
</script>

<template>
    <div class="loging_container">
        <nav class="menu">
          <div>
            <h1>會員登入</h1>
          </div> 
          <div>
            <h2>帳號 <input type="text" ></h2>      
          </div>
          <div>
            <h2>密碼 <input type="password" ></h2>           
          </div>
          <div>
            <button>登入</button>
          </div>
        </nav>
    </div>



</template>

<style scoped>
*{
    padding: 0;
    margin: 0;
    list-style: none;
}

/* ------------------------------------------ */

.loging_container{
  width: 300px;
  height: 400px;
  border-radius: 50px;
  background-color: pink;

  display: flex;
  justify-content: center; /* 水平置中 */
  align-items: center;     /* 垂直置中 */
  margin: 0 auto;          /* 整個容器在畫面中水平置中 */
}
.loging_container>.menu{
  display: inline-block;
  text-align: center; /* 讓裡面的內容也置中 */
}
.loging_container>.menu>div{
  padding: 20px;
}
.loging_container>.menu input{
  height: 30px;
}
.loging_container button{
  width: 100px;
  height: 50px;
  border-radius: 40px;
}
.loging_container button:hover{
  background: black;
  color: aliceblue;
}



</style>