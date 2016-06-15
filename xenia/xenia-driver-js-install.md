# Xenia Driver Installation

```
$ npm install --save xenia-driver
```

## Import and use

```
import XeniaDriver from 'xenia-driver'

// Configure your instance
const xenia = XeniaDriver(baseUrl, {username: 'user', password: 'pass'})

// Use the driver
xenia()
  .match({ 'category': 'sports' })
  .include(['comments', 'name'])
  .limit(14)
  .skip(8)
.join('my_collection')
.exec().then(data => console.log(data.results))
```
