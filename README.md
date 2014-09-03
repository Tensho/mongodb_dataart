# DataArt MongoDB Course
Database: DBS01 MongoDB

## Delivery

---
### The main difficulties encountered during the course

1. Rather slow import. I think the problem is in references generating part (for example, User.all.sample). Does butch insert make import faster?

### Database backup
`pm`

### Test data generator
Prerequisites: ruby >= 2.0.0, bundler

Run: `bundle install && ruby populate.rb`

Used dependencies:

* [mongoid](https://github.com/mongoid/mongoid) - Ruby ODM framework for MongoDB
* [faker](https://github.com/stympy/faker) - Ruby fake data generator

### List of required requests and the rationale for each index on created collections
`queries.js`

[Archive](http://phabricator.dataart.net)
