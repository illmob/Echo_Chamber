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
    -w, --whitelist SEARCHTYPE       Types: ["following","followers","all"]
    -e, --epoch SEARCHTYPE           Types: ["following","followers","all"]
    -v, --verbose BOOLEAN            Types: ["true","false"]
    -s, --search SEARCHTYPE          Types: ["following","followers","all"]
    -t, --target PERSONALITY         Target twitter personality to produce list from
    -o, --output FILENAME            The filename which to store the generated CSV list
    -p, --password PASSWORD          Your twitter password for Authentication
    -d, --debug BOOLEAN              Types: ["true","false"]
    -u, --username USERNAME          Your twitter username for Authentication
```
### Adv. Usage:

Echo_Chamber can be used to generate whitelist of your own followers/following/all to better aid in the prevention of blocked accounts.
This should be used to diff between the blocklist generated from Echo_Chamber. You can use GNU diff or any other method you prefer.

Can be used to identify cohersion between following and followers of the authenticated account by targeting ones own twitter ID. 
This can help identify users who you may want to block or permit. This can as well be useful to see where your post might 
be consumed first (time line impressions) for rapid retweets. This can be done using the -t switch and your own identity.

Epoch feature can be used to identify links between the authenticated account and a target personality. Using the 'all' argument will
ensure that both the following and followers of both personalites will be queries and examined.

Additionally the -v --verbose switch can be assigned with a boolean value to produce additional files with detailed user information
such as: userid, username, usernick, userbio, and useravatar

### CMD Example:
```
RUBY
  C:\ruby Echo_Chamber.rb -s following -t someuser -o someuser.csv -p 'toughpassword' -u 'easyusername'
  C:\ruby Echo_Chamber.rb -s followers -t someuser -o someuser.csv -p 'toughpassword' -u 'easyusername'
  C:\ruby Echo_Chamber.rb -s all -t someuser -o someuser.csv -p 'toughpassword' -u 'easyusername'
  C:\ruby Echo_Chamber.rb -w all -p 'toughpassword' -u 'easyusername' -o whitelisted_names.csv
  C:\ruby Echo_Chamber.rb -e all -t someuser -p 'toughpassword' -u 'easyusername' -v true -o epoch_names.csv
  C:\ruby Echo_Chamber.rb -e all -t someuser -p 'toughpassword' -u 'easyusername' -v true -o epoch_names.csv -d true
EXE
  C:\Echo_Chamber.exe -s following -t someuser -o someuser.csv -p 'toughpassword' -u 'easyusername'
  C:\Echo_Chamber.exe -s followers -t someuser -o someuser.csv -p 'toughpassword' -u 'easyusername'
  C:\Echo_Chamber.exe -s all -t someuser -o someuser.csv -p 'toughpassword' -u 'easyusername'
  C:\Echo_Chamber.exe -w all -p 'toughpassword' -u 'easyusername' -o whitelisted_names.csv
  C:\Echo_Chamber.exe -e all -t someuser -p 'toughpassword' -u 'easyusername' -v true -o epoch_names.csv
  C:\Echo_Chamber.exe -e all -t someuser -p 'toughpassword' -u 'easyusername' -v true -o epoch_names.csv -d true
```

### Example on Windows:
Download [Echo_Chamber.exe](https://github.com/illmob/Echo_Chamber/blob/master/bin/win/Echo_Chamber.exe)  , open command prompt , cd to
the download directory, and run with the parameters in the example.
```
Echo_Chamber.exe -s followers -t SJWlibtard -o soyboys.csv -p CorrectHorseBattery -u TwitterAdmin
```
![Image of Example](https://i.imgur.com/mNfLjPK.png)

### Import Blocklist
Go to https://twitter.com/settings/blocked Click Advanced Options/Import a list/Attach a file to upload/ and navigate to the output
folder of your .csv
![Image of ImportDropdown](https://i.imgur.com/iNSmWJI.png)
![Image of ImportBox](https://i.imgur.com/9eUEX1T.png)

Enjoy a drama-free Twitter.
