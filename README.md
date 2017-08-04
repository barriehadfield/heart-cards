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
git clone https://github.com/barriehadfield/hearty.git
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
