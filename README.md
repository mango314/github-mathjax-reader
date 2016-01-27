# github-mathjax-reader

Github does supports markdown but not math-jax.  Nor will they ever (find source).  It is a "maintenance burden" (see [**no**](https://github.com/github/markup/issues/274))

MathOverflow is nice except it is only for Q/A type posts.  

Instead we propose a very easy fix:  **write your own** To read markdown files from an arbitrary Github repo and display them with Markdown and Mathjax.

Necessity is the mother of invention.  This could be use as a very "lazy" way to writ a math-blog.  I have tried using Ghost or hosting my own web site.  This solution is free and it's just easier to piggyback on Github's infrastructure.

Moreover it is easy to write.  Other examples (for d3.js) are Tributary and [bl.ocks.org](http://bl.ocks.org/) which just pull from github gist.

Secondly, this is an exercise in MVC type frameworks (or just building apps - don't know if I used the term correctly).  We can use Flask or Elm-html or Express or any language we want to practice.

---

a hybrid of two different tutorials: http://elm-lang.org/examples/zip-codes and https://gist.github.com/freakingawesome/7f86ed7683cfeeec4557 we are able to write a responsive app that looks up the names of the repos for any user.

additional follow-up work could be to enter the names of repos and list the files.  also improve the layout if possible.  all of this and more to come.
