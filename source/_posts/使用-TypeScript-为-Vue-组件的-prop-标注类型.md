---
title: 使用 TypeScript 为 Vue 组件的 prop 标注类型
desc: blog html css javascript js vue macOS 前端 frontEnd
tags:
  - TypeScript
  - Vue
date: 2022-06-02 15:27:41
categories: 技术文档
---

在选项式 API 或者不使用 `<script setup>` 时我们可以使用 `PropType` 这个工具类型来标记更复杂的 prop 类型：

```typescript
import { defineComponent } from 'vue'
// 引入 Proptype
import type { PropType } from 'vue'

interface Book {
  title: string
  author: string
  year: number
}

export default defineComponent({
  props: {
    book: {
      // 提供相对 `Object` 更确定的类型
      type: Object as PropType<Book>,
      required: true
    },
    // 也可以标记函数
    callback: Function as PropType<(id: number) => void>,
    itemList: {
      // 定义数组类型
      type: Array as PropType<Array<SingleItem>>,
      required: false,
    },
  },
})
```

如果不使用 `PropType` 而直接对类型进行断言：

```typescript
itemList: {
      // 项目列表
      type: Array as Array<SingleItem>,
      required: false,
    },
```

会得到 `类型 "ArrayConstructor" 到类型 "SingleItem[]" 的转换可能是错误的，因为两种类型不能充分重叠。如果这是有意的，请先将表达式转换为 "unknown"。` 这样的错误。



当使用 `<script setup>` 时，我们直接通过泛型参数来定义 prop 的类型：

```typescript
<script setup lang="ts">
const props = defineProps<{
  foo: string
  bar?: number
}>()
</script>
```

`defineProps()` 宏函数支持从它的参数中推导类型，所以我们也可以在它的参数中定义：

```typescript
<script setup lang="ts">
const props = defineProps({
  foo: { type: String, required: true },
  bar: Number
})

props.foo // string
props.bar // number | undefined
</script>
```

