From: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: imx: Don't require platform data chipselect
 array
Date: Mon, 30 Oct 2017 23:47:37 +0000
Message-ID: <1509407257.5473.7.camel@impinj.com>
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
Content-ID: <94EA4035F276B54B9041CA4FE70A1EDB-+1mpgTUVCH2cE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

T24gV2VkLCAyMDE3LTEwLTE4IGF0IDEwOjAyICswMTAwLCBKdWxpZW4gVGhpZXJyeSB3cm90ZToN
Cj4gLS0tIGEvZHJpdmVycy9zcGkvc3BpLWlteC5jDQo+ID4gKysrIGIvZHJpdmVycy9zcGkvc3Bp
LWlteC5jDQo+ID4gQEAgLTEzNjQsMTMgKzEzNjQsMTUgQEAgc3RhdGljIGludCBzcGlfaW14X3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gICANCj4gPiAgIAlpZiAobXhj
X3BsYXRmb3JtX2luZm8pIHsNCj4gPiAgIAkJbWFzdGVyLT5udW1fY2hpcHNlbGVjdCA9IG14Y19w
bGF0Zm9ybV9pbmZvLT5udW1fY2hpcHNlbGVjdDsNCj4gDQo+IG5pdDoNCj4gVGhpcyBpcyBvbmx5
IHVzZWZ1bCB3aGVuIG51bV9jaGlwc2VsZWN0IGlzIG5vbi16ZXJvIChtYXN0ZXIncyBtZW1vcnkg
aXMgDQo+IHplcm9lZCBvbiBhbGxvY2F0aW9uKS4gU28gbWF5YmUgdGhpcyBjb3VsZCBiZSBzaW1w
bGlmaWVkIGEgYml0IG1vcmUgYXM6DQo+IA0KPiBpZiAobXhjX3BsYXRmb3JtX2luZm8gJiYgbXhj
X3BsYXRmb3JtX2luZm8tPmNoaXBzZWxlY3QpIHsNCj4gCW1hc3Rlci0+bnVtX2NoaXBzZWxlY3Qg
PSBteGNfcGxhdGZvcm1faW5mby0+bnVtX2NoaXBzZWxlY3Q7DQo+IAlbLi4uXQ0KPiB9DQo+IA0K
PiBSZWR1Y2luZyBhbiBpbmRlbnRhdGlvbiBsZXZlbCBmb3IgYWxsIHRoZSBmb2xsb3dpbmcgc3Rh
dGVtZW50cy4NCg0KVGhvdWdodCBhYm91dCB0aGlzIHNvbWUgbW9yZSwgYW5kIGl0IGRvZXNuJ3Qg
d29yayB0byBkbyB0aGF0LiAgSWYNCmNoaXBzZWxlY3QgaXMgTlVMTCwgcGxhdGZvcm0gZGF0YSBp
cyBzdGlsbCBhbGxvd2VkIHRvIHNldCB0aGUgbnVtYmVyIG9mDQpjaGlwc2VsZWN0cyB1c2luZyBt
Y3hfcGxhdGZvcm1faW5mby0+bnVtX2NoaXBzZWxlY3QuDQoNCj4gDQo+ID4gLQkJCXNpemVvZihp
bnQpICogbWFzdGVyLT5udW1fY2hpcHNlbGVjdCwgR0ZQX0tFUk5FTCk7DQo+ID4gLQkJaWYgKCFt
YXN0ZXItPmNzX2dwaW9zKQ0KPiA+IC0JCQlyZXR1cm4gLUVOT01FTTsNCj4gPiAtDQo+ID4gLQkJ
Zm9yIChpID0gMDsgaSA8IG1hc3Rlci0+bnVtX2NoaXBzZWxlY3Q7IGkrKykNCj4gPiAtCQkJbWFz
dGVyLT5jc19ncGlvc1tpXSA9IG14Y19wbGF0Zm9ybV9pbmZvLT5jaGlwc2VsZWN0W2ldOw0KPiA+
ICsJCWlmIChteGNfcGxhdGZvcm1faW5mby0+Y2hpcHNlbGVjdCkgew0KPiA+ICsJCQltYXN0ZXIt
PmNzX2dwaW9zID0gZGV2bV9remFsbG9jKCZtYXN0ZXItPmRldiwNCj4gPiArCQkJCXNpemVvZihp
bnQpICogbWFzdGVyLT5udW1fY2hpcHNlbGVjdCwgR0ZQX0tFUk5FTCk7DQo+ID4gKwkJCWlmICgh
bWFzdGVyLT5jc19ncGlvcykNCj4gPiArCQkJCXJldHVybiAtRU5PTUVNOw0KPiA+ICsNCj4gPiAr
CQkJZm9yIChpID0gMDsgaSA8IG1hc3Rlci0+bnVtX2NoaXBzZWxlY3Q7IGkrKykNCj4gPiArCQkJ
CW1hc3Rlci0+Y3NfZ3Bpb3NbaV0gPSBteGNfcGxhdGZvcm1faW5mby0+Y2hpcHNlbGVjdFtpXTsN
Cj4gPiArCQl9DQo+ID4gICAgCX0NCj4gPiAgIA0KPiA+ICAgCXNwaV9pbXgtPmJpdGJhbmcuY2hp
cHNlbGVjdCA9IHNwaV9pbXhfY2hpcHNlbGVjdDsNCj4gPiANCj4gDQo+IA==
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
