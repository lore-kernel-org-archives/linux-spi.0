From: "Yang, Wenyou" <Wenyou.Yang@atmel.com>
Subject: RE: [PATCH v7 08/14] spi/spi-atmel: fix spi-atmel driver to adapt
 to slave_config changes
Date: Tue, 2 Apr 2013 05:45:48 +0000
Message-ID: <B256D81BAE5131468A838E5D7A24364150E8A2ED@penmbx01>
References: <1363678866-3567-1-git-send-email-wenyou.yang@atmel.com>
 <1363679236-3973-1-git-send-email-wenyou.yang@atmel.com>
 <20130401135104.GZ18636@opensource.wolfsonmicro.com>
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
In-Reply-To: <20130401135104.GZ18636@opensource.wolfsonmicro.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

SGksIE1hcmssDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyayBC
cm93biBbbWFpbHRvOmJyb29uaWVAb3BlbnNvdXJjZS53b2xmc29ubWljcm8uY29tXQ0KPiBTZW50
OiAyMDEzxOo01MIxyNUgMjE6NTENCj4gVG86IFlhbmcsIFdlbnlvdQ0KPiBDYzogbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBncmFudC5saWtlbHlAc2VjcmV0bGFiLmNhOw0K
PiByaWNoYXJkLmdlbm91ZEBnbWFpbC5jb207IHBsYWduaW9qQGpjcm9zb2Z0LmNvbTsgRmVycmUs
IE5pY29sYXM7IExpbiwgSk07DQo+IHNwaS1kZXZlbC1nZW5lcmFsQGxpc3RzLnNvdXJjZWZvcmdl
Lm5ldDsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHY3IDA4LzE0XSBzcGkvc3BpLWF0bWVsOiBmaXggc3BpLWF0bWVsIGRyaXZlciB0byBhZGFwdCB0
bw0KPiBzbGF2ZV9jb25maWcgY2hhbmdlcw0KPiANCj4gT24gVHVlLCBNYXIgMTksIDIwMTMgYXQg
MDM6NDc6MTZQTSArMDgwMCwgV2VueW91IFlhbmcgd3JvdGU6DQo+ID4gRnJvbTogUmljaGFyZCBH
ZW5vdWQgPHJpY2hhcmQuZ2Vub3VkQGdtYWlsLmNvbT4NCj4gPg0KPiA+IFRoaXMgaXMgdGhlIGZv
bGxvd2luZyBvZiB0aGUgcGF0Y2gNCj4gPiBlMmIzNWYzZGJmYzA4MGYxNWI3MjgzNGQwOGYwNGYw
MjY5ZGJlOWJlDQo+IA0KPiBXaGF0IGlzIHRoaXMgcGF0Y2ggYWN0dWFsbHkgZG9pbmcsIHNob3Vs
ZG4ndCBpdCBiZSBwYXJ0IG9mIHRoZSBwcmV2aW91cyBjb21taXQ/DQo+IFRoZSBjaGFuZ2Vsb2cg
cmVhbGx5IG91Z2h0IHRvIGhhdmUgYSBwbGFpbiB0ZXh0IHZlcnNpb24gb2YgdGhlIGNvbW1pdA0K
PiBkZXNjcmlwdGlvbiB0b28uDQpZb3UgYXJlIHJpZ2h0LCBpdCBpc24ndCB0aGUgcGFydCBvZiB0
aGUgcHJldmlvdXMgY29tbWl0Lg0KSSB3aWxsIHNxdWFzaCBpdCBpbnRvIHRoZSBkbWFlbmdpbmUg
cGF0Y2guDQoNCkJlc3QgUmVnYXJkcywNCldlbnlvdSBZYW5nDQo=
