### FreeRTOS Mirror
This is an *unofficial* mirror of [FreeRTOS](http://www.freertos.org/) project's subversion repository hosted on [SourceForge](https://sourceforge.net/projects/freertos/).

I use [git-svn](https://git-scm.com/docs/git-svn) to clone this repo and push to GitHub.

### Update Frequency

This project will be updated every day at 2:30 AM (GMT+8, Taiwan Time).

### How to use git-svn

If you want to use [git-svn](https://git-scm.com/docs/git-svn) to clone [FreeRTOS](http://www.freertos.org/) by your own, you can use following command to fetch the source

```sh
git svn clone https://svn.code.sf.net/p/freertos/code/trunk FreeRTOS
```
To update the repo, just use

```sh
git svn rebase
```
