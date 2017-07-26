# YACC (Yet Another Chocolatey Cookbook)

Manages chocolatey packages through attributes.

## Requirements

### Depends

- [chocolatey](https://supermarket.chef.io/cookbooks/chocolatey) ~> 1.2.0

### Platforms

- Windows

### Chef

- Chef 12.0 or later

## Attributes

Set the chocolatey default sources: 

Default: 
```json
{
  "chocolatey": {
    "source": "https://chocolatey.org/api/v2/",
    "action": "present",
    "priority": 0
  }
}
```

Example:

```json
{
  "yacc" : {
    "default_sources" : {
      "private": {
        "source": "https://repo.private.com/api/v2/",
        "action": "present",
        "user": "some_user",
        "password": "some_password",
        "priority": 1
      },
      "private2": {
        "source": "https://repo2.private.com/api/v2/",
        "action": "disabled",
        "priority": 99
      },
      "private3": {
        "source": "https://repo3.private.com/api/v2/",
        "action": "absent",
        "priority": 100
      },
      "chocolatey": {
        "source": "https://chocolatey.org/api/v2/",
        "action": "present",
        "priority": 0
      }
    }
  }
}
```


Set config options(Default: `{}`):

Valid actions: `set|unset`

Example:

```json
{
  "yacc" : {
    "config" : {
      "cacheLocation": {
        "action": "set",
        "value": "C:\\tmp"
      }
    }
  }
}
```


Determine if failures should be ignored(Default: `false`):

```json
{
  "yacc" : {
    "ignore_failure" : true
  }
}
```

Global install options that will be run with each choco install (Default: `{}`)

```json
{
  "yacc" : {
    "install_options" : [
      "--cachelocation C:\\tmp"
    ]
  }
}
```

Define packages:

```json
{
  "yacc" : {
    "packages" : {
      "googlechrome": {
        "action": "56.0.2924.76",
        "install_options": [
          "--ignorechecksum",
          "--allow-downgrade"
        ]
      },
      "firefox": {
        "action": "upgrade"
      },
      "chocolateygui": {
        "action": "purge"
      }
    }
  }
}
```

The `action` field follows the same actions as [this documentation](https://docs.chef.io/resource_chocolatey_package.html), it also can take a version number.

## Usage

### yacc::default

Just include `yacc` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[yacc]"
  ]
}
```

