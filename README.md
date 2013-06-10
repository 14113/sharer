# Sharer [![Build Status](https://secure.travis-ci.org/14113/sharer.png?branch=master)](http://travis-ci.org/14113/sharer)

If your application needs to count the number of shared, this gem can help you.

## Install

Add to your Gemfile and run the `bundle` command to install it.

```ruby
gem "sharer"
```
## Source

Sharer's Git repo is available on GitHub, which can be browsed at:

```ruby
http://github.com/14113/sharer
```

and cloned with:

```ruby
git clone git://github.com/14113/sharer.git
```

## Usage

Call Sharer in an Model and pass the url of the website.

```ruby
site = Sharer::Site.new("google.com")
number_of_likes = site.facebook_likes
number_of_shares = site.facebook_shares
number_of_tweets_buttons = site.twitter_button
number_of_linkedin_shares = site.linked_in_share

# or all together by threads
hash = site.find_all
```

This will find count of shareing in facebook, twitter abd linkedin.


This gem is created by Adam Martinik and is under the MIT License.