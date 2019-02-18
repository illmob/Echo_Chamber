########################################################################################################################
#
# Release by: illmob 'https://www.illmob.org/CoC/'
#
# [ SHOUTZ ]
#   *.EVERYONE in illmob, you know who you are ~
#
# [ README ]
#   Users will be required to configure the application for proper use
#   This is developed for Windows and Firefox
#   This does require authentication to the twitter platform
#   Your credential pairs are not stored/saved local or remote
#   No information is sent to developers of its use
#   This script assumes the following:
#    * The Operating System is a modern Windows implementation
#    * The OS User has enough permissions to install applications
#       ? User has installed a modern release of Ruby
#       ? User has installed a modern release of Firefox
#   This script does require the use of external gems (Required)
#    * 'selenium-webdriver'
#    * 'optparse'
#    * 'ostruct'
#
# [ HOWTO ]
#   This script can be compiled on the system to produce a binary, this is outside the scope of this tutorial
#
# [ NOTEZ ]
#   Developer is not responsible for others ignorance or arrogance
#
#[Class] ######################################] TwitterAuth [##########################################################
class TwitterAuth  # class start TwitterAuth
  puts "[Class]:: Entering TwitterAuth"
  # authenticate to Twitter web interface from FF browser
  def self.twitter_login_selenium(session, username, password)  # start function twitter_login_selenium
    puts "\t[Function]:: Entering twitter_login_selenium"
    # Auth through headless FF with credential pair
    begin  # Catch/Rescue block start
      if $diag# if diag true, display error
        puts "\t\t[Variable]:: TwitterAuth::twitter_login_selenium::username #{username}"
        puts "\t\t[Variable]:: TwitterAuth::twitter_login_selenium::password #{password}"
      end  # end if block
      puts "\t[Function]:: Get auth page from twitter"
      session.get("https://twitter.com/login")  # actual login page for twitter
      sleep(1)  # take a nap
      username_field = session.find_element(:css,'.js-username-field')  # find username element
      puts "\t[Function]:: Find username field"
      username_field.send_keys(username)  # assign username to the form field
      puts "\t[Function]:: Send username to filed" 
      password_field = session.find_element(:css, '.js-password-field')  # find password element
      puts "\t[Function]:: Find password field"
      password_field.send_keys(password)  # assign password to the form field
      puts "\t[Function]:: Send password to field"
      session.find_element(:css, "button.submit").click#, :return)  # send synthetic mouse click on button
    rescue => tautherror  # Catch error to var
      # if diag true, display error
      puts "\t\t[ERROR]:: TwitterAuth::twitter_login_selenium fault: #{tautherror}"
    end  # Catch/Rescue block end
    begin  # Catch/Rescue block start
      $username = ""  # clear username
      username = ""  # clear username
      # if diag true, display error
      puts "\t\t[Variable]:: Global TwitterAuth::twitter_login_selenium::$username #{$username}" if $diag
      puts "\t\t[Variable]:: Local TwitterAuth::twitter_login_selenium::username #{username}" if $diag
      $password = ""  # clear password
      password = ""  # clear password
      # if diag true, display error
      puts "\t\t[Variable]:: Global TwitterAuth::twitter_login_selenium::$password #{$password}" if $diag
      puts "\t\t[Variable]:: Local TwitterAuth::twitter_login_selenium::password #{password}" if $diag
    rescue => clearcredserror  # Catch error to var
      # if diag true, display error
      puts "\t\t[ERROR]:: TwitterAuth::twitter_login_selenium creds fault: #{clearcredserror}" if $diag
    end  # Catch/Rescue block end
    return session  # return session information
  end  # close function twitter_login_selenium
  def self.twitter_userinfo(session, targetuser)  # start function twitter_userinfo
    puts "\t[Function]:: Entering twitter_userinfo"
    begin  # Catch/Rescue block start
      puts "\t[Function]:: Request target users page"  # gather target user info from browser session
      session.get("https://twitter.com/#{targetuser}")  # request page from browser
      return session.page_source  # return resulting page source
    rescue => tuserinfo  # Catch error to var
      puts "\t\t[ERROR]:: TwitterAuth::twitter_userinfo fault: #{tuserinfo}" if $diag # if diag true, display error
    end  # Catch/Rescue block end
    puts "\t[Function]:: Exiting twitter_userinfo" 
  end  # close function twitter_user_followers_selenium
  def self.twitter_get_selfinfo(session)
    puts "\t[Function]:: Entering twitter_get_selfinfo" 
    begin  # Catch/Rescue block start
      element = session.find_element(
          xpath: '//*[@id="page-container"]/div[1]/div[1]/div/div[2]/span/a'
      ).attribute('href')  # find target personalities user ID
      puts "\t[Function]:: Get username for whitelist" 
      return element.split("/")[3]
    rescue => tgetinfoerror  # Catch error to var
      # if diag true, display error
      puts "\t\t[ERROR]:: TwitterAuth::twitter_get_selfinfo fault: #{tgetinfoerror}" if $diag
    end  # Catch/Rescue block end
    puts "\t[Function]:: Entering twitter_get_selfinfo"
  end  # close function twitter_get_selfinfo
  def self.twitter_get_userinfo(session, hashfile, targetuser, search_type) # start function twitter_get_userinfo
    puts "\t[Function]:: Entering twitter_get_userinfo"
    if $diag  # if diag true, display error
      puts "\t\t[Variable]:: TwitterAuth::twitter_get_userinfo::hashfile #{hashfile.lenght}"
      puts "\t\t[Variable]:: TwitterAuth::twitter_get_userinfo::targetuser #{targetuser}"
      puts "\t\t[Variable]:: TwitterAuth::twitter_get_userinfo::search_type #{search_type}"
    end  # end if block
    begin  # Catch/Rescue block start
      # extract details from followers
      element = session.find_element(
          xpath: '//*[@id="page-container"]/div[1]/div/div[1]/div[1]/img'
      ).attribute('src')  # find target personalities user ID
      puts "\t[Function]:: Get userid from profile"
      hashfile[targetuser][search_type].store(
          element.split("/")[-3], ""
      )  # write target user to the hashfile
      # if diag true, display error
      puts "\t\t[Variable]:: TwitterAuth::twitter_login_selenium::hashfile #{hashfile.lenght}" if $diag
    rescue => tgetinfoerror  # Catch error to var
      # if diag true, display error
      puts "\t\t[ERROR]:: TwitterAuth::twitter_get_userinfo fault: #{tgetinfoerror}" if $diag
    end  # Catch/Rescue block end
    puts "\t[Function]:: Entering twitter_get_userinfo" 
  end  # close function twitter_get_userinfo
  def self.twitter_user_followers(session, targetuser)  # start function twitter_user_followers_selenium
    puts "\t[Function]:: Entering twitter_user_followers"
    if $diag # if diag true, display error
      puts "\t\t[Variable]:: TwitterAuth::twitter_user_followers::targetuser #{targetuser}"
    end  # end if block
    begin  # Catch/Rescue block start
      # gather followers from browser session
      session.get("https://twitter.com/#{targetuser}/followers")  # request page from browser
      SeleniumWebHandler.pagescroll(session)  # call pagescroll function, find page end
      puts "\t[Function]:: Scroll followers page ended"
      return session.page_source  # return resulting page source
    rescue => tuserinfoerror  # Catch error to var
      # if diag true, display error
      puts "\t\t[ERROR]:: TwitterAuth::twitter_get_userinfo fault: #{tuserinfoerror}" if $diag
    end  # Catch/Rescue block end
    puts "\t[Function]:: Exiting twitter_get_userinfo" 
  end  # close function twitter_user_followers_selenium
  def self.twitter_user_following(session, targetuser)  # start function twitter_user_following_selenium
    puts "\t[Function]:: Entering twitter_user_following"
    if $diag # if diag true, display error
      puts "\t\t[Variable]:: TwitterAuth::twitter_user_following::targetuser #{targetuser}"
    end  # end if block
    begin  # Catch/Rescue block start
      # gather following from browser session
      session.get("https://twitter.com/#{targetuser}/following")  # request page from browser
      SeleniumWebHandler.pagescroll(session)  # call pagescroll function, find page end
      puts "\t[Function]:: Scroll following page ended"
      return session.page_source  # return resulting page source
    rescue => tuserfolerr  # Catch error to var
      # if diag true, display error
      puts "\t\t[ERROR]:: TwitterAuth::twitter_user_following fault: #{tuserfolerr}" if $diag
    end  # Catch/Rescue block end
    puts "\t[Function]:: Exiting twitter_user_following" 
  end  # close function twitter_user_following_selenium
  def self.twitter_get_followers(session, hashfile, targetuser) # start function twitter_get_followers_selenium
    puts "\t[Function]:: Entering twitter_get_followers"
    if $diag  # if diag true, display error
      puts "\t\t[Variable]:: TwitterAuth::twitter_get_followers::hashfile #{hashfile.length}"
      puts "\t\t[Variable]:: TwitterAuth::twitter_get_followers::targetuser #{targetuser}"
    end  # end if block
    begin  # Catch/Rescue block start
      puts "\t[Function]:: Global Hashfile: #{hashfile.length}"
      $followerlist = []  # set default follower list
      if $diag # if diag true, display error
        puts "\t\t[Variable]:: TwitterAuth::twitter_get_followers::$followerlist #{$followerlist.length}"
      end  # end if block
      # extract details from followers
      puts "\t[Function]:: Generated default global follower list"
      element = session.find_elements(:xpath, "//*[starts-with(@id, 'stream-item-user-')]")  # find userid element
      puts "\t[Function]:: Found elements needed"
      element.select do |everything|
        puts "\t[Function]:: Iterating follower information"
        userid = everything.attribute('data-item-id') # get user id from source
        # if diag true, display error
        puts "\t\t[Variable]:: TwitterAuth::twitter_get_followers::userid #{userid}" if $diag
        friendnick = everything.find_element(:css,'div > div > div.ProfileCard-userFields > div > div > a'
        ).attribute('href').to_s.gsub("https://twitter.com/", '')
        if friendnick == ""; friendnick = "Unknown" end  # set unknown to var if false
        # if diag true, display error
        puts "\t\t[Variable]:: TwitterAuth::twitter_get_followers::friendnick #{friendnick}" if $diag
        friendavatar = everything.find_element(:css, 'div > div > a > img').attribute('src')
        if friendavatar == ""; friendavatar = "Unknown" end  # set unknown to var if false
        # if diag true, display error
        puts "\t\t[Variable]:: TwitterAuth::twitter_get_followers::friendavatar #{friendavatar}" if $diag
        friendname = everything.find_element(:css, 'div > div > div.ProfileCard-userFields > div > div > a').text
        if friendname == ""; friendname = "Unknown" end  # set unknown to var if false
        # if diag true, display error
        puts "\t\t[Variable]:: TwitterAuth::twitter_get_followers::friendname #{friendname}" if $diag
        friendbio = everything.find_element(:css, 'div > div > div.ProfileCard-userFields > p').text
        if friendbio == ""; friendbio = "Unknown" end  # set unknown to var if false
        if $diag # if diag true, display error
          puts "\t\t[Variable]:: TwitterAuth::twitter_get_followers::friendbio #{friendbio}"
        end  # end if block
        puts "\t[Function]:: Create entry for followerlist"
        dataline = "\"#{userid}\",\"#{friendname}\",\"#{friendnick}\",\"#{friendbio}\""
        # if diag true, display error
        puts "\t\t[Variable]:: TwitterAuth::twitter_get_followers::dataline #{dataline.length}" if $diag
        $followerlist.append(dataline)  # append data line to followerlist
        # if diag true, display error
        puts "\t\t[Variable]:: TwitterAuth::twitter_get_followers::$followerlist #{$followerlist.length}" if $diag
        puts "\t[Function]:: Finished followerlist append"
        hashfile[targetuser]['followers'].store(
            userid.to_s, [
            friendname.to_s,
            friendnick.to_s,
            friendavatar.to_s,
            friendbio.to_s
        ])  # store data variables in hash
        puts "\t[Function]:: Finished hashfile "
      end # iterate over each element finding relevant information
      $hashfile = hashfile  # store hashfile to global hashfile var
      # if diag true, display error
      puts "\t\t[Variable]:: TwitterAuth::twitter_get_followers::$hashfile #{$hashfile.length}" if $diag
    rescue => tgetfolerr  # Cat error to var
      # if diag true, display error
      puts "\t\t[ERROR]:: TwitterAuth::twitter_get_followers fault: #{tgetfolerr}" if $diag
    end   # Catch/Rescue block end
    puts "\t[Function]:: Exiting twitter_get_followers"
  end  # close function twitter_get_followers_selenium
  def self.twitter_get_following(session, hashfile, targetuser)  # start function twitter_get_following_selenium
    puts "\t[Function]:: Entering twitter_get_following"
    $followinglist = []  # set default followinglist
    # if diag true, display error
    puts "\t\t[Variable]:: TwitterAuth::twitter_get_following::$followinglist #{$followinglist.to_s}" if $diag
    # extract details from following
    puts "\t[Function]:: Created default followinglist"
    begin  # Catch/Rescue block start
      element = session.find_elements(:xpath, "//*[starts-with(@id, 'stream-item-user-')]") # find userid element
      element.select do |everything|
        userid = everything.attribute('data-item-id')  # get userid from source
        # if diag true, display error
        puts "\t\t[Variable]:: TwitterAuth::twitter_get_following::userid #{userid}" if $diag
        friendnick = everything.find_element(:css, 'div > div > div.ProfileCard-userFields > div > div > a'
        ).attribute('href').to_s.gsub("https://twitter.com/", '')  # set var from source
        if friendnick.to_s == ""; friendnick = "Unknown" end  # set unknown to var if false
        # if diag true, display error
        puts "\t\t[Variable]:: TwitterAuth::twitter_get_following::friendnick #{friendnick}" if $diag
        friendavatar = everything.find_element(:css, 'div > div > a > img').attribute('src')  # set var from source
        if friendavatar.to_s == ""; friendavatar = "Unknown" end  # set unknown to var if false
        # if diag true, display error
        puts "\t\t[Variable]:: TwitterAuth::twitter_get_following::friendavatar #{friendavatar.to_s}" if $diag
        # set var from source
        friendname = everything.find_element(:css, 'div > div > div.ProfileCard-userFields > div > div > a').text
        if friendname.to_s == ""; friendname = "Unknown" end  # set unknown to var if false
        # if diag true, display error
        puts "\t\t[Variable]:: TwitterAuth::twitter_get_following::friendname #{friendname.to_s}" if $diag
        # set var from source
        friendbio = everything.find_element(:css, 'div > div > div.ProfileCard-userFields > p').text
        if friendbio.to_s == ""; friendbio = "Unknown" end  # set unknown to var if false
        # if diag true, display error
        puts "\t\t[Variable]:: TwitterAuth::twitter_get_following::friendbio #{friendbio.length}" if $diag
        puts "\t[Function]:: Create entry for followinglist"
        dataline = "\"#{userid}\",\"#{friendname}\",\"#{friendnick}\",\"#{friendbio}\""  # create dataline
        # if diag true, display error
        puts "\t\t[Variable]:: TwitterAuth::twitter_get_following::dataline #{dataline.to_s}" if $diag
        $followinglist.append(dataline)  # append dataline to followinglist
        # if diag true, display error
        puts "\t\t[Variable]:: TwitterAuth::twitter_get_following::$followinglist #{$followinglist.length}" if $diag
        puts "\t[Function]:: Finished followinglist append"
        hashfile[targetuser]['following'].store(
            userid.to_s, [
            friendname.to_s,
            friendnick.to_s,
            friendavatar.to_s,
            friendbio.to_s
        ])  # store data variables in hash
        if $diag # if diag true, display error
          puts "\t\t[Variable]:: TwitterAuth::twitter_get_following::hashfile #{hashfile.length}"
          puts "\t[Function]:: Finished hashlist append"
        end  # end if block
      end  # end do block
    rescue => tgetfolerr  # Cat error to var
      # if diag true, display error
      puts "\t\t[ERROR]:: TwitterAuth::twitter_get_following fault: #{tgetfolerr}" if $diag
    end  # Catch/Rescue block end
    puts "\t[Function]:: Exiting twitter_get_following" if $diag # if diag true, display error
    $hashfile = hashfile
    if $diag # if diag true, display error
      puts "\t\t[Variable]:: TwitterAuth::twitter_get_following::$hashfile #{$hashfile.length}"
      puts "\t[Function]:: Exiting twitter_get_following"
    end  # end if block
  end  # close function twitter_get_following_selenium
  def self.default_hashes(targetuser, search_type) # start function default_hash
    puts "\t[Function]:: Entering TwitterAuth::default_hashes"
    # identify if there is a file for a target to load from disk
    begin  # Catch/Rescue block start
      hashlist = {}  # generate default hash variable
      hashlist[targetuser] = {}  # assign hash with variable name
      if search_type == 'all'  # if query is all
        hashlist[targetuser]['followers'] = {}  # assign hash with variable name
        hashlist[targetuser]['following'] = {}  # assign hash with variable name
      else  # else do other thing
        hashlist[targetuser][search_type] = {}  # assign hash with variable name
      end  # end if block
      if $diag# if diag true, display error
        puts "\t\t[Variable]:: TwitterAuth::default_hashes::hashlist #{hashlist.length}"
        puts "\t[Function]:: Default hashlist is generated"
      end  # end if block
      return hashlist  # return hashlist
    rescue => defhasherror  # Catch error to var
      puts "\t\t[ERROR]:: TwitterAuth::default_hashes fault: #{defhasherror}" if $diag # if diag true, display error
    end  # Catch/Rescue block end
    puts "\t[Function]:: Exiting TwitterAuth::default_hashes"
  end  # close function default_hash
  def self.twitter_logoff_selenium(session)  # start function twitter_logoff_selenium
    puts "\t[Function]:: Entering TwitterAuth::twitter_logoff_selenium"
    begin  # Catch/Rescue block start
      session.get("https://twitter.com/logout")  # request twitter logout page
      session.find_element(:css, 'div > div > form > div.buttons > button').click  # send synthetic mouse click
      session.find_element(:css,'.js-submit').click  # send synthetic mouse click
      session.close  # close browser session
      puts "\t[Function]:: Logged off twitter"
      return  # return to calling process
    rescue => selnlogofferr  # Catch error to var
      # if diag true, display error
      puts "\t\t[ERROR]:: TwitterAuth::twitter_logoff_selenium fault: #{selnlogofferr}" if $diag
    end  # Catch/Rescue block start
    puts "\t[Function]:: Exiting TwitterAuth::twitter_logoff_selenium"
  end  # close function twitter_logoff_selenium
end  # close class TwitterAuth
#
#[Class] ##################################] SeleniumWebHandler [#######################################################
class SeleniumWebHandler  # start class SeleniumWebHandler
  def self.start_ff_driver  # start function start_ff_driver
    puts "\t[Function]:: Entering SeleniumWebHandler::start_ff_driver"
    # Loads Firefox in headless mode
    begin  # Catch/Rescue block start
      # EDIT ME BELOW TO MATCH YOU FILE LOCATIONS
      webdriver_path = File.join(File.absolute_path(File.dirname(
          "D:\\")),"webdriver", "geckodriver.exe"
      ) # set the location where the geckodriver is located, obviously edit to match your needs
      puts "\t[Function]:: Finished loading browser driver"
      Selenium::WebDriver::Firefox.driver_path = webdriver_path  # set the geckodriver location in module
      driver = Selenium::WebDriver.for :firefox#, :profile => profile  # set the web browser web driver
      puts "\t[Function]:: Return browser driver"
      return driver  # returns driver to application for later use
    rescue => startfffail  # Catch error to var
      # if diag true, display error
      puts "\t\t[ERROR]:: SeleniumWebHandler::start_ff_driver fault: #{startfffail}" if $diag
    end    # Catch/Rescue block end
    puts "\t[Function]:: Exiting SeleniumWebHandler::start_ff_driver"
  end  # close function start_ff_driver
  def goto(url)  # start function goto
    # uses the GET function from selenium
    puts "\t[Function]:: Entering SeleniumWebHandler::goto"
    puts "\t\t[Variable]:: SeleniumWebHandler::goto::url #{url.to_s}" if $diag # if diag true, display error
    begin  # Catch/Rescue block start
      @driver.get(url)  # request URl from headless browser session
      puts "\t[Function]:: Grab URL"
      @driver.find_element(:css, '#doc > div.topbar.js-topbar > div').click  # send synthetic mouse click
      puts "\t[Function]:: Send synthetic click on form"
    rescue => selgotoerr  # Catch error to var
      puts "\t\t[ERROR]:: SeleniumWebHandler::goto fault: #{selgotoerr}" if $diag # if diag true, display error
    end  # Catch/Rescue block end
  end  # Close function goto
  def self.pagescroll(session)  # start function pagescroll
    # page source validation and break function
    puts "\t[Function]:: Entering SeleniumWebHandler::pagescroll"
    @oldsource = ""  # sets variable with default value
    # if diag true, display error
    puts "\t\t[Variable]:: SeleniumWebHandler::pagescroll::@oldsource #{@oldsource.length}" if $diag
    # Scrolls a page till the end
    begin
	  if $diag
	    idiorate = 2  # iterate over a small number to reduce coverage
	  else
		idiorate = 50000000000  # iterate over a large number to ensure coverage
	  end
      idiorate.times { |counter|
        sleep 0.5  # take a nap
        @counter = counter  # keep score
        puts "\t\t[Variable]:: SeleniumWebHandler::pagescroll::@counter #{@counter.to_s}" if $diag
        session.execute_script("document.body.scrollTop")  # set scroll top value
        session.execute_script("window.innerHeight")  # set inner height of window
        session.execute_script("if (document.body.scrollHeight == document.body.scrollTop + window.innerHeight)" +
          "{return true} else {return false}")  # execute script as JS in browser
        session.execute_script("window.scrollTo(0, document.body.scrollHeight)")  # execute script as JS in browser
        if source_page_check(session)  # if page has touched the bottom
          puts "\t[Function]:: Entering source_page_check::BREAK"
          break  # exit the begin loop
        end  # end if statement
      }
      puts "\t[Function]:: Exiting SeleniumWebHandler::pagescroll"
      return  # return to calling process
    rescue => pagescrollfail  # Catch error to var
      # if diag true, display error
      puts "\t\t[ERROR]:: SeleniumWebHandler::pagescroll fault: #{pagescrollfail}" if $diag
    end  # Catch/Rescue block end
  end  # close function pagescroll
  def self.teardown  # start function teardown
    puts "\t[Function]:: Entering SeleniumWebHandler::teardown"
    # breaks down the web driver and closes the browser
    begin  # Catch/Rescue block start
      @driver.quit  # send driver QUIT signal
      puts "\t[Function]:: Exiting SeleniumWebHandler::teardown"
      return  # return to calling process
    rescue => teardownfail  # Catch error to var
      puts "\t\t[ERROR]:: SeleniumWebHandler::teardown fault: #{teardownfail}" if $diag # if diag true, display error
    end  # Catch/Rescue block end
  end  # close function teardown
  def self.source_page_check(session)  # start function source_page_check
    # Checks the source of a page to see if anything has changed
    puts "\t[Function]:: Entering SeleniumWebHandler::source_page_check"
    begin  # Catch/Rescue block start
      @newsource = session.page_source  # set variable with resulting page source
      # if diag true, display error
      puts "\t\t[Variable]:: SeleniumWebHandler::source_page_check::@newsource #{@newsource.length}" if $diag
      if @newsource == @oldsource  # compare the values of new vs old
        puts "\t[Function]:: new and old source matched" 
        return true  # resulting in true
      else  # if not, perform these other actions
        @oldsource = @newsource  # set the old variable to the new variable
        puts "\t[Function]:: new and old source DID NOT match"  
        return false  # resulting in false
      end  # end if block
    rescue => teardownfail  # Catch error to var
      # if diag true, display error
      puts "\t\t[ERROR]:: SeleniumWebHandler::source_page_check fault: #{teardownfail}" if $diag
    end  # Catch/Rescue block end
    puts "\t[Function]:: Exiting SeleniumWebHandler::source_page_check" 
  end  #close function source_page_check
end  # close class SeleniumWebHandler
#
#[Function] ##################################] filewriter [############################################################
def filewriter(filename, datatodisk, search_type)
  puts "\t[Function]:: Entering filewriter"
  if $diag # if diag true, display error
    puts "\t\t[Variable]:: filewriter::filename #{filename.to_s}"
    puts "\t\t[Variable]:: filewriter::datatodisk #{datatodisk.length}"
    puts "\t\t[Variable]:: filewriter::search_type #{search_type.to_s}"
  end  # end if block
  if filename  # if filename has been set, check for extension
    begin  # Catch/Rescue block start
      if filename.split('.')[-1].to_s == "csv";  # check if file is csv extension
        puts "\t\t[LOGIC]:: filewriter::filename File is CSV #{filename}" if $diag # if diag true, display error
      else  # do something else
        filename = filename.to_s+".csv"  # the filename has been modified
		puts "\t\t[LOGIC]:: filewriter::filename File is NOW a CSV #{filename}" if $diag # if diag true, display error
      end  # end if block
    rescue => filewriteerr  # Catch error to var
      puts "\t\t[ERROR]:: filewriter fault: #{filewriteerr}" if $diag # if diag true, display error
    end  # Catch/Rescue block end
    filename = search_type.to_s+"_"+filename
  end  # close if statement
  begin  # Catch/Rescue block start
    puts "\t\t[Variable]:: CSV filewriter::filename #{filename}" if $diag # if diag true, display error
    File.open(filename, 'w') {|f|
      datatodisk.each { | dataline |
	    f.write(dataline+"\n") 
	  }  # produce file
	}
  rescue => filenamemod  # Catch error to var
    puts "\t\t[ERROR]:: filewriter filename fault: #{filenamemod}" if $diag # if diag true, display error
  end  # Catch/Rescue block end
  puts "\t[Function]:: Exiting filewriter" 
end  # Close filewriter function
#
#[User Arguments] ##############################] User Args [###########################################################
require 'selenium-webdriver'  # ensure module is included with the script
require 'optparse'  # ensure module is included with the script
require 'ostruct'  # ensure module is included with the script
begin  # Catch/Rescue block start
  options = OpenStruct.new  # create a new OpenStruct object
  OptionParser.new do |opt|
    opt.on('-w','--whitelist SEARCHTYPE','Create whitelist from own Types: ["following","followers","all"]') { |o|
      options[:whitelist] = o }  # create whitelist from commandline of known users who follow(ers|ing) you
    opt.on('-e','--epoch SEARCHTYPE','List connections between users Types: ["following","followers","all"]') { |o|
      options[:epoch] = o }  # create connection list from commandline of known users between you and target user
    opt.on('-v','--verbose BOOLEAN','Writes additional CSV file with detailed information') { |o|
      options[:verbose] = o }  # username from arguments @ cli
    opt.on('-s','--search SEARCHTYPE','List users of target personality Types: ["following","followers","all"]') { |o|
      options[:searchtype] = o }  # create list of users from targets follow(ers|ing)
    opt.on('-t','--target PERSONALITY','Target twitter personality to produce list from') { |o|
      options[:targetuser] = o }  # select target personality from commandline
    opt.on('-o','--output FILENAME','The filename which to store the generated CSV list') { |o|
      options[:filename] = o }  # filename to store created list
    opt.on('-p','--password PASSWORD','Your twitter password for Authentication') { |o|
      options[:password] = o }  # password from arguments @ cli
    opt.on('-d','--debug BOOLEAN','Enable verbose debugging information to be displayed') { |o|
      options[:debug] = o }  # username from arguments @ cli
    opt.on('-u','--username USERNAME','Your twitter username for Authentication') { |o|
      options[:username] = o }  # username from arguments @ cli
  end.parse!  # Stop parsing options from user @ cli
rescue => optparseerr  # catch error to va
  puts "\t\t[ERROR]:: OptionsParser fault: #{optparseerr}" if $diag # if diag true, display error
end  # Catch/Rescue block end
#
#[Global Variables] ##############################] Global Vars [#######################################################
if options.debug.to_s == ""
  $diag = false
else
  $diag = true
end
puts "[$GLOBAL] Diagnostic: #{$diag}" if $diag # if diag true, display error
$whitelist  = options.whitelist.to_s  # set search type to global variable
puts "[$GLOBAL] Whitelist: #{$whitelist}" if $diag # if diag true, display error
$epoch      = options.epoch.to_s  # set search type to global variable
puts "[$GLOBAL] Epochlist: #{$epoch}" if $diag # if diag true, display error
$username   = options.username.to_s  # set username to global variable
puts "[$GLOBAL] AUTHuser: #{$username}" if $diag # if diag true, display error
$password   = options.password.to_s  # set password to global variable
puts "[$GLOBAL] AUTHpass: #{$password}" if $diag # if diag true, display error
$targetuser = options.targetuser.to_s  # set target user to global variable
puts "[$GLOBAL] Targetuser: #{$targetuser}" if $diag # if diag true, display error
$searchtype = options.searchtype.to_s  # set search type to global variable
puts "[$GLOBAL] Searchtype: #{$searchtype}" if $diag # if diag true, display error
$filename   = options.filename.to_s  # set file name to global variable
puts "[$GLOBAL] Filename: #{$filename}" if $diag # if diag true, display error
$verbose    = options.verbose.to_s  # sets verbose statement to global variable
puts "[$GLOBAL] Verbose: #{$verbose}" if $diag # if diag true, display error
begin
  $bsession   = SeleniumWebHandler.start_ff_driver  # start Firefox browser in headless mode
  sleep(0.5)  # Take a small nap for the screen output to align
  puts "[$GLOBAL] Browser: Enabled" if $diag # if diag true, display error
rescue => browsersessionerror
  puts "[ERROR] Browser: FAILED" if $diag # if diag true, display error
end
#
#[Function] #################################] followersquery [#########################################################
def followersquery(queryuser)
  puts "\t[Function]:: Entering followersquery" 
  puts "\t\t[Variable]:: followersquery::queryuser #{queryuser.to_s}" if $diag # if diag true, display error
  begin
    puts "\t[Function]:: Entering followersquery::TwitterAuth.twitter_user_followers" 
    TwitterAuth.twitter_user_followers($bsession, queryuser)  # request followers page
    puts "\t[Function]:: Exiting followersquery::TwitterAuth.twitter_user_followers"
  rescue => tauferr
    # if diag true, display error
    puts "\t\t[ERROR]:: followersquery::TwitterAuth.twitter_user_followers fault: #{tauferr}" if $diag
  end
  begin
    # if diag true, display error
    puts "\t[Function]:: Entering followersquery::TwitterAuth.twitter_get_followers"
    # page scroll and gather followers information, stow in hash
	TwitterAuth.twitter_get_followers($bsession,$hashfile,queryuser)
     puts "\t[Function]:: Exiting followersquery::TwitterAuth.twitter_get_followers"  
  rescue => tagferr
    # if diag true, display error
    puts "\t\t[ERROR]:: followersquery::TwitterAuth.twitter_get_followers fault: #{tagferr}" if $diag
  end
  begin
    if $whitelist == "";
      targetuser = $targetuser.downcase.to_s
    else
      targetuser = $myusername.downcase.to_s
    end
    puts "\t\t[Variable]:: followersquery::targetuser #{targetuser.to_s}" if $diag # if diag true, display error
  rescue => tuserseterr
    puts "\t\t[ERROR]:: followersquery::targetuser fault: #{tuserseterr}" if $diag # if diag true, display error
  end
  begin
    if $epoch != ""
	  return
	end
  rescue => verbosefileerr
    # if diag true, display error
    puts "\t\t[ERROR]:: Verbose followersquery::filewriter fault: #{verbosefileerr}" if $diag
  end
  puts "\t[Function]:: Exiting followersquery" 
end
#
#[Function] #################################] followingquery [#########################################################
def followingquery(queryuser)
  begin
    puts "\t[Function]:: Entering followingquery"
    if $diag # if diag true, display error
      puts "\t\t[Variable]:: followingquery::queryuser #{queryuser}"
    end
    puts "\t[Function]:: Entering followingquery::TwitterAuth.twitter_user_following"
    TwitterAuth.twitter_user_following($bsession, queryuser)  # request followers page
    puts "\t[Function]:: Exiting followingquery::TwitterAuth.twitter_user_following"
  rescue => tawuferror
    # if diag true, display error
    puts "\t\t[ERROR]::followingquery::TwitterAuth.twitter_user_following fault: #{tawuferror}" if $diag
  end
  begin
    # if diag true, display error
    puts "\t[Function]:: Entering followingquery::TwitterAuth.twitter_get_following" 
    # page scroll and gather following information, stow in hash
	TwitterAuth.twitter_get_following($bsession,$hashfile,queryuser)
    puts "\t[Function]:: Exiting followingquery::TwitterAuth.twitter_user_following" 
  rescue => tawgferror
    # if diag true, display error
    puts "\t\t[ERROR]:: followingquery::TwitterAuth.twitter_get_following fault: #{tawgferror}" if $diag
  end
  begin
    if $whitelist == "";
      targetuser = $targetuser.downcase.to_s
    else
      targetuser = $myusername.downcase.to_s
    end
    puts "\t\t[Variable]:: followingquery::targetuser #{targetuser}" if $diag # if diag true, display error
  rescue => settusererror
    puts "\t\t[ERROR]:: followingquery::targetuser fault: #{settusererror}" if $diag # if diag true, display error
  end
  begin
    if $epoch.to_s != ""
	  return
	end  # close if statement
    puts "\t[Function]:: Exiting Verbose followingquery::filewriter" 
  rescue => vfilewriteerror
    puts "\t\t[ERROR]:: followingquery::Vfilewriter fault: #{vfilewriteerror}" if $diag # if diag true, display error
  end
  puts "\t[Function]:: Exiting followingquery" 
end
#
#[Function] ####################################] doallquery [##########################################################
def doallquery(queryuser)
  puts "\t[Function]:: Entering doallquery" 
  puts "\t\t[Variable]:: doallquery::queryuser #{queryuser}" if $diag # if diag true, display error
  begin
    puts "\t[Function]:: Entering doallquery::followersquery" 
    followersquery(queryuser)
    puts "\t[Function]:: Exiting doallquery::followersquery" 
  rescue => filewriteerror
    puts "\t\t[ERROR]:: doallquery::followersquery fault: #{filewriteerror}" if $diag # if diag true, display error
  end
  begin
    puts "\t[Function]:: Entering doallquery::followingquery" 
    followingquery(queryuser)
    puts "\t[Function]:: Exiting doallquery::followingquery" 
  rescue => filewriteerror
    puts "\t\t[ERROR]:: doallquery::followingquery fault: #{filewriteerror}" if $diag # if diag true, display error
  end
  puts "\t[Function]:: Exiting doallquery"
end
#
#[Function] #####################################] searchfun [##########################################################
def searchfun(querytype, queryuser)
  puts "\t[Function]:: Entering searchfun"
  if $diag # if diag true, display error
    puts "\t\t[Variable]:: searchfun::querytype #{querytype}"
    puts "\t\t[Variable]:: searchfun::queryuser #{queryuser}" 
  end
  begin
    if querytype.downcase.to_s == 'followers'  # if searching for followers only
      puts "\t[Function]:: Entering searchfun::followersquery" 
      followersquery(queryuser)
      puts "\t[Function]:: Exiting searchfun::followersquery" 
    end  # end if statement
  rescue => followfault
    puts "\t\t[ERROR]:: searchfun::followersquery fault: #{followfault}" if $diag # if diag true, display error
  end
  begin
    if querytype.downcase.to_s == 'following'  # if searching for following only
      puts "\t[Function]:: Entering searchfun::followingquery" 
      followingquery(queryuser)
      puts "\t[Function]:: Exiting searchfun::followingquery" 
    end  # end if statement
  rescue => followfault
    puts "\t\t[ERROR]:: searchfun::followingquery fault: #{followfault}" if $diag # if diag true, display error
  end
  begin
    if querytype.downcase.to_s == 'all'  # if searching for all
      puts "\t[Function]:: Entering searchfun::doallquery" 
      doallquery(queryuser)
      puts "\t[Function]:: Exiting searchfun::doallquery" 
    end  # end if statement
  rescue => followfault
    puts "\t\t[ERROR]:: searchfun::doallquery fault: #{followfault}" if $diag # if diag true, display error
  end
  puts "\t[Function]:: Exiting searchfun" 
end
#
#[Function] #####################################] genblacklist [#######################################################
def genblacklist
  if $searchtype.to_s != "" && $targetuser.downcase.to_s != $myusername.downcase.to_s
    puts "\t[Function]:: Entering genblacklist" 
    begin
      puts "\t[Function]:: Starting genblacklist::TwitterAuth.default_hashes"
      $hashfile   = TwitterAuth.default_hashes($targetuser, $searchtype)  # generate the default hash file
      puts "\t\t[Variable]:: genblacklist::$hashfile #{$hashfile.length}" if $diag # if diag true, display error
      puts "\t[Function]:: Exiting genblacklist::TwitterAuth.default_hashes"
    rescue => setvarerror
      # if diag true, display error
      puts "\t\t[ERROR]:: genblacklist::TwitterAuth.default_hashes fault: #{setvarerror}" if $diag
    end
    begin
      puts "\t[Function]:: Starting genblacklist::searchfun"
      searchfun($searchtype, $targetuser)
      puts "\t[Function]:: Exiting genblacklist::searchfun"
    rescue => setvarerror
      puts "\t\t[ERROR]:: genblacklist::searchfun fault: #{setvarerror}" if $diag # if diag true, display error
    end
    $bhashfile = $hashfile[$targetuser]
	begin
      $bhashfile.keys.each { |wmkey |
	  	$tuser = []
		$tverbose = []
	    $bhashfile[wmkey].keys.each { |bhashkey |
		  puts "\t\t[LOGIC]:: Gathering blacklist data from target users"
	      puts "\t\t[Variable]:: Blacklist userid genepoch::whashkey #{bhashkey}" if $diag # if diag true, display error
	      $tuser.append(bhashkey)
	      if $verbose != ""
            suser   = $bhashfile[wmkey][bhashkey][1]   # username of shared account between target personalities
	        snick   = $bhashfile[wmkey][bhashkey][0]   # usernick of shared account between target personalities
	        sbio    = $bhashfile[wmkey][bhashkey][3]   # userbios of shared account between target personalities
  	        $tverbose.append("\"#{bhashkey}\",\"#{suser}\",\"#{snick}\",\"#{sbio}\"")
	      end
	      puts "\t\t[LOGIC]:: Finished selecting user data from targets bhashkey"
		}  # end $bhashfile[bhashkey].include each block
        puts "\t[Function]:: Entering blacklist genblacklist::filewriter"
	    filewriter("#{$targetuser}_blacklist_#{$filename}", $tuser, wmkey)  # write list to disk
  	    puts "\t[Function]:: Exiting blacklist genblacklist::filewriter"
	    if $verbose != ""
		  puts "\t[Function]:: Entering blacklist Verbose genblacklist::filewriter"
		  filewriter("#{$targetuser}_blacklistt_verbose_#{$filename}", $tverbose, wmkey)
		  puts "\t[Function]:: Exiting blacklist Verbose genblacklist::filewriter"
	    end  # close if statement
	  }
	rescue => blacklistwritererror
      # if diag true, display error
	  puts "\t\t[ERROR]:: Whitelist Epoch::filewriter fault: #{blacklistwritererror}" if $diag
	end
  end
  puts "\t[Function]:: Exiting genblacklist" 
end
#
#[Function] #####################################] genwhitelist [#######################################################
def genwhitelist
  puts "\t[Function]:: Entering genwhitelist" 
  if $whitelist.to_s != "" && $targetuser.downcase.to_s != $myusername.downcase.to_s
    begin
      puts "\t[Function]:: Starting genwhitelist::TwitterAuth.default_hashes" 
      $hashfile   = TwitterAuth.default_hashes($myusername, $whitelist)  # generate the default hash file
      puts "\t\t[Variable]:: genwhitelist::$hashfile #{$hashfile.length}" if $diag # if diag true, display error
      puts "\t[Function]:: Exiting genwhitelist::TwitterAuth.default_hashes" 
    rescue => setvarerror
      # if diag true, display error
      puts "\t\t[ERROR]:: genwhitelist::TwitterAuth.default_hashes fault: #{setvarerror}" if $diag
    end
    begin
      puts "\t[Function]:: Starting genwhitelist::searchfun" 
      searchfun($whitelist, $myusername)
      puts "\t[Function]:: Exiting genwhitelist::searchfun" 
    rescue => setvarerror
      puts "\t\t[ERROR]:: genwhitelist::searchfun fault: #{setvarerror}" if $diag # if diag true, display error
    end
    $whashfile = $hashfile[$myusername]
	begin
      $whashfile.keys.each { |wmkey |
	  	$myuser = []
		$myverbose = []
	    $whashfile[wmkey].keys.each { |whashkey |
		  puts "\t\t[LOGIC]:: Gathering whitelist data from target users" 
	      puts "\t\t[Variable]:: whitelist userid genwhitelist::whashkey #{whashkey}" if $diag # if diag true, display error
	      $myuser.append(whashkey)
	      if $verbose != ""
            suser   = $whashfile[wmkey][whashkey][1]   # username of shared account between target personalities
	        snick   = $whashfile[wmkey][whashkey][0]   # usernick of shared account between target personalities
	        sbio    = $whashfile[wmkey][whashkey][3]   # userbios of shared account between target personalities
  	        $myverbose.append("\"#{whashkey}\",\"#{suser}\",\"#{snick}\",\"#{sbio}\"")
	      end
	      puts "\t\t[LOGIC]:: Finished selecting user data from targets whashkey"
		}  # end $whashfile[whashkey].include each block
        puts "\t[Function]:: Entering whitelist genwhitelist::filewriter" 
	    filewriter("#{$targetuser}_whitelist_#{$filename}", $myuser, wmkey)  # write list to disk
  	    puts "\t[Function]:: Exiting whitelist genwhitelist::filewriter"
	    if $verbose != ""
		  puts "\t[Function]:: Entering whitelist Verbose genwhitelist::filewriter"
		  filewriter("#{$targetuser}_whitelist_verbose_#{$filename}", $myverbose, wmkey)
		  puts "\t[Function]:: Exiting whitelist Verbose genwhitelist::filewriter"
	    end  # close if statement
	  }
    rescue => whitelistwritererror
	  # if diag true, display error
	  puts "\t\t[ERROR]:: Whitelist Epoch::filewriter fault: #{whitelistwritererror}" if $diag
    end
  end
  puts "\t[Function]:: Exiting genwhitelist" 
end
#
#[Function] #########################################] genepoch [#######################################################
def genepoch
  puts "\t[Function]:: Entering genepoch" 
  begin
    puts "\t[Function]:: Starting genepoch::TwitterAuth.default_hashes"
    $hashfile = TwitterAuth.default_hashes($myusername, $epoch)  # generate the default hash file
    puts "\t\t[Variable]:: genepoch::$hashfile #{$hashfile.length}" if $diag # if diag true, display error
    puts "\t[Function]:: Exiting genepoch::TwitterAuth.default_hashes"
  rescue => setvarerror
    # if diag true, display error
    puts "\t\t[ERROR]:: genepoch::TwitterAuth.default_hashes fault: #{setvarerror}" if $diag
  end
  begin
    puts "\t[Function]:: Starting genepoch::searchfun"
    searchfun($epoch, $myusername)
    $whashfile = $hashfile[$myusername]
    puts "\t[Function]:: Exiting genepoch::searchfun"
    puts "\t\t[Variable]:: genepoch::$whashfile #{$whashfile.length}" if $diag # if diag true, display error
  rescue => setvarerror
    puts "\t\t[ERROR]:: genepoch::searchfun fault: #{setvarerror}" if $diag # if diag true, display error
  end
  begin
    if $targetuser.downcase.to_s != $myusername.downcase.to_s
      puts "\t[Function]:: Starting genepoch::TwitterAuth.default_hashes" 
      $hashfile = TwitterAuth.default_hashes($targetuser, $epoch)  # generate the default hash file
  	  puts "\t\t[Variable]:: genepoch::$hashfile #{$hashfile.length}" if $diag # if diag true, display error
      puts "\t[Function]:: Exiting genepoch::TwitterAuth.default_hashes" 
      puts "\t[Function]:: Starting genepoch::searchfun" 
      searchfun($epoch, $targetuser)
      puts "\t[Function]:: Exiting genepoch::searchfun" 
      $bhashfile = $hashfile[$targetuser]
      $whashfile.keys.each { |wmkey|
        puts "\t\t[Variable]:: Epoch genepoch::wmkey #{wmkey}" if $diag # if diag true, display error
        begin
		  $myuser = []
  		  $myverbose = []
		  $whashfile[wmkey].keys.each { |whashkey|
		    $myuser.append(whashkey)
		    if $verbose != ""
			  suser   = $whashfile[wmkey][whashkey][1]   # username of shared account between target personalities
		   	  snick   = $whashfile[wmkey][whashkey][0]   # usernick of shared account between target personalities
			  sbio    = $whashfile[wmkey][whashkey][3]   # userbios of shared account between target personalities
			  $myverbose.append("#{whashkey},\"#{suser}\",\"#{snick}\",\"#{sbio}\"")
	  	    end
		    puts "\t\t[Variable]:: Epoch genepoch::whashkey #{whashkey}" if $diag # if diag true, display error
		  }  # end $whashfile[whashkey].include each block
		  begin
		    if $targetuser.downcase.to_s != $myusername.downcase.to_s
			  myusername = $myusername.downcase.to_s
		      puts "\t[Function]:: Entering myuser genepoch::filewriter"
 		      filewriter("#{myusername}_whitelist_#{$filename}", $myuser, wmkey)  # write list to disk
		      puts "\t[Function]:: Exiting myuser genepoch::filewriter"
		      if $verbose != ""
		        puts "\t[Function]:: Entering myuser Verbose genepoch::filewriter"
		        filewriter("#{myusername}_whitelist_verbose_#{$filename}", $myverbose, wmkey)
		        puts "\t[Function]:: Exiting myuser Verbose genepoch::filewriter"
		      end
		    end  # close if statement
		  rescue => whitelistwritererror
		    # if diag true, display error
		    puts "\t\t[ERROR]:: Whitelist Epoch::filewriter fault: #{whitelistwritererror}" if $diag
		  end
	    rescue => whitelistfail
	      puts "\t\t[ERROR]:: Whitelist Epoch::block fault: #{whitelistfail}" if $diag
	    end
	    begin
		  if $targetuser.downcase.to_s != $myusername.downcase.to_s
		    $tuser = []
		    $tverbose = []
		    $epochlist = []
		    $epochverbose = []
		    $bhashfile[wmkey].keys.each { |bhashkey |
		      puts "\t\t[LOGIC]:: Gathering blacklist data from target users"
		      puts "\t\t[Variable]:: Blacklist userid genepoch::whashkey #{bhashkey}" if $diag # if diag true, display error
		      $tuser.append(bhashkey)
		      if $verbose != ""
    	  	    suser   = $bhashfile[wmkey][bhashkey][1]   # username of shared account between target personalities
	  	        snick   = $bhashfile[wmkey][bhashkey][0]   # usernick of shared account between target personalities
			    sbio    = $bhashfile[wmkey][bhashkey][3]   # userbios of shared account between target personalities
		        $tverbose.append("#{bhashkey},\"#{suser}\",\"#{snick}\",\"#{sbio}\"")
		      end
		      if $myuser.include? bhashkey
                puts "\t\t[LOGIC]:: Found user exisitng in whitelist #{bhashkey}"  
		        $epochlist.append(bhashkey)
			    if $verbose.to_s != ""
			      $epochverbose.append("#{bhashkey},\"#{suser}\",\"#{snick}\",\"#{sbio}\"")
			    end
		      end
		      puts "\t\t[LOGIC]:: Finished selecting user data from targets bhashkey"  
		    }  # end $bhashfile[bhashkey].include each block
		    begin
		      puts "\t[Function]:: Entering target blacklist genepoch::filewriter"
		      if $tuser.length != 0
		        filewriter("#{$targetuser}_blacklist_#{$filename}", $tuser, wmkey)  # write list to disk
		      end
		      puts "\t[Function]:: Exiting target blacklist genepoch::filewriter"
		      if $verbose != ""
		  	    if $tverbose.length != 0
			      puts "\t[Function]:: Entering target blacklist Verbose genepoch::filewriter"
			      filewriter("#{$targetuser}_blacklist_verbose_#{$filename}", $tverbose, wmkey)
			      puts "\t[Function]:: Exiting target blacklist Verbose genepoch::filewriter"
			    else
			      puts "\t\t[LOGIC]:: No data to be written for #{wmkey} Epoch list"
			    end
		      end  # close if statement
		    rescue => blacklistwritererror
		      # if diag true, display error
		      puts "\t\t[ERROR]:: Targetlist Blacklist::filewriter fault: #{blacklistwritererror}" if $diag
		    end
		  end
		  begin
		    puts "\t[Function]:: Entering Epoch link genepoch::filewriter"
		    if $epochlist.length != 0
		      filewriter("epoch_#{$filename}", $epochlist, wmkey)  # write list to disk
		    end
		    puts "\t[Function]:: Exiting Epoch link genepoch::filewriter"
		    if $verbose != ""
		  	  if $epochverbose.length != 0
  			    puts "\t[Function]:: Entering Epoch link Verbose genepoch::filewriter"
			    filewriter("epoch_verbose_#{$filename}", $epochverbose, wmkey)
			    puts "\t[Function]:: Exiting Epoch link Verbose genepoch::filewriter"
			  end
		    end  # close if statement
		  rescue => epochlinkingerror
		    # if diag true, display error
		    puts "\t\t[ERROR]:: Targetlist Epochlist::filewriter fault: #{epochlinkingerror}" if $diag
		  end
	    rescue => blistfail
	      puts "\t\t[ERROR]:: Targetlist Epochlist::filewriter fault: #{blistfail}" if $diag
	    end
      } # end $whashlist block
	else
	  if $whashfile.length == 2
	    begin
  	  	  $epochlist = []
		  $epochverbose = []
		  $whashfile['followers'].keys.each { | usercheck |
			if $whashfile['following'].keys.include? usercheck
			  puts "\t\t[LOGIC]:: Found user exisitng in both lists"  
			  $epochlist.append(usercheck)
		      if $verbose != ""
    	  		suser   = $whashfile['followers'][usercheck][1]   # username of shared account between target personalities
	  			snick   = $whashfile['followers'][usercheck][0]   # usernick of shared account between target personalities
				sbio    = $whashfile['followers'][usercheck][3]   # userbios of shared account between target personalities
				$epochverbose.append("#{usercheck},\"#{suser}\",\"#{snick}\",\"#{sbio}\"")
			  end
			end
          }
		rescue => selfepocherror
	      puts "selfepocherror #{selfepocherror}"
	    end
	  end
	  begin
	    myuserdown = $myusername.downcase.to_s
		puts "\t[Function]:: Entering my own user epoch genepoch::filewriter"
		filewriter("#{myuserdown}_#{$filename}", $epochlist, 'cohesion')  # write list to disk
		puts "\t[Function]:: Exiting my own user epoch genepoch::filewriter"
		if $verbose != ""
	      puts "\t[Function]:: Entering my own user epoch Verbose genepoch::filewriter"
		  filewriter("#{myuserdown}_verbose_#{$filename}", $epochverbose, 'cohesion')
		  puts "\t[Function]:: Exiting my own user epoch Verbose genepoch::filewriter"
		end
	  rescue => myownusererr
		# if diag true, display error
		puts "\t\t[ERROR]:: My own user Epoch::filewriter fault: #{myownusererr}" if $diag
	  end
    end
    puts "\t\t[Variable]:: genepoch::$bhashfile #{$bhashfile.length}" if $diag # if diag true, display error
	puts "\t[Function]:: Entering genepoch" 
	exit
  rescue => setvarerror
    puts "\t\t[ERROR]:: genepoch::searchfun process fault: #{setvarerror}" if $diag # if diag true, display error
  end
  puts "\t[Function]:: Entering genepoch" 
end
#
#[Main] #############################################] Main [###########################################################
begin
  puts "\t[Function]:: Entering MAIN"
  puts "\t[Function]:: Starting MAIN TwitterAuth.twitter_login_selenium"
  if $diag # if diag true, display error
    puts "\t\t[Variable]:: MAINT witterAuth.twitter_login_selenium::$username #{$username}"
    puts "\t\t[Variable]:: MAIN TwitterAuth.twitter_login_selenium::$password #{$password}"
  end
  TwitterAuth.twitter_login_selenium($bsession, $username, $password)  # log into the twitter web application
  if $diag # if diag true, display error
    puts "\t\t[Variable]:: TwitterAuth.twitter_login_selenium::$username [#{$username}]"
    puts "\t\t[Variable]:: TwitterAuth.twitter_login_selenium::$password [#{$password}]"
  end
  puts "\t[Function]:: Exiting MAIN TwitterAuth.twitter_login_selenium"
rescue => twlogserr  # rescue any faults with parsing
  # if diag true, display error
  puts "\t\t[ERROR]:: MAIN TwitterAuth.twitter_login_selenium fault: #{twlogserr}" if $diag
end  # stop being loop
begin
  puts "\t[Function]:: Starting MAIN::TwitterAuth.twitter_get_selfinfo"
  $myusername = TwitterAuth.twitter_get_selfinfo($bsession)
  puts "\t\t[Variable]:: MAIN::$myusername #{$myusername}" if $diag # if diag true, display error
  puts "\t[Function]:: Exiting MAIN::TwitterAuth.twitter_get_selfinfo"
rescue => setvarerror
  # if diag true, display error
  puts "\t\t[ERROR]:: MAIN::TwitterAuth.twitter_get_selfinfo fault: #{setvarerror}" if $diag
end
begin
  puts "\t[Function]:: Starting MAIN TwitterAuth.twitter_userinfo"
  # if diag true, display error
  if $whitelist.to_s != "" && $targetuser.downcase.to_s != $myusername.downcase.to_s
    puts "\t[Function]:: Starting MAIN genwhitelist"
    puts "\t\t[Variable]:: $whitelist #{$whitelist.length}" if $diag # if diag true, display error
    genwhitelist if $whitelist.to_s != '' # end if statement
    puts "\t[Function]:: Exiting MAIN genwhitelist"
  end
rescue => gelisterr  # rescue any faults with parsing
  puts "\t\t[ERROR]:: MAIN genwhitelist fault: #{gelisterr}" if $diag # if diag true, display error
end  # stop being loop
begin
  if $epoch.to_s != ""
    puts "\t[Function]:: Starting MAIN genepoch"
    puts "\t\t[Variable]:: $epoch #{$epoch}" if $diag # if diag true, display error
    genepoch if $epoch.to_s != '' # end if statement
    puts "\t[Function]:: Exiting MAIN genepoch"
  end
rescue => genepocherr  # rescue any faults with parsing
  puts "\t\t[ERROR]:: MAIN genepoch fault: #{genepocherr}" if $diag # if diag true, display error
end  # stop being loop
begin
  if $searchtype.to_s != "" && $targetuser.downcase.to_s != $myusername.downcase.to_s
    puts "\t[Function]:: Starting MAIN searchfun"
	if $diag # if diag true, display error
      puts "\t\t[Variable]:: searchfun::$searchtype #{$searchtype}"
      puts "\t\t[Variable]:: searchfun::$targetuser #{$targetuser}"
	end
    genblacklist if $searchtype.to_s != '' # end if statement
    puts "\t[Function]:: Exiting MAIN searchfun"
  end
rescue => serfunerr  # rescue any faults with parsing
  puts "\t\t[ERROR]:: MAIN searchfun fault: #{serfunerr}" if $diag # if diag true, display error
end  # stop being loop
puts "\t[Function]:: Exiting MAIN"
#
#[END] ###########################################] The End [###########################################################
