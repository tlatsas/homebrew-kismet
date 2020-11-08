class Kismet < Formula
  desc "Wireless network and device detector, sniffer, wardriving tool, and WIDS framework."
  homepage "https://www.kismetwireless.net/"
  url "https://github.com/kismetwireless/kismet/archive/kismet-2020-09-R4.tar.gz"
  sha256 "c9044b60f5efc2a83c024d51ea16dd549ec158c3bb8b36019513d91cd5b2f94c"
  version "2020-09-R4"
  head "https://github.com/kismetwireless/kismet.git"
  license "GPL-2.0-only"

  depends_on "pkg-config" => :build
  depends_on "python@3.9"
  depends_on "libpcap"
  depends_on "protobuf"
  depends_on "protobuf-c"
  depends_on "pcre"
  depends_on "librtlsdr"
  depends_on "libbtbb"
  depends_on "ubertooth"
  depends_on "libusb"
  depends_on "libwebsockets"

  def install
    inreplace "Makefile.in" do |s|
      s.gsub! "-o $(INSTUSR) -g $(SUIDGROUP)", ""
      s.gsub! "-o $(INSTUSR) -g $(INSTGRP)", ""
    end

    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match "Kismet 2020-00-GIT", shell_output("#{bin}/kismet --version")
  end
end
