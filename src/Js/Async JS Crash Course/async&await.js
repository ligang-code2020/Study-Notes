/*
async和await的用法：

1.async 会返回一个promise对象，可以使用 then 方法添加回调函数。
2.await 关键字仅在 async function 中有效。如果在 async function 函数体外使用 await ，你只会得到一个语法错误。
3.await 操作符用于等待一个 Promise 对象, 它只能在异步函数 async function 内部使用。
*/

const posts = [
  {
    title: "Post One",
    body: "This is post one",
  },
  {
    title: "Post Two",
    body: "This is post two",
  },
];

function getPosts() {
  setTimeout(() => {
    let output = "";
    posts.map((post, index) => {
      output += `<li>${post.title}</li>`;
    });
    document.body.innerHTML = output;
  }, 1000);
}

function createPosts(post) {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      posts.push(post);
      const error = false;
      if (!error) {
        resolve();
      } else {
        reject("Error:Something went wrong");
      }
    }, 2000);
  });
}

async function init() {
  await createPosts({ title: " Post Three", body: "This is post three" });

  getPosts();
}
//init();

async function fetchUsers() {
  const res = await fetch
  ('https://jsonplaceholder.typicode.com/users');

  const data = await res.json();
  console.log(data);
}
fetchUsers();
