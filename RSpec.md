# RSpec Style Guide

This RSpec style guide recommends best practices so that On the Beach
programmers can write code that can be maintained by other real-world
programmers. A style guide that reflects real-world usage gets used, and a style
guide that holds to an ideal that has been rejected by the people it is supposed
to help risks not getting used at all - no matter how good it is.

The guide is separated into several sections of related rules. We've tried to
add the rationale behind the rules (if it's omitted we've assumed that it is
pretty obvious).

The guide is still a work in progress - some rules are lacking examples, some
rules don't have examples that illustrate them clearly enough. In due time these
issues will be addressed - just keep them in mind for now.

## Table of Contents

* [RSpec](#rspec)
* [Controllers](#controllers)
* [Models](#models)
* [Contributing](#contributing)

## RSpec

* Try to use just one expectation, within reason.

```ruby
# bad
describe OrdersController do
  # ...

  describe 'GET "new"' do
    it 'assigns a new order and renders the new article template' do
      get :new
      expect(assigns :order).to be order
      expect(response).to render_template :new
    end
  end
end

# good
describe OrdersController do
  # ...

  describe 'GET "new"' do
    it 'assigns a new order' do
      get :new
      expect(assigns :order).to be order
    end

    it 'renders the new article template' do
      get :new
      expect(response).to render_template :new
    end
  end
end
```

* When using a `subject`, use it directly after the `describe` block,
and named where possible:

```ruby
# bad
describe '#some_method' do
  let(:something) { double }

  subject { instance.some_method(something) }

  # ...

# good
describe '#some_method' do
  subject(:some_method) { instance.some_method(something) }

  let(:something) { double }

  # ...
```

* Keep the full spec name (concatenation of the nested description)
  grammatically correct.

    * Top level: use `describe` with a constant name: `describe User ...`
    * Second level: use `describe` with a method name: `describe '#awesome?'`
    * Inner blocks: use a `context` that starts with `when`: `context 'when user
      is unsubscribed`
    * Example describes the expectation: `it { is_expected.to be_false }`
    * Full spec name: `'User#awesome? when user is unsubscribed is false'`

* Do not use “should” in our example names:

```ruby
# bad
it 'should return the result of a computation'

# good
it 'returns the result of a computation'
```

* Do not use a description when the test returns true or false.

```ruby
# bad
it 'returns true' do
  expect(named_subject).to be_true
end

# good
it { is_expected.to be_true }
```

* Write expectations at a high level, removed from logic and implementation
  details.

```ruby
# bad
it 'calls more_results if i=0' do
  # ...
end

# good
context 'no results are returned by the initial search' do
  it 'attempts to find more results' do
    # ...
  end
end
```

* Name `describe` blocks using dot ".method" for class methods and hash
  "#method" for instance methods

```ruby
class Order
  def summary
    # ...
  end

  def self.latest
    # ...
  end

# the spec
describe Order do
  describe '#summary' do
    # ...
  end

  describe '.latest' do
    # ...
  end
end
```

* Do not write iterators to generate tests.

```ruby
# bad
[:new, :show, :index].each do |action|
  it 'returns 200' do
    get action
    expect(response).to be_ok
  end
end
```

* Use `let` blocks instead of `before :each` blocks to create data for the spec
  examples. `let` blocks get lazily evaluated.

```ruby
# bad
before(:each) { @order = instance_double('Order') }

# good
let(:order) { instance_double('Order') }
```

* Place contexts at the bottom of the `describe` block, with the happy path at
  the top. This allows the core behaviour to be more visible to people reading
  the spec for the first time.

```ruby
describe 'testing the thing' do
  it 'tests the thing'

  context 'when an edge case ocurrs' do
    it 'handles it gracefully'
  end
end
```

## Controllers

* Mock the models and stub their methods. Testing the controller should not
  depend on the model creation.
* Test only the behaviour the controller should be responsible for:
    * Execution of particular methods
    * Data returned from the action - assigns, etc.

```ruby
# Example of a commonly used controller spec
# spec/controllers/orders_controller_spec.rb
# We are interested only in the actions the controller should perform
# So we are mocking the model creation and stubbing its methods
# And we concentrate only on the things the controller should do

describe OrdersController do
  # The model will be used in the specs for all methods of the controller
  let(:order) { class_double('Order') }

  describe 'POST create' do
    before { allow(Order).to receive(:new).and_return(order) }

    it 'creates a new order with the given attributes' do
      expect(Order).to receive(:new).with(passenger: 'Mr Smith').
        and_return(order)
      post :create, order: { passenger: 'Mr Smith' }
    end

    it 'saves the order' do
      expect(order).to receive(:save)
      post :create
    end

    it 'redirects to the Orders index' do
      order.stub(:save)
      post :create
      expect(response).to redirect_to(action: 'index')
    end
  end
end
```

* Use context when the controller action has different behaviour depending on
  the received params.

```ruby
# A classic example for use of contexts in a controller is creation or update
# when the object saves successfully or not.

describe OrdersController do
  let(:order) { class_double('Order') }

  it 'creates a new order with the given attributes' do
    expect(Order).to receive(:new).with(passenger: 'Mr Smith').and_return(order)
    post :create, order: { passenger: 'Mr Smith' }
  end

  it 'saves the order' do
    expect(order).to receive(:save)
    post :create
  end

  context 'when the order saves successfully' do
    before { allow(order).to receive(:save).and_return(true) }

    it 'sets a flash[:notice] message' do
      post :create
      expect(flash[:notice]).to eq('The order was saved successfully.')
    end

    it 'redirects to the Orders index' do
      post :create
      expect(response).to redirect_to(action: 'index')
    end
  end

  context 'when the order fails to save' do
    before { allow(order).to receive(:save).and_return(false) }

    it 'assigns @order' do
      post :create
      expect(assigns[:order]).to be_eql(order)
    end

    it 're-renders the "new" template' do
      post :create
      expect(response).to render_template('new')
    end
  end
end
```

## Models

* Do not mock the models in their own specs.
* Use FactoryGirl to make real objects.
* It is acceptable to mock other models or child objects.
* Create the model for all examples in the spec to avoid duplication.
* Avoid unnecessary database calls.

    ```ruby
    describe Order
      let(:order) { FactoryGirl.build(:order) }
    end
    ```

## Contributing

Feel free to open tickets or send pull requests with improvements. Thanks in
advance for your help!
