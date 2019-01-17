From: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v7 3/5] mtd: m25p80: add support of octal mode I/O
 transfer
Date: Thu, 17 Jan 2019 07:16:01 +0000
Message-ID: <8381785e-95c2-8dfc-6fac-ea4710b3c943@microchip.com>
References: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1547546584-5254-4-git-send-email-yogeshnarayan.gaur@nxp.com>
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
In-Reply-To: <1547546584-5254-4-git-send-email-yogeshnarayan.gaur@nxp.com>
Content-Language: en-US
Content-ID: <CDE7A108107BB745BE3483018FC7CA90@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

DQoNCk9uIDAxLzE1LzIwMTkgMTI6MDUgUE0sIFlvZ2VzaCBOYXJheWFuIEdhdXIgd3JvdGU6DQo+
IEFkZCBzdXBwb3J0IGZvciBvY3RhbCBtb2RlIEkvTyBkYXRhIHRyYW5zZmVyIGJhc2VkIG9uIHRo
ZSBjb250cm9sbGVyIChzcGkpDQo+IG1vZGUuDQo+IEFzc2lnbiBody1jYXBhYmlsaXR5IG1hc2sg
Yml0cyBmb3Igb2N0YWwgdHJhbnNmZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZb2dlc2ggTmFy
YXlhbiBHYXVyIDx5b2dlc2huYXJheWFuLmdhdXJAbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFR1
ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCg0KPiAtLS0NCj4gIGRy
aXZlcnMvbXRkL2RldmljZXMvbTI1cDgwLmMgfCA5ICsrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbXRkL2RldmljZXMvbTI1cDgwLmMgYi9kcml2ZXJzL210ZC9kZXZpY2VzL20yNXA4MC5j
DQo+IGluZGV4IGM0YTFkMDRiOGM4MC4uNjUxYmFiNmQ0ZTMxIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL210ZC9kZXZpY2VzL20yNXA4MC5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL2RldmljZXMvbTI1
cDgwLmMNCj4gQEAgLTE5NSw3ICsxOTUsMTQgQEAgc3RhdGljIGludCBtMjVwX3Byb2JlKHN0cnVj
dCBzcGlfbWVtICpzcGltZW0pDQo+ICAJc3BpX21lbV9zZXRfZHJ2ZGF0YShzcGltZW0sIGZsYXNo
KTsNCj4gIAlmbGFzaC0+c3BpbWVtID0gc3BpbWVtOw0KPiAgDQo+IC0JaWYgKHNwaS0+bW9kZSAm
IFNQSV9SWF9RVUFEKSB7DQo+ICsJaWYgKHNwaS0+bW9kZSAmIFNQSV9SWF9PQ1RBTCkgew0KPiAr
CQlod2NhcHMubWFzayB8PSBTTk9SX0hXQ0FQU19SRUFEXzFfMV84Ow0KPiArDQo+ICsJCWlmIChz
cGktPm1vZGUgJiBTUElfVFhfT0NUQUwpDQo+ICsJCQlod2NhcHMubWFzayB8PSAoU05PUl9IV0NB
UFNfUkVBRF8xXzhfOCB8DQo+ICsJCQkJCVNOT1JfSFdDQVBTX1BQXzFfMV84IHwNCj4gKwkJCQkJ
U05PUl9IV0NBUFNfUFBfMV84XzgpOw0KPiArCX0gZWxzZSBpZiAoc3BpLT5tb2RlICYgU1BJX1JY
X1FVQUQpIHsNCj4gIAkJaHdjYXBzLm1hc2sgfD0gU05PUl9IV0NBUFNfUkVBRF8xXzFfNDsNCj4g
IA0KPiAgCQlpZiAoc3BpLT5tb2RlICYgU1BJX1RYX1FVQUQpDQo+IA0K
