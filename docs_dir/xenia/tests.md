## Running Tests

You can run tests in the `app` and `pkg` folder.

If you plan to run tests in parallel, use this command:

```
go test -cpu 1 ./...
```

You can always run individual tests in each package using simply:

```
go test
```

Do not run tests in the vendor folder.
