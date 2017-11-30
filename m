From: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Subject: Re: spidev: Instantiating from DT as "spidev"
Date: Thu, 30 Nov 2017 02:07:37 +0000
Message-ID: <1512007657.9792.45.camel@impinj.com>
References: <20171129150435.5npybjuu2ndmtx2v@senary>
         <CAMuHMdUps9Ti=CRZM7UxrHLD8GA+FKD+_RFLW3H9wUpSRTYs8w@mail.gmail.com>
         <20171129192407.vrkphuhttmzl2ii4@senary>
         <CAMuHMdX62=vC6=P-v=SPe_hq0F12tOZCgePaS7=MZZg_4PkvUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: "kyle.roeschley-acOepvfBmUk@public.gmane.org" <kyle.roeschley-acOepvfBmUk@public.gmane.org>,
        "geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org" <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdX62=vC6=P-v=SPe_hq0F12tOZCgePaS7=MZZg_4PkvUw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Content-ID: <DC1AF26D850B6F47B6847DFFD43E283C-+1mpgTUVCH2cE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

T24gV2VkLCAyMDE3LTExLTI5IGF0IDIzOjE4ICswMTAwLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3Jv
dGU6DQo+IA0KPiBUbyBtZSwgdGhlIGFib3ZlIHNvdW5kcyBhIGJpdCBjb250cmFkaWN0aXZlOiBl
aXRoZXIgeW91IGhhdmUNCj4gICAxLiBhIHNpbXBsZSAodHJpdmlhbCkgZGVzY3JpcHRpb24sIHdo
aWNoIGNhbiBiZSBoYW5kbGVkIGJ5IHNwaWRldiBhbmQNCj4gICAgICB1c2Vyc3BhY2UsIGFuZCB0
aHVzIGJ5IGp1c3Qgd3JpdGluZyAiPHVuaXQtYWRkcj4gc3BpZGV2IiB0byBhIG5ld19kZXZpY2UN
Cj4gICAgICBzeXNmcyBub2RlLCBvcg0KPiAgIDIuIGEgY29tcGxleCBkZXNjcmlwdGlvbiwgZm9y
IHdoaWNoIHlvdSBuZWVkIGEgc3BlY2lhbGl6ZWQgaW4ta2VybmVsIGRyaXZlciwNCj4gICAgICBz
byB5b3UncmUgZ29ubmEgbmVlZCBhIHJlYWwgRFQgbm9kZSAoYW5kIG92ZXJsYXlzPykgdG8gZGVz
Y3JpYmUgaXQuDQo+IA0KPiBJIGRvbid0IHRoaW5rIHdyaXRpbmcgYSBjb21wbGV4IGRlc2NyaXB0
aW9uIHRvIGEgbmV3X2RldmljZSBzeXNmcyBub2RlIG1ha2VzDQo+IHNlbnNlLg0KDQpJcyB0aGVy
ZSBhbnl0aGluZyBvbmUgY2FuIGRvIHdpdGggbmV3X2RldmljZSB0aGF0IGNhbid0IGJlIGRvbmUg
d2l0aCBhDQpkdCBmcmFnbWVudD8NCg0KSTJDIGFkZGVkIHRoYXQgZmVhdHVyZSBhIGxvbmcgdGlt
ZSBhZ28sIHdoZW4gd2Ugd2VyZSBzdGlsbCBsYXJnZWx5DQp1c2luZyBwbGF0Zm9ybV9kYXRhIGFu
ZCBib2FyZCBmaWxlcyBhbmQgZGV2aWNlIHRyZWUgZnJhZ21lbnRzIGRpZG4ndA0KZXhpc3QuICBJ
dCBzZWVtcyBvYnNvbGV0ZSB0byBtZS4gIE1heWJlIGVhc2llciB0byB1c2UgaWYgeW91IGxpbWl0
DQp5b3Vyc2VsZiB0byB3aGF0J3MgaW4gYnVzeWJveCwgYnV0IEkgdGhpbmsgb25lIGNvdWxkIHdy
aXRlIGEgc2ltcGxlDQpzaGVsbCBzY3JpcHQgdGhhdCBtYWtlcyBpdCBqdXN0IGFzIHNpbXBsZSB0
byBjcmVhdGUgbmV3IGRldmljZXMgd2l0aCBkdA0KZnJhZ21lbnRzIGFzIHdpdGggbmV3X2Rldmlj
ZS4=
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
