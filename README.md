# Heart Cards

## HEART

The Heat Cards application provides, tracks, and manages a (Google inspired) software development HEART process.

HEART stands for Happiness, Engagement, Adoption, Retention and Task Success. Traditional product analytics is usually metrics focused, and the function normally depends on gathering as much quantity of data as possible on net promoter scores, cost of acquisition, conversion rates, retention rates and so on.

HEART takes a more holistic approach and recognizes the need to gather quantitive as well as qualitative feedback when assessing the success of a software initiative.

You can read more about HEART here: https://www.interaction-design.org/literature/article/google-s-heart-framework-for-measuring-ux

If you are on a journey of continuous improvement, HEART can help you stay true to a build-measure-learn software development lifecycle and can unite designers, developers, product managers and testers.

## This tutorial

The goal of this tutorial is to provide a fully featured Hyperloop application which demonstrates all aspects of the Hyperloop Isomorphic COMPS architecture with Rails.

This tutorial assumes a working knowledge of Rails and of Hyoerloop and does not go into any setup. If you are just staring wiht Hyperloop then there are better tutorial to start with - specifically the [Hello World](http://ruby-hyperloop.io/tutorials/hyperlooprails/helloworld/) tutorial on the [Hyperloop website](http://ruby-hyperloop.io/) or the most execllent [ToDo](https://github.com/ruby-hyperloop/todo-tutorial) tutorial which takes you through a step by step process of building a Hyperloop application in just 87 lines of code.


## Technology

This Isomorphic application is a showcase for Hyperloop's COMPS architecture, all written in beautiful Ruby. The goal of publishing this application is to show how all these technology work together in a live application.

We will be working with the following technologies:

+ Hyperloop Isomorphic Components, Opertions, Models, Policies and Stores (COMPS for short)
+ Hyper-Router which is a DSL wrapping React Router
+ Rails 5.1 with ActionCable for pushing changes between connected clients
+ Opel Hot Reloader for developer bliss with no page reloads while coding
+ Yarn and Webpacker for managing JavaScript libraries
+ The Devise Gem for authentication (connected to Hyperloop)
+ React for the interactive UI (used by Hyperloop)
+ The React-Semantic-UI for integrating React and Semantic UI

## Setup

You will need to install **Ruby**, **Rails 5.1.x**, **Yarn** and **Postgres SQL** first.

> Note: This application uses Postrges SQL so that it is deployable to Heroku. If you do not want to use Postgres then you will need to swap it our for MYSQL, but please do not use SQLITE as it is not capable of providing the concurrency Hyperloop requires. There are detailed Postgres installation instructions here: https://wiki.postgresql.org/wiki/Detailed_installation_guides

After you have done that run the following sequence of commands from your console:

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

And you should be rewarded with a running application. If you are not then there is something not right in the setup. If you cannot resolve it then please reach out to us in the Gitter Hyperloop room: https://gitter.im/ruby-hyperloop/chat

## Code

### Where are the Controllers and Views?

There are none, we have replaced all of these parts of thr Rails stack with Isomorphic Hyperloop code. If you have a look at `routes.rb` you will see that we have an automagical route `root 'hyperloop#AppRouter'` which Hyperloop uses to render our root Component `AppRouter`.

This is not the only way to work with Hyperloop, and we could have had a traditional Controller and View and launched the root Hyperloop Component either from the Controller or from within a View, but for now we just don't need all that.

While we are looking at `routes.rb` pay attention to this line at the end of the file (it's important that it remains at the end of the file as this is our catch all route) `match '*all', to: 'hyperloop#AppRouter', via: [:get]`

That last line tells our Rails server to simply route all requests to our Hyperloop Component so we can deal with them there. We will discuss SPA (single page application) routing later.

### The AppRouter Component

The first Component we launch is the Router. It's job is to read the incomming route and launch the appropriate Component. Simple as that! We have SPA using React Router to route incoming requests in just a few lines of Ruby code.

```ruby
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

As you can see from the code above, there are just two routes in this application. `/` which will render a Component called `Home` and `/members` which will render a Component called `Members`. As our routing needs in this application are so simple we will not go into routing further, but you can learn more about this Hyper Router here: https://github.com/ruby-hyperloop/hyper-router

### The Home Component

The Home Component generates the main user interface for this application. We will spend a little time going through this line by line as there might be several new concepts here.

> Note on coding style: There are two coding conventions used here which are purely a matter of coding style. You will notice that the HTML elements (`DIV`) are in caps which would normally indicate a constant. We are using caps simply as we believe it makes the code easier to read. If you do not like this then `div` will work just as well. Secondly (and perhaps more controversially) you will notice the misuse of `{ }` curly braces extending over more than one line whereas the Ruby norm is to use `do end` blocks if the block extends over more than one line and `{ }` if it just one line. Personally, I like curley braces for Component and HTML element blocks and `do end` for conditional or looping logic. I find this easier to read and work with, but if it hurts your eyes you can simply use `do end` instead.

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

Every Hyperloop Component has a `render` macro which is called when the Component is to render. I always like to keep this method near the top of the class so you can quickly see what the Component does.

In this case, the first thing our `Home` Component does is render another Component - `MainAppBar`. That is the key to Component oriented architecture - Components render other Components so your user interface is composed of increasingly smaller contained Components. You will get very used to this pattern.

> Note: You might also notice that 'Home' is not a completely normal Hyperloop Component, as it is derived from `Hyperloop::Router::Component` whereas normal Hyperloop components are classes derived from `Hyperloop::Component`. We are doing this simply because we need to pass information routing down into out `MainAppBar` Component.

### Using JavaScript based React libraries

Lets look at the `render` macro of our MainAppBar Component and then discuss this mysterious `Sem` object.

[Semantic UI React](https://react.semantic-ui.com/) is a React library which we are accessing from within our Ruby code. Semantic UI React is a React based DSL wrapper for the famous Semantic UI style sheet.

There is a quick tutorial on the Hyperloop site which explains how to setup Yarn and Webpacker and import libraries like semantic-ui-react or react-bootstrap(or any React of JavaScript library): http://ruby-hyperloop.io/tutorials/hyperlooprails/webpacker/

`Sem.Menu` is this Component: https://react.semantic-ui.com/collections/menu Lets have a look at the documentation with examples is JSX and write a Ruby version.

For the Menu Component, if we were writing it in JSX it would look like this:

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

There are a few key differences which you need to understand and after that you will find it very easy to translate any JSX example into Ruby.

Firstly, notice that we are accessing the library through an object called `Sem`.

If you are wondering where the `Sem` object came from, there were two things we had to do to get it - we had to have Webpack `require` it for us:

```javascript
// app/javascript/packs/application.js
Sem = require('semantic-ui-react');
```

and then you import it into Hyperloop so you can access it in your Ruby code.

```ruby
# app/hyperloop/shared/imports.rb
class Sem < React::NativeLibrary
  imports 'Sem'
end
```

The other key difference is that we do not use the dot notation in the same way the JSX example does. `Menu.Item` becomes `MenuItem` and so-forth. (TODO Find out why).

Finally notice how the JSX paramaters `inverted color='blue' size='huge'` become a hash `inverted: true, color: :blue, size: :huge` in the Ruby version.

The information in this chapter should equip you with most of what you need to work with any JavaScript or React library. The only things we have not discussed is how to create and pass a React object to another object and how to handle JavaScript callbacks. We will address both these topics later in this tutorial.

## The HeartModal Component

Going back to our `Home` Component code, you will see that we invoke the `HeartModal` Component passing in an empty `Heart` object and a `mode` param.

`HeartModal(heart: Heart.new, mode: :new)`
