# Coding standards for (S)CSS

Welcome to the coding standards for (S)CSS. Here are some guidelines for creating elegant stylesheets that work well with git diffs.


## Coding style

* Use `//` For comments, as these won't appear in the generated CSS
* Use spaces instead of tabs with a 2 space indent
* Use multiple lines for selectors
* Put spaces before opening `{` to aid readability
* Put a space after `:` to aid readability
* Styles should be 1 per line to aid readability
* Use pixels for font sizing, as this allows for greater control and stops you having to deal with inheriting `em` sizes
* Use **hex** codes as default colours, **RGBA** if you need to alter the opacity
* Hex code colours should always use the full 6 alphanumeric syntax, this makes for easier find and replace
* Whenever using colours, use the colours defined in `app/assets/stylesheets/application/settings.scss` so that if we need to change any, it will change across the whole site

e.g:

    // This is a good example  
    .selector-1,  
    .selector-2 {  
      display: block;  
      left: 0;  
      top: 0;  
      font-size: 15px;  
      color: $royalBlue; // Colour would be defined in "settings.scss"  
    }

    // This is a bad example
    .selector-1, .selector-2{  
      display:block;  
      left:0; top:0;  
      font-size:1.5em; colour:RGB(255, 255, 255);  
    }


## SCSS Specific

Same rules as regular CSS, with a few extensions:

* When using nested selectors, go a maximum of 3 levels deep, any more and you should consider restructuring your HTML or CSS Selectors
* If using variables, define them at the top of the file, or if used in more than one file, define them in `app/assets/stylesheets/application/settings.scss`
* If you are using the same patterns in lots of places (e.g. a clearfix) then move them into `app/assets/stylesheets/application/helpers.scss`


## Everything should be a component

When writing your styles, imagine every block on the page broken down into a component, this will make it easier to create reusable styles. See [SMACSS](http://smacss.com/)


## Specificity

* Always prefer classes over IDs unless you need to link to them via the the URL. The only exceptions to this should be `#header`, `#footer` and `#main` as there should only ever be one of these kinds of elements on the page.
* If you end up with a specificity issue, consult [Specificity Wars](http://www.stuffandnonsense.co.uk/archives/images/specificitywars-05v2.jpg)


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
