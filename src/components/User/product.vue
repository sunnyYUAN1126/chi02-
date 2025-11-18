<template>
  <div class="page">
    <h2>書籍管理</h2>

    <table border="1" cellpadding="6">
      <thead>
        <tr>
          <th>書名</th>
          <th>幾成新</th>
          <th>有無筆記</th>
          <th>書況描述</th>
          <th>上架日期</th>
          <th>二手價</th>
          <th>圖片</th>
          <th>操作</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(item, index) in books" :key="index">
          <template v-if="editIndex !== index">
            <td>{{ item.title }}</td>
            <td>{{ item.condition }} 成新</td>
            <td>{{ item.notes }}</td>
            <td>{{ item.description }}</td>
            <td>{{ item.uploadTime }}</td>
            <td>{{ item.price }}</td>
            <td>
              <div class="d-flex gap-2">
                <img
                  v-for="(img, i) in item.images || []"
                  :key="i"
                  :src="img"
                  alt="preview"
                  style="width:60px; height:60px; object-fit:cover; border:1px solid #ccc; cursor:pointer;"
                  @click="openPreview(img)"
                />
              </div>
            </td>
            <td>
              <button @click="startEdit(item, index)">編輯</button>
              <button @click="deleteBook(index)">刪除</button>
            </td>
          </template>

          <template v-else>
            <td>{{ editData.title }}</td>
            <td>
              <select v-model="editData.condition">
                <option value="9">9成新</option>
                <option value="8">8成新</option>
                <option value="7">7成新</option>
                <option value="6">6成新</option>
                <option value="5">5成新</option>
                <option value="4">4成新</option>
                <option value="3">3成新</option>
                <option value="2">2成新</option>
                <option value="1">1成新</option>
              </select>
            </td>
            <td>
              <select v-model="editData.notes">
                <option value="無筆記">無筆記</option>
                <option value="少量筆記">少量筆記</option>
                <option value="大量筆記">大量筆記</option>
              </select>
            </td>
            <td><textarea v-model="editData.description"></textarea></td>
            <td>{{ editData.uploadTime }}</td>
            <td><input type="number" v-model="editData.price" min="0" /></td>
            <td>
              <div class="d-flex gap-2 flex-wrap">
                <div v-for="(img, i) in editData.images" :key="i" class="position-relative">
                  <img
                    :src="img"
                    alt="preview"
                    style="width:60px; height:60px; object-fit:cover; border:1px solid #ccc; cursor:pointer;"
                    @click="openPreview(img)"
                  />
                  <button
                    type="button"
                    @click="removeImage(i)"
                    style="position:absolute; top:0; right:0; background:red; color:white; border:none; border-radius:50%; width:18px; height:18px; cursor:pointer;"
                  >
                    ×
                  </button>
                </div>
                <div v-if="editData.images.length < 4">
                  <input type="file" accept="image/*" @change="addImage($event)" />
                </div>
              </div>
            </td>
            <td>
              <button @click="saveEdit(editIndex)">儲存</button>
              <button @click="cancelEdit">取消</button>
            </td>
          </template>
        </tr>
      </tbody>
    </table>

    <!-- 放大預覽遮罩 -->
    <div v-if="previewImage" class="preview-overlay" @click="closePreview">
      <img :src="previewImage" class="preview-img" />
    </div>
  </div>
</template>

<script setup>
import { ref, reactive } from "vue"

const books = ref([
  {
    title: "資料庫系統概論",
    condition: 9,
    notes: "無筆記",
    description: "近全新，無破損",
    uploadTime: "2025-01-01",
    price: 250,
    images: []
  },
  {
    title: "Java 程式設計",
    condition: 8,
    notes: "少量筆記",
    description: "封面微折",
    uploadTime: "2025-01-15",
    price: 150,
    images: []
  }
])

const editIndex = ref(null)
const editData = reactive({})
const previewImage = ref(null)

function startEdit(item, index) {
  editIndex.value = index
  Object.assign(editData, {
    ...item,
    images: [...(item.images || [])]
  })
}

function saveEdit(index) {
  Object.assign(books.value[index], editData)
  editIndex.value = null
}

function cancelEdit() {
  editIndex.value = null
}

function deleteBook(index) {
  if (confirm("確定要刪除這本書嗎？")) {
    books.value.splice(index, 1)
  }
}

function removeImage(i) {
  editData.images.splice(i, 1)
}

function addImage(e) {
  const file = e.target.files[0]
  if (!file) return
  if (editData.images.length >= 4) {
    alert("最多只能上傳4張圖片")
    return
  }
  const reader = new FileReader()
  reader.onload = (event) => {
    editData.images.push(event.target.result)
  }
  reader.readAsDataURL(file)
  e.target.value = ""
}

function openPreview(url) {
  previewImage.value = url
}

function closePreview() {
  previewImage.value = null
}
</script>

<style scoped>
table {
  width: 100%;
  border-collapse: collapse;
}
th, td {
  padding: 8px;
  text-align: center;
}
button {
  margin: 2px;
}
.position-relative {
  position: relative;
}

/* 圖片放大預覽樣式 */
.preview-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0,0,0,0.7);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 9999;
  cursor: pointer;
}
.preview-img {
  max-width: 90%;
  max-height: 90%;
  border-radius: 8px;
}
</style>
