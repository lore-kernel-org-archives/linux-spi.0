From: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/4] spi: orion: Respect per-transfer bits_per_word
 settings
Date: Thu, 15 Feb 2018 17:13:27 +0000
Message-ID: <1518714806.25567.63.camel@impinj.com>
References: <bc8bf712358fbb000ea7e2ea9e1aec42b21988e6.1518704854.git.jan.kundrat@cesnet.cz>
         <b983963f1ad0400fdca2f8bf8095d25b62b0ffb0.1518704854.git.jan.kundrat@cesnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org"
        <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        "christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org" <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>,
        "Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org"
        <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>,
        "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org" <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org" <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b983963f1ad0400fdca2f8bf8095d25b62b0ffb0.1518704854.git.jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Content-Language: en-US
Content-ID: <EA9CFB6319BFFC418C563B3CBAB749F0-+1mpgTUVCH2cE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

T24gVGh1LCAyMDE4LTAyLTE1IGF0IDE1OjE5ICswMTAwLCBKYW4gS3VuZHLDoXQgd3JvdGU6DQo+
IEl0J3MgYSBidWcgdG8gbG9vayBhdCB0aGUgZGV2aWNlJ3MgYml0c19wZXJfd29yZCBiZWNhdXNl
IGVhY2ggdHJhbnNmZXINCj4gY2FuIG92ZXJyaWRlIHRoZXNlIHNldHRpbmdzLiBJbiBmYWN0LCBl
LmcuLCBzcGlkZXYgY2Fubm90IHNwZWNpZnkNCj4gImdsb2JhbCIgYml0c19wZXJfd29yZCBhbmQg
aW5zdGVhZCByZWxpZXMgb24gcGFzc2luZyB0aGF0IHRocm91Z2ggZXZlcnkNCj4gaW9jdGwuDQo+
IA0KPiBAQCAtNDI3LDcgKzQyNyw3IEBAIG9yaW9uX3NwaV93cml0ZV9yZWFkKHN0cnVjdCBzcGlf
ZGV2aWNlICpzcGksIHN0cnVjdCBzcGlfdHJhbnNmZXIgKnhmZXIpDQo+ICAJc3RydWN0IG9yaW9u
X3NwaSAqb3Jpb25fc3BpOw0KPiAgCWludCBjcyA9IHNwaS0+Y2hpcF9zZWxlY3Q7DQo+ICANCj4g
LQl3b3JkX2xlbiA9IHNwaS0+Yml0c19wZXJfd29yZDsNCj4gKwl3b3JkX2xlbiA9IHhmZXItPmJp
dHNfcGVyX3dvcmQgPyB4ZmVyLT5iaXRzX3Blcl93b3JkIDogc3BpLT5iaXRzX3Blcl93b3JkOw0K
PiAgCWNvdW50ID0geGZlci0+bGVuOw0KDQpfX3NwaV92YWxpZGF0ZSgpIGFscmVhZHkgZG9lcyB0
aGlzLiAgWW91IGNhbiBqdXN0IGxvb2sgYXQgeGZlci0NCj5iaXRzX3Blcl93b3JkIGFuZCBpdCB3
aWxsIGhhdmUgYWxyZWFkeSBiZWVuIHNldCAgdG8gc3BpLT5iaXRzX3Blcl93b3JkIA0KaWYgbmVj
ZXNzYXJ5LiAgVGhpcyBzaG91bGQgaG9sZCBmb3IgYWxsIHRoZSB4ZmVyIGZpZWxkcy4gIFRoZXkg
YXJlDQp2YWxpZGF0ZWQgYW5kIHdpbGwgaW5jb3Jwb3JhdGUgdGhlIHNwaSBzbGF2ZSdzIGFuZC9v
ciBzcGkgbWFzdGVyJ3MNCmRlZmF1bHQgdmFsdWVzIGFzIG5lY2Vzc2FyeS4NCg0KDQo=
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
