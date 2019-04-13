From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v5 3/4] spi/spi-bcm2835: Split transfers that exceed DLEN
Date: Sat, 13 Apr 2019 22:24:50 +0200
Message-ID: <20190413202450.exugxegqjvxeu7dx@wunner.de>
References: <20190413182415.38543-1-noralf@tronnes.org>
 <20190413182415.38543-4-noralf@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: stefan.wahren@i2se.com, dri-devel@lists.freedesktop.org,
 linux-spi@vger.kernel.org, broonie@kernel.org,
 linux-rpi-kernel@lists.infradead.org, meghana.madhyastha@gmail.com,
 kernel@martin.sperl.org
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20190413182415.38543-4-noralf@tronnes.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
List-Id: linux-spi.vger.kernel.org

T24gU2F0LCBBcHIgMTMsIDIwMTkgYXQgMDg6MjQ6MTRQTSArMDIwMCwgTm9yYWxmIFRyw7hubmVz
IHdyb3RlOgo+IEBAIC04NDQsNiArODE2LDE3IEBAIHN0YXRpYyBpbnQgYmNtMjgzNV9zcGlfcHJl
cGFyZV9tZXNzYWdlKHN0cnVjdCBzcGlfbWFzdGVyICptYXN0ZXIsCj4gIAlzdHJ1Y3Qgc3BpX2Rl
dmljZSAqc3BpID0gbXNnLT5zcGk7Cj4gIAlzdHJ1Y3QgYmNtMjgzNV9zcGkgKmJzID0gc3BpX21h
c3Rlcl9nZXRfZGV2ZGF0YShtYXN0ZXIpOwo+ICAJdTMyIGNzID0gYmNtMjgzNV9yZChicywgQkNN
MjgzNV9TUElfQ1MpOwo+ICsJaW50IHJldDsKPiArCj4gKwkvKgo+ICsJICogRE1BIHRyYW5zZmVy
cyBhcmUgbGltaXRlZCB0byAxNiBiaXQgKDAgdG8gNjU1MzUgYnl0ZXMpIGJ5IHRoZSBTUEkgSFcK
PiArCSAqIGR1ZSB0byBETEVOLiBTcGxpdCB1cCB0cmFuc2ZlcnMgKDMyLWJpdCBGSUZPIGFsaWdu
ZWQpIGlmIHRoZSBsaW1pdCBpcwo+ICsJICogZXhjZWVkZWQuCj4gKwkgKi8KPiArCXJldCA9IHNw
aV9zcGxpdF90cmFuc2ZlcnNfbWF4c2l6ZShtYXN0ZXIsIG1zZywgNjU1MzIsCj4gKwkJCQkJICBH
RlBfS0VSTkVMIHwgR0ZQX0RNQSk7Cj4gKwlpZiAocmV0KQo+ICsJCXJldHVybiByZXQ7CgpUaGlz
IGxvb2tzIG11Y2ggYmV0dGVyIHRoYW4gdGhlIHByZXZpb3VzIHZlcnNpb24gYmVjYXVzZQpzcGlf
c3BsaXRfdHJhbnNmZXJzX21heHNpemUoKSBpcyBub3cgdXNlZCBhcyBhIGxpYnJhcnkgZnVuY3Rp
b24KYnkgYW4gaW5kaXZpZHVhbCBkcml2ZXIsIHJhdGhlciB0aGFuIHNvbWV0aGluZyB0aGF0IGlz
IGluZmxpY3RlZApvbiAqYWxsKiBkcml2ZXJzIChtaWRsYXllciBmYWxsYWN5KS4KCk9mIGNvdXJz
ZSB0aGUgcGVyZm9ybWFuY2UgaXMgc3Vib3B0aW1hbCBjb21wYXJlZCB0byBhbiBhcHByb2FjaAp3
aGljaCB0cmFuc21pdHMgdGhlIHNnbGlzdCBpbiBwb3J0aW9ucyB3aGljaCBhcmUgPCA2NTUzNSBl
YWNoLApidXQgd2UgY2FuIG1vdmUgdG8gdGhhdCBsYXRlci4KCkluIGNhc2UgaXQgaGVscHMsClJl
dmlld2VkLWJ5OiBMdWthcyBXdW5uZXIgPGx1a2FzQHd1bm5lci5kZT4KClRoYW5rcywKCkx1a2Fz
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZl
bCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
