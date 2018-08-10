From: Trent Piepho <tpiepho@impinj.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI based
 QUP
Date: Fri, 10 Aug 2018 18:43:20 +0000
Message-ID: <1533926600.2283.358.camel@impinj.com>
References: <1525383283-18390-1-git-send-email-girishm@codeaurora.org>
         <152607782792.34267.8023817955251139395@swboyd.mtv.corp.google.com>
         <24b3ef71-18c1-1704-e324-5581fd18a998@codeaurora.org>
         <152700759909.210890.13296077062705155869@swboyd.mtv.corp.google.com>
         <20180522173000.GG24776@sirena.org.uk>
         <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
         <20180524162940.GA4828@sirena.org.uk>
         <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
         <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org>
         <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
         <1533839042.2283.305.camel@impinj.com>
         <CAD=FV=V4miw3i+8EPZPpgWGaVJhHbb2OBVTz6_iP-pMVhZoBOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "sdharia@codeaurora.org" <sdharia@codeaurora.org>,
        "dkota@codeaurora.org" <dkota@codeaurora.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "kramasub@codeaurora.org" <kramasub@codeaurora.org>,
        "girishm@codeaurora.org" <girishm@codeaurora.org>
To: "dianders@chromium.org" <dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=V4miw3i+8EPZPpgWGaVJhHbb2OBVTz6_iP-pMVhZoBOQ@mail.gmail.com>
Content-Language: en-US
Content-ID: <03018E91C631B542897077574CC2F32A@namprd06.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

T24gVGh1LCAyMDE4LTA4LTA5IGF0IDEyOjM3IC0wNzAwLCBEb3VnIEFuZGVyc29uIHdyb3RlOg0K
PiBPbiBUaHUsIEF1ZyA5LCAyMDE4IGF0IDExOjI0IEFNLCBUcmVudCBQaWVwaG8gPHRwaWVwaG9A
aW1waW5qLmNvbT4gd3JvdGU6DQo+ID4gDQo+IEkgdGhpbmsgd2UncmUgaW4gYWdyZWVtZW50IGJ1
dCBwZXJoYXBzIHRoZXJlJ3MgYSBtaXNjb21tdW5pY2F0aW9uIGhlcmU/DQo+IA0KPiBJJ20gc2F5
aW5nIHRoYXQgd2UgX3Nob3VsZG4ndF8gcHV0IHRoZSBtYXgtc3BlZWQgb2YgdGhlIG1hc3RlciBp
biB0aGUNCj4gZGV2aWNlIHRyZWUuICBUaGUgbWF4IHNwZWVkIGZvciB0aGUgSVAgYmxvY2sgb3Vn
aHQgdG8gYmUgaW4gY29kZQ0KPiBlaXRoZXIgaW4gdGhlIGNsb2NrIGRyaXZlciBvciBpbiB0aGUg
U1BJIGRyaXZlciBiYXNlZCBvbiB0aGUNCj4gY29tcGF0aWJsZSBzdHJpbmcuDQoNClllcywgdG90
YWxseSBhZ3JlZS4NCg0KVXN1YWxseSB0aGUgY2xvY2sgZnJhbWV3b3JrIHByb3ZpZGVzIGEgY2xv
Y2sgdG8gdGhlIFNQSSBJUCBibG9jayBhdA0Kc29tZSByYXRlLCBvciByYW5nZSBvZiByYXRlcy4g
IEJhc2VkIG9uIHRoYXQgY2xvY2ssIHRoZSBTUEkgSVAgYmxvY2sNCmhhcyBhIG1heCBTUEkgY2xv
Y2ssIGFuZCB0aGUgZHJpdmVyIGNhbiBjYWxjdWxhdGUgaXQuDQoNCldlIGRvIGhhdmUgYSBjb25j
ZXB0IG9mIGEgU1BJIG1hc3RlciBtYXggY2xvY2ssIGJ1dCBpdCdzIG5ldmVyIG5lZWRlZA0KdG8g
YmUgc3BlY2lmaWVkIGluIHRoZSBEVC4NCg0KQ29uc2lkZXIgdXNlcnNwYWNlIGFjY2VzcyB2aWEg
c3BpZGV2LiAgVGhlIHRyYW5zZmVyIGFza3MgZm9yIDEwMCBNSHosDQpidXQgdGhlIHNwaSBtYXN0
ZXIgZHJpdmVyIGNhbiBub3QgcG9zc2libHkgcHJvZ3JhbSB0aGF0IHNwZWVkIGludG8NCndoYXRl
dmVyIHJlZ2lzdGVyKHMpIGNvbnRyb2wgdGhlIHNwaSBjbG9jay4gIFRoZSBTUEkgY29yZSBoYW5k
bGVzIHRoYXQNCmNhc2Ugb2YgbGltaXRpbmcgYSB0cmFuc2ZlciB0byB0aGUgbWFzdGVyJ3MgbWF4
Lg0KDQo+IC4uLmFzIG9uZSBhcmd1bWVudCBfYWdhaW5zdF8gcHV0dGluZyBhIG1heC1zcGVlZCBm
b3IgdGhlIG1hc3RlciBpbiB0aGUNCj4gZGV2aWNlIHRyZWUgSSdtIHNheWluZyB0aGF0IHdlIGNh
biBhbHJlYWR5IHNwZWNpZnkgYSBtYXgtc3BlZWQgb2YgZWFjaA0KPiBzbGF2ZSBpbiB0aGUgZGV2
aWNlIHRyZWUuICBUaGUgbWF4IHNwZWVkIG9mIHRoZSBzbGF2ZSBzaG91bGQgdGFrZSBpbnRvDQo+
IGFjY291bnQgd2hhdGV2ZXIgZmFjdG9ycyBhcmUgc3BlY2lmaWMgdG8gdGhpcyBib2FyZCBpbmNs
dWRpbmcgdHJhY2UNCj4gbGVuZ3Rocywgbm9pc2UsIGV0Yy4gIElmIHdlIHNvbWVob3cgZGlkIG5l
ZWQgdG8gZ2V0IGEgbWF4IHNwZWVkIGluIHRoZQ0KPiBkZXZpY2UgdHJlZSBpdCBzZWVtcyBsaWtl
IHdlIGNvdWxkIGp1c3QgYWRqdXN0IHRoZSBtYXggc3BlZWQgZm9yIHRoZQ0KPiBzbGF2ZSB0byBi
ZSBzb21ldGhpbmcgbG93ZXIuICBJbiBvdGhlciB3b3JkcyBpZiB5b3Uga25vdyBhIGJvYXJkIGhh
cw0KPiBhbiBzZG04NDUgb24gaXQgYW5kIHlvdSBrbm93IHRoYXQgdGhlIFNQSSBjbG9jayBvbiBz
ZG04NDUgY2FuJ3QgZ28NCj4gb3ZlciA1MCBNSHogdGhlbiBpdCB3b3VsZCBtYWtlIG5vIHNlbnNl
IHRvIHN1Z2dlc3QgdGhhdCB3ZSBzaG91bGQgcnVuDQo+IHRoZSBTUEkgY2xvY2sgZm9yIGEgZGV2
aWNlIGF0IDEwMCBNSHouDQoNCldoYXQgeW91IG1pZ2h0IGRvIGlzIGRldGVybWluZSB0aGUgc2xh
dmUgY2FuIHJ1biBhdCAxMDAgTUh6LCBpbiBzb21lDQpjYXNlcy4gIFRoZSBib2FyZCwgdHJhY2Vz
LCBtYXN0ZXIsIGV0Yy4gY2FuIGRvIGl0LCBpbiBzb21lIGNhc2VzLiAgQnV0DQppdCdzIGFsc28g
cG9zc2libGUgdG8gY2hhbmdlIHRoZSBjbG9ja2luZyBkZXNpZ24gb3Igc2V0dGluZ3MgYXQgYQ0K
aGlnaGVyIGxldmVsLCB3aGljaCB0cmlja2xlcyBkb3duIHRvIHRoZSBTUEkgbWFzdGVyIElQIGJs
b2NrIGhhdmluZyBhDQpsb3dlciBjbG9jay4gIFRoaXMgaXMgaGFuZGxlZCBieSB0aGUgbWFzdGVy
IG1heCBzcGVlZCBiZWluZyBsZXNzIHRoZW4NCnRoZSBzbGF2ZSdzIG1heCBzcGVlZC4NCg0KVGhl
IG1hc3RlciBtYXggd291bGRuJ3QgYmUgaW4gdGhlIERULCBzaW5jZSBpdCdzIHByb2JhYmx5IGRl
dGVybWluZWQgYXQNCnJ1biB0aW1lIGJhc2VkIG9uIGlucHV0IGNsb2NrIHRvIHRoZSBtYXN0ZXIu
ICBCYXNlZCBvbiB0aGUgU29DIGNvcmUNCmNsb2NrLCB2b2x0YWdlLCBwb3dlciBtb2RlLCBldGMu
DQoNClNvIHlvdSBtaWdodCBoYXZlIGEgRFQgd2l0aCBhIHNsYXZlIGF0IDEwMCBNSHosIGV2ZW4g
aWYgaW4gc29tZSBjYXNlcw0KdGhlIG1hc3RlcidzIG1heCBpcyBsZXNzIHRoYW4gMTAwIE1Iei4g
IEl0J3Mgb2sgdG8gZGVwZW5kIG9uIHRoZSBtYXN0ZXINCnRvIGJlIHRoZSBsaW1pdGluZyBmYWN0
b3Iu
