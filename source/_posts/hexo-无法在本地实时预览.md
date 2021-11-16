---
title: hexo 无法在本地实时预览
toc: true
tags:
  - hexo
date: 2021-11-16 17:24:09
cover: https://i.loli.net/2021/11/16/Gfx3jSCbEqXYBRQ.png
thumbnail: https://i.loli.net/2021/11/16/Gfx3jSCbEqXYBRQ.png
categories: 疑难杂症
---

自从更换了 icarus 主题以后，之前一直在使用的 `hexo s --debug` 以及 `hexo s` 都没有办法在本地实时对页面进行更新，只能通过 `hexo g` 和 `hexo s` 的方式重新启动服务器才能够更新。虽然这样也能看到预览，但是像我这种写一下看一眼的选手来说这可是要命的，属实是困扰了我好久。

今天摸鱼时候寻思不如赶紧解决掉，查了一圈，虽然不知道是什么原因导致的，但解决办法找到了：
```
hexo g --watch
```
> Hexo 能够监视文件变动并立即重新生成静态文件，在生成时会比对文件的 SHA1 checksum，只有变动的文件才会写入。  

上面是 hexo 官方给出的命令解释，也就是说虽然 `hexo s` 不能够帮我们监视文件变化，那么我们就自己来监视。只需要在 `hexo s` 之前启动一个 `hexo g --watch` 就能解决这个问题了。