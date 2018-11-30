From: Trent Piepho <tpiepho@impinj.com>
Subject: Re: [PATCH v3 5/5] spi: imx: drop useless member speed_hz from driver
 data struct
Date: Fri, 30 Nov 2018 17:21:40 +0000
Message-ID: <1543598496.18519.101.camel@impinj.com>
References: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
 <20181130064709.6998-6-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "marex@denx.de" <marex@denx.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-imx@nxp.com" <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
To: "yibin.gong@nxp.com" <yibin.gong@nxp.com>,
 "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
 "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181130064709.6998-6-u.kleine-koenig@pengutronix.de>
Content-Language: en-US
Content-ID: <00CA1E85BCA1F3498BCB55D8E03FC353@namprd06.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

T24gRnJpLCAyMDE4LTExLTMwIGF0IDA3OjQ3ICswMTAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90
ZToNCj4gVGhlIGRyaXZlciBkYXRhJ3MgbWVtYmVyIHZhcmlhYmxlIGp1c3QgY2FjaGVzIHRoZSB0
cmFuc2ZlcidzIHNwZWVkX2h6DQo+IG1lbWJlci4gQWxsIHVzZXJzIG9mIHRoZSBmb3JtZXIgbm93
IGhhdmUgYWNjZXNzIGRpcmVjdGx5IHRvIHRoZSBsYXR0ZXIuDQo+IFNvIGZpeCB0aGVtIHRvIHVz
ZSB0aGUgdW5jYWNoZWQgdmFsdWUgYW5kIHJlbW92ZSB0aGUgY2FjaGUuDQoNCldoYXQgc2hvdWxk
IGhhdmUgYmVlbiBkb25lIHdpdGggdGhpcyBpcyB0byBjb21wYXJlIHRoZSBuZXh0IHRyYW5zZmVy
J3MNCnNwZWVkX2h6IHRvIHRoaXMgY2FjaGVkIHZhbHVlLCBhbmQgbm90IHByZXByb2dyYW0gdGhl
IGNsb2NrIGlmIGl0IGhhcw0Kbm90IGNoYW5nZWQuICBTaW5jZSB1c3VhbGx5IGl0IGRvZXNuJ3Qg
Y2hhbmdlIGJldHdlZW4gdHJhbnNmZXJzLg0KDQpzcGlfYnVzX2NsayBjYWNoZXMgdGhlIGFjdHVh
bCBzcGkgYnVzIGNsb2NrLCB3aGljaCBpcyBvZnRlbiBub3QgZXhhY3RseQ0KdGhlIHNhbWUgYXMg
dGhlIHRyYW5zZmVyIHNwZWVkLCBzbyB1c2luZyBpdCBjb21wYXJlIGFnYWluc3QgdGhlIG5leHQN
CnRyYW5zZmVyIGRvZXNuJ3Qgd29yayBhcyB3ZWxsLg0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
