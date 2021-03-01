const addNums = (num1, num2) => {
  return num1 + num2;
};
console.log(addNums(10, 15));
console.log("---------------------------------------------");
//---------------------------------------------------------原生函数
function Person(firstName, lastName, dob) {
  this.firstName = firstName;
  this.lastName = lastName;
  this.dob = new Date(dob);
}

Person.prototype.getBirthYear = function () {
  return this.dob.getFullYear();
};

Person.prototype.getFullName = function () {
  return `${this.firstName} ${this.lastName}`;
};

const person1 = new Person("li", "gang", "11-12-1997");
const person2 = new Person("zhong", "yi", "03-10-1999");

console.log(person1.getBirthYear());
console.log(person1.getFullName());
console.log(person2.getBirthYear());
console.log(person2.getFullName());
console.log(person1);
console.log(person2);

console.log("-------------------------------------------");

//-----------------------------------------------------Es6中的类
class person {
  constructor(firstName, lastName, dob) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.dob = new Date(dob);
  }
  getBirthYear() {
    return this.dob.getFullYear();
  }
  getFullName() {
    return `${this.firstName} ${this.lastName}`;
  }
}

const person3=new person('li','ming','05-09-1998')
const person4=new person('wang','meimei','06-27-1997')
console.log(person3.getBirthYear());
console.log(person4.getFullName());

console.log("--------------------------------------");