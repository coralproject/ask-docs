# Introduction

Stats is a command line tool to run on the Coral database. Right now we calculate different numbers in this app. For more complex statistics we are using Atoll.


# Install it

# Run it

To look at the options:

```
stats -h
```

You have to have a collection named 'users' in your mongo database. If coral is the name of the database you can run the stats with:

```
./stats --mongodb-database=coral
```

# Accumulators

## Users

It creates a user_statistics collection with a document per user.

- statistics
  - actions
    - performed
      - likes
      - all
      - ratios
    - received
      - likes
      - all
      - ratios
  - comments
    - author
    - section
    - assets
      - untouched
        - count
        - replied_count
        - replied_ratio
        - reply_count
        - reply_ratio
        - first
        - last
        - word_count_average
      - all
        - count
        - replied_count
        - replied_ratio
        - reply_count
        - reply_ratio
        - first
        - last
        - word_count_average
      - ratios
    - all


# Wishlist

This list is coming from the conversation with @frontend and journalists and publishers.

## Asset
    - headline for every asset
    - stats
          - how many comments it has
          - what comments are in that asset
          - list of users on that asset
    - use case
          - list of top stories today
          - leaderboard
          - display info assets
          - most comments
          - most replies

## Section
    - average on comments on assets
    - by authors
