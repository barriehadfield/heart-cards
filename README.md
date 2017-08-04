# Heart Cards

## HEART

The Heat Cards application provides tracks and manages the Google inspired HEART process.

HEART stands for Happiness, Engagement, Adoption, Retention and Task Success. Traditional product analytics is usually metrics focused, and the function normally depends on gathering as much quantity of data as possible on net promoter scores, cost of acquisition, conversion rates, retention rates and so on.

HEART takes a more holistic approach and recognizes the need to gather quantitive as well as qualitative feedback when assessing the success of a software initiative.

You can read more about HEART here: https://www.interaction-design.org/literature/article/google-s-heart-framework-for-measuring-ux

If you are on a journey of continuous improvement, HEART can help you stay true to a build-measure-learn software development lifecycle and can unite designers, developers, product managers and testers.


## Technology

This Isomorphic application is a showcase for Hyperloop's COMPS architecture, all written in beautiful Ruby. The goal of publishing this application is to show how all these technology work together in a live application.

+ Hyperloop Isomorphic Components, Opertions, Models, Policies and Stores (COMPS for short)
+ Rails 5.1 with ActionCable, Yarn and Webpacker
+ Devise for authentication
+ React for the interactive UI (used by Hyperloop)
+ Semantic UI for the stylesheet
+ The amazing React-Semantic-UI for integrating React and Semantic UI

## Setup

You will need to install Ruby, Rails and Postgres SQL first.

```
git clone https://github.com/barriehadfield/heart-cards.git
cd heart-cards
bundle
gem install foreman
rake db:create
rake db:migrate
yarn
bin/webpack
```

Start the server:

`foreman start`

Navigate to

`http://localhost:5000/`

And you should be rewarded with a running application.

## Code

### Where are the Controllers and Views?

There are none, we have replaced all of these parts of thr Rails stack with Isomorphic Hyperloop code. If you have a look at `routes.rb` you will see that we have an automagical route `root 'hyperloop#AppRouter'` which Hyperloop uses to render our root Component `AppRouter`.

This is not the only way to work with Hyperloop, and we could have had a traditional Controller and View and launched the root Hyperloop Component either from the Controller or from within a View, but for now we just don't need all that.

While we are looking at `routes.rb` pay attention to this line at the end of the file (it's important that it remains at the end of the file as this is our catch all route) `match '*all', to: 'hyperloop#AppRouter', via: [:get]`

That last line tells our Rails server to simply route all requests to our Hyperloop Component so we can deal with them there. We will discuss SPA (single page application) routing later.
