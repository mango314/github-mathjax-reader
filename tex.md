# Notes on compiling TeX

I have been asking around about the origins of the TeX program.  It was written in the 70s and 80s (so about 15 years to develop!!)
and has not been much improved since 1982.  

The [source code](http://tug.org/texlive/devsrc/Build/source/texk/web2c/tex.web) is available online, written in WEB Pascal.
An example of **literate programming** (which I think just means it's well commmented), this is the version officially in use today.
The file is **both** the source code and the documentation book itself.  To compile the book, 3 lines worked nicely on my Linux.

  weave tex.web
  tex tex.tex
  dvips tex.dvi -o tex.ps
  
  It took a while to learn the terminology and ask phrase the question in a way that experts could understand.
  Some reponse were still quite derisive, but I still could extract a meaningful answer.
  
  * http://tex.stackexchange.com/questions/291005/what-language-is-texlive-written-in
  * http://tex.stackexchange.com/questions/95369/what-language-is-tex-implemented-in
  * http://tex.stackexchange.com/questions/218567/latex-vs-word-improvements-of-latex-over-the-years?
  * [What is the Difference between TeX and LaTeX?](http://tex.stackexchange.com/questions/49/what-is-the-difference-between-tex-and-latex)
  
  Basically LaTeX factors into two parts:  TeX (which is the core language) and LaTeX (which are macros which build around the language).
  Almost always, LaTeX should be enough and much easier to use, but aspects of graphic design are hard to implement with the 
  macros provided.  Therefore, I have to resort to learning Tex, **but** at least I don't have to re-write all of TeX from scratch.
  
## A Simple TeX Document

In order to write TeX without any special macros (or shortcuts) we can still use `$...$` as math, and remember to end the document.

    $ 123 \int $ \end
    
This one line file is a valid TeX document.  

    $ tex test.tex
    This is TeX, Version 3.14159265 (TeX Live 2015/Debian) (preloaded format=tex) 
    (./test.tex [1] )
    Output written on test.dvi (1 page, 268 bytes).
    Transcript written on test.log.

And it works! 

Donald Knuth was not a graphic designer, graphic design has moved on since 1982 (and computer modern.  Yet
most designers cannot program.  So what can we do?  Even worse I am not good at either.

Working with TeX, we have all the basic TeX features at our fingertips -- and much more flexiliby than if we used LaTeX.
This will be important as we try to experiment with [fonts](http://www.thinkingwithtype.com/) and [grid](http://www.thinkingwithtype.com/contents/grid/) layouts.


![](http://i.imgur.com/vxlpSbx.png)
