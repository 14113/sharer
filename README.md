# Sharer

If your application needs to count the number of shared, this gem can help you.

## Install

Add to your Gemfile and run the `bundle` command to install it.

```ruby
gem "sharer"
```
## Source

Sharer's Git repo is available on GitHub, which can be browsed at:

http://github.com/14113/Sharer

and cloned with:

git clone git://github.com/14113/sharer.git
	
	
## Usage

Call Sharer in an Model and pass the url of the website.

```ruby
result = Sharer.find("google.com")
```

This will find count of shareing in facebook, twitter abd linkedin.


This gem is created by Adam Martinik and is under the MIT License.