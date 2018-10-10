From: Trent Piepho <tpiepho@impinj.com>
Subject: Re: [PATCH 3/3] eeprom: at25: Split writes in two SPI transfers to
 optimize DMA
Date: Wed, 10 Oct 2018 21:47:44 +0000
Message-ID: <1539208063.1944.12.camel@impinj.com>
References: <20181010134036.8296-1-geert+renesas@glider.be>
         <20181010134036.8296-4-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@vger.kernel.org" <linux-mtd@vger.kernel.org>
To: "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010134036.8296-4-geert+renesas@glider.be>
Content-Language: en-US
Content-ID: <FD31C196B848E14FB1B404D2DC096035@namprd06.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

T24gV2VkLCAyMDE4LTEwLTEwIGF0IDE1OjQwICswMjAwLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3Jv
dGU6DQo+IEN1cnJlbnRseSBFRVBST00gd3JpdGVzIGFyZSBpbXBsZW1lbnRlZCB1c2luZyBhIHNp
bmdsZSBTUEkgdHJhbnNmZXIsDQo+IHdoaWNoIGNvbnRhaW5zIGFsbCBvZiBjb21tYW5kLCBhZGRy
ZXNzLCBhbmQgcGF5bG9hZCBkYXRhIGJ5dGVzLg0KPiBBcyBzb21lIFNQSSBjb250cm9sbGVycyBp
bXBvc2UgbGltaXRhdGlvbnMgb24gdHJhbnNmZXJzIHdpdGggcmVzcGVjdCB0bw0KPiB0aGUgdXNl
IG9mIERNQSwgdGhleSBtYXkgaGF2ZSB0byBmYWxsIGJhY2sgdG8gUElPLiBFLmcuIERNQSBtYXkg
cmVxdWlyZQ0KPiB0aGUgdHJhbnNmZXIgbGVuZ3RoIHRvIGJlIGEgbXVsdGlwbGUgb2YgNCBieXRl
cy4NCj4gDQo+IE9wdGltaXplIHdyaXRlcyBmb3IgRE1BIGJ5IHNwbGl0dGluZyB3cml0ZXMgaW4g
dHdvIFNQSSB0cmFuc2ZlcnM6DQo+ICAgLSBUaGUgZmlyc3QgdHJhbnNmZXIgY29udGFpbnMgY29t
bWFuZCBhbmQgYWRkcmVzcyBieXRlcywNCj4gICAtIFRoZSBzZWNvbmQgdHJhbnNmZXIgY29udGFp
bnMgdGhlIGFjdHVhbCBwYXlsb2FkIGRhdGEsIG5vdyBzdG9yZWQgYXQNCj4gICAgIHRoZSBzdGFy
dCBvZiB0aGUgKGttYWxsb2MoKSBhbGlnbmVkKSBidWZmZXIsIHRvIGltcHJvdmUgcGF5bG9hZA0K
PiAgICAgYWxpZ25tZW50Lg0KDQpEb2VzIHRoaXMgYWx3YXlzIG9wdGltaXplPyAgQSBtYXN0ZXIg
Y2FwYWJsZSBvZiBhbiBvZiBhbGlnbmVkIDE4IGJ5dGUNCkRNQSB4ZmVyIHdvdWxkIG5vdyBoYXZl
IGEgMiBieXRlIHhmZXIgdGhhdCB3b3VsZCBwcm9iYWJseSBiZSBQSU8NCmZvbGxvd2VkIGJ5IGEg
MTYgYnl0ZSBETUEuDQoNCk9yIHdyaXRpbmcgMTQgYnl0ZXMgdG8gdGhlIEVFUFJPTSBoYXMgY2hh
bmdlZCBmcm9tIGFuIGFsaWduZWQgMTYgYnl0ZQ0Kd3JpdGUgdG8gYSAyIGJ5dGUgYW5kIGEgMTQg
Ynl0ZSwgd2hpY2ggaXMgbm93IHdvcnNlIGZvciB0aGUgNCBieXRlDQptdWx0aXBsZSByZXF1aXJl
bWVudCBtYXN0ZXIgd2hpY2ggY2FuIHVzZSBhbnkgRE1BIGFueW1vcmUuDQoNCkl0IHNlZW1zIGxp
a2UgYW4gZW5oYW5jZW1lbnQgdG8gdGhlIERNQSBjb2RlIHRvIGxvb2sgbW9yZSBsaWtlIGENCmVm
ZmljaWVudCBtZW1jcHkoKSB0aGF0IGFsaWducyB0aGUgYWRkcmVzcywgdGhlbiB4ZmVycyBlZmZp
Y2llbnQNCmJsb2NrcywgdGhlbiBmaW5pc2hlcyB0aGUgc3ViLWJsb2NrIHRhaWwgd291bGQgYmUg
bW9yZSBnZW5lcmFsbHkNCmFwcGxpY2FibGUuDQoNCk9yIG1vcmUgc2ltcGx5LCBnaXZlbiBhbiBh
bGlnbmVkIDE4IGJ5dGUgeGZlciwgdGhlIGRyaXZlciBzaG91bGQgZG8gYW4NCmFsaWduZWQgMTYg
Ynl0ZSBETUEgYW5kIHRoZW4gdHdvIG1vcmUgYnl0ZXMuDQo=
