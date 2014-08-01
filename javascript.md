# Coding standards for JavaScript

Welcome to the coding standards for JavaScript. Here are some guidelines for creating elegant stylesheets that work well with git diffs.


## Coding style

* Prefer an OO approach to JavaScript
* Everything should be named with CamelCase, classes use UppperCamelCase, variables and functions use lowerCamelCase.
* Everything should be contained in a closure, pass in any global's you need as arguments (e.g. jQuery)
* Use strict mode
* Use `//` For comments, as these won't appear in the minified JavaScript
* Use spaces instead of tabs with a 2 space indent
* Put spaces before opening `{` to aid readability
* `{` should be on the same line as function definitions, if's etc.
* End all statements with a `;`
* All equality tests should use `===`

```javascript
var MyClass = (function($) {
  'use strict';

  function MyClass(data) {
    this.data = data;
  }
  
  MyClass.classMethod = function() {
    return "I'm a class method";
  };

  MyClass.prototype.instanceMethod = function(key) {
    return "I'm an instance method, I can see the data: " + this.data;
  };

  function helperMethod() {
    return "I'm a helper method, I can't be accessed outside of this closure";
  }

  return MyClass;
}(window.jQuery));

// ==============================================================
//
// Using MyClass
//
// ==============================================================

MyClass.classMethod();
// => Returns "I'm a class method"

var instanceOfMyClass = new MyClass("this is my data");
instanceOfMyClass.instanceMethod();
// => Returns "I'm an instance method, I can see the data: this is my data"

helperMethod()
// => Returns ReferenceError: helperMethod is not defined

instanceOfMyClass.helperMethod();
// => Returns TypeError: undefined is not a function

```

## Views

Seperate view logic from data logic. Views should be concerned with binding to the DOM and rendering. Data logic should be done in models. 

### Generate a container element in the initializer

```javascript
function MyView() {
  this.$el = $('<div class="my-view"></div>');
}
```

### Binding to the DOM

```javascript
MyView.prototype.bind = function() {
  var self = this;

  this.$el.on("click", ".something-in-my-view", function(e) {
    self.doSomething();
    e.preventDefault();
  });
}
```

### Rendering HTML

Use a JST e.g.

```javascript
MyView.prototype.render = function() {
  this.$el.html(JST["templates/my_class"]({ data: this.data }));
  return this;
};
```

### Use events to notify other components of state changes

```javascript
MyView.prototype.doSomething = function() {
  // Do something
  this.$el.trigger("somethingcomplete.myView");
};
```

### Prefer toggling classes to change state instead of manipulating elements directly

```javascript
MyView.prototype.doSomething = function() {
  this.$el.addClass("my-view-with-something");
}
```

## General things

Some other general styling things

#### Predicate methods

Their name should start with `is` or `has` to show the return will be a boolean e.g.

```javascript
MyClass.prototype.isActive = function() {
  return true;
};
```

#### Prefer shorthand array and object syntax

```javascript
var a = [];
var b = {};
```

## NodeJS

NodeJS specific things

#### Requirements go at the top of the file

```javascript
_ = require("lodash");
```

#### Module exports should always be at the bottom of the file

```javascript
module.exports = MyClass
```
