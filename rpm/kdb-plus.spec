## Template RPM Spec File for kdb+

## Copyright (c) 2014 Jaskirat M.S. Rajasansir
## License BSD, see LICENSE for details

Name:           kdb-plus
Version:        ~~VERSION~~
Release:        ~~RELEASE~~
Summary:        kdb+ Database and q Programming Language

Group:          kx/kdb
License:        Custom (http://kx.com/software-download.php)
URL:            http://kx.com/
Source0:        %{name}-%{version}-%{release}.tar.gz

Prefix:         /opt
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-build

ExclusiveArch:  i386 x86_64
ExclusiveOS:    linux


%description
From http://kx.com/software.php:

Kx offers kdb+, a high-performance column-store database with a built-in 
expressive query and programming language, q. Used as a central repository 
to store time-series data within an enterprise, kdb+ supports real-time analysis 
of billions of records and fast access to terabytes of historical data. It also:

 - provides seamless scalability;
 - runs on industry standard server platforms;
 - is top-ranked in third-party benchmark testing;
 - has an extremely small footprint, which makes installation and maintenance 
fast and straightforward;
 - easily accommodates available APIs for connectivity to major external systems 
and modules;
 - requires fewer developers, contributing to lower total cost of ownership.

The result? A rich environment of powerful solutions.

%prep
%setup %{name}-%{version}-%{release}.tar.gz

%build
mkdir -p %{buildroot}/opt/kdb-plus

%post

%clean
rm -rf $RPM_BUILD_ROOT

%changelog

%files
/etc/profile.d/kdb-plus.sh
/opt/kdb-plus/%{name}-%{version}

%install
install -m 755 -d %{buildroot}/etc/profile.d
install -m 755 ../%{name}-%{version}/kdb-plus.profile %{buildroot}/etc/profile.d/kdb-plus.sh
# Auto completed below here

