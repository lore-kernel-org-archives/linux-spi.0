From: "Yang, Wenyou" <Wenyou.Yang@atmel.com>
Subject: RE: [v3 PATCH 06/12] spi/atmel_spi: add dmaengine support
Date: Tue, 8 Jan 2013 01:02:38 +0000
Message-ID: <B256D81BAE5131468A838E5D7A2436413A057056@penmbx02>
References: <1357523413-27209-1-git-send-email-wenyou.yang@atmel.com>
	 <1357523413-27209-7-git-send-email-wenyou.yang@atmel.com>
 <1357524615.4940.19.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Ferre, Nicolas" <Nicolas.FERRE@atmel.com>,
	"plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>,
	"richard.genoud@gmail.com" <richard.genoud@gmail.com>,
	"Lin, JM" <JM.Lin@atmel.com>,
	"grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>
To: Joe Perches <joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1357524615.4940.19.camel@joe-AO722>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9lIFBlcmNoZXMgW21h
aWx0bzpqb2VAcGVyY2hlcy5jb21dDQo+IFNlbnQ6IDIwMTPE6jHUwjfI1SAxMDoxMA0KPiBUbzog
WWFuZywgV2VueW91DQo+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEZlcnJlLA0KPiBOaWNvbGFzOyBwbGFnbmlv
akBqY3Jvc29mdC5jb207IHJpY2hhcmQuZ2Vub3VkQGdtYWlsLmNvbTsgTGluLCBKTTsNCj4gZ3Jh
bnQubGlrZWx5QHNlY3JldGxhYi5jYTsgc3BpLWRldmVsLWdlbmVyYWxAbGlzdHMuc291cmNlZm9y
Z2UubmV0DQo+IFN1YmplY3Q6IFJlOiBbdjMgUEFUQ0ggMDYvMTJdIHNwaS9hdG1lbF9zcGk6IGFk
ZCBkbWFlbmdpbmUgc3VwcG9ydA0KPiANCj4gT24gTW9uLCAyMDEzLTAxLTA3IGF0IDA5OjUwICsw
ODAwLCBXZW55b3UgWWFuZyB3cm90ZToNCj4gPiBGcm9tOiBOaWNvbGFzIEZlcnJlIDxuaWNvbGFz
LmZlcnJlQGF0bWVsLmNvbT4NCj4gW10NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvc3Bp
LWF0bWVsLmMgYi9kcml2ZXJzL3NwaS9zcGktYXRtZWwuYw0KPiBbXQ0KPiA+ICtzdGF0aWMgaW5s
aW5lIGJvb2wgYXRtZWxfc3BpX3VzZV9kbWEoc3RydWN0IGF0bWVsX3NwaSAqYXMsDQo+ID4gKwkJ
CQlzdHJ1Y3Qgc3BpX3RyYW5zZmVyICp4ZmVyKQ0KPiA+ICt7DQo+ID4gKwlpZiAoKGFzLT51c2Vf
ZG1hKSAmJiAoeGZlci0+bGVuID49IERNQV9NSU5fQllURVMpKQ0KPiA+ICsJCXJldHVybiB0cnVl
Ow0KPiA+ICsJZWxzZQ0KPiA+ICsJCXJldHVybiBmYWxzZTsNCj4gPiArfQ0KPiANCj4gU2FtZSB1
bm5lY2Vzc2FyeSBmb3JtLg0KPiANCj4gCXJldHVybiBhcy0+dXNlX2RtYSAmJiB4ZmVyLT5sZW4g
Pj0gRE1BX01JTl9CWVRFUzsNCj4gDQo+ID4gK3N0YXRpYyBpbmxpbmUgYm9vbCBhdG1lbF9zcGlf
dXNlX3BkYyhzdHJ1Y3QgYXRtZWxfc3BpICphcykNCj4gPiArew0KPiA+ICsJaWYgKGFzLT51c2Vf
cGRjKQ0KPiA+ICsJCXJldHVybiB0cnVlOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCXJldHVybiBmYWxz
ZTsNCj4gPiArfQ0KPiANCj4gRG9lcyB0aGlzIGZ1bmN0aW9uIHJlYWxseSBuZWVkIHRvIGV4aXN0
IGF0IGFsbD8NCj4gDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgYWR2aWNlLg0KDQo=
