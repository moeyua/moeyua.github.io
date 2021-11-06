---
title: Markdown笔记
date: 2021-01-25 21:25:53
tags: 笔记
---
# Markdown笔记

<!-- TOC -->

- [Markdown笔记](#markdown笔记)
  - [标题](#标题)
  - [段落](#段落)
  - [换行](#换行)
  - [强调](#强调)
  - [引用](#引用)
  - [列表](#列表)
    - [有序列表](#有序列表)
    - [无序列表](#无序列表)
    - [在列表中嵌套其他元素](#在列表中嵌套其他元素)
  - [代码](#代码)
  - [分割线](#分割线)
  - [链接](#链接)
    - [引用链接](#引用链接)
  - [图片](#图片)
    - [图片链接](#图片链接)
  - [转义](#转义)
  - [内嵌HTML](#内嵌html)

<!-- /TOC -->

## 标题
使用多个`#`来表示标题级别，且在标题和`#`间用空格隔开

## 段落
使用空白行

来间隔段落

## 换行
在行末插入两个空格  
或者在行末插入`<br>`<br>
进行换行

## 强调
用`**`包裹需要**加粗**的文本  
用`*`包裹需要*斜体*的文本  
用`***`包裹需要***同时加粗和斜体***的文本

## 引用
> 用`>`表示引用

> 多个段落引用可以在
>
> 空行前插入`>`
>> 用`>>`进行引用嵌套
> 引用也可以带有**其他**元素，但并非所有*元素*都可以

## 列表
### 有序列表
在每个列表项前添加数字并紧跟英文句点`1.`，并且列表以1开始
1. First item
2. Second item
   1. 使用TAB缩进
   2. 进行嵌套
3. Third item
4. Fourth item

### 无序列表
在每个列表项前添加`-`
- First item
- Second item
- Third item
- Fourth item
  
<ul>
    <li>First item</li>
    <li>Second item</li>
    <li>Third item</li>
    <li>Fourth item</li>
</ul>
  
### 在列表中嵌套其他元素
使用TAB来嵌套其他元素，同时不破坏列表连续性
1. First item
2. Second item
   
    ***这里是嵌套元素***

3. Third item
4. Fourth item

<ol>
    <li>First item</li>
    <li>Second item</li>
    <em><b>这里是嵌套元素</b><em>
    <li>Third item</li>
    <li>Fourth item</li>
</ol>

> ***代码块通常采用一个制表符，所以在嵌套时需要两个制表符***

## 代码
通过反引号`` ` `` 包裹需要表示为代码的部分<br>
``Use `code` in your Markdown file.``
> 当代码中包含`` ` ``时，可以用``` `` ```包裹需要表示为代码的部分<br>
> 当代码中包含``` `` ```时，可以用```` ``` ````包裹需要表示为代码的部分<br>
> 当代码中包含```` ``` ````时，可以用````` ```` `````包裹需要表示为代码的部分<br>
> ......以此类推

要创建代码块，请将代码块的每一行缩进至少四个空格或一个制表符。

    <html>
      <head>
      </head>
    </html>

或者也可用```` ``` ````包裹你的代码块，同时也可在后面标注语言来实现代码高亮

````html
```html
<html>
  <body>
    <a href="https://moeyua.github.io/Blog/">
  </body>
</html>
```
````

## 分割线
在单独一行上使用三个或多个星号 (***)、破折号 (---) 或下划线 (___) ，并且不能包含其他内容。

***

为了兼容性，建议在分隔线的前后均添加空白行

## 链接
链接文本放在中括号内，链接地址放在后面的括号中，链接title可选，放在圆括号中链接地址后面，跟链接地址之间以空格分隔。<br>
`[超链接显示名](超链接地址 "超链接title")`<br>
[Moeyua的Blog](https://moeyua.github.io/blog/ "Moeyua的Blog")

可以使用尖括号将不可点击的链接变为可用状态(似乎在vscode中不需要尖括号也可)<br>
<https://moeyua.github.io/blog/><br>
<moeyua@foxmail.com>

>**在vscode中可以先写显示文本，选中该文本，将url复制在该位置即可快速实现一个markdown链接**

### 引用链接
[hobbit-hole][1]
引用样式链接是一种特殊的链接，它使URL在Markdown中更易于显示和阅读。参考样式链接分为两部分：与文本保持内联的部分以及存储在文件中其他位置的部分，以使文本易于阅读。<br>
第一部分两个中括号，分别存放链接显示的文本和该链接的标签或者说是编号，用于与其他链接区分<br>
`[hobbit-hole][1]`<br>
第二部分由编号和链接组成，中间用冒号连接，最后可选连接标题<br>
`[1]: https://en.wikipedia.org/wiki/Hobbit#Lifestyle "Hobbit lifestyles"`<br>
第二部分可以放在文档的任意位置，有些人将它们放在出现的段落之后，有些人则将它们放在文档的末尾（例如尾注或脚注）。

[1]: https://en.wikipedia.org/wiki/Hobbit#Lifestyle "Hobbit lifestyles"

## 图片
使用感叹号 (!), 然后在方括号增加替代文本，图片链接放在圆括号里，括号里的链接后可以增加一个可选的图片标题文本<br>
`![github](https://i.loli.net/2021/01/21/RXGWbrCUaLINp9J.png "github")`<br>
![github](https://i.loli.net/2021/01/21/RXGWbrCUaLINp9J.png "github")

### 图片链接
将图片的markdown用方括号包裹，并且在后面跟一个圆括号添加链接，简单说就是将链接的显示文本替换为图片
[![github](https://i.loli.net/2021/01/21/RXGWbrCUaLINp9J.png "github")](https://github.com/)

## 转义
要显示原本用于格式化 Markdown 文档的字符，请在字符前面添加反斜杠字符<br>
\* Without the backslash, this would be a bullet in an unordered list.

## 内嵌HTML
行级元素可以直接使用;<br>
块级元素需要用空行与其他部分区分，且首尾标签不可缩进;<br>
块级元素内markdown语法不起作用。