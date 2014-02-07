From: "Zhang, Sonic" <Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH] spi: bfin5xx: Remove duplicate code to check spi->mode
Date: Fri, 7 Feb 2014 02:07:06 +0000
Message-ID: <B168F8A49F4BCF4C84FD23DA5F6363EE6114EF38@NWD2MBX7.ad.analog.com>
References: <1391395890.4629.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Steven Miao <realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Jiang, Scott" <Scott.Jiang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1391395890.4629.1.camel@phoenix>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Q0MgU2NvdHQgSmlhbmcNCg0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBB
eGVsIExpbiBbbWFpbHRvOmF4ZWwubGluQGluZ2ljcy5jb21dDQo+U2VudDogTW9uZGF5LCBGZWJy
dWFyeSAwMywgMjAxNCAxMDo1MiBBTQ0KPlRvOiBNYXJrIEJyb3duDQo+Q2M6IFpoYW5nLCBTb25p
YzsgU3RldmVuIE1pYW87IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmcNCj5TdWJqZWN0OiBbUEFU
Q0hdIHNwaTogYmZpbjV4eDogUmVtb3ZlIGR1cGxpY2F0ZSBjb2RlIHRvIGNoZWNrIHNwaS0+bW9k
ZQ0KPg0KPlRoaXMgY2hlY2tpbmcgaXMgYWxyZWFkeSBkb25lIGluIHRoZSBpbXBsZW1lbnRhdGlv
biBvZiBzcGlfc2V0dXAoKS4NCj4NCj5TaWduZWQtb2ZmLWJ5OiBBeGVsIExpbiA8YXhlbC5saW5A
aW5naWNzLmNvbT4NCj4tLS0NCj4gZHJpdmVycy9zcGkvc3BpLWJmaW41eHguYyB8IDQgLS0tLQ0K
PiAxIGZpbGUgY2hhbmdlZCwgNCBkZWxldGlvbnMoLSkNCj4NCj5kaWZmIC0tZ2l0IGEvZHJpdmVy
cy9zcGkvc3BpLWJmaW41eHguYyBiL2RyaXZlcnMvc3BpL3NwaS1iZmluNXh4LmMgaW5kZXggZjBm
MTk1YS4uYzY5MDJkMg0KPjEwMDY0NA0KPi0tLSBhL2RyaXZlcnMvc3BpL3NwaS1iZmluNXh4LmMN
Cj4rKysgYi9kcml2ZXJzL3NwaS9zcGktYmZpbjV4eC5jDQo+QEAgLTEwMzAsMTAgKzEwMzAsNiBA
QCBzdGF0aWMgaW50IGJmaW5fc3BpX3NldHVwKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpDQo+ICAg
ICAgIH0NCj4NCj4gICAgICAgLyogdHJhbnNsYXRlIGNvbW1vbiBzcGkgZnJhbWV3b3JrIGludG8g
b3VyIHJlZ2lzdGVyICovDQo+LSAgICAgIGlmIChzcGktPm1vZGUgJiB+KFNQSV9DUE9MIHwgU1BJ
X0NQSEEgfCBTUElfTFNCX0ZJUlNUKSkgew0KPi0gICAgICAgICAgICAgIGRldl9lcnIoJnNwaS0+
ZGV2LCAidW5zdXBwb3J0ZWQgc3BpIG1vZGVzIGRldGVjdGVkXG4iKTsNCj4tICAgICAgICAgICAg
ICBnb3RvIGVycm9yOw0KPi0gICAgICB9DQo+ICAgICAgIGlmIChzcGktPm1vZGUgJiBTUElfQ1BP
TCkNCj4gICAgICAgICAgICAgICBjaGlwLT5jdGxfcmVnIHw9IEJJVF9DVExfQ1BPTDsNCj4gICAg
ICAgaWYgKHNwaS0+bW9kZSAmIFNQSV9DUEhBKQ0KPi0tDQo+MS44LjEuMg0KPg0KPg0KPg0KDQo=

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
