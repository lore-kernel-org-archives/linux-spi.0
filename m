From: "Yang, Wenyou" <Wenyou.Yang@atmel.com>
Subject: RE: [PATCH v7 10/14] spi/spi-atmel: correct 16 bits transfers with
 DMA
Date: Tue, 2 Apr 2013 05:46:50 +0000
Message-ID: <B256D81BAE5131468A838E5D7A24364150E8B304@penmbx01>
References: <1363678866-3567-1-git-send-email-wenyou.yang@atmel.com>
 <1363679341-4087-1-git-send-email-wenyou.yang@atmel.com>
 <20130401135359.GB18636@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
	"richard.genoud@gmail.com" <richard.genoud@gmail.com>,
	"plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>,
	"Ferre, Nicolas" <Nicolas.FERRE@atmel.com>,
	"Lin, JM" <JM.Lin@atmel.com>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130401135359.GB18636@opensource.wolfsonmicro.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

SGksIE1hcmssDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyayBC
cm93biBbbWFpbHRvOmJyb29uaWVAb3BlbnNvdXJjZS53b2xmc29ubWljcm8uY29tXQ0KPiBTZW50
OiAyMDEzxOo01MIxyNUgMjE6NTQNCj4gVG86IFlhbmcsIFdlbnlvdQ0KPiBDYzogbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBncmFudC5saWtlbHlAc2VjcmV0bGFiLmNhOw0K
PiByaWNoYXJkLmdlbm91ZEBnbWFpbC5jb207IHBsYWduaW9qQGpjcm9zb2Z0LmNvbTsgRmVycmUs
IE5pY29sYXM7IExpbiwgSk07DQo+IHNwaS1kZXZlbC1nZW5lcmFsQGxpc3RzLnNvdXJjZWZvcmdl
Lm5ldDsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHY3IDEwLzE0XSBzcGkvc3BpLWF0bWVsOiBjb3JyZWN0IDE2IGJpdHMgdHJhbnNmZXJzIHdpdGgg
RE1BDQo+IA0KPiBPbiBUdWUsIE1hciAxOSwgMjAxMyBhdCAwMzo0OTowMVBNICswODAwLCBXZW55
b3UgWWFuZyB3cm90ZToNCj4gPiBGcm9tOiBSaWNoYXJkIEdlbm91ZCA8cmljaGFyZC5nZW5vdWRA
Z21haWwuY29tPg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBHZW5vdWQgPHJpY2hh
cmQuZ2Vub3VkQGdtYWlsLmNvbT4NCj4gPiBDYzogc3BpLWRldmVsLWdlbmVyYWxAbGlzdHMuc291
cmNlZm9yZ2UubmV0DQo+ID4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBb
d2VueW91LnlhbmdAYXRtZWwuY29tOiBzdWJtaXQgdGhlIHBhdGNoXQ0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFdlbnlvdSBZYW5nIDx3ZW55b3UueWFuZ0BhdG1lbC5jb20+DQo+IA0KPiBTaG91bGRuJ3Qg
dGhpcyBiZSBzcXVhc2hlZCBpbnRvIHRoZSBkbWFlbmdpbmUgcGF0Y2g/DQpPSywgSSB3aWxsIHNx
dWFzaCBpdCBpbnRvIHRoZSBkbWFlbmdpbmUgcGF0Y2gNCg0KQmVzdCBSZWdhcmRzLA0KV2VueW91
IFlhbmcNCg==
