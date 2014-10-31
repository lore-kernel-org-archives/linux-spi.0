From: "Chen, Alvin" <alvin.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 1/2 v3] SPI: spi-pxa2xx: Add helpers for regiseters'
 accessing
Date: Fri, 31 Oct 2014 01:03:38 +0000
Message-ID: <4656BEB6164FC34F8171C6538F1A595B2E9A9417@SHSMSX101.ccr.corp.intel.com>
References: <1412783423-9408-1-git-send-email-alvin.chen@intel.com>
	 <1412783423-9408-2-git-send-email-alvin.chen@intel.com>
	 <4656BEB6164FC34F8171C6538F1A595B2E9A90E6@SHSMSX101.ccr.corp.intel.com>
	 <5450CF36.7060105@nexus-software.ie>
	 <4656BEB6164FC34F8171C6538F1A595B2E9A92B3@SHSMSX101.ccr.corp.intel.com>
 <1414653134.2396.67.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Bryan O'Donoghue <pure.logic-SyKdqv6vbfZdzvEItQ6vdLNAH6kLmebB@public.gmane.org>,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	"Haojian Zhuang" <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Westerberg, Mika" <mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"Kweh, Hock Leong" <hock.leong.kweh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"Ong, Boon Leong" <boon.leong.ong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"Tan, Raymond" <raymond.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1414653134.2396.67.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

DQo+IA0KPiBPbiBUaHUsIDIwMTQtMTAtMzAgYXQgMDE6MDIgKzAwMDAsIENoZW4sIEFsdmluIHdy
b3RlOg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IEhpIEFsdmluLCBXZWlrZS4NCj4gPiA+DQo+ID4g
PiBJJ20gbm90IGNsZWFyIGlmIHRoZXNlIHBhdGNoZXMgYXBwbHkgdG8gdGhlIGN1cnJlbnQgdGlw
LW9mLXRyZWUuDQo+ID4gPg0KPiA+ID4gSSB0aG91Z2h0IHRoZSBhY3Rpb24gcmVxdWlyZWQgaGVy
ZSwgd2FzIGZvciBhIHJlc2VuZCBvZiBwYXRjaGVzIHRvDQo+ID4gPiBlbnN1cmUgdGhleSBhcHBs
aWVkIHRvIHRpcC1vZi10cmVlID8NCj4gPiA+DQo+ID4gQXMgSSBzYWlkIGJlZm9yZSwgaXQgaXMg
YmFzZWQgb24gdGhlIHNsYXZlLWRtYSB0cmVlIChnaXQuaW5mcmFkZWQub3JnKSBmb3ItbGludXMN
Cj4gYnJhbmNoLCB3aGljaCB3aWxsIGJlIHJlYXBwbGllZCBvbiB0b3Agb2YgdjMuMTktcmMxLg0K
PiA+DQo+ID4gVGhhdCBpcyB0byBzYXkgdGhlc2UgcGF0Y2hlcyB3aWxsIGJlIGFwcGxpZWQgdG8g
c2xhdmUtZG1hIHRyZWUgZm9yLWxpbnVzIGJyYW5jaCwNCj4gYW5kIHRoZW4gdGhlIHNsYXZlLWRt
YSB0cmVlIGZvci1saW51cyBicmFuY2ggd2lsbCBiZSBhcHBsaWVkIHRvIHYzLjE5Lg0KPiA+IEFu
ZHksIGFtIEkgcmlnaHQ/DQo+IA0KPiBBbGwgb2YgdGhvc2UgcGF0Y2hlcyBhcmUgaW4gdjMuMTgt
cmMxLCBzbyB5b3UgbWF5IHJlYmFzZSBvbiB0b3Agb2YgMy4xOC1yY1gNCj4gc2FmZWx5IEkgZ3Vl
c3MuDQo+IA0KQW5keSwgSSByZW1lbWJlciB5b3UgYXNrIG1lIHRvIHJlYmFzZSBvbiB0aGUgc2xh
dmUtZG1hIHRyZWUgKGdpdC5pbmZyYWRlZC5vcmcpIGZvci1saW51cyBicmFuY2gsIGFuZCB0aGUg
c2xhdmUtZG1hIGZvci1saW51cyBicmFuY2ggd2lsbCBiZSByZWFwcGxpZWQgb24gdG9wIG9mIHYz
LjE5LXJjMS4NCg0KU28gbm93IEkgbmVlZCByZWJhc2Ugb24gdG9wIG9mIDMuMTgtcmNYLCBpc24n
dCBpdD8gSnVzdCB0byBjb25maXJtLg0KDQo=
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
