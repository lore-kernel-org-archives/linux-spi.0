From: Trent Piepho <tpiepho@impinj.com>
Subject: Re: [PATCH v2] spi: dw: support 4-16 bits per word
Date: Fri, 17 Aug 2018 16:32:31 +0000
Message-ID: <1534523550.2283.397.camel@impinj.com>
References: <20180808071421.32707-1-simon.k.r.goldschmidt@gmail.com>
         <20180817070105.1725-1-simon.k.r.goldschmidt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "simon.k.r.goldschmidt@gmail.com" <simon.k.r.goldschmidt@gmail.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180817070105.1725-1-simon.k.r.goldschmidt@gmail.com>
Content-Language: en-US
Content-ID: <1E96AE1C0D7E3F4F9072F9FBF5E5E939@namprd06.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

T24gRnJpLCAyMDE4LTA4LTE3IGF0IDA5OjAxICswMjAwLCBTaW1vbiBHb2xkc2NobWlkdCB3cm90
ZToNCj4gVGhlIHNwaS1kdyBkcml2ZXIgY3VycmVudGx5IG9ubHkgc3VwcG9ydHMgOCBvciAxNiBi
aXRzIHBlciB3b3JkLg0KPiANCj4gU2luY2UgdGhlIGhhcmR3YXJlIHN1cHBvcnRzIDQtMTYgYml0
cyBwZXIgd29yZCwgYWRhcHQgdGhlIGRyaXZlcg0KPiB0byBhbHNvIHN1cHBvcnQgdGhpcy4NCj4g
DQo+IA0KDQo+IEBAIC0zMDcsMTUgKzMwNywxMyBAQCBzdGF0aWMgaW50IGR3X3NwaV90cmFuc2Zl
cl9vbmUoc3RydWN0IHNwaV9jb250cm9sbGVyICptYXN0ZXIsDQo+ICsNCj4gKwlpZiAoKHRyYW5z
ZmVyLT5iaXRzX3Blcl93b3JkIDwgNCkgfHwgKHRyYW5zZmVyLT5iaXRzX3Blcl93b3JkID4gMTYp
KQ0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gLQl9DQoNCllvdSBkb24ndCBuZWVkIHRoaXMgY2hl
Y2sgYXMgdGhlIHNwaSBjb3JlIHZhbGlkYXRlcyB0aGUgdHJhbnNmZXINCmFnYWluc3QgbWFzdGVy
LT5iaXRzX3Blcl93b3JkX21hc2suDQoNCj4gIAltYXN0ZXItPm1vZGVfYml0cyA9IFNQSV9DUE9M
IHwgU1BJX0NQSEEgfCBTUElfTE9PUDsNCj4gLQltYXN0ZXItPmJpdHNfcGVyX3dvcmRfbWFzayA9
IFNQSV9CUFdfTUFTSyg4KSB8IFNQSV9CUFdfTUFTSygxNik7DQo+ICsJbWFzdGVyLT5iaXRzX3Bl
cl93b3JkX21hc2sgPSAgU1BJX0JQV19SQU5HRV9NQVNLKDQsIDE2KTsNCj4gIAltYXN0ZXItPmJ1
c19udW0gPSBkd3MtPmJ1c19udW07DQo+IA==
