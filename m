From: kernel@martin.sperl.org
Subject: Re: [PATCH V2 8/9] spi: bcm2835aux: add driver stats to debugfs
Date: Mon, 25 Mar 2019 10:52:13 +0100
Message-ID: <5AE813DD-9A2F-453D-B334-997FCEF72C31@martin.sperl.org>
References: <20190324175002.28969-1-kernel@martin.sperl.org>
 <20190324175002.28969-9-kernel@martin.sperl.org>
 <c2601fdb-3a5d-0a6c-eaea-54a332ec2027@i2se.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: linux-spi@vger.kernel.org, Eric Anholt <eric@anholt.net>,
 Mark Brown <broonie@kernel.org>, linux-rpi-kernel@lists.infradead.org,
 Hubert Denkmair <h.denkmair@intence.de>, linux-arm-kernel@lists.infradead.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <c2601fdb-3a5d-0a6c-eaea-54a332ec2027@i2se.com>
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

Cj4gT24gMjUuMDMuMjAxOSwgYXQgMTA6MjgsIFN0ZWZhbiBXYWhyZW4gPHN0ZWZhbi53YWhyZW5A
aTJzZS5jb20+IHdyb3RlOgo+IAo+IEhpIE1hcnRpbiwKPiAKPiBBbSAyNC4wMy4xOSB1bSAxODo1
MCBzY2hyaWViIGtlcm5lbEBtYXJ0aW4uc3Blcmwub3JnOgo+PiArCj4+ICsjaWYgZGVmaW5lZChD
T05GSUdfREVCVUdfRlMpCj4+ICsjZGVmaW5lIEJDTTI4MzVfQVVYX0lOQ1IoZmllbGQpICgoZmll
bGQpKyspCj4+ICsJdTY0IGNvdW50X3RyYW5zZmVyX3BvbGxpbmc7Cj4+ICsJdTY0IGNvdW50X3Ry
YW5zZmVyX2lycTsKPj4gKwl1NjQgY291bnRfdHJhbnNmZXJfaXJxX2FmdGVyX3BvbGw7Cj4+ICsK
Pj4gKwlzdHJ1Y3QgZGVudHJ5ICpkZWJ1Z2ZzX2RpcjsKPj4gKyNlbHNlCj4+ICsjZGVmaW5lIEJD
TTI4MzVfQVVYX0lOQ1IoZmllbGQpCj4+ICsjZW5kaWYgLyogQ09ORklHX0RFQlVHX0ZTICovCj4+
IH07Cj4+IAo+IGlzIHRoZXJlIGEgY2hhbmNlIHRvIGF2b2lkIHRoZXNlIGlmZGVmcyBDT05GSUdf
REVCVUdfRlM/Cj4gCgpUaGUgaWRlYSB3YXMgbm90IHRvIGFkZCB0aG9zZSBzdGF0cyBhdCBhbGwg
d2hlbiBkZWJ1Z2ZzIGlzIGRpc2FibGVkLgpPdGhlciBncm91cHMgKGUuZyBuZXQvY2FuKSBwcmVm
ZXIgaXQgdGhpcyB3YXnigKYKCkkgZG8gbm90IGNhcmUgZWl0aGVyIHdheSAtIHlvdXIgcHJlZmVy
ZW5jZS4uLgoKTWFydGluCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbAo=
