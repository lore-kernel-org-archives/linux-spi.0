From: Robin Gong <yibin.gong@nxp.com>
Subject: Re: [EXT] Re: [PATCH v3 00/14] add ecspi ERR009165 for i.mx6/7 soc
 family
Date: Fri, 17 May 2019 09:54:55 +0000
Message-ID: <1558115932.2569.7.camel@nxp.com>
References: <1557249513-4903-1-git-send-email-yibin.gong@nxp.com>
         <1557739890.3997.1.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
To: "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1557739890.3997.1.camel@pengutronix.de>
Content-Language: en-US
Content-ID: <EF094952BA67E6458AFB211805B746ED@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

T24gMjAxOS0wNS0xMyBhdCAwOTozMSArMDAwMCwgTHVjYXMgU3RhY2ggd3JvdGU6DQo+IFBTOg0K
PiA+IMKgIFBsZWFzZSBnZXQgc2RtYSBmaXJtd2FyZSBmcm9tIGJlbG93IGxpbnV4LWZpcm13YXJl
IGFuZCBjb3B5IGl0IHRvDQo+ID4geW91cg0KPiA+IGxvY2FsIHJvb3RmcyAvbGliL2Zpcm13YXJl
L2lteC9zZG1hLg0KPiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9v
ay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmcNCj4gPiBpdC5rZXJuZWwub3JnJTJGcHViJTJGc2Nt
JTJGbGludXglMkZrZXJuZWwlMkZnaXQlMkZmaXJtd2FyZSUyRmxpbnV4DQo+ID4gLWZpcm13YXJl
LmdpdCUyRnRyZWUlMkZpbXglMkZzZG1hJmFtcDtkYXRhPTAyJTdDMDElN0N5aWJpbi5nb25nJTQw
bg0KPiA+IHhwLmNvbSU3QzU3ZWIzMGMwM2M5MzQ1ZTJjMjdlMDhkNmQ3ODVjY2EzJTdDNjg2ZWEx
ZDNiYzJiNGM2ZmE5MmNkOTkNCj4gPiBjNWMzMDE2MzUlN0MwJTdDMCU3QzYzNjkzMzM2Njk5NTY5
MjQzMCZhbXA7c2RhdGE9d0xLYTJxd2tJTWxOJTJCZWVEDQo+ID4gNExPR0UlMkZ0SUZ6dkdLWHlJ
aG9aNEZla3I0dkklM0QmYW1wO3Jlc2VydmVkPTANCj4gVGhpcyBzZXJpZXMgaXMgdW5maXQgZm9y
IG1lcmdpbmcsIGFzIGxvbmcgYXMgaXQgZGVwZW5kcyBvbiBhIFNETUEgUkFNDQo+IHNjcmlwdCB0
aGF0IGlzIGtub3duIHRvIGJyZWFrIHNlcmlhbCBETUEuIFdoZW4gY2FuIHdlIGV4cGVjdCB0byBn
ZXQgYQ0KPiBmaXJtd2FyZSB2ZXJzaW9uIHdpdGggdGhlIGJyb2tlbiBzZXJpYWwgc2NyaXB0IHJl
bW92ZWQgb3V0IGludG8gdGhlDQo+IHB1YmxpYz8NCkhpIEx1Y2FzLA0KwqAgSSB3YW50IHRvIHNl
bnQgYW5vdGhlciBwYXRjaCBmb3IgZml4aW5nIFVBUlQgZmFpbHVyZSBvbiByYW0gc2NyaXB0DQps
YXRlciBhZnRlciB0aGlzIGVjc3BpIHBhdGNoIHNldCBhY2NlcHRlZC4gQnV0IG5vdyBJJ20gc3Rp
bGwgd2FpdGluZw0KZm9yIGFjayBmcm9tIFZpbm9kIHdobyBpcyBvd25lciBvZiBkbWFlbmdpbmUu
DQo+IA0KPiBSZWdhcmRzLA0KPiBMdWNhcw0KPiANCj4gPiANCj4gPiB2MjoNCj4gPiDCoCAxLiBh
ZGQgY29tbWl0IGxvZyBmb3IgcmV2ZXJ0ZWQgcGF0Y2hlcy4NCj4gPiDCoCAyLiBhZGQgY29tbWVu
dCBmb3IgJ2Vjc3BpX2ZpeGVkJyBpbiBzZG1hIGRyaXZlci4NCj4gPiDCoCAzLiBhZGQgJ2ZzbCxp
bXg2c2xsLWVjc3BpJyBjb21wYXRpYmxlIGluc3RlYWQgb2YgJ2ZzbCxpbXg2dWwtDQo+ID4gZWNz
cGknDQo+ID4gwqDCoMKgwqDCoHJhdGhlciB0aGFuIHJlbW92ZS4NCj4gPiB2MzoNCj4gPiDCoCAx
LiBjb25maXJtIHdpdGggZGVzaWduIHRlYW0gbWFrZSBzdXJlIEVSUjAwOTE2NSBmaXhlZCBvbg0K
PiA+IGkubXg2dWwvaS5teDZ1bGwNCj4gPiDCoCAvaS5teDZzbGwsIG5vdCBmaXhlZCBvbiBpLm14
OG0vOG1tIGFuZCBvdGhlciBpLm14Ni83IGxlZ2FjeQ0KPiA+IGNoaXBzLg0KPiA+IMKgIENvcnJl
Y3QgZHRzIHJlbGF0ZWQgZHRzIHBhdGNoIGluIHYyLg0KPiA+IMKgIDIuIGNsZWFuIGVyYXR0YSBp
bmZvcm1hdGlvbiBpbiBiaW5kaW5nIGRvYyBhbmQgbmV3DQo+ID4gJ3R4X2dsaXRjaF9maXhlZCcg
ZmxhZw0KPiA+IMKgIGluIHNwaS1pbXggZHJpdmVyIHRvIHN0YXRlIEVSUjAwOTE2NSBmaXhlZCBv
ciBub3QuDQo+ID4gwqAgMy4gRW5sYXJnZSBidXJzdCBzaXplIHRvIGZpZm8gc2l6ZSBmb3IgdHgg
c2luY2UgdHhfd21sIHNldCB0byAwDQo+ID4gaW4gdGhlDQo+ID4gwqAgZXJyYXRhIHdvcmthcm91
ZCwgdGh1cyBpbXByb3ZlIHBlcmZvcm1hbmNlIGFzIHBvc3NpYmxlLg0KPiA+IA0KPiA+IFJvYmlu
IEdvbmcgKDE0KToNCj4gPiDCoCBSZXZlcnQgIkFSTTogZHRzOiBpbXg2cTogVXNlIGNvcnJlY3Qg
U0RNQSBzY3JpcHQgZm9yIFNQSTUgY29yZSINCj4gPiDCoCBSZXZlcnQgIkFSTTogZHRzOiBpbXg2
OiBVc2UgY29ycmVjdCBTRE1BIHNjcmlwdCBmb3IgU1BJIGNvcmVzIg0KPiA+IMKgIFJldmVydCAi
ZG1hZW5naW5lOiBpbXgtc2RtYTogcmVmaW5lIHRvIGxvYWQgY29udGV4dCBvbmx5IG9uY2UiDQo+
ID4gwqAgZG1hZW5naW5lOiBpbXgtc2RtYTogcmVtb3ZlIGR1cGlsaWNhdGVkIHNkbWFfbG9hZF9j
b250ZXh0DQo+ID4gwqAgZG1hZW5naW5lOiBpbXgtc2RtYTogYWRkIG1jdV8yX2Vjc3BpIHNjcmlw
dA0KPiA+IMKgIHNwaTogaW14OiBmaXggRVJSMDA5MTY1DQo+ID4gwqAgc3BpOiBpbXg6IHJlbW92
ZSBFUlIwMDkxNjUgd29ya2Fyb3VuZCBvbiBpLm14NnVsDQo+ID4gwqAgZHQtYmluZGluZ3M6IHNw
aTogaW14OiBhZGQgbmV3IGkubXg2dWwgY29tcGF0aWJsZSBuYW1lDQo+ID4gwqAgZG1hZW5naW5l
OiBpbXgtc2RtYTogcmVtb3ZlIEVSUjAwOTE2NSBvbiBpLm14NnVsDQo+ID4gwqAgZHQtYmluZGlu
Z3M6IGRtYTogaW14LXNkbWE6IGFkZCBpLm14NnVsLzZzeCBjb21wYXRpYmxlIG5hbWUNCj4gPiDC
oCBkbWFlbmdpbmU6IGlteC1zZG1hOiBmaXggZWNzcGkxIHJ4IGRtYSBub3Qgd29yayBvbiBpLm14
OG1tDQo+ID4gwqAgQVJNOiBkdHM6IGlteDZ1bDogYWRkIGRtYSBzdXBwb3J0IG9uIGVjc3BpDQo+
ID4gwqAgQVJNOiBkdHM6IGlteDZzbGw6IGNvcnJlY3Qgc2RtYSBjb21wYXRpYmxlDQo+ID4gwqAg
YXJtNjQ6IGRlZmNvbmZpZzogRW5hYmxlIFNETUEgb24gaS5teDhtcS84bW0NCj4gPiANCj4gPiDC
oC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9mc2wtaW14LXNkbWEudHh0wqDCoMKgwqDCoMKg
wqB8wqDCoDIgKw0KPiA+IMKgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL2ZzbC1pbXgtY3Nw
aS50eHTCoMKgwqDCoMKgwqDCoHzCoMKgMSArDQo+ID4gwqBhcmNoL2FybS9ib290L2R0cy9pbXg2
cS5kdHNpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHzCoMKg
MiArLQ0KPiA+IMKgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC5kdHNpwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfMKgwqA4ICstLQ0KPiA+IMKgYXJjaC9hcm0vYm9v
dC9kdHMvaW14NnNsbC5kdHNpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgfMKgwqAyICstDQo+ID4gwqBhcmNoL2FybS9ib290L2R0cy9pbXg2dWwuZHRzacKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfMKgwqA4ICsrKw0KPiA+IMKgYXJj
aC9hcm02NC9jb25maWdzL2RlZmNvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB8wqDCoDMgKw0KPiA+IMKgZHJpdmVycy9kbWEvaW14LXNkbWEuY8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8IDc4
DQo+ID4gKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiA+IMKgZHJpdmVycy9zcGkvc3BpLWlteC5j
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgfCA2MQ0KPiA+ICsrKysrKysrKysrKysrLS0tDQo+ID4gwqBpbmNsdWRlL2xpbnV4L3BsYXRm
b3JtX2RhdGEvZG1hLWlteC1zZG1hLmjCoMKgwqDCoMKgwqDCoMKgwqB8wqDCoDEgKw0KPiA+IMKg
MTAgZmlsZXMgY2hhbmdlZCwgMTMyIGluc2VydGlvbnMoKyksIDM0IGRlbGV0aW9ucygtKQ0KPiA+
IA0KPiA+IC0tDQo+ID4gMi43LjQNCj4gPiA=
