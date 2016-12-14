From: Pandy Gao <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH] spi: fsl-lpspi: Pre-initialize ret in
 fsl_lpspi_transfer_one_msg()
Date: Wed, 14 Dec 2016 12:05:06 +0000
Message-ID: <AM4PR0401MB17809B70577B49585C505312F69A0@AM4PR0401MB1780.eurprd04.prod.outlook.com>
References: <1481714455-14224-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1481714455-14224-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

PiBGcm9tOiBHZWVydCBVeXR0ZXJob2V2ZW4gW21haWx0bzpnZWVydEBsaW51eC1tNjhrLm9yZ10N
Cj4gU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciAxNCwgMjAxNiA3OjIxIFBNDQo+IFRvOiBNYXJr
IEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+OyBQYW5keSBHYW8NCj4gPHBhbmR5Lmdhb0BueHAu
Y29tPg0KPiBDYzogbGludXgtc3BpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgR2VlcnQNCj4gVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4N
Cj4gU3ViamVjdDogW1BBVENIXSBzcGk6IGZzbC1scHNwaTogUHJlLWluaXRpYWxpemUgcmV0IGlu
DQo+IGZzbF9scHNwaV90cmFuc2Zlcl9vbmVfbXNnKCkNCj4gDQo+IFdpdGggZ2NjIDQuMS4yOg0K
PiANCj4gICAgIGRyaXZlcnMvc3BpL3NwaS1mc2wtbHBzcGkuYzogSW4gZnVuY3Rpb24g4oCYZnNs
X2xwc3BpX3RyYW5zZmVyX29uZV9tc2figJk6DQo+ICAgICBkcml2ZXJzL3NwaS9zcGktZnNsLWxw
c3BpLmM6MzY5OiB3YXJuaW5nOiDigJhyZXTigJkgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZA0K
PiBpbiB0aGlzIGZ1bmN0aW9uDQo+IA0KPiBJZiB0aGUgbWVzc2FnZSBjb250YWlucyBubyB0cmFu
c2ZlcnMsIHRoZSBmdW5jdGlvbiB3aWxsIHNldCB0aGUgbWVzc2FnZSdzDQo+IHN0YXR1cyB0byBh
biB1bmluaXRpYWxpemVkIHZhbHVlLCBhbmQgd2lsbCByZXR1cm4gdGhhdCB1bmluaXRpYWxpemVk
IHZhbHVlLg0KPiANCj4gV2hpbGUgX19zcGlfdmFsaWRhdGUoKSBzaG91bGQgaGF2ZSBiZWVuIGNh
bGxlZCBpbiBhbGwgcGF0aHMgbGVhZGluZyB0byB0aGlzLA0KPiBhbmQgdGh1cyBoYXZlIHJlamVj
dGVkIHN1Y2ggbWVzc2FnZXMsIHdlIGJldHRlciBwcmUtaW5pdGlhbGl6ZSByZXQgdG8gYmUNCj4g
c2FmZSBmb3IgZnV0dXJlIG1vZGlmaWNhdGlvbnMgKHNwaV90cmFuc2Zlcl9vbmVfbWVzc2FnZSgp
IGFsc28gZG9lcyB0aGlzKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEdlZXJ0IFV5dHRlcmhvZXZl
biA8Z2VlcnRAbGludXgtbTY4ay5vcmc+DQo+IC0tLQ0KDQpBY2tlZC1ieTogR2FvIFBhbiA8cGFu
ZHkuZ2FvQG54cC5jb20+DQoNCkJlc3QgUmVnYXJkcw0KUGFuZHkNCg==
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
