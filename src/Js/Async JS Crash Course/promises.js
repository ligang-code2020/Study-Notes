/*
promise的用法：
1.首先，我们理解一下异步的概念，一般来说，可以改变程序执行顺序的操作就可以看成为异步操作。

promise的三种状态：
1.Pending是初始状态，等到任务完成或者被拒绝。
2.Resolved是执行完成并且成功的状态。
3.Rejected是执行完成并且失败的状态。

promise的优点：
1.利用promise可以将异步操作以同步操作的流程表达出来，避免了层层嵌套的回调函数。
2.此外，promise对象提供统一的接口，使得控制异步操作更加容易。

promise的缺点：
1.但注意promise无法取消，一旦建立就会立即执行，无法中途取消。
2.而且，如果不设置回调函数，promise内部抛出的错误不会反映到外部。
3.当处于Pending状态时，无法得知进展到哪一个阶段。

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


function createPosts(post, callback) {
  setTimeout(() => {
    posts.push(post);
    callback();
  }, 2000);
}
