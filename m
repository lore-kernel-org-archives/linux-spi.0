From: Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Subject: Re: [PATCH v4 2/2] spi: Add generic SPI multiplexer
Date: Mon, 3 Feb 2020 21:11:56 +0000
Message-ID: <86509a5e6656c4f560ee6f6514ab00a232994957.camel@alliedtelesis.co.nz>
References: <20200131023433.12133-1-chris.packham@alliedtelesis.co.nz>
         <20200131023433.12133-3-chris.packham@alliedtelesis.co.nz>
         <CAHp75VfT=KNM6J1bP5cPsLw7Z776opcB9Kf6qhNCZukY-7g=pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: "andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VfT=KNM6J1bP5cPsLw7Z776opcB9Kf6qhNCZukY-7g=pQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Content-ID: <05AFCD9D1BA3554699885BAC2DCCA5A2-aR5bhbO/t7M@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

SGkgQW5keSwNCg0KT24gTW9uLCAyMDIwLTAyLTAzIGF0IDExOjUwICswMjAwLCBBbmR5IFNoZXZj
aGVua28gd3JvdGU6DQoNCk90aGVyIGNvbW1lbnRzIGFsbCBhY2NlcHRlZCBhbmQgd2lsbCBiZSBh
ZGRyZXNzZWQgaW4gdjUuDQoNCj4gDQo+IC4uLg0KPiANCj4gDQo+ID4gKyAgICAgICBwcml2LT5t
dXggPSBkZXZtX211eF9jb250cm9sX2dldCgmc3BpLT5kZXYsIE5VTEwpOw0KPiA+ICsgICAgICAg
cmV0ID0gUFRSX0VSUl9PUl9aRVJPKHByaXYtPm11eCk7DQo+IA0KPiBUaGlzIGlzIGEgYml0IGNv
bXBsaWNhdGVkLg0KPiANCj4gPiArICAgICAgIGlmIChyZXQpIHsNCj4gDQo+IFdoeSBub3Qgc2lt
cGxlIGRvDQo+IA0KPiAgIGlmIChJU19FUlIocHJpdi0+bXV4KSkgew0KPiAgICAgcmV0ID0gUFRS
X0VSUiguLi4pOw0KPiAgICAgLi4uDQo+ICAgfQ0KPiANCj4gPw0KDQpJJ3ZlIGhhZCBvdGhlciBt
YWludGFpbmVycy9yZXZpZXdlcnMgc3VnZ2VzdCB0aGUgb3Bwb3NpdGUgZm9yIHBhdGNoZXMNCkkn
dmUgc3VibWl0dGVkIHRvIG90aGVyIHN1YnN5c3RlbXMgd2hpY2ggaXMgd2h5IEkgd2VudCB3aXRo
DQpQVFJfRVJSX09SX1pFUk8uIEl0IGFsc28gd29ya3Mgd2VsbCB3aXRoIHRoZSBnb3RvIGVycl9w
dXRfY3Rscjsgd2hpY2gNCm5lZWRzIHJldCB0byBiZSBzZXQuIEl0J3Mgbm90IGV4YWN0bHkgYSBj
b21tb24gcGF0dGVybiBpbiB0aGUgc3BpIGNvZGUNCnNvIEknZCBiZSBoYXBweSB0byBnbyB0aGUg
b3RoZXIgd2F5IGlmIHRoYXQncyB0aGUgZGVzaXJlZCBjb252ZW50aW9uDQpmb3Igc3BpLg0KDQo+
IA0KPiA+ICsgICAgICAgICAgICAgICBpZiAocmV0ICE9IC1FUFJPQkVfREVGRVIpDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgZGV2X2Vycigmc3BpLT5kZXYsICJmYWlsZWQgdG8gZ2V0IGNv
bnRyb2wtbXV4XG4iKTsNCj4gPiArICAgICAgICAgICAgICAgZ290byBlcnJfcHV0X2N0bHI7DQo+
ID4gKyAgICAgICB9DQo+ID4gKyAgICAgICBjdGxyLT5kZXYub2Zfbm9kZSA9IHNwaS0+ZGV2Lm9m
X25vZGU7DQo+IA0KPiBJJ20gd29uZGVyaW5nIHdoeSBTUEkgY29yZSBjYW4ndCBoYW5kbGUgdGhp
cyBieSBkZWZhdWx0IChsaWtlIEdQSU8NCj4gc3Vic3lzdGVtIGRvZXMpLg0KPiANCg0KV2UgZG8g
aGF2ZSBpdCBmb3Igc3BpIGRldmljZXMgaW4gb2ZfcmVnaXN0ZXJfc3BpX2RldmljZSgpLiBJJ20g
bm90DQphd2FyZSBvZiBhbnkgcmVhc29uIHNwaV9yZWdpc3Rlcl9jb250cm9sbGVyKCkgY291bGRu
J3QgZG8gdGhlIHNhbWUgZm9yDQpjb250cm9sbGVycy4gSXQgd291bGQgYWZmZWN0IGEgbGFyZ2Ug
bnVtYmVyIG9mIGRyaXZlcnMgc28gc2hvdWxkDQpwcm9iYWJseSBiZSBzZXBhcmF0ZSB0byB0aGlz
IHNlcmllcy4gSXQncyBwcm9iYWJseSByZWFzb25hYmx5DQphdXRvbWF0YWJsZSB3aXRoIGNvY2Np
bmVsbGUuDQoNCg==
