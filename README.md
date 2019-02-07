# Echo_Chamber
Twitter relationship noise management application.

Correlates relationships between a Twitter user and their connections. 
Creates a blocklist which can be imported into your twitter account 
Useful towards amplifying polarisation and drown out the noisiness.

### Installation:
```
gem install ocra
ocra Echo_Chamber.rb --gem-all --console --add-all-core
```
### Usage:
```
Echo_Chamber [options]
    -s, --search SEARCHTYPE          Types: ["following","followers","all"]
    -t, --target PERSONALITY         Target twitter personality to produce list from
    -o, --output FILENAME            The filename which to store the generated CSV list
    -p, --password PASSWORD          Your twitter password for Authentication
    -u, --username USERNAME          Your twitter username for Authentication
```
### Example on Windows:
```
Echo_Chamber.exe -s followers -target SJWlibtard -o soyboys.csv -p CorrectHorseBatteryStaple -u TwitterAdmin
```
![Image of Example](https://i.imgur.com/mNfLjPK.png)

### Import Blocklist
Go to https://twitter.com/settings/blocked Click Advanced Options/Import a list/Attach a file to upload/ and navigate to the output folder of your .csv
![Image of ImportDropdown](https://i.imgur.com/iNSmWJI.png)
![Image of ImportBox](https://i.imgur.com/9eUEX1T.png)

Enjoy a drama-free Twitter.
