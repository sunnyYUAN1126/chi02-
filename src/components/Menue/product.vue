<template>
  <div class="p-6 max-w-6xl mx-auto">
    <!-- 標題 -->
    <h1 class="text-2xl font-bold mb-6">書籍館（示範畫面）</h1>

    <!-- 列表頁（首頁） -->
    <div v-if="view === 'list'">
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        <div v-for="book in books" :key="book.isbn" class="bg-white rounded-2xl shadow p-4 flex flex-col">
          <img :src="book.image" alt="cover" class="w-full h-48 object-cover rounded-lg mb-3" />
          <div class="flex-1">
            <p class="text-sm text-gray-500">ISBN: <span class="font-medium text-gray-700">{{ book.isbn }}</span></p>
            <h2 class="mt-2 text-lg font-semibold">{{ book.title }}</h2>
            <p class="text-sm text-gray-600">作者：{{ book.author }}</p>
            <p class="text-sm text-gray-600">出版社：{{ book.publisher }}</p>
          </div>

          <div class="mt-4 flex items-center justify-between">
            <button @click="openDetail(book)" class="px-3 py-1 rounded-xl bg-indigo-600 text-white">查看詳細</button>
            <div class="text-sm text-gray-500">售出：{{ book.sales }}</div>
          </div>
        </div>
      </div>
    </div>

    <!-- 詳細頁 -->
    <div v-if="view === 'detail'">
      <button @click="view='list'" class="mb-4 text-sm text-indigo-600">← 回列表</button>

      <div class="bg-white rounded-2xl shadow p-6 grid grid-cols-1 md:grid-cols-3 gap-6">
        <div class="md:col-span-1">
          <img :src="selectedBook.image" alt="cover" class="w-full h-80 object-cover rounded-lg" />
        </div>

        <div class="md:col-span-2">
          <h2 class="text-2xl font-bold">{{ selectedBook.title }}</h2>
          <p class="text-sm text-gray-500 mt-1">ISBN: <span class="font-medium text-gray-700">{{ selectedBook.isbn }}</span></p>
          <p class="text-sm text-gray-600 mt-2">作者：{{ selectedBook.author }}</p>
          <p class="text-sm text-gray-600">出版社：{{ selectedBook.publisher }} • 出版日期：{{ selectedBook.publishDate }}</p>

          <div class="mt-4">
            <h3 class="font-semibold">書籍摘要</h3>
            <p class="text-sm text-gray-700 mt-2">{{ selectedBook.summary }}</p>
          </div>

          <div class="mt-4 flex gap-6">
            <div>庫存：<span class="font-medium">{{ selectedBook.stock }}</span></div>
            <div>銷售數量：<span class="font-medium">{{ selectedBook.sales }}</span></div>
          </div>

          <!-- 其他賣家清單 -->
          <div class="mt-6">
            <h3 class="font-semibold mb-2">其他賣家（可選擇並加入購物車）</h3>
            <div class="space-y-3">
              <label v-for="seller in selectedBook.sellers" :key="seller.id" class="flex items-center justify-between p-3 border rounded-lg">
                <div>
                  <div class="font-medium">{{ seller.storeName }}</div>
                  <div class="text-sm text-gray-500">價格：NT$ {{ seller.price }} </div>
                </div>

                <div class="flex items-center gap-3">
                  <input type="radio" :value="seller.id" v-model="selectedSellerId" />
                  <button @click="addToCart(selectedBook, seller)" :disabled="seller.stock === 0" class="px-3 py-1 rounded-xl text-white" :class="seller.stock === 0 ? 'bg-gray-400' : 'bg-green-600'">加入購物車</button>
                </div>
              </label>
            </div>
          </div>

          <div v-if="cartMessage" class="mt-4 text-sm text-green-600">{{ cartMessage }}</div>

        </div>
      </div>

      <!-- 推薦：同類或其他賣家上架的書籍縮圖 -->
      <div class="mt-6">
        <h3 class="font-semibold mb-3">其他賣家上架的書籍</h3>
        <div class="flex gap-4 overflow-x-auto py-2">
          <div v-for="book in otherSellerBooks" :key="book.isbn" class="min-w-[200px] bg-white rounded-xl shadow p-3">
            <img :src="book.image" class="w-full h-36 object-cover rounded-md mb-2" />
            <div class="text-sm font-medium">{{ book.title }}</div>
            <div class="text-xs text-gray-500">{{ book.author }}</div>
            <button @click="openDetail(book)" class="mt-2 text-sm text-indigo-600">選擇此賣家商品</button>
          </div>
        </div>
      </div>
    </div>

    <!-- 簡單的購物車顯示（非後端） -->
    <div class="fixed bottom-6 right-6 bg-white rounded-2xl shadow p-3">
      <div class="text-sm">購物車：<span class="font-semibold">{{ cart.length }}</span> 件</div>
      <button @click="showCart" class="text-xs text-indigo-600 mt-1">查看（示範）</button>
    </div>

    <!-- Cart modal（簡易） -->
    <div v-if="showCartModal" class="fixed inset-0 bg-black/40 flex items-end md:items-center justify-center p-4">
      <div class="bg-white rounded-2xl w-full md:w-1/2 p-4">
        <h3 class="font-semibold">購物車內容</h3>
        <div class="mt-3 space-y-2">
          <div v-for="(item, idx) in cart" :key="idx" class="flex items-center justify-between p-2 border rounded-md">
            <div>
              <div class="font-medium">{{ item.book.title }}</div>
              <div class="text-sm text-gray-500">賣家：{{ item.seller.storeName }} • 價格：NT$ {{ item.seller.price }}</div>
            </div>
            <div class="flex items-center gap-2">
              <div class="text-sm">數量：{{ item.qty }}</div>
            </div>
          </div>
        </div>

        <div class="mt-4 flex justify-end gap-3">
          <button @click="showCartModal=false" class="px-3 py-1 rounded-xl border">關閉</button>
          <button @click="checkout" class="px-3 py-1 rounded-xl bg-indigo-600 text-white">結帳（示範）</button>
        </div>
      </div>
    </div>

  </div>
</template>

<script setup>
import { ref } from 'vue'

const view = ref('list')
const books = ref([
  {
    isbn: '978-986-476-000-1',
    title: '深夜的程式旅人',
    author: '陳小明',
    publisher: '晨星出版社',
    publishDate: '2023-06-15',
    image: 'https://picsum.photos/seed/book1/600/900',
    summary: '一本關於程式與人生交織的短篇隨筆集，適合夜深人靜時閱讀。',
    stock: 12,
    sales: 245,
    sellers: [
      { id: 's1', storeName: '小明二手書店', price: 320, stock: 1 },
      { id: 's2', storeName: '城市書攤', price: 300, stock: 1},
      { id: 's3', storeName: '網路賣家A', price: 330, stock: 1 }
    ]
  },
  {
    isbn: '978-957-444-123-4',
    title: '資料庫真好玩',
    author: '李老師',
    publisher: '大學出版社',
    publishDate: '2021-11-01',
    image: 'https://picsum.photos/seed/book2/600/900',
    summary: '帶你從零到一理解資料庫設計與 SQL 實作的入門書。',
    stock: 5,
    sales: 1021,
    sellers: [
      { id: 's4', storeName: '學長書局', price: 450, stock: 1 },
      { id: 's5', storeName: '書香門市', price: 470, stock: 1 }
    ]
  }
])

const otherSellerBooks = ref([
  { isbn: '978-123-456-789-7', title: '前端玩世界', author: '王前端', image: 'https://picsum.photos/seed/book3/600/900' },
  { isbn: '978-987-654-321-0', title: '演算法日常', author: '演算法君', image: 'https://picsum.photos/seed/book4/600/900' }
])

const selectedBook = ref(books.value[0])
const selectedSellerId = ref(null)
const cart = ref([])
const cartMessage = ref('')
const showCartModal = ref(false)

function openDetail(book) {
  selectedBook.value = book
  // 預設選第一個有庫存的賣家
  const firstAvailable = book.sellers.find(s => s.stock > 0)
  selectedSellerId.value = firstAvailable ? firstAvailable.id : (book.sellers[0] && book.sellers[0].id)
  view.value = 'detail'
  cartMessage.value = ''
}

function addToCart(book, seller) {
  if (seller.stock === 0) {
    cartMessage.value = '此賣家已售完，請選其他賣家。'
    return
  }
  cart.value.push({ book, seller, qty: 1 })
  cartMessage.value = `已加入購物車：${book.title}（${seller.storeName}）`
}

function showCart() {
  showCartModal.value = true
}

function checkout() {
  // 示範行為：清空購物車並提示
  cart.value = []
  showCartModal.value = false
  cartMessage.value = '已模擬結帳，購物車已清空（僅示範）'
}
</script>

<style scoped>
/* 如果你使用 Tailwind，這裡可以留空；否則加一點簡單樣式 */
</style>
