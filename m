From: kernel@martin.sperl.org
Subject: Re: [PATCH V2 8/9] spi: bcm2835aux: add driver stats to debugfs
Date: Mon, 25 Mar 2019 11:11:24 +0100
Message-ID: <E1B24527-4297-4347-9B41-4A3A73024A11@martin.sperl.org>
References: <20190324175002.28969-1-kernel@martin.sperl.org>
 <20190324175002.28969-9-kernel@martin.sperl.org>
 <c2601fdb-3a5d-0a6c-eaea-54a332ec2027@i2se.com>
 <5AE813DD-9A2F-453D-B334-997FCEF72C31@martin.sperl.org>
 <719f7607-4941-04d3-c05a-c9797cccc8ec@i2se.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: linux-spi@vger.kernel.org, Eric Anholt <eric@anholt.net>,
 Mark Brown <broonie@kernel.org>, linux-rpi-kernel@lists.infradead.org,
 Hubert Denkmair <h.denkmair@intence.de>, linux-arm-kernel@lists.infradead.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <719f7607-4941-04d3-c05a-c9797cccc8ec@i2se.com>
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

Cj4gT24gMjUuMDMuMjAxOSwgYXQgMTE6MDYsIFN0ZWZhbiBXYWhyZW4gPHN0ZWZhbi53YWhyZW5A
aTJzZS5jb20+IHdyb3RlOgo+IAo+IEFtIDI1LjAzLjE5IHVtIDEwOjUyIHNjaHJpZWIga2VybmVs
QG1hcnRpbi5zcGVybC5vcmc6Cj4+PiBPbiAyNS4wMy4yMDE5LCBhdCAxMDoyOCwgU3RlZmFuIFdh
aHJlbiA8c3RlZmFuLndhaHJlbkBpMnNlLmNvbT4gd3JvdGU6Cj4+PiAKPj4+IEhpIE1hcnRpbiwK
Pj4+IAo+Pj4gQW0gMjQuMDMuMTkgdW0gMTg6NTAgc2NocmllYiBrZXJuZWxAbWFydGluLnNwZXJs
Lm9yZzoKPj4+PiArCj4+Pj4gKyNpZiBkZWZpbmVkKENPTkZJR19ERUJVR19GUykKPj4+PiArI2Rl
ZmluZSBCQ00yODM1X0FVWF9JTkNSKGZpZWxkKSAoKGZpZWxkKSsrKQo+Pj4+ICsJdTY0IGNvdW50
X3RyYW5zZmVyX3BvbGxpbmc7Cj4+Pj4gKwl1NjQgY291bnRfdHJhbnNmZXJfaXJxOwo+Pj4+ICsJ
dTY0IGNvdW50X3RyYW5zZmVyX2lycV9hZnRlcl9wb2xsOwo+Pj4+ICsKPj4+PiArCXN0cnVjdCBk
ZW50cnkgKmRlYnVnZnNfZGlyOwo+Pj4+ICsjZWxzZQo+Pj4+ICsjZGVmaW5lIEJDTTI4MzVfQVVY
X0lOQ1IoZmllbGQpCj4+Pj4gKyNlbmRpZiAvKiBDT05GSUdfREVCVUdfRlMgKi8KPj4+PiB9Owo+
Pj4+IAo+Pj4gaXMgdGhlcmUgYSBjaGFuY2UgdG8gYXZvaWQgdGhlc2UgaWZkZWZzIENPTkZJR19E
RUJVR19GUz8KPj4+IAo+PiBUaGUgaWRlYSB3YXMgbm90IHRvIGFkZCB0aG9zZSBzdGF0cyBhdCBh
bGwgd2hlbiBkZWJ1Z2ZzIGlzIGRpc2FibGVkLgo+PiBPdGhlciBncm91cHMgKGUuZyBuZXQvY2Fu
KSBwcmVmZXIgaXQgdGhpcyB3YXnigKYKPiAKPiBZZXMsIHRoaXMgaXMgYWx3YXlzIGEgYmFsYW5j
ZSBiZXR3ZWVuIHNpemUgcmVkdWN0aW9uIGFuZCBjb2RlIHJlYWRhYmlsaXR5Lgo+IAo+IE15IGJp
Z2dlc3QgY29uY2VybiB3YXMgYWJvdXQgQkNNMjgzNV9BVVhfSU5DUgo+IApqdXN0IHRlbGwgbWUg
d2hpY2ggd2F5IHlvdSBwcmVmZXIgaXQgLSBhbnl3YXk6IGRpc2FibGluZyBERUJVRyBpcyBxdWl0
ZSBoYXJkCnRvIGRvIGluIHRoZSBmaXJzdCBwbGFjZSAodG9vIG1hbnkgY29tcG9uZW50cyBzZWxl
Y3QgaXQgYXV0b21hdGljYWxseSkKc28gSSBhbSBhbHdheXMgd29uZGVyaW5nIHdoeSBJIG5lZWQg
dG8gaG9wIHRodHUgdGhvc2UgbG9vcHMuCgpJZiB5b3UgYWdyZWUgSSB3aWxsIHJlbW92ZSB0aG9z
ZSBzcGVjaWZpYyBpZmRlZnMgYW5kIG1hY3Jvcy4KCk1hcnRpbgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
