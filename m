From: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 4/4] ARM: imx: Update spi_imx platform data to reflect
 current state
Date: Wed, 18 Oct 2017 17:50:30 +0000
Message-ID: <1508349029.87493.8.camel@impinj.com>
References: <20171013195410.30767-1-tpiepho@impinj.com>
         <20171013195410.30767-4-tpiepho@impinj.com> <20171018021709.GD18810@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "fabio.estevam-3arQi8VN3Tc@public.gmane.org" <fabio.estevam-3arQi8VN3Tc@public.gmane.org>,
        "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        "gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org" <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: "shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171018021709.GD18810@dragon>
Content-Language: en-US
Content-ID: <A8A48B3DC22AF04FB8030153B6A334AD-+1mpgTUVCH2cE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

T24gV2VkLCAyMDE3LTEwLTE4IGF0IDEwOjE3ICswODAwLCBTaGF3biBHdW8gd3JvdGU6DQo+IE9u
IEZyaSwgT2N0IDEzLCAyMDE3IGF0IDEyOjU0OjEwUE0gLTA3MDAsIFRyZW50IFBpZXBobyB3cm90
ZToNCj4gPiANCj4gPiBJZiBhIGJvYXJkIHVzZXMgYWxsIG5hdGl2ZSBjaGlwIHNlbGVjdHMsIHRo
ZW4gaXQncyBub3QgbmVjZXNzYXJ5IHRvDQo+ID4gc3BlY2lmeSBhIGNoaXAgc2VsZWN0IGFycmF5
IGF0IGFsbCwgYXMgYWxsIG5hdGl2ZSBpcyB0aGUgZGVmYXVsdCAodGhpcyBpcw0KPiA+IGhvdyBk
ZXZpY2UtdHJlZSBjb25maWd1cmVkIFNQSSBtYXN0ZXJzIHdvcmsgdG9vKS4gIE1vc3Qgb2YgdGhl
IHNwaS1pbXgNCj4gPiBwbGF0Zm9ybSBkYXRhIHVzZXJzIGhhdmUgdGhlaXIgY2hpcCBzZWxlY3Qg
YXJyYXlzIHJlbW92ZWQgYnkgdGhpcyBwYXRjaC4NCj4gPiANCj4gPiANCj4gRG9lcyB0aGlzIHBh
dGNoIGhhdmUgYW55IGRlcGVuZGVuY3kgb24gb3RoZXJzIGluIHRoaXMgc2VyaWVzLCBvciBjYW4g
aXQNCj4gYmUgc2VudCB2aWEgYXJtLXNvYyB0cmVlIGluZGVwZW5kZW50bHk/DQoNCkl0IG5lZWRz
IHBhdGNoIDEgYW5kIDMgaW4gdGhlIHNlcmllcy4gIEN1cnJlbnRseSBzdXBwbHlpbmcgY3MgZ3Bp
b3MgaXMNCm1hbmRhdG9yeSBmb3IgYm90aCBwbGF0Zm9ybSBkYXRhIGFuZCBEVCBiYXNlZCBzeXN0
ZW1zIHVzaW5nIHNwaS1pbXguIA0KVGhlIGxhdHRlciBpcyBhIGJ1ZywgYXMgdGhlIERUIGJpbmRp
bmcgY2xlYXJseSBtYWtlcyBjcy1ncGlvcyBvcHRpb25hbA0KYW5kIG90aGVyIGRyaXZlcnMgZG8g
bm90IHJlcXVpcmUgaXQuICBJIGZpZ3VyZWQgSSBtaWdodCBhcyB3ZWxsIGNsZWFuDQp1cCB0aGUg
cGxhdGZvcm0gZGF0YSB3aGlsZSBJIGZpeGVkIHRoYXQgYnVnIGFuZCBjYW1lIGFjcm9zcyB0aGUN
CmlteDMxbW9ib2FyZCBidWcgaW4gdGhhdCBwcm9jZXNzLg0K
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
