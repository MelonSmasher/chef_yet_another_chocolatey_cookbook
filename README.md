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

Set the chocolatey source: (Default: `https://chocolatey.org/api/v2`)

```json
{
  "yacc" : {
    "source" : "https://chocolatey.org/api/v2"
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

Global install options that will be run with each choco install (Default: `[]`)

```json
{
  "yacc" : {
    "install_options" : [
      "--cachelocation C:\\temp"
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
          "--ignorechecksum"
         ]
      },
      "firefox": {
        "action": "upgrade",
        "source": "https://private.repo.com/api/v2",
        "install_options": [
          "--ignorechecksum",
          "--cachelocation C:\\windows\\temp"
        ]
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

