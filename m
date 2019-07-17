From: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Subject: Re: [PATCH 2/5] drivers: spi: core: Add optional stall delay
 between cs_change transfers
Date: Wed, 17 Jul 2019 11:37:30 +0000
Message-ID: <138d96e8af0f1c873046b7257c6c40a3d4b9d95e.camel@analog.com>
References: <20190625131328.11883-1-alexandru.ardelean@analog.com>
         <20190625131328.11883-2-alexandru.ardelean@analog.com>
         <20190626193438.7248d0a9@archlinux> <20190709141228.GC14859@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
To: "broonie@kernel.org" <broonie@kernel.org>,
        "jic23@jic23.retrosnub.co.uk" <jic23@jic23.retrosnub.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190709141228.GC14859@sirena.co.uk>
Content-Language: en-US
Content-ID: <2E005C72BC45774396FB9D4262E0F4AE@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

T24gVHVlLCAyMDE5LTA3LTA5IGF0IDE1OjEyICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBXZWQsIEp1biAyNiwgMjAxOSBhdCAwNzozNDozOFBNICswMTAwLCBKb25hdGhhbiBDYW1lcm9u
IHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjUgSnVuIDIwMTkgMTY6MTM6MjUgKzAzMDANCj4gPiBBbGV4
YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPiB3cm90ZToNCj4g
PiANCj4gPiA+IFNvbWUgZGV2aWNlcyBsaWtlIHRoZSBBRElTMTY0NjAgSU1VIHJlcXVpcmUgYSBz
dGFsbCBwZXJpb2QgYmV0d2Vlbg0KPiA+ID4gdHJhbnNmZXJzLCBpLmUuIGJldHdlZW4gd2hlbiB0
aGUgQ1MgaXMgZGUtYXNzZXJ0ZWQgYW5kIHJlLWFzc2VydGVkLiBUaGUNCj4gPiA+IGRlZmF1bHQg
dmFsdWUgb2YgMTB1cyBpcyBub3QgZW5vdWdoLiBUaGlzIGNoYW5nZSBtYWtlcyB0aGUgZGVsYXkN
Cj4gPiA+IGNvbmZpZ3VyYWJsZSBmb3Igd2hlbiB0aGUgbmV4dCBDUyBjaGFuZ2UgZ29lcyBhY3Rp
dmUuDQo+IA0KPiBUaGlzIGxvb2tzIGxpa2UgY3NfY2hhbmdlX2RlbGF5Lg0KPiANCj4gQXMgZG9j
dW1lbnRlZCBpbiBTdWJtaXR0aW5nUGF0Y2hlcyBwbGVhc2Ugc2VuZCBwYXRjaGVzIHRvIHRoZSAN
Cj4gbWFpbnRhaW5lcnMgZm9yIHRoZSBjb2RlIHlvdSB3b3VsZCBsaWtlIHRvIGNoYW5nZS4gIFRo
ZSBub3JtYWwga2VybmVsDQo+IHdvcmtmbG93IGlzIHRoYXQgcGVvcGxlIGFwcGx5IHBhdGNoZXMg
ZnJvbSB0aGVpciBpbmJveGVzLCBpZiB0aGV5IGFyZW4ndA0KPiBjb3BpZWQgdGhleSBhcmUgbGlr
ZWx5IHRvIG5vdCBzZWUgdGhlIHBhdGNoIGF0IGFsbCBhbmQgaXQgaXMgbXVjaCBtb3JlDQo+IGRp
ZmZpY3VsdCB0byBhcHBseSBwYXRjaGVzLg0KDQpBY2suDQpbU29ycnkgZm9yIHRoZSBsYXRlIHJl
cGx5OyBJJ20gYmFsYW5jaW5nIG90aGVyIHN0dWZmIGFzIHdlbGwgYW5kIHRlcnJpYmxlIGF0IGl0
XQ0KDQpJJ2xsIHByb2JhYmx5IHVwZGF0ZSBteSBwcmFjdGljZSB0byBhbHNvIGluY2x1ZGUgbWFp
bnRhaW5lcnMgdmlhIC0tY2MgdG8gYGdpdCBzZW5kLWVtYWlsYC4NClVwIHVudGlsIG5vdywgSSB3
b3VsZCBzZW5kIGVtYWlscyB0byBsaXN0cyBbYXMgbXVjaCBhcyBwb3NzaWJsZV0gYW5kIHRyeSB0
byBub3QgaW5jbHVkZSBwZW9wbGUgZGlyZWN0bHkuDQpNeSBhc3N1bXB0aW9uIHdhcyB0aGF0IHRo
ZSBsaXN0IGlzIGVub3VnaC4NCg0KSSdtIHN0aWxsIGFkanVzdGluZyB0byBob3cgdGhpbmdzIGdl
dCBkb25lIGluIHRoZSB2YXJpb3VzIExpbnV4IGtlcm5lbCBzdWJzeXN0ZW1zL3N1Ymdyb3Vwcy4N
Cg==
