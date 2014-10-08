From: "Chen, Alvin" <alvin.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 1/2 v2] SPI: spi-pxa2xx: Add helpers for regiseters'
 accessing
Date: Wed, 8 Oct 2014 00:46:58 +0000
Message-ID: <4656BEB6164FC34F8171C6538F1A595B2E997C28@SHSMSX101.ccr.corp.intel.com>
References: <1412000548-9908-1-git-send-email-alvin.chen@intel.com>
	 <1412000548-9908-2-git-send-email-alvin.chen@intel.com>
 <1411980737.10697.0.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
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
In-Reply-To: <1411980737.10697.0.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

DQo+IEknbSBva2F5IHdpdGggdGhlIGN1cnJlbnQgdmVyc2lvbiwgdGhvdWdoIEkgaGF2ZSBmZXcg
bWlub3IgY29tbWVudHMgYmVsb3cuDQo+IA0KPiA+IEludHJvZHVjZSBoZWxwZXIgZnVuY3Rpb25z
IHRvIGFjY2VzcyB0aGUgJ1NTQ1IwJyBhbmQgJ1NTQ1IxJy4NCj4gPg0KPiANCj4gTGlrZSB5b3Ug
c2FpZCBpbiB0aGUgc3VtbWFyeSB0aGVyZSBhcmUgbWFueSBhY2Nlc3NvcnMgdG8gbWFueSByZWdp
c3RlcnMsIG5vdA0KPiBvbmx5IGNyMS9jcjAuIFBlcmhhcHMsIHlvdSBtYXkgZXh0ZW5kIHlvdXIg
Y29tbWl0IG1lc3NhZ2UuDQo+IA0KT0suDQoNCj4gSW4gYW55IGNhc2UNCj4gUmV2aWV3ZWQtYnk6
IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPg0KPiAN
Ck9LLg0KPiA+ICsNCj4gPiAgLyoNCj4gPiAgICogUmVhZCBhbmQgd3JpdGUgTFBTUyBTU1AgcHJp
dmF0ZSByZWdpc3RlcnMuIENhbGxlciBtdXN0IGZpcnN0IGNoZWNrIHRoYXQNCj4gPiAgICogaXNf
bHBzc19zc3AoKSByZXR1cm5zIHRydWUgYmVmb3JlIHRoZXNlIGNhbiBiZSBjYWxsZWQuDQo+ID4g
QEAgLTIzNCw3ICszMDEsNyBAQCBzdGF0aWMgaW50IG51bGxfd3JpdGVyKHN0cnVjdCBkcml2ZXJf
ZGF0YSAqZHJ2X2RhdGEpDQo+ID4gIAl2b2lkIF9faW9tZW0gKnJlZyA9IGRydl9kYXRhLT5pb2Fk
ZHI7DQo+ID4gIAl1OCBuX2J5dGVzID0gZHJ2X2RhdGEtPm5fYnl0ZXM7DQo+ID4NCj4gPiAtCWlm
ICgoKHJlYWRfU1NTUihyZWcpICYgU1NTUl9URkxfTUFTSykgPT0gU1NTUl9URkxfTUFTSykNCj4g
PiArCWlmIChweGEyeHhfc3BpX3R4Zmlmb19mdWxsKGRydl9kYXRhKQ0KPiA+ICAJCXx8IChkcnZf
ZGF0YS0+dHggPT0gZHJ2X2RhdGEtPnR4X2VuZCkpDQo+IA0KPiBKdXN0IHdvbmRlcmluZyBpZiB0
aG9zZSB0d28gY291bGQgZml0IG9uZSBsaW5lLg0KPiANCk5vLCBpZiBtYWtlIHRoZSB0d28gaW4g
b25lIGxpbmUsIGl0IGlzIDg0IGNoYXJhY3RlcnMuDQo=
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
