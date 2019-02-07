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

### Output:
```
type example_output.txt

949919900469952512
77810175
860829795780775936
15684556
127038322
1081707861863026688
89466371
1666562078
987065018
2428712008
903253371041316865
1193238781
63619129
870465760459718657
940588450524418048
821463887681875969

```
