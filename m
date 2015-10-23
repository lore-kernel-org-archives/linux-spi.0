From: "Shevchenko, Andriy" <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Applied "spi: dw: explicitly free IRQ handler in
 dw_spi_remove_host()" to the spi tree
Date: Fri, 23 Oct 2015 16:30:50 +0000
Message-ID: <1445617849.22669.66.camel@intel.com>
References: <E1ZpP0f-0000MP-5w@finisterre>
	 <1445586058.22669.55.camel@linux.intel.com>
	 <20151023161810.GH29919@sirena.org.uk>
	 <1445617533.22669.64.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445617533.22669.64.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
Content-ID: <F45342EE34DA4F4799D34B4BCB3BF96C-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

T24gRnJpLCAyMDE1LTEwLTIzIGF0IDE5OjI1ICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IE9uIFNhdCwgMjAxNS0xMC0yNCBhdCAwMToxOCArMDkwMCwgTWFyayBCcm93biB3cm90ZToN
Cj4gPiBPbiBGcmksIE9jdCAyMywgMjAxNSBhdCAxMDo0MDo1OEFNICswMzAwLCBBbmR5IFNoZXZj
aGVua28gd3JvdGU6DQo+ID4gPiBPbiBGcmksIDIwMTUtMTAtMjMgYXQgMDg6MTEgKzA5MDAsIE1h
cmsgQnJvd24gd3JvdGU6DQoNCj4gPiA+ID4gQXJlIHlvdSBzYXlpbmcgdGhhdCB5b3UgaGF2ZSBy
ZWFsaXNlZCB0aGF0IHlvdXIgcGF0Y2ggaXMgYnJva2VuDQo+ID4gc2luY2UNCj4gPiBzZW5kaW5n
IGl0P8KgwqBJJ3ZlIGRyb3BwZWQgdGhpcyBjb21taXQuLi4NCg0KSnVzdCBjaGVja2VkIHVwZGF0
ZWQgdG9waWMvZHcgYnJhbmNoLg0KSXQnaXMgY29ycmVjdCByaWdodCBub3chDQoNCkkgaGF2ZSBu
byBpZGVhIGZyb20gd2hpY2ggcG9pbnQgdGhlIG90aGVyIGNvbW1pdCBhcHBlYXJlZCAoSSBkaWRu
J3QNCnNlbmQgYSBzdWNoKS4NCg0KLS0gDQpBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hl
bmtvQGludGVsLmNvbT4NCkludGVsIEZpbmxhbmQgT3kNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpJbnRlbCBGaW5s
YW5kIE95ClJlZ2lzdGVyZWQgQWRkcmVzczogUEwgMjgxLCAwMDE4MSBIZWxzaW5raSAKQnVzaW5l
c3MgSWRlbnRpdHkgQ29kZTogMDM1NzYwNiAtIDQgCkRvbWljaWxlZCBpbiBIZWxzaW5raSAKClRo
aXMgZS1tYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIG1h
dGVyaWFsIGZvcgp0aGUgc29sZSB1c2Ugb2YgdGhlIGludGVuZGVkIHJlY2lwaWVudChzKS4gQW55
IHJldmlldyBvciBkaXN0cmlidXRpb24KYnkgb3RoZXJzIGlzIHN0cmljdGx5IHByb2hpYml0ZWQu
IElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZApyZWNpcGllbnQsIHBsZWFzZSBjb250YWN0IHRo
ZSBzZW5kZXIgYW5kIGRlbGV0ZSBhbGwgY29waWVzLgo=

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
