# Zendesk Coding Challenge 2018

This is my solution to the Zendesk Seach CLI coding challenge. It uses Ruby, as this is currently the language I'm most familiar with.

## Usage

After cloning the repo you can run `bundle install` to install dependencies. You will also need Ruby 2.5.3 installed.

From your project directory run

```
ruby 'bin/perform_search.rb'
```

and follow the prompts.

## Running Tests

To run the test suite you can run this line from the project directory:

```
  ruby test/test_all.rb
```

## Assumptions
- It's unlikely Zendesk is giving out sensitive customer data to candidates, so the `data` folder has been committed.
- We can rely on the user to specify the type of resource and the specific field they're looking for.
- We don't need to return all the data of the associated resources, just enough to get a feel for what we're looking at.

