# SpreeSslWirelessGateway

Introduction goes here.

## Installation

1. Add this extension to your Gemfile with this line:

    ```ruby
    gem 'spree_ssl_wireless_gateway', github: 'rubyrider/spree_ssl_wireless_gateway'
    ```

2. Install the gem using Bundler

    ```ruby
    bundle install
    ```

3. Copy & run migrations

    ```ruby
    bundle exec rails g spree_ssl_wireless_gateway:install
    ```

4. Restart your server

  If your server was running, restart it so that it can find the assets properly.


## Testing

Sandbox Environment

All the transaction made using this environment are counted as test transaction and has no effect with accounting, URL starts with https://sandbox.sslcommerz.com.

Test Credit Card Account Numbers

VISA:

Card Number: 4111111111111111
Exp: 12/25
CVV: 111
Mastercard:

Card Number: 5111111111111111
Exp: 12/25
CVV: 111
American Express:

Card Number: 371111111111111
Exp: 12/25
CVV: 111
Mobile OTP: 111111 or 123456

```shell
bundle
bundle exec rake
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_ssl_wireless_gateway/factories'
```

## Contributing

If you'd like to contribute, please take a look at the
[instructions](CONTRIBUTING.md) for installing dependencies and crafting a good
pull request.

Copyright (c) 2021 Irfan Ahmed, released under the New BSD License
