<p align="center">
	<a href="http://ruby-hyperloop.io/" alt="Hyperloop" title="Hyperloop">
		<img src="https://raw.githubusercontent.com/ruby-hyperloop/ruby-hyperloop.io/source/source/images/hyperloop-logo-small-pink.png">
	</a>
</p>

# Heart Cards Application and Tutorial

**WIP: This tutorial is not complete yet**

## What is HEART?

Google invented the HEART process, which stands for Happiness, Engagement, Adoption, Retention and Task Success.

The HEART process takes a more holistic approach and recognizes the need to gather quantitive as well as qualitative feedback when assessing the success of a software initiative.

You can read more about HEART here: https://www.interaction-design.org/literature/article/google-s-heart-framework-for-measuring-ux

If you are on a journey of continuous improvement, HEART can help you stay true to a build-measure-learn software development lifecycle and can unite designers, developers, product managers, and testers.


## The Heart Cards Application

This *Heat Cards* application provides a digital platform to track and manage a HEART process.

*Heart Cards* is also a fully featured Hyperloop application which demonstrates all aspects of the Hyperloop Isomorphic COMPS architecture.

## This tutorial

This tutorial assumes a working knowledge of Rails and Hyperloop. The detailed [Rails Hello World](http://ruby-hyperloop.io/tutorials/hyperlooprails/helloworld/) or [ToDo](https://github.com/ruby-hyperloop/todo-tutorial) tutorials are good precursors if starting out with Hyperloop.

## Technology covered

*Heart Cards* is an Isomorphic Ruby application showcasing Hyperloop's COMPS architecture.

The following technologies are covered:

+ Hyperloop Isomorphic Components, Operations, Models, Policies and Stores
+ Hyper-Router which is a DSL wrapping React Router
+ Rails 5.1 with ActionCable for pushing changes between connected clients
+ Opel Hot Reloader for developer bliss with no page reloads while coding
+ Yarn and Webpacker for managing JavaScript libraries
+ The Devise Gem for authentication (connected to Hyperloop)
+ React for the interactive UI (used by Hyperloop)
+ The React-Semantic-UI for integrating React and Semantic UI

## Setup

Ensure Ruby, Rails 5.1.x, Yarn and Postgres SQL are installed first.

> Note: This application uses Postgres SQL so that it is deployable to Heroku. If you do not want to use Postgres then you will need to swap it out for MYSQL, but please do not use SQLite as it is not capable of providing the concurrency Hyperloop requires. There are detailed Postgres installation instructions here: https://wiki.postgresql.org/wiki/Detailed_installation_guides

Thereafter, run the following console commands:

```
git clone https://github.com/barriehadfield/heart-cards.git
cd heart-cards
bundle
gem install foreman
rails db:create
rails db:migrate
yarn
bin/webpack
```

Start the server:

`foreman start`

Navigate to:

`http://localhost:5000/`

And you should be rewarded with a running application, but if it is not working, then there is something not right in the setup. If you cannot resolve this, then please reach out to us in the Gitter Hyperloop room: https://gitter.im/ruby-hyperloop/chat and we will be happy to help you.

## Single Page Application Routing

### The AppRouter Component

The first Component we launch is the Router. Its job is to read the incoming route and render the appropriate Component. Simple as that! We have SPA using React Router to route incoming requests in just a few lines of Ruby code.

```ruby runable
# app/hyperloop/components/shared/app_router.rb
class AppRouter < Hyperloop::Router
  history :browser

  route do
    DIV {
      Switch do
        Route('/', exact: true, mounts: Home)
        Route('/members', exact: true, mounts: Members)
      end
    }
  end
end
```

As you can see from the code above, there are just two routes in this application. `/` which will render a Component called `Home` and `/members` which will render a Component called `Members`. As our routing needs in this application are so simple, we will not go into routing further, but you can learn more about this Hyper Router here: https://github.com/ruby-hyperloop/hyper-router

### Where are the Controllers and Views?

You might be wondering where the controllers and views are for our application. There are none, we have replaced all of these parts of the Rails stack with Isomorphic Hyperloop code. If you have a look at `routes.rb` you will see that we have an automagical route `root 'hyperloop#AppRouter'` which Hyperloop uses to render our root Component `AppRouter`.

There are other ways to work with Hyperloop, you could have had a traditional Controller and View and launched the root Hyperloop Component either from the Controller or from within a View, but for now, we just don't need all that.

While we are looking at `routes.rb` pay attention to this line at the end of the file. It's important that it remains at the end of the file as this is our catch all route `match '*all', to: 'hyperloop#AppRouter', via: [:get]`

That last line tells our Rails server to route all requests to our Hyperloop Component so we can deal with them there. We will discuss SPA (single page application) routing later.

## Reactive Components

### The Home Component

The Home Component generates the primary user interface for this application. We will spend a little time going through this line by line as there might be several new concepts here.

> **Note on coding style:** There are two coding conventions used here which are purely a matter of coding style. You will notice that the HTML elements (`DIV`) are in caps which would indicate a constant. We are using caps as we believe it makes the code easier to read. If you do not like this then `div` will work just as well. Secondly (and perhaps more controversially) you will notice the misuse of `{ }` curly braces extending over more than one line whereas the Ruby norm is to use `do end` blocks if the block extends over more than one line and `{ }` if it just one line. Personally, I like curly braces for Component and HTML element blocks and `do end` for conditional or looping logic. I find this easier to read and work with, but if it hurts your eyes, you can use `do end` instead.

```ruby
# app/hyperloop/components/home.rb
class Home < Hyperloop::Router::Component

  render(DIV) do
    MainAppBar()
    Sem.Container(style: { marginTop: '2em' }) {
      Sem.Grid {
        Sem.GridRow {
          Sem.GridColumn {
            new_heart
          }
        }
        heart_cards
      }
    }
  end

  def new_heart
    HeartModal(heart: Heart.new, mode: :new)
  end

  def heart_cards
    Heart.reverse.each do |heart|
      Sem.GridRow {
        Sem.GridColumn {
          HeartCard(heart: heart)
        }
      }
    end
  end
end
```

Hyperloop calls the `render` macro to render a Component. I always like to keep this method near the top of the class so you can quickly see what the Component does.

In this case, the first thing our `Home` Component does is render another Component - `MainAppBar`. That is the key to Component oriented architecture - Components render other Components, so your user interface is composed of increasingly smaller contained Components. You will get very used to this pattern.

You might also notice that 'Home' is not an entirely standard Hyperloop Component, as it is derived from `Hyperloop::Router::Component` whereas typical Hyperloop components are classes derived from `Hyperloop::Component`. We are doing this because we need to pass information routing down into out `MainAppBar` Component. The reason for this is well covered in [Chapter 6 of the ToDo  tutorial](https://github.com/ruby-hyperloop/todo-tutorial#chapter-6-routing). If you go off and read that now do make sure you come back here as there are still many interesting topics we are about to get into!

### Using JavaScript based React libraries

Let's look at the `render` macro of our MainAppBar Component and then discuss this mysterious `Sem` object.

[Semantic UI React](https://react.semantic-ui.com/) is a React library which we are accessing from within our Ruby code. Semantic UI React is a React based DSL wrapper for the great Semantic UI style sheet.

There is a quick tutorial on the Hyperloop site which explains how to setup Yarn and Webpacker and import libraries like semantic-ui-react or react-bootstrap(or any React of JavaScript library): http://ruby-hyperloop.io/tutorials/hyperlooprails/webpacker/

`Sem.Menu` is this Component: https://react.semantic-ui.com/collections/menu Lets have a look at the documentation with examples is JSX and write a Ruby version.

For the Menu Component, if we were writing it in JSX syntax it would look like this:

```javascript
// if this were in JSX
return (
  <Menu inverted color='blue' size='huge'>
    <Container>
      <Menu.Item name='home' active={activeItem === 'home'} onClick={this.handleItemClick} > HOME </Menu.Item>
      <Menu.Item name='members' active={activeItem === 'members'} onClick={this.handleItemClick} > MEMBERS </Menu.Item>
    </Container>
  </Menu>
)
```

And here is our Ruby version:

```ruby
# app/hyperloop/components/shared/main_app_bar.rb
render(DIV) do
  Sem.Menu(inverted: true, color: :blue, size: :huge) {
    Sem.Container {
      Sem.MenuItem { heart_cards }
      Sem.MenuItem { members }
    }
  }
end
```

There are a few simple things you need to understand, and after that, you will find it very easy to translate any JSX example into Ruby and work with any JavaScript or React library.

Firstly, notice that we are accessing the `semantic-ui-react` library through an object called `Sem`.

If you are wondering where the `Sem` object came from, its as simple as using Yarn and Webpack to package the library then creating a JavaScript object called `Sem` through a `require` of the library.

```javascript
// app/javascript/packs/application.js
Sem = require('semantic-ui-react');
```

The other thing to notice is that we do not use the dot notation in exactly the same way the JSX example does. `Menu.Item` becomes `MenuItem` and so-forth. `Menu.Item` is actually an assignment of the `MenuItem` object within the Menu object. The fact that `Menu.Item` is not imported as something to do with the way Webpack is importing it and beyond the scope of this tutorial.

Finally notice how the JSX paramaters `inverted color='blue' size='huge'` become a hash `inverted: true, color: :blue, size: :huge` in the Ruby version.

The information in this chapter should equip you with most of what you need to work with any JavaScript or React library. The only things we have not discussed is how to create and pass a React object to another object and how to handle JavaScript callbacks. We will address both these topics later in this tutorial.

## Models and Modals

### The HeartModal Component

![](/public/images/modal.png)

`HeartModal` is a self-contained, DRY, multi-functional component. It renders itself as  Button (in an Edit or New state) and then morphs into a Modal when clicked. It handles editing or creating of Heart objects and it achieves all of that in roughly 50 lines of code.  

+ **Multi-functional** - this Component handles editing or creating of `Heart` objects using the same rendering code and when the Modal is not open, the Component knows if it should render as a New or Edit `Button` (or as a `Modal` if it opened).
+ **Self-contained** - all of the functionality is contained within the Component, we do not need to worry about its rendering state (Button or Modal) or even if the Modal should be shown or hidden. There are also no call-backs to worry about.
+ **DRY** - It uses the same Components as the `Card` Component to render the `Heart` object data. The rendering is slightly different, so it does depart in part but were there is no need for difference the code is completely DRY.

### Interface

In our `Home` Component code, you will notice that we invoke the `HeartModal` Component passing in an empty `Heart` object and a `mode` param.

```ruby
HeartModal(heart: Heart.new, mode: :new)
```

And then again in the `Card` Component we use it again:

```ruby
HeartModal(heart: params.heart, mode: :edit)
```

We could simplify the interface and just pass the `Heart` object we would like to operate on and let the `HeartModal` Component figure out if it is a new or existing object and then render itself as a New or Edit  Button but that would be a little to pithy for my liking. The interface to this Component (passing the `Heart` object we want to operate on, and a `mode` param) makes for clear understandable code.

### Implementation

Firstly, lets have a look at the render macro:

```ruby
render(DIV) do
  if state.open
    render_modal
  else
    edit_or_new_button.on(:click) { mutate.open true }
  end
end
```

Herein lies the beauty of React. These 7 lines of code tell us everything we need to know about how this Component works:

If its internal (reactive) state `open` is true then it will render (and add to the DOM of the page) a Modal, otherwise it will render itself as a Button (either an Edit or New Button) that' if clicked, will mutate its `open` state so that it then renders as a Modal.

Our `render_modal` method does exactly what it describes; it renders a Semantic UI Modal and sets the open state of the Modal to the same reactive state `open`. This is key - our reactive state variable `open` does three things - firstly it governs if the Component should present itself as a Button or a Modal, secondly it governs if the Modal CSS is added to the DOM and thirdly it governs if this particular Modal (which is now rendered to the DOM) is visible or not.

There is a subtly yet important point here - the Modal will only be rendered to the DOM if it is to be displayed. This is important as we will be adding many of these `HeartModal` Components to our page (one per `HeartCard` which we will see later) and we do not want them to render unless necessary as the rendering code will be expensive.  

```ruby
def render_modal
  Sem.Modal(open: state.open) {
    Sem.ModalHeader {
      params.heart.name.nil? || params.heart.name.length == 0 ? "New Heart Card" : params.heart.name
    }
    Sem.ModalContent {
      content
    }
    Sem.ModalActions {
      actions
    }
  }
end
```

Lets consider the second part of the `render` macro - rendering itself as a Button if the Modal is closed.

```ruby
edit_or_new_button.on(:click) { mutate.open true }
```

Herein lies the beauty of Ruby. We render a method `edit_or_new_button` which will return a Button and we add an event handler to whichever Button is returned.

```ruby
def edit_or_new_button
  if params.mode == :new
    Sem.Button(icon: true, labelPosition: 'left', primary: true) {
      Sem.Icon(name: :heart)
      "New Heart Card"
    }
  else
    Sem.Button(circular: true, icon: :setting)
  end
end
```

### Methods or Components

Its worth taking a moment to discuss the choice of using methods in a Component class or creating new Components. One could argue that each of the methods above could be a Component in its own right and if one were following the React coding guidelines where you create ever smaller Components.

My own rule of thumb is to use methods to simplify the code and I create Components whenever I imagine the Component being re-used somewhere else in my code. Often code starts life as a method and turns into a Component.

For example, in this `HeartModal` Component we use methods throughout other than one Component which we render in the body of the Modal `Categories(heart: params.heart, edit: true)`. We will discuss this Component in a later chapter as it has some of its own magic. For now all we need to know is that a Component called `Categories` will be rendered in the body of our Modal (if the Modal itself is rendered).

### Creating and Updating Heart Objects

You might have noticed that our Modal has two action buttons:

```ruby
def actions
  Sem.Button(primary: true) { "Save" }.on(:click) { save } if params.heart.changed?
  Sem.Button { "Cancel" }.on(:click) { cancel }
end
```

Our 'save' action is implemented here:

```ruby
def save
  params.heart.save.then do |result|
    if result[:success]
      mutate.open false
    else
      alert "Unable to save Heart Card"
    end
  end
end
```

Herein lies the beauty of Hyperloop. The code above is the only code we write to handle the saving or creating of modified Heart objects.

Under the covers Hyperloop does all of the following tasks:

+ Serialies our `Heart` object into JSON
+ POSTSs it to the server (expecting a promise to be returned at some time)
+ Saves it to the database (depending on the `current_users` access rights)
+ Uses ActionCable to push a notification to a channel (again, depending on the current_users Policy)
+ De-serilizes the response and updates the client-side Models with any changes
+ Re-renders any Component which is currently displaying data from a modified Model or collection of Models
+ Executes the code which was waiting for the promise to be returned, which in this case changes the state of the Modal to not be shown or alerts an error

In a non-isomorphic, single page application (most likely with the frontend in JavaScript and the backend in Ruby) all of the tasks above would have to have been considered and coded by the developer. Howevere, with Hyperloop, the simple fact that Models are shared between the client and server makes all of the above possible and designates those mundane, repetitive, complicated, and fragile tasks to plumbing.

...
todo:
t.boolean :completed, null: false, default: false
Todo.send(match.params[:scope]).each do |todo|
param :on_save, type: Proc
 .on(:blur) { params.on_cancel }   

and excellent question. The answer is (as you suspect) local state which would be the easiest to implement and simplest. That said, and the reason for your excellent question I think, one has to look deeper and ask why this checkbox exists - it must be there to communicate business value and give the user some choice which has consequence outside of the Card Component. Somehow you will need to communicate the choice the user is making back up the parent-child three to a higher order function in your code where this choice means something. In Hyperloop’s architecture you have four choices ahead of you - four ways you can pass information around your application:
1 - you could have passed a Proc as a param to the Card Component and use this to communicate back to the Card’s parent (CardList perhaps). This approach is ok for straightforward child-parent communications but quickly becomes way too complicated as soon as you find yourself passing Proc up and down several layers of Components
2 - Stores are designed to hold shared state outside Components, so are an excellent choice. You can create class methods (one instance for the whole application) or many instances of a Store and you can communicate with Stores either through invoking their methods or sending them messages Flux style. The choice of how you communicate with a Store is down to how you feel about architecture. With the method approach, you shift responsibility for the code creating the change in state to update the Stores whereas with the message approach you are expecting the Stores themselves to listen for changes and the code making the change not even know which Stores are listenting.
3 - Models. A Model is like a clever Store which is connected to your database with Policy to keep data safe and push notifications to push changes to all connected authorized clients. Models are Stores on steroids. Much like as in Rails where you Models are available to your Views, Hyperloop Models communicate directly with Components. (Don't be tempted to wrap your Model in a Store as you end up having your application performance as every change takes at least two rendering cycles). Components watch instances they are rendering and update themselves when they see change, so data held in a model is reactive, much like reactive state variables in a Store and local state variables in a Component.
So back to your checkbox on a Card question. I would choose a param/Proc approach if all you needed to do were communicate something very one off and simple to the Card’s parent
I would use a Store if the checkbox represented a session wide preference which would not be persisted.
And I would use a Model if the checkbox described something in my business logic. I would pass the Model into the Component and have tie the checkbox value directly to the model with nothing in between.
Long answer - hope it is helpful.

Rodolphe Edouard @rodoard 07:53
thanks @barriehadfield for the bird's eye view, I was not quite sure on how to decide or even fully aware of all the possibilities, it's all much clearer now!

Barrie Hadfield @barriehadfield 08:05
Can I add just one more thing to the mix - Operations. In designing the COMPS architecture, we knew it was essential that Components and Models should communicate directly as this is the most effective and efficient way of displaying and managing persistent state. However, we also know that a terrible design pattern is where your business logic ends up in your Models (which should have a single purpose of wrapping the database) or worse in your Components (which become unusable and un-maintainable). So this is where Operations came in. Whenever you need to make a sequence of changes to your Models, it is better to wrap those changes in an Operation and run it there, passing in the affected Models. This gives you discreet, testable pockets of business functionality which are abstracted from your UI. You have the choice of normal Operations (which can run anywhere) and their special cousins ServerOps (which guarantee to only run on the server as they can do things that can only be done on the server). The amazing thing about Operations and ServerOps is that your client-side code does not really need to know the difference, its actually an implementation detail for you (a ServerOp can send an email because the Mailer is on the server). Invoking this Operation (from the client) is the same as invoking a normal Operation, the fact that it runs on the server is just an implementation detail.
