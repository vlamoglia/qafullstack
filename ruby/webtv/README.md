### Installation

This script requires:
+ [Ruby] https://www.ruby-lang.org/en/documentation/installation/
+ [Chromedriver] https://chromedriver.chromium.org/
+ [Capybara] https://github.com/teamcapybara/capybara
+ [RSpec] https://rspec.info/

### Modifying the script
Open forms_spec.rb and change the data between "#Change the data below - START" and "END". 

### Running the script
```sh
$ rspec -fd
```
### Troubleshooting
If the chromedriver version is incompatible:
+ Install Homebrew [https://brew.sh/]
```sh
$ brew cask reinstall chromedriver
$ cd /usr/local/Caskrook/chromedriver/<latest version>
$ xattr -d com.apple.quarantine.chromedriver
```