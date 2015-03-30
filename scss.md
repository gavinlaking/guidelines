# Coding standards for (S)CSS

Welcome to our coding standards for writing (S)CSS.

## Coding style

* Use spaces instead of tabs with a 2 space indent
* Use multiple lines for multiple selectors
* Put spaces before opening `{` to aid readability
* Put a space after `:` to aid readability
* Styles should be 1 per line to aid readability
* Use hyphens for CSS names (e.g. `.package-block`, not `.packageBlock`)
* Avoid over qualifying selectors (e.g. `p.qualified {…}` should just be `.qualified`)
* Use single quotes when referencing strings
* Whenever using colours, use the colours defined in `app/assets/stylesheets/application/settings.scss` so that if we need to change any, it will change across the whole site
* Comments should only when absolutely neccessary (the CSS should explain itself), for example, if a unicode character is used `\u201D` a comment would be neccsary to explain what it is
* When writing comments, use `//` as these won't appear in the generated CSS
* Whilst not a requirement, we recommend ordering CSS properties either alphabetically or "outside-in".

e.g:

    // This is a good example
    .selector-1,
    .selector-2 {
      display: block;
      left: 0;
      top: 0;
      font-size: 15px;
      color: $default-body-font; // Colour would be defined in "settings.scss"
    }

    // This is a bad example
    .selector-1, .selector-2{
      display:block;
      left:0; top:0;
      font-size:1.5em; colour:RGB(255, 255, 255);
    }


## SCSS Specifics

Same rules as regular CSS, with a few extensions:

* When using nested selectors, go a maximum of 3 levels deep, any more and you should consider restructuring your HTML or CSS selectors
* If using variables, define them at the top of the file, or if used in more than one file, define them in `app/assets/stylesheets/application/settings.scss`
* If you are using the same patterns in lots of places (e.g. a clearfix) move it into the helpers folder as a new component `app/assets/stylesheets/application/helpers/`
* If you need to modify a colour, you should use the SASS colour modification functions, using an existing colour as your base. [http://sass-lang.com/documentation/Sass/Script/Functions.html](Module: Sass::Script::Functions)

## Everything should be a component

When writing your styles, imagine every block on the page broken down into a component, this will make it easier to create reusable styles. See [SMACSS](http://smacss.com/)

When creating a new component, its name should be kept short (ideally below 12 characters) but descriptive enough so that it's clear what the component is.

* Good: `.deal-pod`
* Bad: `.pod` (not specific enough)
* Bad: `.flight-and-holiday-deal-pod` (too long)

## BEM

For components, we use a BEM-like (Block Element Modifier) naming convention. [CSSWizardy](http://csswizardry.com/2013/01/mindbemding-getting-your-head-round-bem-syntax/) BEM helps keep our CSS logical and predictable. The naming convention follows this pattern:

    .component {} // Block
    .component__element {} // Element
    .component--modifier {} // Modifier

`.component` represents the higher level of an abstraction; the component.
`.component__element` represents a descendent of `.component` that helps form `.component` as a whole.
`.component--modifier` represents a different state or version of `.component`.

Using the `&` feature in SASS, we can write cleaner and leaner CSS adhering to the BEM convention.

e.g:

    $component-name: 'deal-pod';

    .#{$component-name} {
      float: left;
      display: block;
      padding: 1em;
      background: $primary-background;

      &__title {
        font-size: 1.6em;
        font-weight: bold;
        color: $primary-body-font;
      }

      &--large {
        padding: 2em;

        .#{$component-name}__title {
          font-size: 2.4em;
        }
      }
    }

## Specificity

* You should avoid using element type selectors e.g. `div { ... }` and IDs, using class names where possible
* If you end up with a specificity issue, consult [Specificity Wars](http://www.stuffandnonsense.co.uk/archives/images/specificitywars-05v2.jpg)

## IE

When writing IE specific styles, use the `.li-ie#` classes conditionally added to the `html` element within your components (e.g. `.lt-ie9 & {`. Do not use IE specific stylesheets. In doing so we keep the styles for our components in one place.

## Variant testing

When you are testing variants, your variant should be classed as _experimental_ and the class names should reflect this. Create a copy of the original components styling, suffix `-experimental` on to the end of your component and make your changes. This allows for easier cleanup!

    // Original component
    .my-component {
      display: block;
      background: $mainYellow;

      a {
        text-decoration: none;
      }
    }

    // Experimental variation component
    .my-component-experimental {
      display: block;
      background: $royalBlue;
      color: $white;

      a {
        text-decoration: none;
      }
    }
