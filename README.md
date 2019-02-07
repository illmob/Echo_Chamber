# Echo_Chamber
Twitter relationship noise management application.

Correlates relationships between a Twitter user and their connections. 
Creates a blocklist which can be imported into your twitter account 
Useful for amplifying polarisation and drowning out the noisiness.

### Installation:
```
gem install ocra
ocra Echo_Chamber.rb --gem-all --console --add-all-core
```

### APP Usage:
```
Echo_Chamber [options]
    -s, --search SEARCHTYPE          Types: ["following","followers","all"]
    -t, --target PERSONALITY         Target twitter personality to produce list from
    -o, --output FILENAME            The filename which to store the generated CSV list
    -p, --password PASSWORD          Your twitter password for Authentication
    -u, --username USERNAME          Your twitter username for Authentication
```

### CMD Example:
```
RUBY
  C:\ruby Echo_Chamber.rb -s following -t someuser -o someuser.csv -p 'toughpassword' -u 'easyusername'
  C:\ruby Echo_Chamber.rb -s followers -t someuser -o someuser.csv -p 'toughpassword' -u 'easyusername'
  C:\ruby Echo_Chamber.rb -s all -t someuser -o someuser.csv -p 'toughpassword' -u 'easyusername'
EXE
  C:\Echo_Chamber.exe -s following -t someuser -o someuser.csv -p 'toughpassword' -u 'easyusername'
  C:\Echo_Chamber.exe -s followers -t someuser -o someuser.csv -p 'toughpassword' -u 'easyusername'
  C:\Echo_Chamber.exe -s all -t someuser -o someuser.csv -p 'toughpassword' -u 'easyusername'
```

### Example on Windows:
Download [Echo_Chamber.exe](https://github.com/illmob/Echo_Chamber/blob/master/bin/win/Echo_Chamber.exe)  , open command prompt , cd to the download directory, and run with the parameters in the example.
```
Echo_Chamber.exe -s followers -t SJWlibtard -o soyboys.csv -p CorrectHorseBattery -u TwitterAdmin
```
![Image of Example](https://i.imgur.com/mNfLjPK.png)

### Import Blocklist
Go to https://twitter.com/settings/blocked Click Advanced Options/Import a list/Attach a file to upload/ and navigate to the output folder of your .csv
![Image of ImportDropdown](https://i.imgur.com/iNSmWJI.png)
![Image of ImportBox](https://i.imgur.com/9eUEX1T.png)

Enjoy a drama-free Twitter.
