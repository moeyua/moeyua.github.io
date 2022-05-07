---
title: 'Grid 用于布局, Flexbox 用于组件'
desc: blog html css javascript js vue macOS 前端 frontEnd
tags:
  - CSS
  - Grid
  - Flex
  - Flexbox
  - 布局
date: 2022-03-05 14:27:05
summary: 本文是 Ahmad Shadeed 的博客文章 《Grid for layout, Flexbox for components》 的翻译。
categories: 译文
---
本文是 [Ahmad Shadeed](https://ishadeed.com/) 的博客文章 [Grid for layout, Flexbox for components](https://ishadeed.com/article/grid-layout-flexbox-components/) 的翻译。

3 月 5 号开始翻译，摸了 3 个月终于翻译完了，下次还敢（不是

------

我的弟弟是一名刚毕业的软件工程师，现在他正在做前端开发相关的实习岗位。他以前学过 Grid 和 flexbox，但是我发现和我经常网上看到的情况一样，他在布局的时候使用 Grid 还是 flexbox 之间摇摆不定。举个例子，他尝试使用 Grid 布局去开发一个网站的 header，但是当他使用了 `grid-column` 属性的时候他发现过程好像并不像想象中那么顺利，所以他只能不停地调整来让页面看起来和设计稿一致。

说句实话，我不太喜欢这样子，所以我试着去找一些关于这方面的资料来让他了解 grid 和 flexbox 之间的区别，最好还能带上几个例子，但可惜的是我一无所获。所以我尝试写了一篇涵盖了这个主题所有内容的文章，希望大家能够从中获益。

#### 介绍

在深入探讨概念和实例之前，首先要确保你了解 CSS grid 和 flexbox 的主要区别。CSS Grid是一个拥有「行」和「列」概念的多维布局模块。Flexbox 可以将其子项布局成列或行，但不能同时进行（译者注：可以理解为一维）。

如果你还不了解关于 CSS grid 和 flexbox 相关的知识，我非常建议你去阅读这篇 [可视化文章](https://ishadeed.com/article/learn-box-alignment/)。如果你已经了解了这些内容那就太棒了，接下来我们就将深入了解它们直接的区别，以及如何使用它们。

#### Grid 和 Flexbox 之间的不同点
首先我需要澄清一点，关于「何时使用 CSS Grid 或 flexbox」这里没有一个非常明确的界线。还有一点就是，没有「使用这种方法 **正确** 或者 **错误**」这种说法。这篇文章是推荐在特定的使用情况下使用某种技术的指南，我将会讲述一些基本概念，然后通过一些例子说明这些概念，剩余的就需要靠你自己去探索和实验了。
```CSS
/* Flexbox 容器 */
.wrapper {
  display: flex;
}

/* Grid 容器 */
.wrapper {
  display: grid;
  grid-template-columns: 2fr 1fr;
  grid-gap: 16px;
}
```
![grid-vs-flexbox](https://s2.loli.net/2022/03/05/TR6MeZLhgxrW7ED.png)

发现了什么吗？Flexbox 是在一行内布局自己的元素，CSS grid 使其转化为拥有行和列的表格。Flexbox 是在行内进行对齐的，当然如果我们愿意也可以在列内。
```CSS
/* Flexbox 容器 */
.wrapper {
  display: flex;
  flex-direction: column;
}
```
![grid-vs-flexbox-1](https://s2.loli.net/2022/03/05/Eo3KZHtYLcURTwv.png)

#### 如何决定使用哪种布局呢

在 CSS grid 和 flexbox 之间做决定有时会很困难，特别是刚入门 CSS 的新手，我非常理解这种心情，我在开始选择之前会问自己下面这几个问题：

- 组件内的元素是如何展示的？行内还是行和列？

- 组件在不同种类的屏幕大小下期望的展示方式是什么？

如果组件的子元素的排列方式是行内，那大多数情况最好的方案应该就是 flexbox 了。看看下面这个例子：

![decide-1](https://s2.loli.net/2022/03/05/msqhfZrGS3toQ9Y.png)

如果是行和列的话，CSS grid 应该是这种情况下的方案。

![decide-2](https://s2.loli.net/2022/03/05/APLnzX29OUEB5iu.png)

现在我已经说明了它们之间主要的不同点，现在让我们看一下更加特殊的例子来学习如何决定这两种布局。



#### 一些案例和实例

在下面的章节中，我将详细讨论 flexbox 和 grid 的不同使用情况。

##### CSS Grid

###### 两栏式布局（Main And Sidebar）

当你需要一个两栏式布局（一个侧边栏和主要内容）时，CSS grid 就是最好的选择，请看下面这个例子：

![grid-use-1](https://s2.loli.net/2022/03/07/7RwjJ92avFyO5VX.png)

这里是实现代码：

``` html
<div class="wrapper">
  <aside>Sidebar</aside>
  <main>Main</main>
</div>
```

``` css
@media (min-width: 800px) {
  .wrapper {
    display: grid;
    grid-template-columns: 200px 1fr;
    grid-gap: 16px;
  }
  aside {
    align-self: start;
  }
}
```

如果 `<aside>` 元素没有使用 `align-self` 属性，那么它的高度就会无视内容，始终等于 `<main>` 元素。

###### Cards Grid（网格卡片）

正如我们在文章开头所说的，布局 cards grid 的最佳方式从 CSS grid 的名字就不言而喻了。

![grid-use-2](https://s2.loli.net/2022/03/07/wPGfl194NcrRhFj.png)

这里是我实现这个布局的代码：

``` CSS
.wrapper {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  grid-gap: 16px;
}
```

每一列的宽度最小应该是 `200px`，如果没有足够的空间则会自动换到下一行。需要注意的是，如果视口（viewport）的宽度小于 `200px` ，上述写法会导致在水平方向上发生滚动。

一个比较简单的解决方式是只有在 `viewport` 的宽度足够时上述代码才会生效，像下面这样：

``` css
@media (min-width: 800px) {
  .wrapper {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    grid-gap: 16px;
  }
}
```

###### Section Layout

在下面的这个例子中，我们可以使用两次 grid 布局来实现。首先我们使用 grid 布局将整个区域分成两个部分（侧边栏部分和表单部分），接着我们就可以使用 grid 将表单进行布局。

![grid-use-3](https://s2.loli.net/2022/03/09/lZfCT9dbjVUqLex.png)

I can’t emphasis how CSS grid is perfect for that. 下面是 CSS 实现代码：

```css
@media (min-width: 800px) {
  .wrapper {
    display: grid;
    grid-template-columns: 200px 1fr;
  }
  
  .form-wrapper {
    display: grid;
    grid-template-columns: 1fr 1fr;
    grid-gap: 16px;
  }
  
  .form-message,
  .form-button {
    grid-column: 1 /3; /* 让它们充满整个宽度 */
  }
}
```

这个例子引用自我在 Envato 的 [这一篇文章](https://webdesign.tutsplus.com/tutorials/how-to-build-web-form-layouts-with-css-grid--cms-28776)，这是一篇关于在 web 开发时如何使用 CSS grid 进行布局的文章，非常值得一读。

##### CSS Flexbox

###### 网站导航

在 90% 的情况下，网站的导航栏都应该使用 CSS flexbox 进行开发。它们最大的共同之处就是在左边有一个 logo，导航的部分都在右边。这种情况非常适用于 flexbox。

![flexbox-use-1](https://s2.loli.net/2022/03/09/mhKH4MjieyZ3uc5.png)

要想实现上面这个例子，你只需要按照下面的方式进行设置：

``` css
.site-header {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
}
```

同样的，上述代码也可以用在下面的这种设计中。

![flexbox-use-2](https://s2.loli.net/2022/03/09/dS1gIjmuVKABCFN.png)

你应该注意到导航栏的结构发生了一点变化，但是子元素之间的间距仍由 `ustify-content` 属性决定。

###### 操作列表

当你听到列表的时候第一反应一定是垂直排列的列表。这里特别说明一下，一个列表也可以在一行内排列，所以各位不要搞错。

关于操作列表的例子我们可以参考 Facebook 或者 Twitter。操作列表由几个操作按钮组成。我们看看下面的这张截图吧：

![flexbox-use-3](https://s2.loli.net/2022/03/09/7jLgqSUGeJiTKuZ.png)

就像你看到的那样，所有元素之间彼此相邻，而且它们水平分布。Flexbox 简直是最完美的选择，这也是它的核心用途之一。

```css
.action-list {
  display: flex;
}

.action-list_item {
  flex: 1; /* 让所有子元素扩大，使得它们能够平分所有空间 */
}
```

另一个类似的用法就是用作弹窗的标题和操作按钮。
不管弹窗页脚 `footer` 还是页眉 `header` 的子元素全都是在行内排列，就像你看到的，他们之间的空隙如下所示：
![flexbox-use-4](https://s2.loli.net/2022/03/14/NfznIZOB9DGk1b5.png)
对于弹窗的页眉来说，下面这种写法就能够满足需要：
```css
.modal-header {
	display: flex;
	justify-content: space-between;
}
```
页脚对于我们来说可能有一些不同的地方。「取消」按钮需要将 `margin` 设置为 `auto` 来将它放置到右边。关于这一点我写了一篇详细介绍这方面内容的 [文章]（https://ishadeed.com/article/auto-css/ 。
```css
.cancel_action {
	margin-left: auto;
}
```
`.cancel_action` 可能在这里不是一个好的命名方式，但是在这篇文章里我并不打算详细说明有关 CSS 的命名规则。

###### 表单元素
一个输入框旁边紧挨着一个按钮的组合可以说是 Flexbox 的完美案例了。
请看下面这个例子：

![flexbox-use-5](https://s2.loli.net/2022/03/14/A9v8msD6bk3WzTU.png)

在第一个表单当中，输入框占据了所有的剩余空间，所以我们需要给它设置一个动态的宽度。同样的，第二个表单（Facebook 的 Messenger）也是一样，文字输入框占据了所有的剩余位置。让我们试着模仿一下。

![flexbox-use-6](https://s2.loli.net/2022/03/14/rmgPZoAE6tlJ3Mb.png)

``` css
.input {
  flex: 1 1 auto;
}
```

主要注意的是，如果我们没有在文字输入框上设置 `flex: 1 1 auto`，那么输入框就不会自动填充满整个剩余空间。

###### 跟帖回复

Flexbox 的另一个比较通用的例子就是「跟帖回复」，比如下面这个例子：

![flexbox-use-7](https://s2.loli.net/2022/03/16/O24yCjo6KvsnUfc.png)

这里有用户的头像和评论本身，评论模块占据了容器的所有剩余空间，用 flexbox 可以完美的实现这种布局。

###### 卡片组件

卡片组件的种类有非常多，但是一般来说最常见的还是下面例子中的这种设计：

![flexbox-use-8](https://s2.loli.net/2022/03/16/fXLsipQD7mkBV52.png)

左边的例子中，我们将 flex 的方向设置为了 `column`，所以卡片的子元素是叠在一起的。相反，右边的方向是 `row` ，而且 flexbox 默认的方向就是 row，这一点千万不要忘记。

```css
.card {
	display: flex;
	flex-direction: column;
}
@media (min-width: 800px) {
	.card {
		flex-direction: row;
	}
}
```

另外一个比较常见的变种是在卡片中有一个图标，而且会有一个文字标签紧挨在下面。它可能是一个按钮、一个链接、或者就仅仅是装饰而已。让我们看看下面这个例子：

![flexbox-use-9](https://s2.loli.net/2022/03/16/3GD6qXxuSekcLBd.png)

值得注意的是图标和文本标签在水平和垂直方向是居中的。感谢 flexbox，让我们能够很简单的实现这种布局。

```css
.card {
  display: flex;
  flex-direction: column;
  align-items: center;
}
```

行内的样式是默认的，我们只需要删除 `flex-direction: column` 让它恢复到默认的值 \<row> 就可以了。 

###### 标签页 / 底部菜单

当一个元素的宽度需要始终等于屏幕宽度，而且它的子元素需要填满所有的可用空间，这时 flexbox 就是我们的最佳选择。

![flexbox-use-10](https://s2.loli.net/2022/03/17/BvNJwm58njPo1db.png)

在上面这个例子中，所有的子元素都应该充满可用空间，而且所有子元素的宽度相同。我们只需要将容器的 display 设置为 `flex` 就可以很轻松的实现这一布局了。

```css
.tabs_item {
  flex-grow: 1;
}
```

这种方式被 React Native 框架用来在移动端创建 Tab 菜单。这里有一段 React Native 的示例代码展示了和上面一样的内容。这里的代码是从 [这里](https://reactnative.dev/docs/flexbox) 借鉴来的。

```react
import React from "react";
import { View } from "react-native";

export default FlexDirectionBasics = () => {
  return (
    <View style=>
      <View
        style=
      />
      <View
        style=
      />
      <View
        style=
      />
    </View>
  );
};
```

###### 功能列表

关于 flexbox 最喜欢的一点就是它能够随意翻转元素的方向。flexbox 默认的方向是 `row` ，但是我们可以像下面这样转换一下：

```css
.item {
	flex-direction: row-reverse;
}
```

在下面这个例子中我们能看到偶数项被翻转，这就是通过上面的方式实现的，非常实用。

![flexbox-use-11](https://s2.loli.net/2022/04/21/YoIa5zwRxBjuXry.png)

###### 居中内容

然后我们设想这样一种情况：我们有一个很重要的部分，这个部分的内容需要被垂直且水平居中。水平居中我们能够使用文本对齐简单的实现。

![flexbox-use-12](https://s2.loli.net/2022/04/21/lCbLxvm29Bq67wT.png)

```css
.hero {
  text-align: center;
}
```

但是如何使用 flexbox 将元素垂直居中呢？这正是我们需要实现的：

```css
.hero {
	display: flex;
	flex-direction: column;
	align-items: center; /* 水平居中元素 */
	justify-content: center; /* 垂直居中元素 */
	text-align: center;
}
```
#### CSS Grid 和 Flexbox 的结合

不仅每个布局模块有自己的使用例，我们甚至可以将他们结合起来使用。当我考虑如何将这两种布局方式结合在一起的时候，我脑海中的第一个想法就是卡片列表。使用 Grid 来布局卡片，使用 flexbox 来布局卡片组件自身。

![grid-and-flex](https://s2.loli.net/2022/04/28/yWjkASTfL8zbaVC.png)

上面的这个布局有以下几点需求：

- 每一行的卡片高度应该保持相等；

- 不管卡片高度如何，Read more 按钮应该始终在卡片的底部；

- Grid  应当使用 `minimal()` 函数。

```html
<div class="wrapper">
  <article class="card">
    <img src="sunrise.jpg" alt="" />
    <div class="card__content">
      <h2><!-- Title --></h2>
      <p><!-- Desc --></p>
      <p class="card_link"><a href="#">Read more</a></p>
    </div>
  </article>
</div>
```

  ```css
  @media (min-width: 500px) {
    .wrapper {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
      grid-gap: 16px;
    }
  }
  
  .card {
    display: flex; /* [1] */
    flex-direction: column; /* [2] */
  }
  
  .card__content {
    flex-grow: 1; /* [3] */
    display: flex; /* [4] */
    flex-direction: column;
  }
  
  .card__link {
    margin-top: auto; /* [5] */
  }
  ```

现在让我来解释一下上面的 CSS。

1. 将卡片设置成 flexbox 容器
2. 排列方向为纵向，也就是说卡片的元素是通过栈的方式进入的
3. 让卡片的内容扩大并充满所有剩余空间
4. 将卡片内容设置为 flexbox 容器
5. 最后，使用 `margin-top: auto` 将 链接 推入栈中。这样不管卡片高度是多少它都会保持在最底部。

正如你所看到的，结合 CSS grid 和 flexbox 并不是很困难。这两种方式可以给我们带来许多种实现 web 布局的方式。我们应该正确的使用它们，而且**只在**像上述需要的情况去结合它们。

#### 支持旧版本的浏览器的回退方案

##### 通过 CSS `@supports`

大概在几个月之前，我得到了一条推特回复说我的网站在 IE11 上崩溃了。在检查过后我发现了一个奇怪的现象。所有的网站内容都被压缩都了左上角的区域。我的网站无法使用了！

![ishadeed-ie11](https://ishadeed.com/assets/grid-flex/ishadeed-ie11.png)

是的，这就是我的网站——一个前端开发工程师的网站，在 IE11 上。首先让我感到困惑的是，这是如何发生的？我记得 CSS grid 是支持 IE11 的，但是这是微软发布的旧版本。解决方法非常简单，那就是使用 `@supports` 只在新的浏览器中使用 CSS grid。

```css
@supports (grid-area: auto) {
  body {
    display: grid;
  }
}
```

让我解释一下。我使用 `grid-area` 是因为它只在新的 CSS grid 规范中被支持，从2017年3月到今天。由于IE不支持 `@supports` 查询，整个规则将被忽略。因此，新的CSS网格将只用于支持的浏览器。

##### 使用 Flexbox 作为 CSS Grid 的回退方案

flexbox 不适合用于展示网格布局中的项目，但是这并不意味着它不能当作备用方案。你可以使用 flexbox 来作为 不支持 CSS grid 浏览器的备用方案。我曾经开发了一个[工具l](https://shadeed.github.io/grid-to-flex/)用来解决这个问题。

```css
@mixin grid() {
  display: flex;
  flex-wrap: wrap;

  @supports (grid-area: auto) {
    display: grid;
    grid-gap: 16px 16px;
  }
}

@mixin gridAuto() {
  margin-left: -16px;

  > * {
    margin-bottom: 16px;
    margin-left: 16px;
  }

  @media (min-width: 320px) {
    > * {
      width: calc((99% / #{2}) - 16px);
      flex: 0 0 calc((99% / #{2}) - 16px);
    }
  }

  @media (min-width: 768px) {
    > * {
      width: calc((99% / #{3}) - 16px);
      flex: 0 0 calc((99% / #{3}) - 16px);
    }
  }

  @supports (grid-area: auto) {
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    margin-left: 0;

    > * {
      width: auto;
      margin-left: 0;
      margin-bottom: 0;
    }
  }
}
```

上面的回退代码通过下面所述的方式运行：

1. 添加 `display: flex` 和 `flex-wrap: wrap` 使元素换行；
2. 检查 CSS grid 是否被支持，如果支持，那么就会使用 `display: grid`；
3. 通过使用 `> *`选择器,我们可以选择容器的直接子后代。在选择完成后，我们就可以给它们每一个都添加一个特殊的宽度或者大小了。
4. 当然，它们之间的间隙是必须的，如果浏览器支持 CSS grid，我们将会用 `grid-gap` 来充当间隙。

这里是一个使用 Sass mixin 的例子：

```css
.wrapper {
  @include grid();
  @include gridAuto();
}
```

[Demo](https://codepen.io/shadeed/pen/XWrLmYe)

#### 如果 Grid 和 Flexbox 都无法正常使用

当我和我弟弟在进行代码评审的时候，我注意到了几个 CSS grid 和 flexbox 都会错误的使用方式，我认为将它们作为重点写出来很有必要。

##### 使用 CSS Grid 来布局网站头部区域

这个问题是让我写下这篇文章的动机之一。我注意到我的弟弟使用 CSS grid 来实现网站的头部区域。

他辩解道“CSS grid 实在是太复杂，太难了“等等。由于使用了不正确的布局方法，他得到了一个想法，认为这是 CSS grid 太复杂造成的。其实不然，他所有的困惑都来自于把它用在不合适的地方的事实。

看一下我注意到的这个例子：

![incorrect-use-1](https://s2.loli.net/2022/05/07/sCj3tBUTWmLZSrv.png)

```css
.site-header {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr 1fr 1fr;
}

.site-nav {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr;
}
```

CSS grid 被使用了两次，第一次是用于整个标题，第二次是用于导航。他用 `grid-column` 来微调元素之间的间距，还有其他一些奇怪的东西，我记不起来了，但是最重要的你应该明白了吧！

##### 使用 CSS Grid 在标签上

CSS grid 的另一个不正确的用法是将其应用于标签组件。请看下面的模拟图。

![incorrect-use-2](https://s2.loli.net/2022/05/07/QGpurMsVOt8RUwN.png)

下面是错误的 CSS 代码：

```css
.tabs-wrapper {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr;
}
```

从上面的代码中，我可以看到，开发者假设标签数只有三个。因此，他用 `1fr 1fr 1fr` 来布置列。如果列数发生变化，布局就失效了。

##### 过度使用 Flexbox 或者 Grid

记住，旧的布局方法可能是完美的方式。过度使用 flexbox 或 grid 会使你的 CSS 的复杂程度随着时间而增加。我并不是说它们很复杂，而是像本文中的例子所解释的那样，在正确的情况下**正确地**使用它们会好很多。

例如，你有如下的主要部分，要求将其所有内容水平居中。

![img](https://s2.loli.net/2022/05/07/yB3ocaDu6G5RvmY.png)

我们可以通过 `text-align: center` 来实现这种布局，那么这个时候我们为什么要去使用 felxbox 这种更复杂的方式？

#### 总结

关于使用 CSS Grid 和 Flexbox 之间的区别，我们已经说了很多了。这个话题我想了很久，我很高兴有机会写这个话题。如果有任何问题请不要犹豫，通过电子邮件或twitter [@shadeed9](https://twitter.com/shadeed9) 提供反馈!

感谢你的阅读！

