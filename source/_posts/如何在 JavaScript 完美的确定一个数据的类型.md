---
title: 如何在 JavaScript 完美的确定一个数据的类型
date: 2021-11-03 19:02:53
toc: true
cover: https://i.loli.net/2021/11/11/pbeTzf1ZRjnSHow.jpg
thumbnail: https://i.loli.net/2021/11/11/pbeTzf1ZRjnSHow.jpg
tags: 
  - 技术向
  - JavaScript
---

JavaScript 中有三种方式来确定一个数据的类型：
- `typeof` 运算符
- `instanceof` 运算符
- `Object.prototype.toString()` 方法  
这里就来简单梳理一下这三种方式的优劣，同时得出一个能够完美判断数据类型的方法。
<!--more-->
# typeof
`typeof` 很简单，下面是一个简单的例子：

```javascript
let a = 'foo';
let b = 1;
let c = true;
typeof a    // "string"
typeof b    // "number"
typeof c    // "boolean"
```

使用 `typeof` 判断『原始类型』（数值、字符串、布尔值）时分别返回 `number`、`string`、`boolean`。『合成类型』（对象、数组、函数）分别返回 `object`、`object`、`function`

```javascript
let a = {foo = 'bar'};
let b = ['foo', 'bar'];
let c = function(foo) {
    return foo + 'bar'
}
typeof a    // "object"
typeof b    // "object"
typeof c    // "function"
```

而对于 `undefined` 和 `null` 这两种类型，`typeof` 能够正常判断 `undefined`，但是 `typeof null` 会返回 `object`。

```javascript
let a = undefined;
let b = null;

typeof a    // "undefined"
typeof b    // "object"
```

出现这种情况的原因时最初版的 JavaScript 并没有将 `null` 单独拿出来作为一个数据类型，只是作为 `object` 类型的一种，后来将 `null` 单独拿了出来，但是为了兼容以前的旧的代码，就没有改变 `typeof null` 的返回值。

可见 `typeof` 大部分情况下确实能够准确判断出数据类型，但是对于 `Array` 和 `null` 就会失效。

# instanceof
`instanceof` 运算符返回一个布尔值，表示对象是否为某个构造函数的实例。根据这一特点我们就能够使用该运算符判断数据类型。  

```javascript
let a = {foo = 'bar'};
let b = ['foo', 'bar'];
let c = function(){};

a instanceof Object     // true
b instanceof Array      // true
c instanceof Function   // true
```

如上面的代码所示，`instanceof` 能够区分对象的各种类型，但是需要注意的是，`instanceof` 只能判断对象类型，对于 `number`、`string`、`boolean`、`undefined`、`null` 这几种类型是无法判断的。

# Object.prototype.toString()
`Object.prototype.toString()` 方法的作用是返回一个对象的字符串形式，默认情况下返回类型字符串。不同数据类型的 `toString` 方法返回如下

|数据类型|返回值|
|:---:|:---:|
|数字|`[object Number]`|
|字符串|`[object String]`|
|布尔值|`[object Boolean]`|
|数组|`[object Array]`|
|函数|`[object Function]`|
|undefined|`[object Undefined]`|
|null|`[object Null]`|
|arguments 对象|`[object Arguments]`|
|Error 对象|`[object Error]`|
|Date 对象|`[object Date]`|
|RegExp 对象|`[object RegExp]`|
|其他对象|`[object Object]`|

**那么基于这一特性，我们可以近乎完美的确定一个常见数据的类型：**

```JavaScript
var type = function (o){
  var s = Object.prototype.toString.call(o);
  return s.match(/\[object (.*?)\]/)[1].toLowerCase();
};

type({});// "object"
type([]); // "array"
type(5); // "number"
type(null); // "null"
type(); // "undefined"
type(/abcd/); // "regex"
type(new Date()); // "date"
```
> 需要注意的是，由于实例对象可能会改写 Object.prototype.toSring，所以我们直接使用 Object.prototype.toSring，使用函数的 Call 方法在任意值上调用这个方法。


在上面这个type函数的基础上，还可以加上专门判断某种类型数据的方法。
```JavaScript
var type = function (o){
  var s = Object.prototype.toString.call(o);
  return s.match(/\[object (.*?)\]/)[1].toLowerCase();
};

['Null',
 'Undefined',
 'Object',
 'Array',
 'String',
 'Number',
 'Boolean',
 'Function',
 'RegExp'
].forEach(function (t) {
  type['is' + t] = function (o) {
    return type(o) === t.toLowerCase();
  };
});

type.isObject({}) // true
type.isNumber(NaN) // true
type.isRegExp(/abc/) // true
```


