#### Development

We welcome community contribution. If you're thinking about making more than a minor change, check in with the Coral team via Github issues to avoid unnecessary work for both parties.

Sequester all work in pull requests

  1. create a new branch with `git checkout -b your-fancy-branch-name`
  2. make a trivial change, and commit back to your branch with `git add ./your-changed-file.js` and `git commit -m "a commit message here"`
  3. push your changes to github with `git push origin your-fancy-branch-name`
  4. on github.com, you should see a button to create a pull request from your new branch
  5. There will be public code reviews before we merge any PRs into master
  6. Add tests for it

We will not accept commits or pushes to the `master` branch, as the latest version of master is automatically deployed. Any direct push to master will be reverted.
