#!/bin/bash 
# Function to check if given command exist !! 
is_Command_Exist(){ 
 local arg="$1" 
 type "$arg" &> /dev/null
 return $? 
} 
# Install Function 
install_package(){ 
 local arg="$1" 
 sudo apt-get update 
 sudo apt-get upgrade -f 
 sudo apt install "$arg" 
} 
# Navigate to the dir 
change_dir(){ 
 local arg="$1" 
 cd ~ 
 cd "$arg" 
 return $? 
} 
is_dir_Exist(){ 
 local arg="$1" 
 cd ~ 
 cd ../.. 
 cd "$arg" 
 return $? 
} 
# Check Java exist or not? 
if is_Command_Exist "java"; then 
 echo "Java is installed in this ubuntu" 
else 
 echo "Java is not installed" 
 install_package "openjdk-8-jdk"; 
fi
# Check git exist or not? 
if is_Command_Exist "git"; then 
 echo "git is installed in this ubuntu" 
else 
 echo "git is not installed" 
 install_package "git"; 
fi
# Check chrome exist or not? 
if is_dir_Exist "opt/google/chrome"; then 
 echo "chrome is installed in this ubuntu" 
else 
 echo "chrome is not installed" 
 wget 
http://mirror.cs.uchicago.edu/google-chrome/pool/main/g/google-chrome-stable/google-chrome-sta
ble_114.0.5735.198-1_amd64.deb 
 sudo dpkg -i google-chrome-stable_114.0.5735.198-1_amd64.deb 
 sudo apt --fix-broken install 
fi
# Check Maven exist or not? 
if is_Command_Exist "mvn"; then 
 echo "Maven is installed in this ubuntu" 
else 
 echo "mvn is not installed" 
 install_package "maven"; 
fi
# check Xvfb exists or not? 
if is_Command_Exist "dpkg -l | grep -qw xvfb"; then 
 echo "Xvfb is installed in this ubuntu" 
else 
 echo "Xvfb is not installed" 
 sudo apt update 
 sudo DEBIAN_FRONTEND=noninteractive apt install -y "xvfb"; 
fi
# Check webdriver folder exist or not? 
if change_dir "selenium/webdriver-tests/webdriver-tests/"; then 
 echo "selenium web driver tests is installed in this ubuntu" 
 ls | grep pom.xml 
else 
 echo "Web driver test is not installed" 
 mkdir selenium 
 cd selenium 
 mkdir webdriver-tests 
 cd webdriver-tests 
 git clone https://github.com/TestLeafInc/webdriver-tests 
fi
cd ~ 
change_dir "selenium/webdriver-tests/webdriver-tests/" 
mvn clean test