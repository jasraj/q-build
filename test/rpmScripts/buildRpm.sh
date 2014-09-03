wget -P /tmp/ http://kx.com/347_d0szre-fr8917_llrsT4Yle-5839sdX/3.1/linux.zip 

unzip -d /tmp /tmp/linux.zip 

/q-build/rpm/build.sh 3.1-2014.08.22 /tmp/q /tmp/rpm-output