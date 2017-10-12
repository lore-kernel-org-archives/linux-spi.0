From: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [2/2] spi: imx: fix use of native chip-selects with devicetree
Date: Thu, 12 Oct 2017 20:41:07 +0000
Message-ID: <1507840866.3880.4.camel@impinj.com>
References: <1489726983-17706-3-git-send-email-gerg@linux-m68k.org>
         <1507667916.74283.19.camel@impinj.com>
         <209bb901-875e-8007-06f8-3ae9698a0e41@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org" <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>,
        "shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "fabio.estevam-3arQi8VN3Tc@public.gmane.org" <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
To: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org" <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <209bb901-875e-8007-06f8-3ae9698a0e41-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Content-Language: en-US
Content-ID: <A8A919E75B9BBA4096B48A230ED0CC42-+1mpgTUVCH2cE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

T24gVGh1LCAyMDE3LTEwLTEyIGF0IDE2OjI2ICsxMDAwLCBHcmVnIFVuZ2VyZXIgd3JvdGU6DQo+
IE9uIDExLzEwLzE3IDA2OjM4LCBUcmVudCBQaWVwaG8gd3JvdGU6DQo+ID4gDQo+ID4gYXJjaC9h
cm0vbWFjaC1pbXgvbWFjaC1teDMxbW9ib2FyZC5jLXN0YXRpYyBpbnQgbW9ib2FyZF9zcGkxX2Nz
W10gPSB7DQo+ID4gYXJjaC9hcm0vbWFjaC1pbXgvbWFjaC1teDMxbW9ib2FyZC5jOiAgIE1YQ19T
UElfQ1MoMCksDQo+ID4gYXJjaC9hcm0vbWFjaC1pbXgvbWFjaC1teDMxbW9ib2FyZC5jOiAgIE1Y
Q19TUElfQ1MoMiksDQo+ID4gYXJjaC9hcm0vbWFjaC1pbXgvbWFjaC1teDMxbW9ib2FyZC5jLX07
DQo+ID4gDQo+ID4gVGhlIHNwaSBkZXZpY2UgY29uZmlndXJlZCB0byB1c2UgY2hpcCBzZWxlY3Qg
MSB3aWxsIG5vIGxvbmdlciB1c2UNCj4gPiBuYXRpdmUgY2hpcCBzZWxlY3QgbGluZSAyLg0KPiA+
IA0KPiA+IExvb2tpbmcgYXQgYWxsIGluLXRyZWUgdXNlcnMgb2Ygc3BpIGlteCBwbGF0Zm9ybSBk
YXRhLCBpdCBhcHBlYXJzIHRoYXQNCj4gPiB0aGlzIGJvYXJkIGlzIHRoZSBvbmx5IG9uZSBpbiB3
aGljaCB0aGUgY3Mgc2VsZWN0ZWQgZG9lcyBub3QgbWF0Y2ggdGhlDQo+ID4gYXJyYXkgaW5kZXgu
ICBUaG91Z2ggdGhlcmUgYXJlIHN0aWxsIHNldmVyYWwgd2hpY2ggc3RpbGwgdXNlDQo+ID4gTVND
X1NQSV9DUygpIGV2ZW4gdGhvdWdoIGl0IGRvZXNuJ3QgcmVhbGx5IHdvcmsgYW55bW9yZS4NCj4g
DQo+IENvbW1pdCA5MDFmMjZiY2U2NGEgKCJBUk06IGlteDogc2V0IGNvcnJlY3QgY2hpcF9zZWxl
Y3QgaW4gcGxhdGZvcm0gc2V0dXAiKSANCj4gZml4ZXMgdGhpcyBpc3N1ZS4gSXQgc3BlY2lmaWNh
bGx5IG1ha2VzIHN1cmUgdGhhdCB0aGUgYm9hcmQgc2V0dXAgY2hpcA0KPiBzZWxlY3QgaXMgc2V0
IGNvcnJlY3RseSAoc28gdGhhdCBzcGktaW14IGNhbiB0aGVuIHVzZSBpdCkuIEl0IGFsc28gcGFk
cw0KPiBvdXQgdGhlIGNoaXBzZWxlY3QgYXJyYXlzIHNvIHRoYXQgdGhlIGNoaXAgc2VsZWN0IGFu
ZCBpbmRleGVzIG1hdGNoLg0KPiANCj4gSXMgdGhpcyBub3Qgd29ya2luZyBmb3IgeW91Pw0KDQpJ
dCBsb29rcyBsaWtlIHRoYXQgcGF0Y2ggbWlzc2VkIG9uZSBzcGkgYnVzIGluIG14MzFtb2JvYXJk
LmMsIHF1b3RlZA0KYWJvdmUuDQoNCkkgaGF2ZSBhIHBhdGNoIHNlcmllcyB0aGF0IHNob3VsZCBm
aXggdGhhdCBhbmQgYWxzbyB0aGUgZG9jdW1lbnRhdGlvbi4gDQpOZWVkIHRvIHRlc3QgaXQgYSBi
aXQgbW9yZS4=
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
