From: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v6 4/7] mtd: spi-nor: add octal read flag for flash
 mt35xu512aba
Date: Fri, 21 Dec 2018 14:45:28 +0000
Message-ID: <bf29684e-138c-5f8d-e0ca-a04e343768df@microchip.com>
References: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1545214186-16987-5-git-send-email-yogeshnarayan.gaur@nxp.com>
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
In-Reply-To: <1545214186-16987-5-git-send-email-yogeshnarayan.gaur@nxp.com>
Content-Language: en-US
Content-ID: <C7D11504F499F14D9ECDFC622B36D03E@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

DQoNCk9uIDEyLzE5LzIwMTggMTI6MTIgUE0sIFlvZ2VzaCBOYXJheWFuIEdhdXIgd3JvdGU6DQo+
IEFkZCBvY3RhbCByZWFkIGZsYWcgZm9yIGZsYXNoIG10MzV4dTUxMmFiYS4NCj4gVGhpcyBmbGFz
aCwgbXQzNXh1NTEyYWJhLCBpcyBvbmx5IGNvbXBsYWludCB0byBTRkRQIEpFU0QyMTZCIGFuZCBk
b2VzDQo+IG5vdCBzZWVtIHRvIHN1cHBvcnQgbmV3ZXIgSkVTRDIxNkMgc3RhbmRhcmQgdGhhdCBw
cm92aWRlcyBhdXRvDQo+IGRldGVjdGlvbiBvZiBPY3RhbCBtb2RlIGNhcGFiaWxpdGllcyBhbmQg
b3Bjb2Rlcy4gVGhlcmVmb3JlLCB0aGlzDQo+IGNhcGFiaWxpdHkgaXMgbWFudWFsbHkgYWRkZWQg
dXNpbmcgbmV3IFNQSV9OT1JfT0NUQUxfUkVBRCBmbGFnLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
VmlnbmVzaCBSIDx2aWduZXNockB0aS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFlvZ2VzaCBOYXJh
eWFuIEdhdXIgPHlvZ2VzaG5hcmF5YW4uZ2F1ckBueHAuY29tPg0KDQpSZXZpZXdlZC1ieTogVHVk
b3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0KPiBDaGFu
Z2VzIGZvciB2NjoNCj4gLSBDb3JyZWN0IFMtby1iIHRhZyB3aXRoIGZ1bGwgYXV0aG9yIG5hbWUg
YXMgJ1lvZ2VzaCBOYXJheWFuIEdhdXInLg0KPiBDaGFuZ2VzIGZvciB2NToNCj4gLSBNb2RpZmll
ZCBzdHJpbmcgJ29jdG8nIHdpdGggJ29jdGFsJy4NCj4gQ2hhbmdlcyBmb3IgdjQ6DQo+IC0gTm9u
ZQ0KPiBDaGFuZ2VzIGZvciB2MzoNCj4gLSBNb2RpZmllZCBzdHJpbmcgJ29jdGFsJyB3aXRoICdv
Y3RvJy4NCj4gQ2hhbmdlcyBmb3IgdjI6DQo+IC0gSW5jb3Jwb3JhdGVkIHJldmlldyBjb21tZW50
cyBvZiBCb3JpcyBhbmQgVmlnbmVzaA0KPiANCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5v
ci5jIHwgMyArKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyBi
L2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+IGluZGV4IDg3MmQ3MDcuLjUzYTNiY2Mg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+ICsrKyBiL2Ry
aXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+IEBAIC0xODc3LDcgKzE4NzcsOCBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IGZsYXNoX2luZm8gc3BpX25vcl9pZHNbXSA9IHsNCj4gIAkvKiBNaWNy
b24gKi8NCj4gIAl7DQo+ICAJCSJtdDM1eHU1MTJhYmEiLCBJTkZPKDB4MmM1YjFhLCAwLCAxMjgg
KiAxMDI0LCA1MTIsDQo+IC0JCQlTRUNUXzRLIHwgVVNFX0ZTUiB8IFNQSV9OT1JfNEJfT1BDT0RF
UykNCj4gKwkJCVNFQ1RfNEsgfCBVU0VfRlNSIHwgU1BJX05PUl9PQ1RBTF9SRUFEIHwNCj4gKwkJ
CVNQSV9OT1JfNEJfT1BDT0RFUykNCj4gIAl9LA0KPiAgDQo+ICAJLyogUE1DICovDQo+IA0K
