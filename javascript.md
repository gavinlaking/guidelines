# Coding standards for JavaScript

Welcome to our style guide for writing consistant and readable JavaScript. If there is something you would like to change or add to this guide, please feel free to open a discussion by creating a pull request.

## Contents

* [Preference for new files](#preference-for-new-files)
  * [Backbone.js](#backbonejs)
  * [Jasmine Tests](#jasmine-tests)
* [Formatting](#formatting)
  * [Whitespace](#whitespace)
  * [Semicolons](#semicolons)
  * [Strings](#strings)
  * [Curly brackets](#curly-brackets)
  * [Var statement](#var-statement)
* [Naming conventions](#naming-conventions)
* [Conditional statements](#conditional-statements)
* [Miscellaneous](#miscellaneous)

## Preference for new files

### Backbone.js

All new JavaScript files should be written using [BackboneJS](http://backbonejs.org/) and should fall into the structure of models, views and collections.

### Jasmine Tests

All Backbone models and collections should be covered with an associated [Jasmine](http://jasmine.github.io/) test. For more information on this please feel free to grab a developer from the Frontend team.

## Formatting

### Whitespace

#### Indentation

For indentation, use spaces instead of tabs with a 2 space indent. 

*The right way:*

```js
function square(a) {
∙∙return a * a;
}
```

*The wrong way:*

```js
function square(a) {
∙∙∙∙return a * a;
}
```

```js
function square(a) {
∙return a * a;
}
```

#### Line endings

UNIX-style newlines (`\n`) should be used at the end of all lines, with a newline character being the terminating character of all files.

*The right way:*

```js
var Flight = (function (Backbone) {
  "use strict";

  return Backbone.Model.extend({
    // ...
  });
}(Backbone));↵
```

*The wrong way:*

```js
var Flight = (function (Backbone) {
  "use strict";

  return Backbone.Model.extend({
    // ...
  });
}(Backbone)); // <- no newline character
```

```js
var Flight = (function (Backbone) {
  "use strict";

  return Backbone.Model.extend({
    // ...
  });
}(Backbone));↵
↵
```

#### Trailing whitespace

Trailing whitespace must not be left at the end of any line.

#### Character limit

Keep the length of your lines under 80 characters.

### Semicolons

Always use semicolons, relying on implicit insertion can cause subtle, hard to debug problems.

*The wrong way:*

```js
var MyNumber = function (val) {
  this.value = val;
};

MyNumber.prototype.addFourtyTwo = function () {
  return this.value + 42;
}  // <- no semicolon here

(function () {
  var eight = new MyNumber(8);
  console.log(eight.addFourtyTwo());
})();
```

The above code will throw a type error, as the function assignment to `addFourtyTwo` will actually execute the closure on the following line, returning 42.
The statement will then attempt to call the number 42 and throw an error, as integers are not callable values.

#### Semicolons in function declarations

When a function is being asigned to a variable or as a property on an existing function, it requires a semicolon. When it is part of a function declaration it does not.

*The right way:*

```js
function square(a) {
  return a * a;
} // <- no semicolon

var MyNumber = function (val) {
  this.value = val;
}; // <- semicolon

MyNumber.prototype.squared = function () {
  return square(this.value)
}; // <- semicolon
```

### Strings

Strings should be kept as brief as possible and should line wrap after 80 characters. Where possible use translations provided through `I18n` instead of hard-coding text as a string to allow globalisation.

We prefer the use of double quotes `"` over single quotes `'` around strings unless there is good reason.

Never use `eval()` on a string, as it opens too many vulnerabilities. This includes eval's cousins who will remain nameless, if you're passing a string representation of a function into another function, stop look and listen.

### Curly brackets

Brackets should be used around all statements, including single line ones, with the opening brace residing on the same line as their related statement.
Due to implicit semicolon insertion, brackets should be in written [K&R style](https://en.wikipedia.org/wiki/Indent_style#Placement_of_braces) as alternative styles can lead to bugs in JavaScript:

*The wrong way:*

```js
function adultAges() {
  return // <- function will exit at this line
  {
    type: "year",
    values: ["18+", 17, 16]
  };
}

console.log(adultAges()); // <- undefined
```

### Var statement

Always declare variables with the `var` keyword, as reluctance to do so can lead to variables accidentaly polluting the global scope.
Keep a one to one relationship between variable statements and the var keyword, as doing so makes it easier to re-order lines in both your editor and in version control.

## Naming conventions

Our naming convention for variables, properties and function names is [camelCase](https://en.wikipedia.org/wiki/CamelCase).
Please choose names that are as succinct as possible while remaining descriptive and obvious.

### Filenames

Files should be named in [snake_case](https://en.wikipedia.org/wiki/Snake_case) to match the structure and naming conventions found in Rails.

## Conditional statements

### Use the === operator for equality

JavaScript's `==` operator has [upredictable behavior](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Comparison_Operators) due to it's use of type coercion, it is best to avoid it altogether and use the triple equality operator `===` instead.

### Always use curly braces

As mentioned already, always use curly brackets when writing conditional statements. See the curly brackets section above for more information.

### Ternary operators

Ternaries are fine, but should always be succinct enough to fit onto a single line and under no circumstances should they be nested.
If you find yourself writing a long or nested ternary this is a sign that the expression should be written as a much clearer (and bug free) `if/else` block instead.

## Miscellaneous

### jQuery

Due to adoption of newer browsers and animation improvements in CSS3, the Frontend team are currently phasing the use of jQuery out.
Try and use native DOM functionality where appropriate (if for example all you are doing is adding or removing a class), you can use [YMNNJQ](http://youmightnotneedjquery.com/) to find the native counterpart for a jQuery method.

__Don't__ use jQuery animations or show/hide functions __ever__ as the jQuery animation library is slow, use CSS to achieve the same effect instead.

__Don't__ use third party jQuery plugins, most of the time the functionality we need is a fraction of what plugins provide. We don't need unnecessary code bloat.

#### Cache lookups and chain function calls

You should cache your jQuery lookups if you're using them more than once, as it saves the code having to repeatedly search the DOM unnecessarily.
You can also use [chaining](http://www.w3schools.com/jquery/jquery_chaining.asp) where possible for the same effect, with the added benefit improved readability when used across several lines.

jQuery objects stored in variables should be prefixed with a `$`, e.g. `$variable`, making it obvious the variable contains a jQuery element.

#### jQuery & Backbone

For those new to Backbone, all Views store thier DOM element in the property `.el`. A jQuery wrapped version of this element is also available in `.$el`.

You can also call `this.$('.some-element')` inside a Backbone View, which is the equivalent to calling `this.$el.find('.some-element')`.

### Browser Support

We write frontend code to work cross-browser, cross-device. Your code must work across popular mobile and tablet devices and all mainstream browsers.
At present we support Internet Explorer from version 11 upwards, but do try to write things in a way that will degrade gracefully where possible.

Sites that can help to guide you towards what you can and cannot use include:

- [MDN - JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
- [ECMAScript compat-tables (ES5)](http://kangax.github.io/compat-table/es5/)
- [You Might Not Need jQuery](http://youmightnotneedjquery.com/)
- [caniuse](http://caniuse.com/)

