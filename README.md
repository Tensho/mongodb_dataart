# DataArt MongoDB Course
Database: DBS01 MongoDB

## Delivery

---
### The main difficulties encountered during the course

* Data model: make choice between [embedded](http://docs.mongodb.org/manual/core/data-model-design/#embedded-data-models) and [normalized](http://docs.mongodb.org/manual/core/data-model-design/#normalized-data-models).
* Import: users need external links to themselves (wish users). Populator makes a query to all documents in users collection for each new user to in order to achieve maximum randomness. This process takes a long time and the only way to optimize it -- reduce the entropy for wish users.
* Aggregate pipline: exceed memory limit for pipeline stages and cure it with [allowDiskUse](http://docs.mongodb.org/manual/core/aggregation-pipeline-limits/#agg-memory-restrictions) option.
* Compound Index: [sort order](http://docs.mongodb.org/manual/core/index-compound/#index-ascending-and-descending) and [prefixes](http://docs.mongodb.org/manual/core/index-compound/#compound-index-prefix).
* Not all queries fit 1 sec, cause can not apply index for the first stage of aggregate pipeline.

### Database backup

GitHub warns you when you try to add a file larger than 50 MB. GitHub rejects pushes containing files larger than 100 MB.

[pm.tar.gz](https://www.dropbox.com/s/jixuj8ham2wfxiz/pm.tar.gz?dl=0)

### Test data generator
Prerequisites: ruby >= 2.0.0, bundler

Run: `bundle install && ruby populate.rb`

Used dependencies:

* [mongoid](https://github.com/mongoid/mongoid) - Ruby ODM framework for MongoDB
* [faker](https://github.com/stympy/faker) - Ruby fake data generator

### List of required requests and the rationale for each index on created collections
`queries`
