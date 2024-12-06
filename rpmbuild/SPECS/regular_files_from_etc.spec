Name:           regular_files_from_etc
Version:        1.0
Release:        1%{?dist}
Summary:        RPM with regular files from /etc directory 
License:        GPL
Source0:        etc
BuildRoot:      %{_tmppath}/%{name}-%{version}-root

%description
This package contains  regular file from /etc directory.

%prep

%build

%install
mkdir -p %{buildroot}/etc_files
cp -r /home/kitimist/rpmbuild/SOURCES/*  %{buildroot}/etc_files/

%clean 
rm -rf %{buildroot}

%files
/etc_files/*

%changelog
*  Thu Oct 31 2024 Alona Moroz <kitimist@gmail.com> - 1.0-1
- Initial package creation