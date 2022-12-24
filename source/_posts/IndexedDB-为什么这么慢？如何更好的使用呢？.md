---
title: 【译文】IndexedDB 为什么这么慢？如何更好的使用呢？
desc: blog html css javascript js vue macOS 前端 frontEnd
tags:
  - IndexedDB
  - JavaScript
date: 2022-01-14 22:48:32
categories: 译文
---




本文是 [RxDB](https://github.com/pubkey/rxdb) 文档 Opinions 部分的文章 [Why IndexedDB is slow and what to use instead](https://rxdb.info/slow-indexeddb.html) 的翻译，原作者为 [pubkey](https://github.com/pubkey)。

------

我们可能出于离线使用的需求，也可能是出于缓存等等的其他目的，需要将 JavaScript Web Application 的数据保存在客户端本地也就是浏览器里。而在浏览器内存储数据一般来说有以下几个选项：

- **Cookies** 会随着每次 HTTP 请求被发送出去，所以它不能存储太多的数据。
- **WebSQL** 已经被 [弃用](https://hacks.mozilla.org/2010/06/beyond-html5-database-apis-and-the-road-to-indexeddb/)，因为它从来都不是一个标准，而将它变成标准又十分困难。
- **LocalStorage** 是一个基于异步 IO-access 的同步 API，存储和读取都会使得 JavaScript 进程被完全阻塞，所以不应该在有许多键值对的情况下使用 LocalStorage 。
- **FileSystem API** 可以用来存储简单的二进制文件，但可惜现在 [只有 Chrome 支持](https://caniuse.com/filesystem) 这一特性。
- **IndexedDB**  是一种「键-值数据库」，可以用来存储 json 类型的数据，而且能够遍历所有的索引。IndexedDB  不仅稳定，而且得到 [广泛的支持](https://caniuse.com/indexeddb)。

不难看出，最好的选择就是 IndexedDB。选定了要使用的方法后就可以着手进行开发了。在刚开始的时候似乎一切都很不错，但随着进度的推进你的应用程序也越来越大，你需要处理更多或者更复杂的数据，这时你发现事情并没有那么简单—— **IndexedDB 太慢了**，甚至比运行在廉价服务器上的数据库**还要慢**！插入几百个文档就要花费好几秒的时间。对于一个需要快速加载的页面来说时间是至关重要的，有时候直接向后端发送请求来传输数据都要比 IndexedDB 要快。

> 事务处理 vs 吞吐量

在抱怨之前我们可以先分析一下这么慢的原因。当你在 Nolans 的 [浏览器数据库比较](http://nolanlawson.github.io/database-comparison/) 中测试时就能发现：插入 1k 条文档到 IndexedDB 大概会花费 80ms，平均 0.08ms 一条，不仅不算慢，甚至可以称得上很快了，而且我们也不太可能同时在客户端存储如此大量的数据。但问题的关键在于这些文档是在 `single transaction` 上写入的。

所以我 fork 了一个 [对比工具](https://pubkey.github.io/client-side-databases/database-comparison/index.html) 并将每次写入文档的方式修改为 `single transaction`，我们可以看到 `single transaction` 插入 1k 条文档大概花费 2 秒钟。但有趣的是，当我们把文档的大小增加到原来的 100 倍以后，存储这些数据的时间差不多和原来是一样的！这下我们大概就清楚了原来限制 IndexedDB 性能的是 `transaction` 而不是数据吞吐量。

![IndexedDB transaction throughput](https://s2.loli.net/2022/01/06/E5ewCK6vYoMWfxP.png)

要想解决 IndexedDB 的性能问题你可以尽可能使用更少的 `transactions` 。有的时候很容易就能解决这个问题：使用 RxDB 的 [`bulk` 方法](https://rxdb.info/rx-collection.html#bulkinsert) 你就可以一次性将许多数据压缩并存储。但是大多数情况下事情没有这么简单：你的用户不停的在页面上点击，重复的数据不停的从后端发送过来，另外一个页面同时还在写入数据。所有的这些事情都会在你不知道的什么时候发生，你也不可能将这些数据全都在单个 `transactions` 处理完成。

另一个解决的办法就是不要再去关心它的性能问题。一些浏览器厂商将会对 IndexedDB 进行优化，它的速度将会有所改观。当然，IndexedDB 缓慢的问题在 [2013 年](https://www.researchgate.net/publication/281065948_Performance_Testing_and_Comparison_of_Client_Side_Databases_Versus_Server_Side) 就已经有了，按照这种趋势，我们有理由相信在未来几年它也还是会缓慢下去，所以我们不应该等待下去。chromium 的开发者们也发布了一个 [声明](https://bugs.chromium.org/p/chromium/issues/detail?id=1025456#c15) 来呼吁大家更多的关注读取性能而不是写入性能。

使用 WebSQL （即便它已经被弃用）也不是一个很好的选择，因为就像 [对比工具显示的结果](https://pubkey.github.io/client-side-databases/database-comparison/index.html) 一样，它的 `transactions` 甚至更慢。

## 不要将 IndexedDB 当作数据库来使用

为了处理性能问题和防止 `transaction` ，我们应当停止将 IndexedDB 当作数据库来使用。相反的，我们应当在初始页面加载时就将所有数据载入到内存（`memory`）当中。这样一来所有的读写操作都在内存当中进行，而内存的读写速度是原来的 100 倍。只有在数据写入以后，通过单事务写入的方式将内存状态持久化到 IndexedDB 中。这种情况下 Indexed 是作为一个文件系统来使用的，而不是一个数据库。

这里有一些已经采用了这种方式的库：

- LokiJS with the [IndexedDB Adapter](https://techfort.github.io/LokiJS/LokiIndexedAdapter.html)
- [Absurd-SQL](https://github.com/jlongster/absurd-sql)
- SQL.js with the [empscripten Filesystem API](https://emscripten.org/docs/api_reference/Filesystem-API.html#filesystem-api-idbfs)
- [DuckDB Wasm](https://duckdb.org/2021/10/29/duckdb-wasm.html)

## 持久化

不直接使用 IndexedDB 的一个缺点就是你的数据不会一直持久化。当 JavaScript 进程在你还没有持久化到 IndexedDB 之前就退出的话，你的数据很有可能就丢失了。为了防止这种情况发生，我们必须要确保内存中的数据已经被写入到了硬盘。一个很重要的点就是尽可能快的将数据进行持久化。例如 LokiJS 就提供了 `incremental-indexeddb-adapter` 用来持久化最新的数据到硬盘当中而不是每次都去持久化所有的数据。而另外一点就是要在正确的时间去持久化你的数据。例如 RxDB [LokiJS storage](https://rxdb.info/rx-storage-lokijs.html) 只会在以下几种情况持久化数据：

- 当有新的数据写入出现，而此时数据库处于空闲状态，既没有读取也没有写入在进行。此时会对数据进行持久化。
- 当 `window` 触发了 [beforeunload event](https://developer.mozilla.org/en-US/docs/Web/API/WindowEventHandlers/onbeforeunload) 的时候，说明此时的 JavaScript 进程随时都可能退出，这时一定要进行数据持久化。在 `beforeunload` 结束之后会有大概几秒的时间让我们足够保存所有新的改动，这足以证明我们的工作是可靠的。

唯一遗漏的地方就是如果浏览器突然崩溃或者电脑电源被关闭，这会导致浏览器意外退出。

## 多标签支持

Web application 和 「普通」应用程序的最大不同就在于用户可以同时在多个浏览器标签当中使用你的应用。但是假如你的所有内存中的数据库状态只会定期写入硬盘，多个浏览器标签可能会发生冲突造成数据丢失。但是这可能对于依赖于服务端响应的应用程序不是什么问题，因为丢失的数据可能早已经上传到了后端，其他标签的数据也一样。但是如果你的客户端是离线使用的话这样就行不通了。

解决这个问题最理想的方法就是使用 [SharedWorker](https://developer.mozilla.org/en/docs/Web/API/SharedWorker)。SharedWorker 和 [WebWorker](https://developer.mozilla.org/en/docs/Web/API/Web_Workers_API) 一样都运行在单独的 JavaScript 进程中，唯一不同的是 SharedWorker 会在多个上下文见进行共享。你可以在 SharedWorker 中创建数据库，这样所有的浏览器标签就会向 Worker 请求数据而不是去单独创建一个数据库。但很遗憾的是 SharedWorker API 并[不支持所有浏览器](https://caniuse.com/sharedworkers)。Safari [放弃了对它的支持](https://bugs.webkit.org/show_bug.cgi?id=140344)，而 IE 和 安卓平台的 Chrome 甚至从来都没有适配过。

此外，我们可以通过 [BroadcastChannel API](https://developer.mozilla.org/en-US/docs/Web/API/Broadcast_Channel_API) 在标签页之间进行通信，然后在它们之间采用 [leader election](https://github.com/pubkey/broadcast-channel#using-the-leaderelection)。Leader election 能够确保无论有多少个标签页被打开永远都会有一个标签是 `Leader`。

![Leader Election](https://s2.loli.net/2022/01/10/YP8U3OXiMhHtFuT.gif)

Leader election 的缺点就是它的进程会在首页面加载时消耗一定时间（大概 150 毫秒）。此外，当 JavaScript 进程阻塞的时候 Leader election 可能会被中断。当这种情况发生时，一个好的解决办法就是重新加载浏览器的标签使 election 进程重新启动。

[RxDB LokiJS Storage](https://rxdb.info/rx-storage-lokijs.html) 已经实现了 Leader election 这种方法来支持多标签。



## 延伸阅读

- [Offline First Database Comparison](https://github.com/pubkey/client-side-databases)
- [Speeding up IndexedDB reads and writes](https://nolanlawson.com/2021/08/22/speeding-up-indexeddb-reads-and-writes/)
- [SQLITE ON THE WEB: ABSURD-SQL](https://hackaday.com/2021/08/24/sqlite-on-the-web-absurd-sql/)
- [SQLite in a PWA with FileSystemAccessAPI](https://anita-app.com/blog/articles/sqlite-in-a-pwa-with-file-system-access-api.html)
