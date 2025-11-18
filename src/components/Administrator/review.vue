<template>
  <div class="container mt-4">
    <h2 class="mb-4">📚 管理員書籍審核</h2>
    <table class="table table-hover table-bordered text-center align-middle">
      <thead class="table-dark">
        <tr>
          <th>會員</th>
          <th>幾成新</th>
          <th>有無筆記</th>
          <th>書況</th>
          <th>上架時間</th>
          <th>二手價</th>
          <th>圖片</th>
          <th>審核</th>
        </tr>
      </thead>

      <tbody>
        <tr v-for="(book, index) in books" :key="index">
          <td>{{ book.user }}</td>
          <td>{{ book.condition }}</td>
          <td>{{ book.notes }}</td>
          <td>{{ book.status }}</td>
          <td>{{ book.date }}</td>
          <td>{{ book.price }}</td>
          <td class="d-flex justify-content-center gap-2">
            <img
              v-for="(img, i) in book.images"
              :key="i"
              :src="img"
              alt="book image"
              style="width: 60px; height: 60px; object-fit: cover; border-radius: 5px; border: 1px solid #ccc;"
            />
          </td>
          <td>
            <button class="btn btn-success btn-sm me-2" @click="approve(book)">同意</button>
            <button class="btn btn-danger btn-sm" @click="reject(book)">不同意</button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script setup>
import { ref } from "vue"

const books = ref([
  {
    user: "user001",
    condition: "九成新",
    notes: "無筆記",
    status: "良好",
    date: "2025/11/18",
    price: "$250",
    images: [
      "https://via.placeholder.com/60x60?text=封面1",
      "https://via.placeholder.com/60x60?text=封面2"
    ]
  },
  {
    user: "user002",
    condition: "七成新",
    notes: "有筆記",
    status: "普通",
    date: "2025/11/17",
    price: "$180",
    images: [
      "https://via.placeholder.com/60x60?text=封面1",
      "https://via.placeholder.com/60x60?text=封面2"
    ]
  },
])

const approve = (book) => {
  alert(`已同意：${book.user} 的書籍上架`)
}

const reject = (book) => {
  alert(`已拒絕：${book.user} 的書籍上架`)
}
</script>
