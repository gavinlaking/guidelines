
# Coding standards for ERB / HTML

## Filenames

Filenames should be named in snake_case to match the structure and naming conventions found in Rails.

## Indentation

Indent all erb & HTML with two spaces:

*The right way:*

```erb
<div class="flight-information-board">
  <div class="flight-information-board__info">
    <% [flight.outbound, flight.inbound].each do |journey| %>
      <div class="flight-information-board__section">
        <span class="flight-information-board__label flight-information-board__label--emphasis">
          <%= journey.departure_time %>
        </span>
        <span class="flight-information-board__label">
          <%= journey.departure_airport_name %>
        </span>
      </div>
    <% end %>
  </div>
</div>
```

*The wrong way:*

```erb
<div class="flight-information-board">
    <div class="flight-information-board__info">
        <% [flight.outbound, flight.inbound].each do |journey| %>
            <div class="flight-information-board__section">
                <span class="flight-information-board__label flight-information-board__label--emphasis">
                    <%= journey.departure_time %>
                </span>
                <span class="flight-information-board__label">
                    <%= journey.departure_airport_name %>
                </span>
            </div>
        <% end %>
    </div>
</div>
```

## Quotemarks

Prefer double quotes for HTML attributes. 
Anything inside an `erb` tag is Ruby so should use single quotes by default, double quotes for interpolation.

## Wrapping

When wrapping a Ruby statment across multiple lines, keep the method name on the same line as the opening erb tag and keep each method argument on its own line:

*The right way:*

```erb
<%= render(
  'components/banner_message',
  banner_link: t('contact.emergency.url'),
  banner_logo: nil,
  message: t('contact.emergency.message'),
  cta: true
) %>
```

*The wrong way:*

```erb
<%=
  render('components/banner_message',
    banner_link: t('contact.emergency.url'),
    banner_logo: nil,
    message: t('contact.emergency.message'),
    cta: true
  )
%>
```
