/*
回调函数的用法:
回调是一个函数，它作为参数传递给另一个函数，并在其父函数完成后执行
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

//设置回调函数
function createPosts(post, callback) {
  setTimeout(() => {
    posts.push(post);
    callback();
  }, 2000);
}

// 将getPosts方法作为函数传入createPosts函数中执行
createPosts({ title: "Post Three", body: "This is post three" }, getPosts);
