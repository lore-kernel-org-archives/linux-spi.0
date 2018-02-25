From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 2/2] spi/spi-bcm2835: Add
 bcm2835_spi_transfer_one_message in spi-bcm2835.c
Date: Sun, 25 Feb 2018 17:49:03 +0100
Message-ID: <20180225164903.GA7348@wunner.de>
References: <cover.1519492575.git.meghana.madhyastha@gmail.com>
 <91a77832e7d4c5ca5f5ec6f81251922ee8019e77.1519492575.git.meghana.madhyastha@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: dri-devel@lists.freedesktop.org, linux-spi@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, Daniel Vetter <daniel.vetter@intel.com>,
 kernel@martin.sperl.org
To: Meghana Madhyastha <meghana.madhyastha@gmail.com>
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <91a77832e7d4c5ca5f5ec6f81251922ee8019e77.1519492575.git.meghana.madhyastha@gmail.com>
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

T24gU2F0LCBGZWIgMjQsIDIwMTggYXQgMDY6MTc6MTJQTSArMDAwMCwgTWVnaGFuYSBNYWRoeWFz
dGhhIHdyb3RlOgo+IC0tLSBhL2RyaXZlcnMvc3BpL3NwaS5jCj4gKysrIGIvZHJpdmVycy9zcGkv
c3BpLmMKPiBAQCAtMTAwMyw3ICsxMDAzLDcgQEAgc3RhdGljIGludCBzcGlfbWFwX21zZyhzdHJ1
Y3Qgc3BpX2NvbnRyb2xsZXIgKmN0bHIsIHN0cnVjdCBzcGlfbWVzc2FnZSAqbXNnKQo+ICAgKiBk
cml2ZXJzIHdoaWNoIGltcGxlbWVudCBhIHRyYW5zZmVyX29uZSgpIG9wZXJhdGlvbi4gIEl0IHBy
b3ZpZGVzCj4gICAqIHN0YW5kYXJkIGhhbmRsaW5nIG9mIGRlbGF5cyBhbmQgY2hpcCBzZWxlY3Qg
bWFuYWdlbWVudC4KPiAgICovCj4gLXN0YXRpYyBpbnQgc3BpX3RyYW5zZmVyX29uZV9tZXNzYWdl
KHN0cnVjdCBzcGlfY29udHJvbGxlciAqY3RsciwKPiAraW50IHNwaV90cmFuc2Zlcl9vbmVfbWVz
c2FnZShzdHJ1Y3Qgc3BpX2NvbnRyb2xsZXIgKmN0bHIsCgpBbiBhbHRlcm5hdGl2ZSB0byBleHBv
cnRpbmcgdGhpcyBmdW5jdGlvbiB3b3VsZCBiZSB0byBoYXZlIGl0IGNoZWNrCmlmIGFueSBvZiB0
aGUgdHJhbnNmZXJzIGluIHRoZSBtZXNzYWdlIGV4Y2VlZCBjdGxyLT5tYXhfZG1hX2xlbiwKYW5k
IGF1dG9tYXRpY2FsbHkgc3BsaXQgdGhvc2UuICBUaGF0J3MgZm9yIE1hcmsgdG8gZGVjaWRlLgoK
Cj4gIAkJaWYgKHhmZXItPnR4X2J1ZiB8fCB4ZmVyLT5yeF9idWYpIHsKPiAgCQkJcmVpbml0X2Nv
bXBsZXRpb24oJmN0bHItPnhmZXJfY29tcGxldGlvbik7Cj4gLQoKU3B1cmlvdXMgZGVsZXRlZCBu
ZXdsaW5lLgoKCj4gIAkvKiBjYWxjdWxhdGUgaG93IG1hbnkgd2UgaGF2ZSB0byByZXBsYWNlICov
Cj4gIAljb3VudCA9IERJVl9ST1VORF9VUCh4ZmVyLT5sZW4sIG1heHNpemUpOwo+IC0KCkFub3Ro
ZXIgb25lLgoKVGhhbmtzLAoKTHVrYXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vZHJpLWRldmVsCg==
