From: Christian Hartmann <cornogle@googlemail.com>
Subject: Re: Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init
 of WM510205 codec via ACPI (resend)
Date: Fri, 17 Jul 2015 09:11:07 +0200
Message-ID: <CAKor6TcTrTzcf3u=UVoP9rkFS0cQYNWUBT1HEsWnTJfwoTKuEg@mail.gmail.com>
References: <20150626115823.GY14071@sirena.org.uk>
 <CAKor6Tf20eC1WQSO=AV2b+XoB5Qv-2Oin_nrrTJUiDV4czxLjA@mail.gmail.com>
 <20150629094854.GB11162@sirena.org.uk>
 <CAKor6TdDPb2qOgdHbeX2w+yQa_ioDM5ak9bk+=jF+cKt_twiXw@mail.gmail.com>
 <20150630103404.GI6321@opensource.wolfsonmicro.com>
 <CAKor6TdKk2OUz4o12RiQBSVZyhD=L4JpBJcYkGE=_6X+ZeQY_g@mail.gmail.com>
 <20150713095359.GM16517@opensource.wolfsonmicro.com>
 <CAKor6Td83zgOS+iHGHGhFW4n26H=tC-QQDuzaHHfybhLeH-jvw@mail.gmail.com>
 <CAKor6TdheYM73aqti362bOnP2GZmX60uuDY5v2eow1vqO9tcKw@mail.gmail.com>
 <20150715081224.GN16517@opensource.wolfsonmicro.com>
 <20150715091709.GK11162@sirena.org.uk>
 <CAKor6TcSc7n=Rd9NJAf-6cYXr50Z62cbcsbuaEutRMPAiM=2NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: alsa-devel@alsa-project.org, mika.westerberg@linux.intel.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org,
 jarkko.nikula@linux.intel.com, Daniel Mack <daniel@zonque.org>,
 Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>, dan.carpenter@oracle.com
To: Mark Brown <broonie@kernel.org>
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <CAKor6TcSc7n=Rd9NJAf-6cYXr50Z62cbcsbuaEutRMPAiM=2NQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
List-Id: linux-spi.vger.kernel.org

SGksCgpJIGhhZCBhbHJlYWR5IGFza2VkIGFib3V0IHRoZSBweGEyeHggYW5kIHRoZSBQSU8gbW9k
ZSAoYWthIG5vIERNQQpjaGFubmVscyBhdmFpbGFibGUpLgpJZiBJIHJlbWVtYmVyIGNvcnJlY3Rs
eSwgaXQgZG9lcyBub3QgbmVlZCBETUEgYXQgYWxsLgoKT3RoZXJ3aXNlIEkgc2VlIGxhdGVyIGlu
IGRtZXNnIHRoZSBEZXNpZ25XYXJlIERNQSBDb250cm9sbGVyICgyeCkgw6AgOCBjaGFubmVscy4K
CklzIHRoZSBweGEyeHggbm90IHVzaW5nIHRoZSBETUEgbW9kZSBjYXVzZSB0aGUgRGVzaWdud2Fy
ZSBjb250cm9sbGVycwphcmUgaW5pdGlhbGl6ZWQgbGF0ZXI/PwpPciBoYXMgdGhpcyBub3RoaW5n
IHRvIGRvIHdpdGggaXQgYXQgYWxsID8gU3RpbGwgaW50ZXJlc3RlZC4uLgoKc25pcCBvZiBkbWVz
ZzoKWyAgICA2LjE2NDQwOV0gcHhhMnh4LXNwaSA4MDg2MEYwRTowMDogbm8gRE1BIGNoYW5uZWxz
IGF2YWlsYWJsZSwgdXNpbmcgUElPClsgICAgNi4xNjQ0ODVdIHB4YTJ4eC1zcGkgODA4NjBGMEU6
MDA6IHJlZ2lzdGVyZWQgbWFzdGVyIHNwaTMyNzY2IChkeW5hbWljKQpbICAgIDYuMTY1MDIwXSBz
cGkgc3BpLVdNNTEwMjA1OjAwOiA4MzMzMzMzIEh6IGFjdHVhbCwgUElPClsgICAgNi4xNjUwMjhd
IHNwaSBzcGktV001MTAyMDU6MDA6IHNldHVwIG1vZGUgMCwgOCBiaXRzL3csIDgwMDAwMDAgSHog
bWF4IC0tPiAwCi4uLgpbICAgIDYuMzkyNTUyXSBkd19kbWFjIElOVEw5QzYwOjAwOiBEZXNpZ25X
YXJlIERNQSBDb250cm9sbGVyLCA4IGNoYW5uZWxzClsgICAgNi4zOTYzMTBdIGR3X2RtYWMgSU5U
TDlDNjA6MDE6IERlc2lnbldhcmUgRE1BIENvbnRyb2xsZXIsIDggY2hhbm5lbHMKCgpzbyBmYXIK
Y2hyaXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxz
YS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9t
YWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
