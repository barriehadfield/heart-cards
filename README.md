# Heart Cards

## HEART

The Heat Cards application provides tracks and manages the Google inspired HEART process.

HEART stands for Happiness, Engagement, Adoption, Retention and Task Success. Traditional product analytics is usually metrics focused, and the function normally depends on gathering as much quantity of data as possible on net promoter scores, cost of acquisition, conversion rates, retention rates and so on.

HEART takes a more holistic approach and recognizes the need to gather quantitive as well as qualitative feedback when assessing the success of a software initiative.

You can read more about HEART here: https://www.interaction-design.org/literature/article/google-s-heart-framework-for-measuring-ux

If you are on a journey of continuous improvement, HEART can help you stay true to a build-measure-learn software development lifecycle and can unite designers, developers, product managers and testers.


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

> Note: This tutorial uses Postrges SQL so that it is deployable to Heroku. If you do not want to use Postgres then you will need to swap it our for MYSQL, but please do not use SQLITE as it is not capable of providing the concurrency Hyperloop requires. There are detailed Postgres installation instructions here: https://wiki.postgresql.org/wiki/Detailed_installation_guides

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

The first Component we launch is the router. It's job is to read the incomming route and launch the appropriate Component. Simple as that!  

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
