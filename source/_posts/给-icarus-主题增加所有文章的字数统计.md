---
title: 给 icarus 主题增加所有文章的字数统计
toc: true
tags:
  - hexo
  - JavaScript
date: 2021-11-18 18:45:17
categories: 技术文档
---
看到苏卡卡大佬的 profile 上有一个统计所有文章的字数功能，感觉很有意思，于是本菜鸡也决定给自己搞一个。
<!--more-->
虽然说菜，但是菜有菜的办法，先到 `profile.jsx` 这个文件看一下组件的源码：
```jsx profile.jsx >folded
const { Component } = require('inferno');
const gravatrHelper = require('hexo-util').gravatar;
const { cacheComponent } = require('hexo-component-inferno/lib/util/cache');

class Profile extends Component {
    renderSocialLinks(links) {
        if (!links.length) {
            return null;
        }
        return <div class="level is-mobile is-multiline">
            {links.filter(link => typeof link === 'object').map(link => {
                return <a class="level-item button is-transparent is-marginless"
                    target="_blank" rel="noopener" title={link.name} href={link.url}>
                    {'icon' in link ? <i class={link.icon}></i> : link.name}
                </a>;
            })}
        </div>;
    }

    render() {
        const {
            avatar,
            avatarRounded,
            author,
            authorTitle,
            location,
            counter,
            followLink,
            followTitle,
            socialLinks
        } = this.props;
        return <div class="card widget" data-type="profile">
            <div class="card-content">
                <nav class="level">
                    <div class="level-item has-text-centered flex-shrink-1">
                        <div>
                            <figure class="image is-128x128 mx-auto mb-2">
                                <img class={'avatar' + (avatarRounded ? ' is-rounded' : '')} src={avatar} alt={author} />
                            </figure>
                            {author ? <p class="title is-size-4 is-block" style={{'line-height': 'inherit'}}>{author}</p> : null}
                            {authorTitle ? <p class="is-size-6 is-block">{authorTitle}</p> : null}
                            {location ? <p class="is-size-6 is-flex justify-content-center">
                                <i class="fas fa-map-marker-alt mr-1"></i>
                                <span>{location}</span>
                            </p> : null}
                        </div>
                    </div>
                </nav>
                <nav class="level is-mobile">
                    <div class="level-item has-text-centered is-marginless">
                        <div>
                            <p class="heading">{counter.post.title}</p>
                            <a href={counter.post.url}>
                                <p class="title">{counter.post.count}</p>
                            </a>
                        </div>
                    </div>
                    <div class="level-item has-text-centered is-marginless">
                        <div>
                            <p class="heading">{counter.category.title}</p>
                            <a href={counter.category.url}>
                                <p class="title">{counter.category.count}</p>
                            </a>
                        </div>
                    </div>
                    <div class="level-item has-text-centered is-marginless">
                        <div>
                            <p class="heading">{counter.tag.title}</p>
                            <a href={counter.tag.url}>
                                <p class="title">{counter.tag.count}</p>
                            </a>
                        </div>
                    </div>
                </nav>
                {followLink ? <div class="level">
                    <a class="level-item button is-primary is-rounded" href={followLink} target="_blank" rel="noopener">{followTitle}</a>
                </div> : null}
                {socialLinks ? this.renderSocialLinks(socialLinks) : null}
            </div>
        </div>;
    }
}

Profile.Cacheable = cacheComponent(Profile, 'widget.profile', props => {
    const { site, helper, widget } = props;
    const {
        avatar,
        gravatar,
        avatar_rounded = false,
        author = props.config.author,
        author_title,
        location,
        follow_link,
        social_links
    } = widget;
    const { url_for, _p, __ } = helper;

    function getAvatar() {
        if (gravatar) {
            return gravatrHelper(gravatar, 128);
        }
        if (avatar) {
            return url_for(avatar);
        }
        return url_for('/img/avatar.png');
    }

    const postCount = site.posts.length;
    const categoryCount = site.categories.filter(category => category.length).length;
    const tagCount = site.tags.filter(tag => tag.length).length;

    const socialLinks = social_links ? Object.keys(social_links).map(name => {
        const link = social_links[name];
        if (typeof link === 'string') {
            return {
                name,
                url: url_for(link)
            };
        }
        return {
            name,
            url: url_for(link.url),
            icon: link.icon
        };
    }) : null;

    return {
        avatar: getAvatar(),
        avatarRounded: avatar_rounded,
        author,
        authorTitle: author_title,
        location,
        counter: {
            post: {
                count: postCount,
                title: _p('common.post', postCount),
                url: url_for('/archives')
            },
            category: {
                count: categoryCount,
                title: _p('common.category', categoryCount),
                url: url_for('/categories')
            },
            tag: {
                count: tagCount,
                title: _p('common.tag', tagCount),
                url: url_for('/tags')
            }
        },
        followLink: follow_link ? url_for(follow_link) : undefined,
        followTitle: __('widget.follow'),
        socialLinks
    };
});

module.exports = Profile;
```

很长，虽然没什么头猪但是关键的部分还是能看懂的，首先我们需要添加 html，改个名字，直接复制过来就好了：
```jsx profile.jsx
<div class="level-item has-text-centered is-marginless">
  <div>
    <p class="heading">{counter.word.title}</p>
    <a href={counter.word.url}>
      <p class="title">{counter.word.count}</p>
    </a>
  </div>
<div>
```
很简单，但是这时我们需要看一下这个 `counter` 是什么：
```jsx profile.jsx
counter: {
  post: {
    count: postCount,
    title: _p('common.post', postCount),
    url: url_for('/archives')
  },
  category: {
    count: categoryCount,
    title: _p('common.category', categoryCount),
    url: url_for('/categories')
  },
  tag: {
    count: tagCount,
    title: _p('common.tag', tagCount),
    url: url_for('/tags')
  }
}
```
这个不就是定义三个计数器的属性的嘛，我们也来一个就好了：
```jsx profile.jsx
word: {
    count: wordCount,
    title: _p('字数', wordCount),
}
```
这里需要注意的是这里我们 title 直接写死，要不然还得去其他地方配置。同时我们不需要点击跳转，所以也就不需要给它 url。 ~~~想写也没有~~~  

这样一来样式就没问题了，我们开始计算字数，这是个麻烦事，先看看其他三个 counter 是怎么写的吧：
``` jsx profile.jsx
const postCount = site.posts.length;
const categoryCount = site.categories.filter(category => category.length).length;
const tagCount = site.tags.filter(tag => tag.length).length;
```
看起来是在 `site` 这个对象中储存了一些网站的信息，我们打印一下它的 `post` 属性看看是什么。

......

看起来还挺多，terminal 都放不下了，都是文章的各种信息，而且因为无法显示全部信息，我们不知道这个对象的全部属性是什么，也就没有办法拿到文章内容了。这个时候就需要用到 `Object.getOwnPropertyNames` 这个方法了。

> `Object.getOwnPropertyNames` 方法返回一个数组，成员是参数对象自身的全部属性的属性名，不管该属性是否可遍历。

这样以来我们就能够摸清楚这个对象的结构了，大概是这样子：
``` js
site: {
  posts: { 
    data: [
      {
        _content: 文章内容,
        ...,
        ...
      },
      {
        ...
      }
    ],
    length: num
  },
  categories: { ... },
  tags: { ... }
}
```

文章内容其实有好多个属性都有保存，但是这个格式相对较少，我们就选择这个来统计文章字数。
```js
site.posts.data[0]._content.length
```
试一下，好像计算出来的结果有点不对，看起来正好是一倍，那这好办，也懒得管为什么，直接给它砍一半
```js
site.posts.data[0]._content.length / 2
```
OK，这样以来就没有问题了，之后只需要遍历 `data` 对象，计算出所有文章的字数总和就好了，这里是我写的函数：
```js
function getWords(site) {
    let posts = site.posts.data;
    let words = 0;
    for (const post of posts) {
        words = words + post._content.length / 2;
    }
    words = (words / 10000).toFixed(2);
    return words;
}
```
这里我选择的单位是 `万`，保留了两位小数。最后我们只需要调用这个函数就 ok 了。
```jsx profile.jsx
  const postCount = site.posts.length;
  const categoryCount = site.categories.filter(category => category.length).length;
  const tagCount = site.tags.filter(tag => tag.length).length;
  const wordCount = getWords(site);
```

最后放一张完成后的截图：
![](https://i.loli.net/2021/11/18/lKHOfbvDzoE3Tj5.png)