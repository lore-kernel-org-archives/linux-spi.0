From: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v7 2/5] mtd: spi-nor: add octal read flag for flash
 mt35xu512aba
Date: Wed, 16 Jan 2019 06:19:20 +0000
Message-ID: <cb800292-a732-f6f4-650e-00bffe760e5a@microchip.com>
References: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1547546584-5254-3-git-send-email-yogeshnarayan.gaur@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: <robh@kernel.org>, <mark.rutland@arm.com>, <shawnguo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <computersforpeace@gmail.com>, <frieder.schrempf@exceet.de>,
        <linux-kernel@vger.kernel.org>
To: <yogeshnarayan.gaur@nxp.com>, <linux-mtd@lists.infradead.org>,
        <boris.brezillon@bootlin.com>, <broonie@kernel.org>,
        <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547546584-5254-3-git-send-email-yogeshnarayan.gaur@nxp.com>
Content-Language: en-US
Content-ID: <94D5D15A0F9C1B4FA92B2F87B7A562AA@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

DQoNCk9uIDAxLzE1LzIwMTkgMTI6MDUgUE0sIFlvZ2VzaCBOYXJheWFuIEdhdXIgd3JvdGU6DQo+
IEFkZCBvY3RhbCByZWFkIGZsYWcgZm9yIGZsYXNoIG10MzV4dTUxMmFiYS4NCj4gVGhpcyBmbGFz
aCwgbXQzNXh1NTEyYWJhLCBpcyBvbmx5IGNvbXBsYWludCB0byBTRkRQIEpFU0QyMTZCIGFuZCBk
b2VzDQo+IG5vdCBzZWVtIHRvIHN1cHBvcnQgbmV3ZXIgSkVTRDIxNkMgc3RhbmRhcmQgdGhhdCBw
cm92aWRlcyBhdXRvDQo+IGRldGVjdGlvbiBvZiBPY3RhbCBtb2RlIGNhcGFiaWxpdGllcyBhbmQg
b3Bjb2Rlcy4gVGhlcmVmb3JlLCB0aGlzDQo+IGNhcGFiaWxpdHkgaXMgbWFudWFsbHkgYWRkZWQg
dXNpbmcgbmV3IFNQSV9OT1JfT0NUQUxfUkVBRCBmbGFnLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
VmlnbmVzaCBSIDx2aWduZXNockB0aS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFlvZ2VzaCBOYXJh
eWFuIEdhdXIgPHlvZ2VzaG5hcmF5YW4uZ2F1ckBueHAuY29tPg0KDQpSZXZpZXdlZC1ieTogVHVk
b3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0KPiAgZHJp
dmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMgfCAzICsrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bXRkL3NwaS1ub3Ivc3BpLW5vci5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCj4g
aW5kZXggODcyZDcwNzIyNjcyLi41M2EzYmNjNmE1NWIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
bXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5v
ci5jDQo+IEBAIC0xODc3LDcgKzE4NzcsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZsYXNoX2lu
Zm8gc3BpX25vcl9pZHNbXSA9IHsNCj4gIAkvKiBNaWNyb24gKi8NCj4gIAl7DQo+ICAJCSJtdDM1
eHU1MTJhYmEiLCBJTkZPKDB4MmM1YjFhLCAwLCAxMjggKiAxMDI0LCA1MTIsDQo+IC0JCQlTRUNU
XzRLIHwgVVNFX0ZTUiB8IFNQSV9OT1JfNEJfT1BDT0RFUykNCj4gKwkJCVNFQ1RfNEsgfCBVU0Vf
RlNSIHwgU1BJX05PUl9PQ1RBTF9SRUFEIHwNCj4gKwkJCVNQSV9OT1JfNEJfT1BDT0RFUykNCj4g
IAl9LA0KPiAgDQo+ICAJLyogUE1DICovDQo+IA0K
