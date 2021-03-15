// 展开数组
const a = [3, 4, 5];
const b = [1, 2, ...a, 6, 7];
console.log(b); //[1,2,3,4,5,6,7]

console.log("---------------------------------------");

// 收集
function foo(a, b, ...c) {
  // ...c将传进来的3,4,5,6收集成数组
  console.log(a, b, c);
}
foo(1, 2, 3, 4, 5, 6); //1,2,[3,4,5,6]

console.log("---------------------------------------");

// 把类数组转换为数组
function foo1(...args) {
  args.push(4, 5, 6);
  return args;
}
console.log(foo1(1, 2, 3)); // [1, 2, 3, 4, 5, 6]

console.log("---------------------------------------");

//为数组增加新成员(可替换 js 中的 push 方法)
const peoples = ["jone", "jack"];
const mrFan = "吴亦凡";
const all = [...peoples, mrFan];
console.log(all); //  ["jone", "jack", "吴亦凡"]

console.log("---------------------------------------");

//为对象新增属性
const obj = { name: "jack", age: 30 };
const result = { ...obj, sex: "男", height: "178cm" };
console.log(result); // {name: "jack", age: 30, sex: "男", height: "178CM"}
