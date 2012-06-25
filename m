From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 7/7] ARM: mxs: Add SPI driver for mx233/mx28
Date: Mon, 25 Jun 2012 10:22:24 -0300
Message-ID: <CAOMZO5BYoU5=tJCUH1nkT24FJhhXXhNwF46yYREGJj7G33HdVg@mail.gmail.com>
References: <1340477033-2761-1-git-send-email-marex@denx.de>
	<1340477033-2761-7-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>,
	Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>,
	Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1340477033-2761-7-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

SGkgTWFyZWssCgpPbiBTYXQsIEp1biAyMywgMjAxMiBhdCAzOjQzIFBNLCBNYXJlayBWYXN1dCA8
bWFyZXhAZGVueC5kZT4gd3JvdGU6Cgo+ICsgwqAgwqAgwqAgc3NwLT5jbGsgPSBjbGtfZ2V0KCZw
ZGV2LT5kZXYsIE5VTEwpOwo+ICsgwqAgwqAgwqAgaWYgKElTX0VSUihzc3AtPmNsaykpIHsKPiAr
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldCA9IFBUUl9FUlIoc3NwLT5jbGspOwo+ICsgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgZ290byBvdXRfc3BpX2ZyZWU7Cj4gKyDCoCDCoCDCoCB9CgpZb3UgY291
bGQgdXNlIGRldm1fY2xrX2dldCBoZXJlIGluc3RlYWQsCgoKPiArCj4gKyDCoCDCoCDCoCBjbGtf
cHJlcGFyZV9lbmFibGUoc3NwLT5jbGspOwo+ICsgwqAgwqAgwqAgc3NwLT5jbGtfcmF0ZSA9IGNs
a19nZXRfcmF0ZShzc3AtPmNsaykgLyAxMDAwOwo+ICsKPiArIMKgIMKgIMKgIHN0bXBfcmVzZXRf
YmxvY2soc3NwLT5iYXNlKTsKPiArCj4gKyDCoCDCoCDCoCBwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShw
ZGV2LCBob3N0KTsKPiArCj4gKyDCoCDCoCDCoCByZXQgPSBzcGlfcmVnaXN0ZXJfbWFzdGVyKGhv
c3QpOwo+ICsgwqAgwqAgwqAgaWYgKHJldCkgewo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGV2
X2VycigmcGRldi0+ZGV2LCAiQ2Fubm90IHJlZ2lzdGVyIFNQSSBtYXN0ZXIsICVkXG4iLCByZXQp
Owo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ290byBvdXRfY2xrX3B1dDsKPiArIMKgIMKgIMKg
IH0KPiArCj4gKyDCoCDCoCDCoCByZXR1cm4gMDsKPiArCj4gK291dF9jbGtfcHV0Ogo+ICsgwqAg
wqAgwqAgY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHNzcC0+Y2xrKTsKPiArIMKgIMKgIMKgIGNsa19w
dXQoc3NwLT5jbGspOwoKLGFuZCB0aGVuIHlvdSB3b3VsZCBub3QgbmVlZCB0aGlzIGNsa19wdXQg
aGVyZS4KCkRyaXZlciBsb29rcyBnb29kLiBUaGFua3MgZm9yIHdvcmtpbmcgb24gaXQuCgpSZWdh
cmRzLAoKRmFiaW8gRXN0ZXZhbQoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkxpdmUgU2VjdXJpdHkg
VmlydHVhbCBDb25mZXJlbmNlCkV4Y2x1c2l2ZSBsaXZlIGV2ZW50IHdpbGwgY292ZXIgYWxsIHRo
ZSB3YXlzIHRvZGF5J3Mgc2VjdXJpdHkgYW5kIAp0aHJlYXQgbGFuZHNjYXBlIGhhcyBjaGFuZ2Vk
IGFuZCBob3cgSVQgbWFuYWdlcnMgY2FuIHJlc3BvbmQuIERpc2N1c3Npb25zIAp3aWxsIGluY2x1
ZGUgZW5kcG9pbnQgc2VjdXJpdHksIG1vYmlsZSBzZWN1cml0eSBhbmQgdGhlIGxhdGVzdCBpbiBt
YWx3YXJlIAp0aHJlYXRzLiBodHRwOi8vd3d3LmFjY2VsYWNvbW0uY29tL2phdy9zZnJubDA0MjQy
MDEyLzExNC81MDEyMjI2My8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18Kc3BpLWRldmVsLWdlbmVyYWwgbWFpbGluZyBsaXN0CnNwaS1kZXZlbC1nZW5lcmFs
QGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0
cy9saXN0aW5mby9zcGktZGV2ZWwtZ2VuZXJhbAo=
