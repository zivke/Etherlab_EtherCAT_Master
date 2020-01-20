# Synapticon build of the Etherlab EtherCAT Master

This folder contains Synapticon specific documentation and scripts to work with
this fork of the IgH EtherCAT Master.

## Preparation

Key branches in this repository are

- `upstream/default` this tracks the main repository from
  [IgH Etherlab](https://etherlab.org/en/ethercat/)
- `upstream/default_sncn_patches` this is the `upstream/default` branch with
  the Synapticon GmbH patches applied.

These two branches are the basis for every further development.

To create a new master please update the `upstream/default` branch and fetch the
[unofficial patchset](https://sourceforge.net/u/uecasm/etherlab-patches/commit_browser)
of Gavin Lambert. Either with Mercurial as described in the README there or
with git (and the `git-remote-hg` extension as described in
[Git SCM Book](https://git-scm.com/book/en/v2/Git-and-Other-Systems-Git-as-a-Client)).
When using git please add these configuration to your git config:

```
remote-hg.track-branches=true
remote-hg.hg-git-compat=true
```

So the commit hashes stay the same. Git and Mercurial have different ways of
calculating the Hash value and the second line in the above configuration
influences the hash calcuation on the git side.

Furthermore maybe add

```
core.notesref=refs/notes/hg
```

to the local configuraiton to see the Mercurial hash and git hash relationship.

## Creating a new Release

[//] # (TODO: apply the patches with)

First we need the latest release of
[Gavin Lambert unofficial patch-set](https://sourceforge.net/u/uecasm/etherlab-patches/commit_browser) 
either directly with Mercurial with

```
hg clone http://hg.code.sf.net/u/uecasm/etherlab-patches uecasm-etherlab-patches
```

or directly with git

```
git clone hg::http://hg.code.sf.net/u/uecasm/etherlab-patches uecasm-etherlab-patches
```

It actually doesn't matter too much since we will not work too much with these.
The only thing we have to do with these patches is to fix some in base which
don't have a proper `user` field which prevents `git am` from working properly. [//] # (patch script should handle this)

Next create a working branch with the merge base at `upstream/default` and
apply all the uecasm patches described in the file `patches_to_apply.txt`
with the script `TOOL-apply`. All lines starting with a `#` are ignored.        [//] # (Should we have a text file with a in-order list of all the patches we want to apply?)

After all the patches are applied properly we have to apply the Synapticon
patches with running

```
git am <path/to/EhterlabMaseter>/synapticon/0001-Fix-wrong-user-name-field.patch
```

in the checkout unofficial patchset (not sure how this works with Mercurial).

[//] # (TODO: Cherry-pick or rebase?)

The final branch should be named `release/EtherCAT_Master-v1.5.2-sncn-<revision>`.
 As last step edit the file
`configure.ac` and add the patched version number (`-sncn-<REVISION>`) to the
autoconfig macro `AC_INIT()`, for example:

```
AC_INIT([ethercat],[1.5.2-sncn-8],[fp@igh-essen.com])
```

For the eighth revision of the Synapticon build of the Etherlab EtherCAT
Master.

[//] # (TODO: build and install the master -> use script or installation
        description in the top level.)
