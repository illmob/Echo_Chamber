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
########################################################################################################################
class TwitterAuth  # class start TwitterAuth
  # authenticate to Twitter web interface from FF browser
  def self.twitter_login_selenium(session, username, password)  # start function twitter_login_selenium
    # Auth through headless FF with credential pair
    session.get("https://twitter.com/login")  # actual login page for twitter
    username_field = session.find_element(:css,'.js-username-field')  # find username element
    username_field.send_keys(username)  # assign username to the form field
    sleep(1)  # take a nap
    password_field = session.find_element(:css, '.js-password-field')  # find password element
    password_field.send_keys(password)  # assign password to the form field
    sleep(1)  # take a nap
    session.find_element(:css, "button.submit").click#, :return)  # send synthetic mouse click on button
    return session  # return session information
  end  # close function twitter_login_selenium
  def self.twitter_userinfo(session, targetuser)  # start function twitter_userinfo
    # gather target user info from browser session
    session.get("https://twitter.com/#{targetuser}")  # request page from browser
    return session.page_source  # return resulting page source
  end  # close function twitter_user_followers_selenium
  def self.twitter_get_userinfo(session, hashfile, targetuser, search_type) # start function twitter_get_userinfo
    # extract details from followers
    element = session.find_element(
        xpath: '//*[@id="page-container"]/div[1]/div/div[1]/div[1]/img'
    ).attribute('src')  # find target personalities user ID
    hashfile[targetuser][search_type].store(
        element.split("/")[-3], ""
    )  # write target user to the hashfile
  end  # close function twitter_get_userinfo
  def self.twitter_user_followers(session, targetuser)  # start function twitter_user_followers_selenium
    # gather followers from browser session
    session.get("https://twitter.com/#{targetuser}/followers")  # request page from browser
    SeleniumWebHandler.pagescroll(session)  # call pagescroll function, find page end
    return session.page_source  # return resulting page source
  end  # close function twitter_user_followers_selenium
  def self.twitter_user_following(session, targetuser)  # start function twitter_user_following_selenium
    # gather following from browser session
    session.get("https://twitter.com/#{targetuser}/following")  # request page from browser
    SeleniumWebHandler.pagescroll(session)  # call pagescroll function, find page end
    return session.page_source  # return resulting page source
  end  # close function twitter_user_following_selenium
  def self.twitter_get_followers(filename, session, hashfile, targetuser,
      search_type
  ) # start function twitter_get_followers_selenium
    # extract details from followers
    element = session.find_elements(:xpath, "//*[starts-with(@id, 'stream-item-user-')]")  # find userid element
    element.select { |everything|
      userid = everything.attribute('data-item-id')
      friendnick = everything.find_element(:css,
          'div > div > div.ProfileCard-userFields > div > div > a'
      ).attribute('href').to_s
      if friendnick.to_s == ""; friendnick = "Unknown" end
      friendavatar = everything.find_element(:css, 'div > div > a > img').attribute('src')
      if friendavatar.to_s == ""; friendavatar = "Unknown" end
      friendname = everything.find_element(:css, 'div > div > div.ProfileCard-userFields > div > div > a').text
      if friendname.to_s == ""; friendname = "Unknown" end
      friendbio = everything.find_element(:css, 'div > div > div.ProfileCard-userFields > p').text
      if friendbio.to_s == ""; friendbio = "Unknown" end
      hashfile[targetuser][search_type].store(userid, [friendname, friendnick, friendavatar, friendbio])
    }  # iterate over each element finding relevant information
    $hashfile = hashfile
  end  # close function twitter_get_followers_selenium
  def self.twitter_get_following(filename, session, hashfile, targetuser,
      search_type
  )  # start function twitter_get_following_selenium
    # extract details from following
    element = session.find_elements(:xpath, "//*[starts-with(@id, 'stream-item-user-')]") # find userid element
    element.select { |everything|
      userid = everything.attribute('data-item-id')
      friendnick = everything.find_element(:css,
        'div > div > div.ProfileCard-userFields > div > div > a'
      ).attribute('href').to_s.gsub("https://twitter.com/",'')
      if friendnick.to_s == ""; friendnick = "Unknown" end
      friendavatar = everything.find_element(:css, 'div > div > a > img').attribute('src')
      if friendavatar.to_s == ""; friendavatar = "Unknown" end
      friendname = everything.find_element(:css, 'div > div > div.ProfileCard-userFields > div > div > a').text
      if friendname.to_s == ""; friendname = "Unknown" end
      friendbio = everything.find_element(:css, 'div > div > div.ProfileCard-userFields > p').text
      if friendbio.to_s == ""; friendbio = "Unknown" end
      hashfile[targetuser][search_type].store(userid, [friendname, friendnick, friendavatar, friendbio])
    }  # iterate over each element finding relevant information
    $hashfile = hashfile
  end  # close function twitter_get_following_selenium
  def self.default_hash(targetuser)  # start function default_hash
    # identify if there is a file for a target to load from disk
    hashlist = {}  # generate default hash variable
    hashlist[targetuser] = {}  # assign hash with variable name
    hashlist[targetuser][$searchtype] = {}  # assign hash with variable name
    return hashlist  # return hashlist
  end  # close function default_hash
  def self.twitter_logoff_selenium(session)  # start function twitter_logoff_selenium
    session.get("https://twitter.com/logout")  # request twitter logout page
    session.find_element(:css, 'div > div > form > div.buttons > button').click  # send synthetic mouse click
    session.find_element(:css,'.js-submit').click  # send synthetic mouse click
    session.close  # close browser session
    return  # return to calling process
  end  # close function twitter_logoff_selenium
end  # close class TwitterAuth
########################################################################################################################
class SeleniumWebHandler  # start class SeleniumWebHandler
  def self.start_ff_driver  # start function start_ff_driver
    # Loads Firefox in headless mode
    begin  # start begin loop
      # EDIT ME BELOW TO MATCH YOU FILE LOCATIONS
      webdriver_path = File.join(File.absolute_path(File.dirname(
          "D:\\")),"webdriver", "geckodriver.exe"
      ) # set the location where the geckodriver is located, obviously edit to match your needs
      Selenium::WebDriver::Firefox.driver_path = webdriver_path  # set the geckodriver location in module
      driver = Selenium::WebDriver.for :firefox#, :profile => profile  # set the web browser web driver
      return driver  # returns driver to application for later use
    rescue => startfffail  # rescue any faults as variable
      if @diag; puts "Failed to start FF Driver: #{startfffail}" end  # if diag true, display error
    end  # close begin loop
  end  # close function start_ff_driver
  def goto(url)  # start function goto
    # uses the GET function from selenium
    @driver.get(url)  # request URl from headless browser session
    @driver.find_element(:css, '#doc > div.topbar.js-topbar > div').click  # send synthetic mouse click
  end  # close function goto
  def self.pagescroll(session)  # start function pagescroll
    # page source validation and break function
    @oldsource = ""  # sets variable with default value
    # Scrolls a page till the end
    begin  # start being loop
      # iterate over a stupid number to ensure coverage
      500000000.times { |counter|
        sleep 0.5  # take a nap
        @counter = counter  # keep score
        session.execute_script("document.body.scrollTop")  # set scroll top value
        session.execute_script("window.innerHeight")  # set inner height of window
        session.execute_script("if (
document.body.scrollHeight == document.body.scrollTop + window.innerHeight)
{return true}
else
{return false}")  # execute script as JS in browser
        session.execute_script("window.scrollTo(0, document.body.scrollHeight)")  # execute script as JS in browser
        if source_page_check(session)  # if page has touched the bottom
          break  # exit the begin loop
        end  # end if statement
      }
    rescue => pagescrollfail  # rescue any faults as variable
      if @diag; puts "PageScroll failed: #{pagescrollfail}" end  # if diag true, display error
    end  # stop being loop
    return  # return to calling process
  end  # close function pagescroll
  def self.teardown  # start function teardown
     # breaks down the web driver and closes the browser
     begin  # start begin loop
       @driver.quit  # send driver QUIT signal
     rescue => teardownfail  # rescue any faults as variable
       if @diag; puts "Teardown Failed: #{teardownfail}" end  # if diag true, display error
     end  # stop being loop
     return  # return to calling process
  end  # close function teardown
  def self.source_page_check(session)  # start function source_page_check
     # Checks the source of a page to see if anything has changed
     @newsource = session.page_source  # set variable with resulting page source
     if @newsource == @oldsource  # compare the values of new vs old
        return true  # resulting in true
     else  # if not, perform these other actions
        @oldsource = @newsource  # set the old variable to the new variable
        return false  # resulting in false
     end  # end if statement
  end  #close function source_page_check
end  # close class SeleniumWebHandler
############################################# FILE WRITER ##############################################################
def filewriter(filename, hashfile, targetuser, search_type)
  if filename  # if filename has been set, save userid to disk
    File.open(search_type.to_s+"_"+filename.to_s, 'w') {|f|
      f.puts(hashfile[targetuser][search_type].keys) }  # produce file
  end  # close if statement
end
#
########################################## USER ARGUMENTS ##############################################################
#
require 'selenium-webdriver'  # ensure module is included with the script
require 'optparse'  # ensure module is included with the script
require 'ostruct'  # ensure module is included with the script
@diag = false  # set diagnostics to FALSE, no verbose
#
# Take user arguments from commandline
#
options = OpenStruct.new  # create a new OpenStruct object
OptionParser.new do |opt|
  opt.on('-s','--search SEARCHTYPE','Types: ["following","followers","all"]') { |o|
     options[:searchtype] = o }  # searchtype from arguments @ cli
  opt.on('-t','--target PERSONALITY','Target twitter personality to produce list from') { |o|
     options[:targetuser] = o }  # targetuser from arguments @ cli
  opt.on('-o','--output FILENAME','The filename which to store the generated CSV list') { |o|
     options[:filename] = o }  # filename from arguments @ cli
  opt.on('-p','--password PASSWORD','Your twitter password for Authentication') { |o|
     options[:password] = o }  # password from arguments @ cli
  opt.on('-u','--username USERNAME','Your twitter username for Authentication') { |o|
     options[:username] = o }  # username from arguments @ cli
end.parse!
#
########################################### GLOBAL ARGUMENTS ###########################################################
#
$username   = options.username.to_s  # set username to global variable
$password   = options.password.to_s  # set password to global variable
$targetuser = options.targetuser.to_s  # set target user to global variable
$searchtype = options.searchtype.to_s  # set search type to global variable
$filename   = options.filename.to_s  # set file name to global variable
$bsession   = SeleniumWebHandler.start_ff_driver  # start Firefox browser in headless mode
$hashfile   = TwitterAuth.default_hash($targetuser)  # generate the default hash file
#
################################################ START MAIN LOGIC ######################################################
#
begin
  TwitterAuth.twitter_login_selenium($bsession, $username, $password)  # log into the twitter web application
  TwitterAuth.twitter_userinfo($bsession, $targetuser)  # get target personality information from page
  TwitterAuth.twitter_get_userinfo($bsession, $hashfile, $targetuser, $searchtype)  # process personality info & stow
  if $searchtype.downcase.to_s == 'followers'  # if searching for followers only
    TwitterAuth.twitter_user_followers($bsession, $targetuser)  # request followers page
    TwitterAuth.twitter_get_followers($filename, $bsession, $hashfile, $targetuser, $searchtype
    )  # page scroll and gather followers information, stow in hash
    filewriter($filename, $hashfile, $targetuser, $searchtype)  # write list to disk
  end  # end if statement
  if $searchtype.downcase.to_s == 'following'  # if searching for following only
    TwitterAuth.twitter_user_following($bsession, $targetuser)  # request followers page
    TwitterAuth.twitter_get_following($filename, $bsession, $hashfile, $targetuser, $searchtype
    )  # page scroll and gather following information, stow in hash
    filewriter($filename, $hashfile, $targetuser, $searchtype)  # write list to disk
  end  # end if statement
  if $searchtype.downcase.to_s == 'all'  # if searching for all
    TwitterAuth.twitter_user_followers($bsession, $targetuser)  # request followers page
    TwitterAuth.twitter_get_followers($filename, $bsession, $hashfile, $targetuser, 'followers'
    )  # page scroll and gather followers information, stow in hash
    filewriter($filename, $hashfile, $targetuser, 'followers')  # write list to disk
    TwitterAuth.twitter_user_following($bsession, $targetuser)  # request following page
    TwitterAuth.twitter_get_following($filename, $bsession, $hashfile, $targetuser, 'following'
    )  # page scroll and gather following information, stow in hash
    filewriter($filename, $hashfile, $targetuser, 'following')  # write list to disk
  end  # end if statement
rescue => mainfailed  # rescue any faults with parsing
  puts "Application Failed: #{mainfailed}"  # display error
end  # stop being loop
################################################# THE END ##############################################################
