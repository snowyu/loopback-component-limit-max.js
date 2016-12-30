# Loopback Component Limit Max

The loopback component limits the max count of find/findOne.

The original default scope settings replace the limit count always.
The new way checks the client limit value, replace only if greater than the max limit.

### Installation

1. Install in you loopback project:

  `npm install --save loopback-component-limit-max`

2. Create a component-config.json file in your server folder (if you don't already have one)

3. Configure options inside `component-config.json`:

  ```json
  {
    "loopback-component-limit-max": {
      "enabled": true
      "limit": 50,
      "models": true
    }
  }
  ```
  - `enabled` *[Boolean]*: whether enable this component. *defaults: true*
  - `limit` *[Integer]*: the max count to limit for all models. *defaults: undefined*
    * the Model.json can control it if not settings.
  - `models` *[Boolean|Array of string]*. *defaults: true*
    * enable the max limit to the models. `true` means all models in the app.models.

### Usage


Just enable it on `component-config.json`.

And set the max limit in the `Model.json`:

```
  "scope": {
    "limit": 50
  },
```

Now the client can limit the count too(<=50).

set `DEBUG=loopback:component:limit:max` env vaiable to show debug info.

## History

### V1.1.0

+ supports scope function in the model config.
