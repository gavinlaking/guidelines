# Coding standards for JavaScript

Welcome to our coding standards for writing JavaScript, jQuery, Backbone and Beyond.

If you don't like something here, want to add to it or want to change/rock our world create a pull request and we'll go from there!

## Coding style

Below are some points to keep in mind when coding JavaScript for our website, split into various sections.  Although it goes into some detail it is by no means a comprehensive list.

The best way to go about writing JavaScript for our site is to make it _readable_ and use the `KISS methodology`.

* Use spaces instead of tabs with a 2 space indent
* Our naming convention for variables and methods is [camelCase](https://en.wikipedia.org/wiki/CamelCase)
* Files should be named in [snake_case](https://en.wikipedia.org/wiki/Snake_case) to match the Ruby File Structure

### Browser Support

We support as far back as Internet Explorer 8 so please make sure any later ECMAScript specific functions you use will work with this browser without throwing an error.

### Strings

* We prefer the use of double quotes `"` over single quotes `'` around strings unless there is good reason
* Strings should be kept as brief as possible and should line wrap after 80 characters
* Where possible use translations provided through `I18n` instead of hard-coding text as a string to allow globalisation
* Never use `eval()` on a string, it opens too many vulnerabilities

### jQuery

* Prefix jQuery object variables with a `$`, e.g. `$variable`
* Use chaining where possible, spanned over several lines to improve readability
```
this.$(".element")
  .method1()
  .method2()
  .method3();
```
* __Don't__ use jQuery animations or show/hide functions __ever__ as the jQuery animation library is pretty slow, use CSS to achieve the same effect instead
* Cache your jQuery lookups if you're using them more than once, it makes things quicker
* Avoid using jQuery plugins where possible. Most of the time the functionality we need is a fraction of what plugins provide. We don't need unnecessary code bloat.

## Preference for new files

In general all new JavaScript written for our apps should be written using the BackboneJS (http://backbonejs.org/) library/structure of models, views and collections.