#!/data/data/com.termux/files/usr/bin/bash
apt install ruby
gem install lolcat
echo "##############################################" | lolcat
echo " Auto Install Metasploit " | lolcat
echo "##############################################"

echo "Installing Metasploit............" 

echo "####################################"  | lolcat
apt install autoconf bison clang coreutils curl findutils git apr figlet apr-util libffi-dev libgmp-dev libpcap-dev postgresql-dev readline-dev libsqlite-dev openssl-dev libtool libxml2-dev libxslt-dev ncurses-dev pkg-config postgresql-contrib wget make ruby-dev libgrpc-dev ncurses-utils termux-tools -y | lolcat
echo "####################################" | lolcat
echo "Downloading & Extracting....." | lolcat

curl -L https://github.com/rapid7/metasploit-framework/archive/4.14.28.tar.gz | tar xz

mv metasploit-framework-4.14.28 metasploit
cd metasploit

sed 's|git ls-files|find -type f|' -i metasploit-framework.gemspec

sed -i 's/grpc (1.3.4)/grpc (1.4.1)/g' Gemfile.lock
#Install bundler
echo "Bundler is installing"
gem install bundler

#Install nokogiri
echo "nokogiri is installing......"
gem install nokogiri -- --use-system-libraries

#Install Network-Interface

gem unpack network_interface
cd network_interface-0.0.1
sed 's|git ls-files|find -type f|' -i network_interface.gemspec
curl -L https://wiki.termux.com/images/6/6b/Netifaces.patch -o netifaces.patch
patch -p1 < netifaces.patch
gem build network_interface.gemspec
echo "network_interface is installing........"
gem install network_interface-0.0.1.gem
cd ..
rm -r network_interface-0.0.1

#Install gems
gem unpack grpc -v 1.4.1
cd grpc-1.4.1
curl -LO https://raw.githubusercontent.com/grpc/grpc/v1.4.1/grpc.gemspec
curl -L https://wiki.termux.com/images/b/bf/Grpc_extconf.patch -o extconf.patch
patch -p1 < extconf.patch
gem build grpc.gemspec
echo "grpc is installing"
gem install grpc-1.4.1.gem
cd ..
rm -r grpc-1.4.1

#Bundle Install
echo "bundle and all other dependencies are installing......"
bundle install -j5

#Fixing Shebang
$PREFIX/bin/find -type f -executable -exec termux-fix-shebang \{\} \;

cd metasploit
ln -d -s $HOME/metasploit/msfconsole $PREFIX/bin
ln -d -s $HOME/metasploit/msfvenom $PREFIX/bin
ln -d -s $HOME/metasploit/msfupdate $PREFIX/bin
echo " =================== " | lolcat
figlet IqbalFAF | lolcat
echo " =================== " | lolcat
echo " Tinggal di jalankan msfconsole " | lolcat
figlet SELESAI | lolcat

