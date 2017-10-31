From: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 1/4] spi: imx: GPIO based chip selects should not be
 required
Date: Tue, 31 Oct 2017 16:57:42 +0000
Message-ID: <1509469061.5473.16.camel@impinj.com>
References: <20171027010841.28624-1-tpiepho@impinj.com>
         <20171027010841.28624-2-tpiepho@impinj.com>
         <20171031111919.gocl7wwrhkwnxrya@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        "fabio.estevam-3arQi8VN3Tc@public.gmane.org" <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
To: "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171031111919.gocl7wwrhkwnxrya-7j8lgAiuQgnQXOPxS62xeg@public.gmane.org>
Content-Language: en-US
Content-ID: <7558B36203F1994EA80DD0B27D9D61D6-+1mpgTUVCH2cE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

T24gVHVlLCAyMDE3LTEwLTMxIGF0IDExOjE5ICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBUaHUsIE9jdCAyNiwgMjAxNyBhdCAwNjowODozOFBNIC0wNzAwLCBUcmVudCBQaWVwaG8gd3Jv
dGU6DQo+ID4gVGhlIGRyaXZlciB3aWxsIGZhaWwgdG8gbG9hZCBpZiBubyBncGlvIGNoaXAgc2Vs
ZWN0cyBhcmUgc3BlY2lmaWVkLA0KPiA+IHRoaXMgcGF0Y2ggY2hhbmdlcyB0aGlzIHNvIHRoYXQg
aXQgbm8gbG9uZ2VyIGZhaWxzLg0KPiA+IA0KPiA+IEl0J3MgcG9zc2libGUgdG8gdXNlIGFsbCBu
YXRpdmUgY2hpcCBzZWxlY3RzLCBpbiB3aGljaCBjYXNlIHRoZXJlIGlzDQo+ID4gbm8gcmVhc29u
IHRvIGhhdmUgYSBncGlvIGNoaXAgc2VsZWN0IGFycmF5LiAgVGhpcyBpcyB3aGF0IGhhcHBlbnMg
aWYNCj4gPiB0aGUgKm9wdGlvbmFsKiBkZXZpY2UgdHJlZSBwcm9wZXJ0eSAiY3MtZ3Bpb3MiIGlz
IG9taXR0ZWQuDQo+IA0KPiBEbyB0aGUgbmF0aXZlIGNoaXAgc2VsZWN0cyBhY3R1YWxseSB3b3Jr
IHVzZWZ1bGx5IG9uIHRoaXMgaGFyZHdhcmU/DQo+IFRoZXJlIHVzZWQgdG8gYmUgcHJvYmxlbXMg
d2l0aCBpdCB3YW50aW5nIHRvIGRvIHRoaW5ncyBsaWtlIGJvdW5jZSB0aGUNCj4gY2hpcCBzZWxl
Y3Qgb24gZXZlcnkgd29yZCB3aGljaCBtYWRlIGl0IGV4dHJlbWVseSBkaWZmaWN1bHQgdG8gdXNl
IHdpdGgNCj4gTGludXguDQoNClN0aWxsIGFyZSBhbm5veWluZywgYnV0IG9uIHRoZSBkZXZpY2Ug
d2UgaGF2ZSBjb25uZWN0ZWQgdG8gaXQsIGl0IGVuZHMNCnVwIHdvcmtpbmcgYXMgZGVzaXJlZC4N
Cg0KSSd2ZSBub3QgdGhvcm91Z2hseSBpbnZlc3RpZ2F0ZWQgdGhpcyBoYXJkd2FyZSB0byBmaW5k
IHRoZSBkZXRhaWxzLiANCklJUkMsIHRoZSBkZXNpZ253YXJlIFNQSSBvbiBBbHRlcmEgU29DRlBH
QSBoYWQgdGhlIHNhbWUgaXNzdWUsIGJ1dCBpdA0Kd2FzIGEgZmxhdyBpbiB0aGUgZHJpdmVyIGFu
ZCBJIHdhcyBhYmxlIHRvIGZpeCBpdC4gIEkndmUgY29tZSB0byBleHBlY3QNCml0LCBhcyBldmVy
eSBuZXcgU1BJIG1hc3RlciBJIHVzZSBkb2Vzbid0IHdvcmsgcHJvcGVybHkgaW4gc29tZQ0KZGlm
ZmVyZW50IHdheS4=
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
