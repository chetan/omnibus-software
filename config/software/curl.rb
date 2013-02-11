#
# Copyright:: Copyright (c) 2012 Opscode, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "curl"
version "7.29.0"
md5 = "4f57d3b4a3963038bd5e04dbff385390"

dependencies ["zlib", "openssl"]

source :url => "http://curl.haxx.se/download/curl-#{version}.tar.gz",
       :md5 => md5

relative_path "#{name}-#{version}"

env = {
  "LDFLAGS"     => "-L#{install_dir}/embedded/lib",
  "CPPFLAGS"    => "-I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
}

build do
  command ["./configure",
           "--prefix=#{install_dir}/embedded",
           "--disable-debug",
           "--enable-optimize",
           "--disable-ldap",
           "--disable-ldaps",
           "--disable-rtsp",
           "--enable-proxy",
           "--disable-dependency-tracking",
           "--enable-ipv6",
           "--without-libidn",
           "--with-ssl=#{install_dir}/embedded",
           "--with-zlib=#{install_dir}/embedded",
           "--without-gnutls",
           "--without-polarssl",
           "--without-cyassl",
           "--without-librtmp"].join(" "), :env => env

  command "make -j #{max_build_jobs}", :env => env
  command "make install"
end
