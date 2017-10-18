From: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: imx: Don't require platform data chipselect
 array
Date: Wed, 18 Oct 2017 17:30:10 +0000
Message-ID: <1508347809.87493.2.camel@impinj.com>
References: <20171013195410.30767-1-tpiepho@impinj.com>
         <20171013195410.30767-3-tpiepho@impinj.com>
         <36d381de-ee3f-26d4-59c3-b9d361758ace@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "fabio.estevam-3arQi8VN3Tc@public.gmane.org" <fabio.estevam-3arQi8VN3Tc@public.gmane.org>,
        "shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org" <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "julien.thierry-5wv7dgnIgG8@public.gmane.org" <julien.thierry-5wv7dgnIgG8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <36d381de-ee3f-26d4-59c3-b9d361758ace-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
Content-ID: <487A3B9A2E0D5F46A8A8010F88EE1A02-+1mpgTUVCH2cE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

T24gV2VkLCAyMDE3LTEwLTE4IGF0IDEwOjAyICswMTAwLCBKdWxpZW4gVGhpZXJyeSB3cm90ZToN
Cj4gPiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktaW14LmMNCj4gPiArKysgYi9kcml2ZXJzL3NwaS9z
cGktaW14LmMNCj4gPiBAQCAtMTM2NCwxMyArMTM2NCwxNSBAQCBzdGF0aWMgaW50IHNwaV9pbXhf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgIA0KPiA+ICAgCWlmICht
eGNfcGxhdGZvcm1faW5mbykgew0KPiA+ICAgCQltYXN0ZXItPm51bV9jaGlwc2VsZWN0ID0gbXhj
X3BsYXRmb3JtX2luZm8tPm51bV9jaGlwc2VsZWN0Ow0KPiANCj4gbml0Og0KPiBUaGlzIGlzIG9u
bHkgdXNlZnVsIHdoZW4gbnVtX2NoaXBzZWxlY3QgaXMgbm9uLXplcm8gKG1hc3RlcidzIG1lbW9y
eSBpcyANCj4gemVyb2VkIG9uIGFsbG9jYXRpb24pLiBTbyBtYXliZSB0aGlzIGNvdWxkIGJlIHNp
bXBsaWZpZWQgYSBiaXQgbW9yZSBhczoNCj4gDQo+IGlmIChteGNfcGxhdGZvcm1faW5mbyAmJiBt
eGNfcGxhdGZvcm1faW5mby0+Y2hpcHNlbGVjdCkgew0KPiAJbWFzdGVyLT5udW1fY2hpcHNlbGVj
dCA9IG14Y19wbGF0Zm9ybV9pbmZvLT5udW1fY2hpcHNlbGVjdDsNCj4gCVsuLi5dDQo+IH0NCj4g
DQo+IFJlZHVjaW5nIGFuIGluZGVudGF0aW9uIGxldmVsIGZvciBhbGwgdGhlIGZvbGxvd2luZyBz
dGF0ZW1lbnRzLg0KDQpHb29kIHBvaW50LCB0aGVyZSdzIG5vdGhpbmcgZWxzZSBpbiB0aGUgcGxh
dGZvcm0gaW5mbyB0byB1c2UuDQo=
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
