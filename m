From: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835aux: use 64-bit arithmetic instead of 32-bit
Date: Mon, 12 Feb 2018 19:31:46 +0000
Message-ID: <1518463905.25398.281.camel@impinj.com>
References: <20180207160002.GA9292@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "garsilva-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org" <garsilva-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>
To: "gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org" <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>,
        "bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org"
        <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        "stefan.wahren-eS4NqCHxEME@public.gmane.org" <stefan.wahren-eS4NqCHxEME@public.gmane.org>,
        "f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org" <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
        "rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org" <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        "sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org" <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180207160002.GA9292@embeddedgus>
Content-Language: en-US
Content-ID: <86ADEA02724F604596EAF6370778382E-+1mpgTUVCH2cE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

T24gV2VkLCAyMDE4LTAyLTA3IGF0IDEwOjAwIC0wNjAwLCBHdXN0YXZvIEEuIFIuIFNpbHZhIHdy
b3RlOg0KPiBBZGQgc3VmZml4IFVMTCB0byBjb25zdGFudCA5IGluIG9yZGVyIHRvIGdpdmUgdGhl
IGNvbXBpbGVyIGNvbXBsZXRlDQo+IGluZm9ybWF0aW9uIGFib3V0IHRoZSBwcm9wZXIgYXJpdGht
ZXRpYyB0byB1c2UuIE5vdGljZSB0aGF0IHRoaXMNCj4gY29uc3RhbnQgaXMgdXNlZCBpbiBhIGNv
bnRleHQgdGhhdCBleHBlY3RzIGFuIGV4cHJlc3Npb24gb2YgdHlwZQ0KPiB1bnNpZ25lZCBsb25n
IGxvbmcgKDY0IGJpdHMsIHVuc2lnbmVkKS4NCj4gDQo+IFRoZSBleHByZXNzaW9uIHRmci0+bGVu
ICogOSAqIDEwMDAwMDAgaXMgY3VycmVudGx5IGJlaW5nIGV2YWx1YXRlZA0KPiB1c2luZyAzMi1i
aXQgYXJpdGhtZXRpYy4NCj4gDQo+IEFkZHJlc3Nlcy1Db3Zlcml0eS1JRDogMTMzOTYxOQ0KPiBT
aWduZWQtb2ZmLWJ5OiBHdXN0YXZvIEEuIFIuIFNpbHZhIDxndXN0YXZvQGVtYmVkZGVkb3IuY29t
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvc3BpL3NwaS1iY20yODM1YXV4LmMgfCAyICstDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3NwaS9zcGktYmNtMjgzNWF1eC5jIGIvZHJpdmVycy9zcGkvc3BpLWJjbTI4
MzVhdXguYw0KPiBpbmRleCA3NDI4MDkxLi5hNzY4YzIzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3NwaS9zcGktYmNtMjgzNWF1eC5jDQo+ICsrKyBiL2RyaXZlcnMvc3BpL3NwaS1iY20yODM1YXV4
LmMNCj4gQEAgLTM2Myw3ICszNjMsNyBAQCBzdGF0aWMgaW50IGJjbTI4MzVhdXhfc3BpX3RyYW5z
ZmVyX29uZShzdHJ1Y3Qgc3BpX21hc3RlciAqbWFzdGVyLA0KPiAgCSAqIGNodW5rIGdldHRpbmcg
dHJhbnNmZXJyZWQgLSBpbiBvdXIgY2FzZSB0aGUgY2h1bmsgc2l6ZQ0KPiAgCSAqIGlzIDMgYnl0
ZXMsIHNvIHdlIGFwcHJveGltYXRlIHRoaXMgYnkgOSBiaXRzL2J5dGUNCj4gIAkgKi8NCj4gLQl4
ZmVyX3RpbWVfdXMgPSB0ZnItPmxlbiAqIDkgKiAxMDAwMDAwOw0KPiArCXhmZXJfdGltZV91cyA9
IHRmci0+bGVuICogOVVMTCAqIDEwMDAwMDA7DQo+ICAJZG9fZGl2KHhmZXJfdGltZV91cywgc3Bp
X3VzZWRfaHopOw0KPiAgDQo+ICAJLyogcnVuIGluIHBvbGxpbmcgbW9kZSBmb3Igc2hvcnQgdHJh
bnNmZXJzICovDQoJaWYgKHhmZXJfdGltZV91cyA8IEJDTTI4MzVfQVVYX1NQSV9QT0xMSU5HX0xJ
TUlUX1VTKQ0KDQpJZiBvbmUgbG9va3MgYXQgdGhlIGxvZ2ljIGFzIGEgd2hvbGUuLi4NCg0KdGZy
LT5sZW4gKiA5VUxMICogMTAwMDAwIC8gc3BpX3VzZWRfaHogPCAzMA0KDQpBIGxpdHRsZSBhbGdl
YnJhIGNhbiBjaGFuZ2UgdGhhdCBpbnRvOg0KDQp0ZnItPmxlbiA8IHNwaV91c2VkX2h6IC8gMzAw
MDAwDQoNClNvIHJhdGhlciB0aGFuIGFkZCBtb3JlIDY0LWJpdCBtYXRoLCBpdCBjYW4gYmUgcmVt
b3ZlZCBlbnRpcmVseS4gIEJvdGgNCnRoZSBsZW5ndGggYW5kIHNwZWVkIGFyZSAzMiBiaXRzIGFu
ZCB0aGVyZSdzIG5vIG5lZWQgdG8gbXVsdGlwbHkgdGhlbQ0KaW50byBzb21ldGhpbmcgbGFyZ2Vy
IHRoYW4gbWlnaHQgbmVlZCA2NCBiaXRzLg0K
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
