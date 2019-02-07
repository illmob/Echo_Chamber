# Echo Chamber
Twitter relationship noise management application.

Correlates relationships between a Twitter user and their connections. 
Creates a blocklist.csv to import into your account to help amplify polarisation and drown out the noise.

```
Usage: echo_chamber [options]
    -s, --search SEARCHTYPE          Types: ["following","followers","all"]
    -t, --target PERSONALITY         Target twitter personality to produce list from
    -o, --output FILENAME            The filename which to store the generated CSV list
    -p, --password PASSWORD          Your twitter password for Authentication
    -u, --username USERNAME          Your twitter username for Authentication
```


### Installation:
```
gem install ocra
ocra echo_chamber.rb --gem-all --console --add-all-core
```
