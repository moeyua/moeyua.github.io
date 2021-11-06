---
title: Cookie？小饼干！
date: 2021-11-02 15:09:53
tags: 
    - Cookie
    - 浏览器
---

# Cookie？小甜饼！

## 概述
Cookie，又称“小甜饼”，指某些网站为了辨别用户身份而储存在用户本地终端（通常为用户的浏览器）上的数据（通常经过加密）。

简单来讲，Cookie 是由服务器保存在用户浏览器上的一小块数据，而且每次都会和 HTTP 请求一起发送给服务器。通常 Cookie 的作用有大概三种：
- 会话状态管理（用户登陆状态、购物车数据）
- 个性化设置（颜色、字体、字号等其他自定义设置）
- **浏览器行为跟踪（跟踪并分析用户行为）**

Cookie 这个名字应该源自一种叫 Fortune Cookie 的饼干，这种饼干里面包有写着一些有趣的句子的纸条。它这种内里包含有隐藏的信息的寓意被用在了计算机上。用户发送给服务器的每一次请求都携带有用户的一些信息，所以就用 Cookie 来指代这些很小的信息碎片。

由于 HTTP 请求是没有状态的，服务器无法知道用户在上一次请求时做了什么，甚至也不知道这个用户是谁，这个特性给用户带来了很糟糕的体验，也其实严重阻碍了 [交互式Web应用程序](https://zh.wikipedia.org/wiki/%E4%BA%A4%E4%BA%92%E5%BC%8FWeb%E5%BA%94%E7%94%A8%E7%A8%8B%E5%BA%8F) 的实现。Cookie 的作用就是在每次请求时携带一些必要的信息告诉服务器，这次请求的发送者是谁；同时因为 Cookie 保存在本地，有些数据直接从本地读取就可以，例如一些个性化设置。

Cookie 不是一种理想的客户端存储机制。它的容量很小（4KB），缺乏数据操作接口，而且会影响性能。客户端存储建议使用 Web storage API 和 IndexedDB。只有那些每次请求都需要让服务器知道的信息，才应该放在 Cookie 里面。

每个 Cookie 都有以下几方面的元数据。
- Cookie 的名字
- Cookie 的值（真正的数据写在这里面）
- 到期时间（超过这个时间会失效）
- 所属域名（默认为当前域名）
- 生效的路径（默认为当前网址）

我们以简单的用户登陆为例，用户登陆网站，浏览器向服务器发送请求，服务器回应的头信息告诉浏览器设置一个 Cookie，这个 Cookie 保存了服务端识别用户所需要的信息。之后用户的每一次请求都会将 Cookie 一同发送给服务器，然后服务器根据不同的用户返回相应的数据。但是 Cookie 并不会一直存在，在最开始设置的时候它的生效时间就以及定好了，所以在 Cookie 过期后，用户发现网站提示登陆失效，需要重新登陆，这时用户就需要重新登陆，而服务器会再次告诉浏览器设置一个 Cookie 以识别用户，直到它再次失效。以下是这个流程的一个示意图：  
![](https://i.loli.net/2021/11/01/ldUm56WesqynIVg.png)


## 创建和发送 Cookie
服务器如果希望在浏览器保存 Cookie，就要在 HTTP 回应的头信息里面，放置一个或者 `Set-Cookie` 字段用来生成一个或多个 Cookie。  
除了 Cookie 的值，`Set-Cookie` 字段还可以附加多个 Cookie ，没有次序的要求。

```
HTTP/1.0 200 OK
Content-type: text/html
Set-Cookie: yummy_cookie=choco
Set-Cookie: tasty_cookie=strawberry
Set-Cookie: <cookie-name>=<cookie-value>; Expires=<date>
Set-Cookie: <cookie-name>=<cookie-value>;Max-Age=<non-zero-digit>
Set-Cookie: <cookie-name>=<cookie-value>;Domain=<domain-value>
Set-Cookie: <cookie-name>=<cookie-value>; Path=<path-value>
Set-Cookie: <cookie-name>=<cookie-value>; Secure
Set-Cookie: <cookie-name>=<cookie-value>; HttpOnly
```

### Cookie 的生命周期
上文我们说过 Cookie 不会一直保存，所以在设置时需要定义 Cookie 的生命周期。Cookie 的生命周期分为两种：
- 会话期 Cookie 不需要定义 `Expires` 和 `Max-Age` 在浏览器关闭时就会结束生命周期，所以会话期 Cookie 仅在会话期间有效。需要注意的是有些浏览器提供了会话恢复的功能，这将会导致 Cookie 在浏览器重新启动后依然存在，使得 Cookie 一直存在，这可能会导致一些问题。
- 持久性 Cookie 的生命周期取决于 `Expires` 或 `Max-Age` 所设定的时间。

> 如果您的站点对用户进行身份验证，则每当用户进行身份验证时，它都应重新生成并重新发送会话 Cookie，甚至是已经存在的会话 Cookie。此技术有助于防止会话固定攻击（session fixation attacks） (en-US)，在该攻击中第三方可以重用用户的会话。

如果服务器想改变一个早先设置的 Cookie，必须同时满足四个条件：Cookie 的 `key`、`domain`、`path` 和 `secure` 都匹配，否则都会修改失败，浏览器就会生成一个全新的 Cookie，而不是替换掉原来那个 Cookie。

### 发送 Cookie
浏览器在发送请求时候也会带上相应的 Cookie，下面是一个例子：
```
GET /sample_page.html HTTP/1.1
Host: www.example.org
Cookie: yummy_cookie=choco; tasty_cookie=strawberry
```

## Cookie 的属性

### Expires, Max-Age
`Expires` 属性指定一个 UTC 格式的时间作为 Cookie 的过期时间，当时间超过以后 Cookie 就会被删除。但是需要注意的是该时间以本地时间为准，所以并不能保证一定会在指定的时间被删除。  
`Max-Age` 指定 Cookie 会在创建后的多少秒后被删除，倒计时结束后该 Cookie 就会被删除。 
 
> 需要注意的是 `Expires` 和 `Max-Age` 如果都没有设置或者有效的值的时候该 Cookie 就成为了 Session Cookie，在结束会话的时候就会被删除。  
> 如果 `Expires` 和 `Max-Age` 同时都被设置时以后者为准，也就是说 `Max-Age` 的优先级更高。
 
### Domain, Path, SameSite
`Domain` 和 `Path` 定义了 Cookie 的作用域，也就是 Cookie 在哪些网站有效。
`Domain` 设置一个域名作为 Cookie 的作用域，如果没有设置则浏览器默认为当前所在的域名。

> 需要特别注意的是，通过 `Domain` 设置的作用域是允许 Cookie 在子域名当中生效的，而通过浏览器默认设置是不允许子域名的。

设置 `Domain` 时也需要遵守一些规则，假设当前为 `foo.bar.com`，只能设置当前域名以及上级域名，但不能直接设置为顶级域名（如 `.net`，`.com`）、子域名（如 `child.foo.bar.com`）、或者其他公共域名（如 `github.io`），正确的设置方法为 `foo.bar.com` 或者 `bar.com`。如果没有正确设置 `Domain` 浏览器会拒绝该 Cookie。

`Path` 指定了 `Domain` 匹配到的域名下的哪些路径可以接受该 Cookie

`SameSite` 要求 Cookie 在跨站请求的时候不会被发送，从而阻止跨站请求伪造攻击 [CSRF](https://zh.wikipedia.org/wiki/%E8%B7%A8%E7%AB%99%E8%AF%B7%E6%B1%82%E4%BC%AA%E9%80%A0)。  

恶意网站会在诱导用户发送带有攻击目标网站请求的链接或者表单，如果用户浏览器中有目标网站的 Cookie，目标网站就会收到带有正确 Cookie 的请求。这种第三方网站引导而附带发送的 Cookie，就称为第三方 Cookie。  
除此之外就是网站通过 Cookie 跟踪用户，通过在第三方网站嵌入一些自己网站的请求，浏览器在加载页面时候就会发出带有用户 Cookie 的请求，这样就能够得知用户访问了哪些网站。

`SameSite` 有三个值：
- `None` 不做任何限制，第三方网站也可以向服务器发出带有 Cookie 的请求
- `Strict` 严格限制，任何第三方网站的请求都不可以携带该 Cookie，只在 `Domain` 规定的域名下的请求才可以携带该 Cookie
- `Lax` 和 `Strict` 相似，只有在用户是通过第三方网站的链接跳转过来的时候才会携带该 Cookie，为一些跨站子请求保留。具体规则可以参考下表：

![](https://i.loli.net/2021/11/01/tQzUX752Wln6akh.png)

>以前，如果 `SameSite` 属性没有设置，或者没有得到运行浏览器的支持，那么它的行为等同于 `None`，Cookies 会被包含在任何请求中——包括跨站请求。  
>
>大多数主流浏览器正在将 `SameSite` 的[默认值迁移至 Lax](https://www.chromestatus.com/feature/5088147346030592)。如果想要指定 Cookies 在同站、跨站请求都被发送，现在需要明确指定 `SameSite` 为 `None`。

### Secure, HttpOnly
有两种方法可以确保 Cookie 被安全发送，并且不会被意外的参与者或脚本访问：`Secure` 属性和 `HttpOnly` 属性。  
`Scure` 属性只允许 Cookie 通过 HTTPS 加密过后的请求，而不支持 HTTP 协议。但需要注意的是，即便如此也不应当通过 Cookie 发送任何敏感信息。
>从 Chrome 52 和 Firefox 52 开始，不安全的站点（http:）无法使用Cookie的 Secure 标记。

`HttpOnly` 规定 Cookie 不能通过 Javascript 的 `Document.cookie` API 等其他方式直接获取。这样可以防止恶意脚本的攻击。

## 通过 JavaScript 访问和创建 Cookie
JavaScript 提供了 `Document.cookie` 来访问当前 Cookie，当然前提是该 Cookie 没有设置 `HttpOnly` 属性。

该方法会返回一个字符串包含所有的Cookie，每条cookie以"分号和空格(; )"分隔(即 key=value 键值对)，可以尝试使用 `String.Prototype.split` 手动将它们分离开来。
```
const cookies = Document.cookie.split(';');
// type of cookies is Array;
```
该方法也可以用来创建一个 Cookie。  
和访问 Cookie 不同，需要注意的是，创建 Cookie 时一次只能创建一条，而且需要以 **键值对** 的形式创建，例如：
```
document.cookie = "foo=bar;domain=example.com;path=/home;";
```
- path属性必须为绝对路径，默认为当前路径。
- domain属性值必须是当前发送 Cookie 的域名的一部分。比如，当前域名是 `example.com`，就不能将其设为 `foo.com`。该属性默认为当前的一级域名（不含二级域名）。
- `max-age` 属性的值为秒数。
- `expires` 属性的值为 UTC 格式，可以使用 `Date.prototype.toUTCString()` 进行日期格式转换。
- Cookie 的值字符串可以用 [encodeURIComponent()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/encodeURIComponent) 来保证它不包含任何逗号、分号或空格( Cookie 值中禁止使用这些值).




## 参考资料： 
- [HTTP Cookies - MDN](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Cookies) 
- [Document.cookie - MDN](https://developer.mozilla.org/zh-CN/docs/Web/API/Document/cookie)  
- [Cookie - Wikipedia](https://zh.wikipedia.org/wiki/Cookie)  
- [跨站点攻击 - Wikipedia](https://zh.wikipedia.org/wiki/%E8%B7%A8%E7%AB%99%E8%AF%B7%E6%B1%82%E4%BC%AA%E9%80%A0)  
- [Cookie - 阮一峰](https://wangdoc.com/javascript/bom/Cookie.html)  
- [Cookies 为什么叫 Cookies](http://fornote.blogspot.com/2009/02/CookiesCookies.html)  