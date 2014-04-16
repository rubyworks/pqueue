# CONTRIBUTING

## Testing

We are using the Microtest framework which is a very simple test
framework built to mimic the original Test::Unit but build on
Ruby Test, the slick meta-testing framework.

Thanks to the configuration in `etc/test.rb` running test should
be as simple as:

```
$ rubytest
```

## Releasing

When releasing a new version there a few things that need to done.
First, of course, make sure the version number is correct by editing
the `Index.yml` file. Then update the canonical `.index` file via:

```
$ index -u Index.yml Gemfile
```

Also, don't forget to add an entry to the `HISTORY.md` file for the
new release.

Though it is not likely to be needed for this project, ensure the MANIFEST
is up to date:

```
$ mast -u
```

Now build the gem:

```
$ gem build .gemspec
```

To release simply use:

```
$ gem push pqueue-x.x.x.gem
```

Finally, don't forget to add a tag for the release. I always use the
description of the release from the HISTORY file as the tag message
(excluding the changes list).

```
$ gem tag -a x.x.x
```

