From: "Chen, Alvin" <alvin.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] SPI: spi-pxa2xx: SPI support for Intel Quark X1000
Date: Sun, 28 Sep 2014 03:23:21 +0000
Message-ID: <4656BEB6164FC34F8171C6538F1A595B2E99710F@SHSMSX101.ccr.corp.intel.com>
References: <1411752349-31490-1-git-send-email-alvin.chen@intel.com>
	 <1411752349-31490-2-git-send-email-alvin.chen@intel.com>
	 <20140926100832.GE27755@sirena.org.uk>
 <1411741357.22717.4.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Westerberg, Mika" <mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"Kweh, Hock Leong" <hock.leong.kweh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"Ong, Boon Leong" <boon.leong.ong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"Tan, Raymond" <raymond.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411741357.22717.4.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

PiANCj4gPg0KPiA+ID4gKy8qICBzZWUgUXVhcmsgU1BJIGRhdGEgc2hlZXQgZm9yIGltcGxlbWVu
dGF0aW9uIHJhdGlvbmFsZSAqLyBzdGF0aWMNCj4gPiA+ICt1MzIgcXVhcmtfeDEwMDBfc2V0X2Ns
a19yZWd2YWxzKHUzMiByYXRlLCB1MzIgKmRkcywgdTMyICpjbGtfZGl2KSB7DQo+ID4NCj4gPiBQ
bGVhc2UgZG9jdW1lbnQgdGhpcyBpbiB0aGUgZHJpdmVyIC0gSSBkb24ndCBrbm93IGlmIHRoaXMg
ZGF0YXNoZWV0IGlzDQo+ID4gcHVibGljIGJ1dCBldmVuIGlmIGl0IGlzIGl0IG1heSBub3Qgc3Rh
eSB0aGF0IHdheS4NCj4gDQo+IERhdGFzaGVldCBpcyBwdWJsaWMuDQo+IEknbSBqdXN0IHdvbmRl
cmluZyBpZiB3ZSBjYW4gdXNlIGp1c3QgYSBmb3JtdWxhIGluc3RlYWQgb2YgdGFibGUuDQo+IA0K
QXMgSSBzYWlkIGJlZm9yZSwgdGhlcmUgYXJlIHR3byBmb3JtdWxhcywgYnV0IGZvciB0aGUgZ2l2
ZW4gcmF0ZSwgZnJvbSB0aGUgZm9ybXVsYXMsIHdlIGNhbiBnZXQgYSBsb3Qgb2YgPGRkcywgY2xr
X2Rpdj4gcGFpcnMsDQphbmQgd2UgYWxzbyBuZWVkIHRvIHNlbGVjdCB0aGVtIGFjY29yZGluZyB0
byB0aGUgZ3VpZGVsaW5lcyB3aGljaCBpcyBub3QgZm9ybXVsYS4gVGhlIHRhYmxlIHRoZSBkYXRh
c2hlZXQgZ2l2ZW4gc2hvdWxkIGJlDQp0aGUgYmVzdCBvbmUgdG8gbWVldCB0aGUgaml0dGVyIGFu
ZCBkdXR5IGN5Y2xlcyBhcyB0aGUgZGF0YXNoZWV0IGRvY3VtZW50ZWQuDQoNCg==
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
