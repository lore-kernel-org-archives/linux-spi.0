From: "Chen, Alvin" <alvin.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 1/2 v3] SPI: spi-pxa2xx: Add helpers for regiseters'
 accessing
Date: Fri, 31 Oct 2014 05:43:08 +0000
Message-ID: <4656BEB6164FC34F8171C6538F1A595B2E9A9CB6@SHSMSX101.ccr.corp.intel.com>
References: <1412783423-9408-1-git-send-email-alvin.chen@intel.com>
	 <1412783423-9408-2-git-send-email-alvin.chen@intel.com>
	 <4656BEB6164FC34F8171C6538F1A595B2E9A90E6@SHSMSX101.ccr.corp.intel.com>
	 <5450CF36.7060105@nexus-software.ie>
	 <4656BEB6164FC34F8171C6538F1A595B2E9A92B3@SHSMSX101.ccr.corp.intel.com>
 <1414653134.2396.67.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Westerberg, Mika" <mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"Kweh, Hock Leong" <hock.leong.kweh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"Ong, Boon Leong" <boon.leong.ong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"Tan, Raymond" <raymond.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Bryan O'Donoghue <pure.logic-SyKdqv6vbfZdzvEItQ6vdLNAH6kLmebB@public.gmane.org>,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"Russell King" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

PiA+DQo+ID4gQWxsIG9mIHRob3NlIHBhdGNoZXMgYXJlIGluIHYzLjE4LXJjMSwgc28geW91IG1h
eSByZWJhc2Ugb24gdG9wIG9mDQo+ID4gMy4xOC1yY1ggc2FmZWx5IEkgZ3Vlc3MuDQo+ID4NCj4g
QW5keSwgSSByZW1lbWJlciB5b3UgYXNrIG1lIHRvIHJlYmFzZSBvbiB0aGUgc2xhdmUtZG1hIHRy
ZWUgKGdpdC5pbmZyYWRlZC5vcmcpDQo+IGZvci1saW51cyBicmFuY2gsIGFuZCB0aGUgc2xhdmUt
ZG1hIGZvci1saW51cyBicmFuY2ggd2lsbCBiZSByZWFwcGxpZWQgb24gdG9wIG9mDQo+IHYzLjE5
LXJjMS4NCj4gDQpKdXN0IHRvIGNvbmZpcm0sIHRoZXNlIHBhdGNoZXMgY2FuIGJlIGFwcGxpZWQg
d2VsbCBvbiB0b3Agb2YgMy4xOC1yYzIuDQoNCj4gU28gbm93IEkgbmVlZCByZWJhc2Ugb24gdG9w
IG9mIDMuMTgtcmNYLCBpc24ndCBpdD8gSnVzdCB0byBjb25maXJtLg0KDQo=
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
