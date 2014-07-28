From: "Shevchenko, Andriy" <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi/pxa2xx-pci: Enable DMA binding through device name
Date: Mon, 28 Jul 2014 11:56:25 +0000
Message-ID: <1406548584.8530.35.camel@smile.fi.intel.com>
References: <1406196111-22861-1-git-send-email-hock.leong.kweh@intel.com>
	 <5426556.OzZIXLrofJ@wuerfel> <1406285147.8530.13.camel@smile.fi.intel.com>
	 <5237362.DJsH7MtqlU@wuerfel> <1406545580.8530.28.camel@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Kweh, Hock Leong" <hock.leong.kweh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	"haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"Chew, Chiau Ee" <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"chiauee85-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <chiauee85-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	"linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
To: "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1406545580.8530.28.camel-XvqNBM/wLWRrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Content-Language: en-US
Content-ID: <F32BCA7CAE2AF44EB81825B7FD8A6171-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

T24gTW9uLCAyMDE0LTA3LTI4IGF0IDE0OjA2ICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IE9uIEZyaSwgMjAxNC0wNy0yNSBhdCAxNzo1NSArMDIwMCwgQXJuZCBCZXJnbWFubiB3cm90
ZToNCj4gPiBPbiBGcmlkYXkgMjUgSnVseSAyMDE0IDEzOjQ1OjQ3IEFuZHkgU2hldmNoZW5rbyB3
cm90ZToNCg0KW10NCg0KPiA+ID4gPiBXaGF0IEkgdGhpbmsgeW91IGdvdCB3cm9uZyBoZXJlIChi
eSBmb2xsb3dpbmcgbXkgYmFkIGFkdmljZSkgaXMgdGhlIG1hc3Rlcg0KPiA+ID4gPiBudW1iZXIu
IExvb2tpbmcgYXQgdGhlIGNvZGUgZm9yIGR3X2RtYSwgSSB0aGluayBzcmNfbWFzdGVyIG5lZWRz
IHRvIGJlICcxJw0KPiA+ID4gPiBmb3IgeW91ciBkcml2ZXIuDQo+ID4gPiANCj4gPiA+IE9uIHNv
bWUgU29DcyB3ZSBoYXZlIHVwIHRvIDQgbWFzdGVycy4gSXQncyBibHVycnkgZm9yIG1lIGhvdyB0
aGUgU1BJDQo+ID4gPiBzaG91bGQgY2hvb3NlIHRob3NlIG1hc3RlcnMuIEN1cnJlbnRseSBpdCB3
b3JrcyBmaW5lLCBidXQgSSBzdXNwZWN0DQo+ID4gPiB0aGVyZSBhcmUgW21pZ2h0IGJlXSBwZXJm
b3JtYW5jZSBpc3N1ZXMuDQo+ID4gDQo+ID4gSSB0aGluayBpdCB3b3JrcyBiZWNhdXNlIHRoZSBk
dy1kbWEgZGVmYXVsdHMgdG8gdGhlIHZhbHVlcyB1c2VkIGJ5DQo+ID4gdGhlIHNwZWNpZmljIGlt
cGxlbWVudGF0aW9uIGluIHlvdXIgaGFyZHdhcmUuDQoNCltNaXNzZWQgaW4gcHJldmlvdXMgZW1h
aWxdDQoNCkFjdHVhbGx5IHRoZSBkZWZhdWx0cyBjYW1lIGZyb20gb3JpZ2luYWwgZHJpdmVyIGZv
ciBBVlIzMiBjYXNlLg0KDQpSZWdhcmRpbmcgdG8gRFcgRE1BIGRhdGFib29rIHRoZSBBSEIgbWFz
dGVycyBjb3VsZCBiZSB1c2VkIGVhY2ggYnkgYW55DQpjaGFubmVsLCB0aG91Z2ggaXQgZGVwZW5k
cyBvbiB3aGF0IEFIQiBsYXllciBpcyBib3VuZCB0byAoYW5kDQpjb3JyZXNwb25kaW5nIHBlcmlw
aGVyYWwgZGV2aWNlKS4NCg0KVGh1cywgbGlrZSBJIHNhaWQgd2UgbWlnaHQgaGF2ZSB0aGUgW21p
bm9yXSBwZXJmb3JtYW5jZSBpc3N1ZXMgaWYgd2UNCnVzZSwgZm9yIGV4YW1wbGUsIHR3byBvdXQg
b2YgZm91ciBtYXN0ZXJzLg0KDQotLSANCkFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVu
a29AaW50ZWwuY29tPg0KSW50ZWwgRmlubGFuZCBPeQ0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkludGVsIEZpbmxh
bmQgT3kKUmVnaXN0ZXJlZCBBZGRyZXNzOiBQTCAyODEsIDAwMTgxIEhlbHNpbmtpIApCdXNpbmVz
cyBJZGVudGl0eSBDb2RlOiAwMzU3NjA2IC0gNCAKRG9taWNpbGVkIGluIEhlbHNpbmtpIAoKVGhp
cyBlLW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgbWF0
ZXJpYWwgZm9yCnRoZSBzb2xlIHVzZSBvZiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpLiBBbnkg
cmV2aWV3IG9yIGRpc3RyaWJ1dGlvbgpieSBvdGhlcnMgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4g
SWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkCnJlY2lwaWVudCwgcGxlYXNlIGNvbnRhY3QgdGhl
IHNlbmRlciBhbmQgZGVsZXRlIGFsbCBjb3BpZXMuCg==

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
