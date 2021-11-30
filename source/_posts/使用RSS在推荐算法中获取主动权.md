---
title: 使用 RSS 在推荐算法中获取主动权
date: 2021-01-30 21:25:53
tags: 
    - RSS
categories: 随便写点
---

## 前言
当学习或者工作感到疲惫时，我们通常会放下手里的事情，拿起手机休息一下，这倒也无可厚非，但是今天我们似乎很难自己掌控休息的时间，往往拿起手机就被各种内容吸引，各类软件依靠着自己的推荐算法，总是能带来新鲜的信息，但是这些信息并不能带给我太多东西，比起零碎的信息还是系统性的的知识比较有用。

<!--more-->

为了让我们回归工作和学习，解决信息过载，获取接受信息的主动权，RSS 或许是一个很好的选择，我们可以通过 RSS 主动选择和调整订阅源，摆脱推荐算法，让获取信息变的简单。

鉴于熟练RSS需要一定的学习，这篇文章就想详细讲讲什么是 RSS ，如何使用 RSS 在网络中获取主动权，争取让小白也可以看懂。



## 什么是RSS
RSS 其实并不是什么新鲜的技术，相反 RSS 是在被成为 WEB1.0 时代就已经出现的技术，我们来看一下维基百科上面对 RSS 的定义：

> RSS（全称：RDF Site Summary；Really Simple Syndication），中文译作「简易信息聚合」，也称「聚合内容」，是一种消息来源 格式规范，**用以聚合经常发布更新资料的网站**，例如 博客 文章、新闻、音频 或 视频 的网摘。RSS 文件（或称做摘要、网络摘要、或频更新，提供到频道）包含全文或是节录的文字，再加上发布者所订阅之网摘资料和授权的元数据。简单来说，RSS 能够让用户订阅个人网站个人博客，当订阅的网站有新文章是能够获得通知。

Really Simple Syndication「简易信息聚合」，听名字就能知道这是一个十分简单的技术，简单来说 RSS最主要的目的就是给个人网站和博客提供信息聚合，并通知所有订阅的阅读者，使信息能够更高效的传播。

## RSS 能做什么
- 可以看到没有广告和图片的标题或文章的摘要，这样你不必阅读全文即可知文章讲的一个意思是什么，方便确定是否要阅读本文。

- RSS 阅读器会自动更新你定制的网站内容，保持新闻的及时性。这样每天你就可以在固定时间打开 RSS 阅读最新文章，而不必打开各个软件和网站，也不会被其他消息所干扰。

- 使用 RSS 可以根据你自已的喜好定制多个 RSS 订阅源，这样做的好处是从多个网站来源搜集，然后整合到单个数据流当中。

- 可以在 RSS 中的路由参数中选择订阅网站的某个栏目，比如知乎热榜，微博热搜，而不需要订阅整个网站。

- 某些阅读器甚至提供了过滤功能，用户只需要提供关键词，阅读器就会自动过滤掉相应内容，极大的简化了我们的信息流

## RSS怎么使用
RSS的使用方式实际上很简单，找到一个订阅源，然后添加到RSS阅读器当中刷新就能完成订阅，但实际情况却比这个麻烦很多————因为你并没有订阅源。

要想知道一个网站是否支持RSS，最直接的方法就是看网站的底部或侧边栏是否有 RSS 图标。一般来说，图标所指向的地址就是该网站的订阅链接，你可以直接点击 RSS 订阅链接跳转到 RSS 客户端内进行订阅，也可以复制粘贴按钮中的地址到自己在用的 RSS 服务中订阅这些网站中的内容。

以我的 [博客](https://moeyua.github.io/) 为例，上方导航栏的 RSS 即为订阅链接，复制或点击即可进行订阅，移动端可以长按图标复制订阅源。

![](https://i.loli.net/2021/01/30/MtbJOLgoknjVC7T.png)  
![](https://i.loli.net/2021/01/30/vyTlD32WhuE5Gr7.png)  

**是复制链接而不是链接里的内容！！**

## RSSHub
现在我们已经知道如何添加订阅源了，但是你会发现很多主流网站像微博，哔哩哔哩，知乎等并没有支持 RSS，那么这时候就需要介绍一个开源项目————[**RSSHub**](https://docs.rsshub.app/)

![](https://i.loli.net/2021/01/30/LoV4s7jxdw2IGmk.png)

> RSSHub 是一个开源、简单易用、易于扩展的 RSS 生成器，可以给任何奇奇怪怪的内容生成 RSS 订阅源。RSSHub 借助于开源社区的力量快速发展中，目前已适配数百家网站的上千项内容

以上内容来自RSSHub的官网介绍，就像官网所说的一样，通过RSSHub确实能够做到 **万物皆可 RSS**  ，你可以通过 <https://docs.rsshub.app/> 来访问他们的官网，里面由很详细的文档以及许多RSS路由，这些RSS几乎涵盖了生活中涉及到的所有方面，所以我们就不需要自己去各个网站寻找RSS图标了

---

接下来我就以微博为例展示如何使用RSSHub

![](https://i.loli.net/2021/01/30/tuD6k5K8GIhsz9n.png)

注意路由部分  
这里的路由中没有带”:” 表示为固定内容，不需要更改，而带有冒号的表示为参数，需要使用者自行配置。这里有 uid 和 routeParams 两个参数，其中第一个参数为必选参数，第二个参数为可选择参数，后者可以根据个人需求进行配置，这里只展示第一个参数 uid:

1. 首先我们打开博主主页，按下F12启动控制台
2. 切换到控制台( console )选项卡
3. 在一堆提示最下面执行 ``$CONFIG.oid``
4. 得到的数字就是我们需要的参数 uid
5. 用我们得到的 id 替换路由中的 ``:uid``

这样我们就能够得到博主“游点艺术”微博的RSS  
``https://rsshub.app/weibo/user/2040839563``

![](https://i.loli.net/2021/01/30/lIYBDeEFxcAm6Ny.png)

接下来只需要复制这个订阅源，到阅读器中订阅，我们就可以在阅读器中接收到博主的微博了。

RSSHub 还支持自建路由和浏览器插件，感兴趣的可以参考官方文档。

## RSS 阅读器
RSS 阅读器我个人使用过 Inoreader 以及 ios 端的 Reeder4，目前在使用的是 Reeder4。

### Reeder4
官网：<https://reederapp.com/>

**不支持中文界面**

Reeder 是 iOS 和 Mac 的老牌阅读器了，说是最好的阅读器也不过分，它除了可以让你手动加入 RSS 频道外，也可以从 Feedbin，Feedly，Inoreader，The Old Reader 等 RSS 阅读平台导入数据，程序本身支持 iCloud Reader 稍后，Pocket，Instapaper 等稍后阅读服务。在 iOS 平台手势操作也是一大亮点，标题左划 Star 文章，右划标记为已读，文章页左划查看源网站，几乎所有操作都可以用手势完成。

### Inoreader
官网：https://www.inoreader.com/

**支持中文界面**

就功能而言 Inoreader 更加丰富，直观的界面设计，高级模式甚至支持去重功能，避免当热点新闻发生时避免被大量内容重复的文章刷屏，也支持关键词过滤，增强订阅源等等。免费版的功能也足够非重度用户使用，且支持 Win，Android，iOS，Mac 以及浏览器使用。推荐新手入门使用

## 推荐订阅源
https://moeyua.notion.site/RSS-1eda6578a8cf474eb9d0634821119334

这里是我个人使用的部分订阅源，是当作笔记写在Notion上的，因为并没有什么内容，暂时不打算搬到博客上来，有需要可以自行查看。

参考资料
> 1. [论 RSS 的「复兴」](https://sspai.com/post/43998)  
> 2. [RSS-Wikipedia](https://zh.wikipedia.org/zh/RSS)  
> 3. [Web 源与内容聚合: RSS/Atom 的扩展、生成、发布、发现与共享](https://www.cnki.net/KCMS/detail/detail.aspx?QueryID=4&CurRec=3&recid=&filename=QBKX200906015&dbname=CJFD2009&dbcode=CJFQ&pr=&urlid=&yx=&uid=WEEvREcwSlJHSldTTGJhYlRqaHdoRU9XSkZ2UlNsYkZkWnlDM3AzTGEzbWdvYkcyQi82Q0pSVFFoUVN1N1crUHBTRT0=A4hF_YAuvQ5obgVAqNKPCYcEjKensW4IQMovwHtwkF4VYPoHbKxJw!!&v=MDU3MDVyRzRIdGpNcVk5RVlZUjhlWDFMdXhZUzdEaDFUM3FUcldNMUZyQ1VSTDZlWmVackZDdm1VYnJCTkMvQWQ=)  
> 4.  [RSSHub](https://docs.rsshub.app/)
> 5.  [高效获取信息，你需要这份 RSS 入门指南](https://sspai.com/post/56391)

