From: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 1/4] spi: imx: GPIO based chip selects should not be
 required
Date: Mon, 6 Nov 2017 19:20:41 +0000
Message-ID: <1509996041.5473.103.camel@impinj.com>
References: <20171027010841.28624-1-tpiepho@impinj.com>
         <20171027010841.28624-2-tpiepho@impinj.com>
         <20171031111919.gocl7wwrhkwnxrya@sirena.co.uk>
         <1509469061.5473.16.camel@impinj.com>
         <20171102151439.6dpfud7a5vtc27dy@sirena.co.uk>
         <1509731639.5473.60.camel@impinj.com>
         <20171103183700.spnqbagr4q7fth4k@sirena.co.uk>
         <1509736735.5473.87.camel@impinj.com>
         <20171106073246.efcz7r2vnymz3me7@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        "fabio.estevam-3arQi8VN3Tc@public.gmane.org" <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
To: "s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171106073246.efcz7r2vnymz3me7-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Content-ID: <F5E7F518751A824EA25B933CB3E488FA-+1mpgTUVCH2cE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

T24gTW9uLCAyMDE3LTExLTA2IGF0IDA4OjMyICswMTAwLCBTYXNjaGEgSGF1ZXIgd3JvdGU6DQo+
IE9uIEZyaSwgTm92IDAzLCAyMDE3IGF0IDA3OjE4OjU2UE0gKzAwMDAsIFRyZW50IFBpZXBobyB3
cm90ZToNCj4gPiANCj4gPiBDb21tZW50cyBpbiB0aGUgZHJpdmVyIGluZGljYXRlIHRoYXQgc29t
ZSBTb0NzIGRvIG5vdCBhbGxvdyBHUElPIHVzYWdlDQo+ID4gb24gYWxsIGNoaXAgc2VsZWN0IHBp
bnMuDQo+IA0KPiBXaGljaCBjb21tZW50cyBkbyB5b3UgbWVhbj8gSSByZW1lbWJlciB0aGVyZSB3
ZXJlIGNvbW1lbnRzLCBidXQgSSBjYW4ndA0KPiBmaW5kIGFueSBpbiB0aGUgZHJpdmVyLg0KDQpJ
dCdzIGluIGFyY2gvYXJtL3BsYXQtbXhjL2luY2x1ZGUvbWFjaC9zcGkuaC4NCg0KPiBUaGUgb25s
eSBTb0Mgd2hpY2ggaGFzIGRlZGljYXRlZCBTUEkgQ1MgcGlucyB3aGljaCBjYW4ndCBiZSBjb25m
aWd1cmVkDQo+IGFzIEdQSU9zIGlzIHRoZSBpLk1YMzEuIFVubGVzcyB5b3UgaGF2ZSBhbiBpLk1Y
MzEgeW91IHNob3VsZG4ndCBiZQ0KPiBmb3JjZWQgdG8gdXNlIG5hdGl2ZSBjaGlwIHNlbGVjdHMu
DQoNCkluZGVlZCBJJ20gbm90IGZvcmNlZCB0bywgYnV0IG5hdGl2ZSBpcyBtb3JlIGVmZmljaWVu
dCBhbmQgZmFzdGVyLCBhbmQNCnNpbmNlIEknbSBsdWNreSBlbm91Z2ggdGhhdCB0aGV5IHdvcmsg
Zm9yIG1lLCBJJ2QgbGlrZSB0byBiZSBhYmxlIHRvDQp1c2UgdGhlbS4gIEFuZCBJIGNhbiBhbHJl
YWR5LCBidXQgdGhlIERUIGJpbmRpbmdzIGFyZSBub24tc3RhbmRhcmQgYW5kDQpJIGRvbid0IHNl
ZSBhbnkgdmFsdWUgaW4gdGhhdC4gRFQgYmluZGluZ3MgYXJlIGNvbXBsZXggZW5vdWdoIHdpdGhv
dXQNCmRyaXZlcnMgYWRkaW5nIHF1aXJrcy4gQW5kIG15IGV4cGVyaWVuY2Ugd2FzIG5vIG9uZSBj
b25uZWN0ZWQgdGhlIG5vbi0NCnN0YW5kYXJkIGJpbmRpbmdzIHdpdGggbmF0aXZlIENTIG5vdCB3
b3JraW5nIHdlbGwuICBJIHRoaW5rIGV4cGxpY2l0DQpkb2N1bWVudGF0aW9uIHdpbGwgYmUgbW9y
ZSBlZmZlY3RpdmUgYXQgdGhhdC4=
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
