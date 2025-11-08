<script setup>
import { ref } from "vue"

const login_message = ref("Hello")
</script>

<template>
    <div class="register_container">
        <nav class="menu">
          <div>
            <h1>註冊新帳號</h1>
          </div>
          <div class="input-group">
            <h2>帳號 </h2><input type="text" >      
          </div>
          <div class="input-group">
            <h2>電子郵件  </h2>  <input type="password" >        
          </div>
          <div class="input-group">
            <h2>系所 </h2>  <input type="password" >         
          </div>
          <div class="input-group">
            <h2>學號 </h2> <input type="password" >          
          </div>
          <div class="input-group">
            <h2>密碼 </h2> <input type="password" >         
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

.register_container{
  width: 400px;
  height: 600px;
  border-radius: 50px;
  background: pink;

  display: flex;
  justify-content: center; /* 水平置中 */
  align-items: center;     /* 垂直置中 */
  margin: 0 auto;          /* 整個容器在畫面中水平置中 */
}
.register_container>.menu{
  display: inline-block;
  text-align: center; /* 讓裡面的內容也置中 */
}
.register_container>.menu>.input-group{
  display: flex;
  padding: 10px;
}
.register_container>.menu>.input-group>h2{
  width: 100px;
}
.register_container>.menu input{
  height: 30px;
}
.register_container button{
  width: 100px;
  height: 50px;
  border: 3px solid black;
  border-radius: 40px;
  margin: 50px 0 0;
}
.register_container button:hover{
  background: black;
  color: aliceblue;
  border: 3px solid white;
}



</style>