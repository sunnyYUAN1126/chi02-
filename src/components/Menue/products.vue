<script setup>
import { ref } from 'vue'

// ⭐ 每個商品都是獨立的（包含書籍 + 賣家）
const products = ref([
  {
    id: 1,
    isbn: '9786263841253',
    bookName: '特殊傳說Ⅲ vol.09',
    seller: '貓咪賣家',
    condition: '六成新',
    note: '有',
    status: '有泡過水，有點皺',
    date: '2025/1/1',
    price: 100,
    images: [
      'https://via.placeholder.com/300?text=1',
      'https://via.placeholder.com/300?text=2',
      'https://via.placeholder.com/300?text=3',
      'https://via.placeholder.com/300?text=4',
    ]
  },
  {
    id: 2,
    isbn: '9786263841253',
    bookName: '特殊傳說Ⅲ vol.09',
    seller: '狗狗賣家',
    condition: '五成新',
    note: '有',
    status: '正常無損壞',
    date: '2025/1/1',
    price: 120,
    images: [
      'https://via.placeholder.com/300?text=A',
      'https://via.placeholder.com/300?text=B',
      'https://via.placeholder.com/300?text=C',
      'https://via.placeholder.com/300?text=D',
    ]
  },
  {
    id: 3,
    isbn: '9781234567890',
    bookName: '魔法書Ⅱ vol.05',
    seller: '小明',
    condition: '九成新',
    note: '無',
    status: '保存良好',
    date: '2025/2/1',
    price: 180,
    images: [
      'https://via.placeholder.com/300?text=X',
      'https://via.placeholder.com/300?text=Y',
      'https://via.placeholder.com/300?text=Z',
      'https://via.placeholder.com/300?text=W',
    ]
  }
])

// 控制頁面
const showDetail = ref(false)
const selectedProduct = ref(null)

// 進入詳細頁
function viewDetail(product) {
  selectedProduct.value = product
  showDetail.value = true
}

// 返回首頁
function goBack() {
  selectedProduct.value = null
  showDetail.value = false
}

// ⭐ 點圖片放大
const showImage = ref(false)
const bigImage = ref('')

function openImage(img) {
  bigImage.value = img
  showImage.value = true
}

function closeImage() {
  showImage.value = false
}
</script>

<template>
  <!-- ⭐ 商品列表：每個賣家的上架都是獨立商品卡 -->
  <div v-if="!showDetail" class="row row-cols-1 row-cols-md-4 g-4 " style="margin: 50px;">

    <div
      class="col"
      v-for="product in products"
      :key="product.id"
    >
      <div class="card shadow-sm" @click="viewDetail(product)" style="cursor:pointer">
        <img :src="product.images[0]" class="card-img-top" style="height: 300px;" alt="商品圖片">

        <div class="card-body">
          <h5 class="card-title">{{ product.bookName }}</h5>
          <p class="card-text">賣家：{{ product.seller }}</p>
          <p class="card-text">ISBN：{{ product.isbn }}</p>
          <p class="card-text fw-bold text-primary">二手價：{{ product.price }} 元</p>
        </div>
      </div>
    </div>

  </div>

  <!-- ⭐ 詳細頁：單一賣家商品 -->
  <div v-else class="apple1 card mx-auto p-4" style="width: 70%;">

    <button class="btn btn-secondary mb-3" @click="goBack">← 返回</button>

    <h4>{{ selectedProduct.bookName }}</h4>
    <p>ISBN：{{ selectedProduct.isbn }}</p>
    <p class="fw-bold">{{ selectedProduct.seller }} 的商品</p>

    <div class="d-flex gap-2 mb-4">
      <img
        v-for="(img, index) in selectedProduct.images"
        :key="index"
        :src="img"
        class="detail-img"
        @click="openImage(img)"
        style="cursor: zoom-in;"
      >
    </div>

    <p>幾成新：{{ selectedProduct.condition }}</p>
    <p>有無筆記：{{ selectedProduct.note }}</p>
    <p>書況描述：{{ selectedProduct.status }}</p>
    <p>上架時間：{{ selectedProduct.date }}</p>

    <h4 class="text-primary fw-bold">售價：{{ selectedProduct.price }} 元</h4>

    <button class="btn btn-primary w-100 mt-3">
      <i class="bi bi-cart4"></i> 加入購物車
    </button>

  </div>

  <!-- ⭐ 放大圖片 Modal -->
  <div
    v-if="showImage"
    class="image-modal"
    @click="closeImage"
  >
    <img :src="bigImage" class="image-modal-content">
  </div>
</template>

<style scoped>
.detail-img {
  width: 23%;
  height: 120px;
  object-fit: cover;
  border-radius: 8px;
  background: #eee;
}

.card-body {
  background: rgb(245, 245, 245);
}

.row {
  padding-top: 120px;
}

.apple1 {
  margin-top: 150px;
}

/* ⭐ 放大圖片 modal */
.image-modal {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0,0,0,0.8);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 9999;
  cursor: zoom-out;
}

.image-modal-content {
  max-width: 90%;
  max-height: 90%;
  border-radius: 10px;
}
</style>
