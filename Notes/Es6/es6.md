# es6 一些常用知识点

## 1.es6 中的 `...`

---

> 基础用法 1：展开数组

```js
const a = [3, 4, 5];
const b = [1, 2, ...a, 6, 7];
console.log(b); //[1,2,3,4,5,6,7]
```

> 基础用法 2：收集

```js
function foo(a, b, ...c) {
  // ...c将传进来的3,4,5,6收集成数组
  console.log(a, b, c);
}
foo(1, 2, 3, 4, 5, 6); //1,2,[3,4,5,6]
```

> 基础用法 3：把类数组转换为数组

```js
const nodeList = document.getElementsByClassName("test");
const array = [...nodeList];

console.log(nodeList); // HTMLCollection [ div.test, div.test ]
console.log(array); // Array [ div.test, div.test ]
```

```js
function foo(...args) {
  args.push(4, 5, 6);
  return args;
}
console.log(foo(1, 2, 3)); // [1, 2, 3, 4, 5, 6]
```

> 基础用法 4：为数组增加新成员(可替换 js 中的 push 方法)

```js
const peoples = ["jone", "jack"];
const mrFan = "吴亦凡";
const all = [...peoples, mrFan];
console.log(all); //  ["jone", "jack", "吴亦凡"]
```

> 基础用法 5：为对象新增属性

```js
const obj = { name: "jack", age: 30 };
const result = { ...obj, sex: "男", height: "178cm" };
console.log(result); // {name: "jack", age: 30, sex: "男", height: "178CM"}
```

> 基础用法 6：合并数组或者数组对象，对象
