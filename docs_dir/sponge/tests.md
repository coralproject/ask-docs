# Running tests

You can run tests in the `pkg` folder.

If you plan to run tests in parallel please use this command:

```
go test -cpu 1 ./...
```

You can alway run individual tests in each package using just:

```
go test
```

Do not run tests in the vendor folder.
