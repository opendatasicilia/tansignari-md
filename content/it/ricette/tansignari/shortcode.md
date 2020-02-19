---
title: "Shortcode"
linkTitle: "Shortcode"
date: 2020-02-11
description: >
  Cosa sono gli shortcode e come usarli.
tags:
  - hugo
  - docsy
  - shortcodes
issue:
autori: ["Andrea Borruso"]
chefs: ["Andrea Borruso"]
---

In T'ansignari è possibile utilizzare gli [`shortcodes` di Docsy](https://www.docsy.dev/docs/adding-content/shortcodes/) e [hugo](https://gohugo.io/content-management/shortcodes/). Consentono di ottenre con stringhe brevi di codice, un output HTML altrimenti più complesso.

## Twitter

A partire dall'ID di un tweet - la parte finale dell'URL (ad esempio https://twitter.com/openantani/status/1200061380478550016) - si può generare il codice di embedding in questo modo

```html
{{</* tweet 1200061380478550016 */>}}
```

che restituirà

{{< tweet 1200061380478550016 >}}


## Gist

Analogamente a Twitter, ma estraendo due parti dall'URL, si può pubblicare ad esempio questo Gist

```
https://gist.github.com/spf13/7896402
```

in questo modo

```html
{{</* gist spf13 7896402 */>}}
```


Verrà visualizzato così

{{< gist spf13 7896402 >}}
