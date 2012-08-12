# CrisplyConnector

A wrapper for the [crisply](http://crisply.com) api that will post
selected activity to a given users account.

## Connect to Github

You can use this to connect your account to github, via the webhooks
functionality (under admin in your repository). Do so by pointing the
webhook at this url: `http://serene-gorge-4899.herokuapp.com/github`

### Using your Crisply timesheet

The url will take the apikey and subdomain in the url.

E.g. `http://serene-gorge-4899.herokuapp.com/github?apikey=SECRET&subdomain=BESTCO`

### Authorship

The expectation is that the name of the committer matches the name of
one of your users. The time will then be allocated to that user.

## Connect to Pivotal Tracker

You can use this to connect to your projects in Pivotal Tracker, again
via webhooks found under Project->Edit Project Settings->Integrations

This time the url is `http://serene-gorge-4899.herokuapp.com/pivotal`

### Using your Crisply timesheet

Again, the url will take the apikey and subdomain in the url.

E.g. `http://serene-gorge-4899.herokuapp.com/pivotal?apikey=SECRET&subdomain=BESTCO`

### Authorship

The expectation is that the name of the user in Pivotal Tracker
matches the name of one of your users in Crisply. The time will then
be allocated to that user.
