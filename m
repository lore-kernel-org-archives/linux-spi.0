From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH V2 8/9] spi: bcm2835aux: add driver stats to debugfs
Date: Mon, 25 Mar 2019 11:45:01 +0100
Message-ID: <95e494c6-194e-36c5-6dd7-71ca42909c48@i2se.com>
References: <20190324175002.28969-1-kernel@martin.sperl.org>
 <20190324175002.28969-9-kernel@martin.sperl.org>
 <c2601fdb-3a5d-0a6c-eaea-54a332ec2027@i2se.com>
 <5AE813DD-9A2F-453D-B334-997FCEF72C31@martin.sperl.org>
 <719f7607-4941-04d3-c05a-c9797cccc8ec@i2se.com>
 <E1B24527-4297-4347-9B41-4A3A73024A11@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: linux-spi@vger.kernel.org, Eric Anholt <eric@anholt.net>,
 Mark Brown <broonie@kernel.org>, linux-rpi-kernel@lists.infradead.org,
 Hubert Denkmair <h.denkmair@intence.de>, linux-arm-kernel@lists.infradead.org
To: kernel@martin.sperl.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <E1B24527-4297-4347-9B41-4A3A73024A11@martin.sperl.org>
Content-Language: en-US
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

QW0gMjUuMDMuMTkgdW0gMTE6MTEgc2NocmllYiBrZXJuZWxAbWFydGluLnNwZXJsLm9yZzoKPj4g
T24gMjUuMDMuMjAxOSwgYXQgMTE6MDYsIFN0ZWZhbiBXYWhyZW4gPHN0ZWZhbi53YWhyZW5AaTJz
ZS5jb20+IHdyb3RlOgo+Pgo+PiBBbSAyNS4wMy4xOSB1bSAxMDo1MiBzY2hyaWViIGtlcm5lbEBt
YXJ0aW4uc3Blcmwub3JnOgo+Pj4+IE9uIDI1LjAzLjIwMTksIGF0IDEwOjI4LCBTdGVmYW4gV2Fo
cmVuIDxzdGVmYW4ud2FocmVuQGkyc2UuY29tPiB3cm90ZToKPj4+Pgo+Pj4+IEhpIE1hcnRpbiwK
Pj4+Pgo+Pj4+IEFtIDI0LjAzLjE5IHVtIDE4OjUwIHNjaHJpZWIga2VybmVsQG1hcnRpbi5zcGVy
bC5vcmc6Cj4+Pj4+ICsKPj4+Pj4gKyNpZiBkZWZpbmVkKENPTkZJR19ERUJVR19GUykKPj4+Pj4g
KyNkZWZpbmUgQkNNMjgzNV9BVVhfSU5DUihmaWVsZCkgKChmaWVsZCkrKykKPj4+Pj4gKwl1NjQg
Y291bnRfdHJhbnNmZXJfcG9sbGluZzsKPj4+Pj4gKwl1NjQgY291bnRfdHJhbnNmZXJfaXJxOwo+
Pj4+PiArCXU2NCBjb3VudF90cmFuc2Zlcl9pcnFfYWZ0ZXJfcG9sbDsKPj4+Pj4gKwo+Pj4+PiAr
CXN0cnVjdCBkZW50cnkgKmRlYnVnZnNfZGlyOwo+Pj4+PiArI2Vsc2UKPj4+Pj4gKyNkZWZpbmUg
QkNNMjgzNV9BVVhfSU5DUihmaWVsZCkKPj4+Pj4gKyNlbmRpZiAvKiBDT05GSUdfREVCVUdfRlMg
Ki8KPj4+Pj4gfTsKPj4+Pj4KPj4+PiBpcyB0aGVyZSBhIGNoYW5jZSB0byBhdm9pZCB0aGVzZSBp
ZmRlZnMgQ09ORklHX0RFQlVHX0ZTPwo+Pj4+Cj4+PiBUaGUgaWRlYSB3YXMgbm90IHRvIGFkZCB0
aG9zZSBzdGF0cyBhdCBhbGwgd2hlbiBkZWJ1Z2ZzIGlzIGRpc2FibGVkLgo+Pj4gT3RoZXIgZ3Jv
dXBzIChlLmcgbmV0L2NhbikgcHJlZmVyIGl0IHRoaXMgd2F54oCmCj4+IFllcywgdGhpcyBpcyBh
bHdheXMgYSBiYWxhbmNlIGJldHdlZW4gc2l6ZSByZWR1Y3Rpb24gYW5kIGNvZGUgcmVhZGFiaWxp
dHkuCj4+Cj4+IE15IGJpZ2dlc3QgY29uY2VybiB3YXMgYWJvdXQgQkNNMjgzNV9BVVhfSU5DUgo+
Pgo+IGp1c3QgdGVsbCBtZSB3aGljaCB3YXkgeW91IHByZWZlciBpdCAtIGFueXdheTogZGlzYWJs
aW5nIERFQlVHIGlzIHF1aXRlIGhhcmQKPiB0byBkbyBpbiB0aGUgZmlyc3QgcGxhY2UgKHRvbyBt
YW55IGNvbXBvbmVudHMgc2VsZWN0IGl0IGF1dG9tYXRpY2FsbHkpCj4gc28gSSBhbSBhbHdheXMg
d29uZGVyaW5nIHdoeSBJIG5lZWQgdG8gaG9wIHRodHUgdGhvc2UgbG9vcHMuCj4KPiBJZiB5b3Ug
YWdyZWUgSSB3aWxsIHJlbW92ZSB0aG9zZSBzcGVjaWZpYyBpZmRlZnMgYW5kIG1hY3Jvcy4KUGxl
YXNlIHJlbW92ZSBpdCBmb3IgdGhlIHF1b3RlZCBwYXJ0IGFib3ZlCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
