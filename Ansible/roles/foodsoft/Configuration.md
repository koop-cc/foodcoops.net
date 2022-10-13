Foodsoft Configuration
======================
- [Foodsoft Configuration](#foodsoft-configuration)
- [Foodsoft settings](#foodsoft-settings)
- [Language settings](#language-settings)
- [Order settings](#order-settings)
- [Email settings](#email-settings)
- [Misc settings](#misc-settings)

By default we use a single configuration file for all Foodsoft instances at [app.foodcoops.net](https://app.foodcoops.net).

However it is possible to enable custom settings for your instance. Most of the following settings are available at the Foodsoft settings page (*Administration --> Configuration*). If you want us to set an option only for your Foodsoft instance please send us an [email](mailto:support@lists.foodcoops.net).

Have a look at the sample settings [file](https://github.com/foodcoops/foodsoft/blob/master/config/app_config.yml.SAMPLE) for more details about each setting.

# Foodsoft settings

| Setting | Value | Description |
|---------|-------|-------------|
| `contact` | string | Multiple settings for contact details |
| `foodsoft_url` | string | Custom foodsoft software URL (used in footer )
| `help_url` | string | URL of your help pages |
| `homepage` | string | URL of your website |
| `logout_redirect_url` | string | URL of a website to redirect after a logout |
| `name` | string | Name of your Foodcoop |
| `page_footer` | string | Add a custom footer to your Foodsoft |

# Language settings

| Setting | Value | Description |
|---------|-------|-------------|
| `currency_space` | bol | Insert white space after currency |
| `currency_unit` | string | Currency symbol |
| `default_locale` | string | Default language |
| `ignore_browser_locale` | bol | Ignore browser language |
| `time_zone` | string | Default time zone |

# Order settings

| Setting | Value | Description |
|---------|-------|-------------|
| `applepear_url` | string | URL of apple point help page |
| `minimum_balance` | int | Lower apple point limit for ordergroups to place an order |
| `order_schedule` | string | Multiple settings for order schedule |
| `price_markup` | float | Price markup in percent |
| `stop_ordering_under` | integer | Lower limit for ordergroups to make new orders |
| `tax_default` | float | Default vat for articles |
| `tolerance_is_costly` | bol | Tolerance order option |
| `use_apple_points` | bol | Apple point system for ordergroups |

# Email settings

| Setting | Value | Description |
|---------|-------|-------------|
| `email_sender` | string | Email address to be used as sender |
  `mailing_list` | string | Email address if your foodcoop uses a mailing list instead of internal messaging system |
| `mailing_list_subscribe` | int | Suscribe address for your mailing list |
| `notification` | int | Multiple settings to receive error and feedback messages |
| `reply_email_domain`| string | Domain to be used for reply emails |

# Misc settings
| Setting | Value | Description |
|---------|-------|-------------|
| `custom_css` | string | Add custom css code |
| `custom_fields` | string | Multiple settings to add custom fileds to invoice, rodergroup, supplier and user |
| `pdf_add_page_breaks` | bol | Multiple settings to insert page breaks to PDF output |
| `pdf_font_size` | int | PDF font size |
| `pdf_page_size` | string | PDF page size |
| `tasks_period_days` | int | How many days there are between two periodic tasks |
| `tasks_upfront_days` | int | How many days upfront periodic tasks are created |
| `use_messages` | bol | Enable internal message system |
| `use_nick` | bol | Login with and display nick names |
| `use_wiki` | bol | Enable Wiki |
| `webstats_tracking_code` | string | Your Matomo tracking code |
