# Working With GitHub

This section explains how the community can contribute code to the Coral Project via pull requests.

For a general primer on contributing to open source projects, GitHub has created [a nice guide to contributing to open source](https://guides.github.com/activities/contributing-to-open-source/).

The fundamentals (which are expanded on below) are:

* Fork the project & clone locally.
* Create an upstream remote and sync your local copy before you branch.
* Branch for each separate piece of work.
* Do the work, and write good commit messages.
* Push to your origin repository.
* Create a new PR in GitHub.
* Respond to any code review feedback.

## Installing Git

First, [download and install Git](https://git-scm.com/download). You can read more about Git on [their website](https://git-scm.com/).

After installing Git, the first thing you should do is setup your name and email:

    $ git config --global user.name "Your Real Name"
    $ git config --global user.email "you@email.com"
    
Note that user.name should be your real name, not your GitHub username. The email you use in the user.email field will be used to associate your commits with your GitHub account.

## Setting up local repository

First, you need to fork the project: navigate to to the repo in GitHub you want to contribute to and press the "Fork" button. This will create a copy of the repository in your own GitHub account and you'll see a note that it's been forked underneath the project name.

Now create a local copy of that fork (in this example, the "docs" repository is the one being cloned):

    git clone git@github.com:your_github_username/docs.git

This will create a new directory "docs", containing a clone of your forked GitHub repository. Switch to the project's new directory:

    cd docs
    
You will now need to setup coralproject/docs as an "upstream" remote. This connects your local repository to the original "upstream" source repository (essentially, telling Git that the original reference repository is the source of your local forked copy). 

    git remote add upstream git@github.com:coralproject/docs.git
    git fetch upstream
    
It's a good idea to regularly pull in changes from "upstream" so that when you submit your pull request, merge conflicts will be less likely. You can find more detailed instructions on [syncing a fork from GitHub](https://help.github.com/articles/syncing-a-fork/).    

## Work on an issue

When working on an issue, create a new branch for the work. Name the branch for the issue you are working on, capitalizing the word "Issue" (for example, "Issue#82").

    $ git checkout master
    $ git pull upstream master && git push origin master
    $ git checkout -b Issue#82
    
What this does: First, we ensure we're on the master branch. Then, the git pull command will sync our local copy with the upstream project and the git push syncs it to our forked GitHub project. Finally, we create our new branch.

Now you can do the work! Ensure that you only fix the thing you're working on. Do not be tempted to fix other things that you see along the way.

## Committing

When committing, be sure to commit in logical blocks and add meaningful commit messages. 

    git commit -m 'Added instructions for commit messages'
    
Some guidelines to follow:

* Never force-push your changes.
* Write your commit messages in the past tense, not present tense.
    * Good: "Added instructions for commit messages"
    * Bad: "Add instructions for commit messages"
* For commits to a branch, prefix the commit message with the branch name. For example: “[1.4.x] Fixed #xxxxx – Added instructions for commit messages.”

## Create the pull request

To create a PR you first need to push your branch to the origin remote.

To push a new branch:

    git push origin readme-update

When you go to your GitHub page, you will notice that a new branch has been created, along with a button that says "Compare and Pull Request." When you feel ready to create a pull request, go ahead and push the button.

On the "Open a pull request" page, ensure that the "base fork" points to the correct repository and branch. Then ensure that you provide a good, succinct title for your pull request and explain why you have created it in the description box. Add any relevant issue numbers if you have them.

Scroll down to see the diff of your changes. Double check that it contains what you expect.

Once you are happy, press the "Create pull request" button. 

## Review by the maintainers

Once you've created your pull request, recruit a code reviewer to take a look.

The reviewer will review and potentially offer suggestions. If that happens, make the suggested changes, commit, and push your changes. You may go through several cycles of reviews, changes, and updates.

Once both of you agree that the code is done, it's time to merge!

## Merging

The code reviewer will merge the pull request. If conflicts emerge, XXX.

TODO: Add information about tagging.

Once the merge is complete, the branch can be deleted.

## Exceptions

* Updates to documentation may be merged directly into master (instead of going through a branch).
* Small bugs or tweaks caught by the maintainer post-merge may be merged directly into master.
 * These commits should include the issue number in the commit message for reference.

