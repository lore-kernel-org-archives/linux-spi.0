From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v4 2/4] spi: Split spi message into max_dma_len size chunks
Date: Fri, 12 Apr 2019 13:16:15 +0200
Message-ID: <20190412111615.25iogtr6qwc5zbx7@wunner.de>
References: <20190412102206.GG6909@sirena.org.uk>
 <20190412094721.GE6909@sirena.org.uk>
 <20190412105448.6xamxj2wtuu3yxvt@wunner.de>
 <20190412110934.GH6909@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: stefan.wahren@i2se.com, dri-devel@lists.freedesktop.org,
 linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 meghana.madhyastha@gmail.com, kernel@martin.sperl.org
To: Mark Brown <broonie@kernel.org>
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20190412110934.GH6909@sirena.org.uk>
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

T24gRnJpLCBBcHIgMTIsIDIwMTkgYXQgMTI6MDk6MzRQTSArMDEwMCwgTWFyayBCcm93biB3cm90
ZToKPiBPbiBGcmksIEFwciAxMiwgMjAxOSBhdCAxMjo1NDo0OFBNICswMjAwLCBMdWthcyBXdW5u
ZXIgd3JvdGU6Cj4gPiBPbiBGcmksIEFwciAxMiwgMjAxOSBhdCAxMDo0NzoyMUFNICswMTAwLCBN
YXJrIEJyb3duIHdyb3RlOgo+ID4gPiBJICp0aGluayogd2UgbWFuYWdlZCB0byBmaXggYWxsIHRo
ZSBhcmNoaXRlY3R1cmVzIHRvIGF0IGxlYXN0IHN0dWIgb3V0Cj4gPiA+IHRoZSBETUEgaW50ZXJm
YWNlcywgaXQncyBzdWNoIGEgcG9pbnRsZXNzIHRoaW5nIHRvIGhhdmUgY29uZGl0aW9uYWwgLQo+
ID4gPiBpdCByZWFsbHkgb25seSBtYWtlcyBhIGRpZmZlcmVuY2UgZm9yIGJ1aWxkIGNvdmVyYWdl
Lgo+IAo+ID4gTXkgcG9pbnQgd2FzIHRoYXQgdGhlIGNhbGwgdG8gc3BpX3NwbGl0X3RyYW5zZmVy
c19tYXhzaXplKCkgc2hvdWxkbid0Cj4gPiBiZSBjYWxsZWQgb24gbm9uLURNQS1jYXBhYmxlIHBs
YXRmb3JtcyBpbiB0aGUgZmlyc3QgcGxhY2UgKGJlY2F1c2UgaXQncwo+ID4gRE1BLXNwZWNpZmlj
KS4KPiAKPiBJdCdzIG5vdCBhIERNQSBzcGVjaWZpYyBwcm9ibGVtIC0gdGhlcmUgY2FuIGJlIFNQ
SSBjb250cm9sbGVyCj4gbGltaXRhdGlvbnMgb24gdHJhbnNmZXIgc2l6ZXMgdG9vLgoKVGhlIGNh
bGwgZG9lcyBwYXNzIGluIGN0bHItPm1heF9kbWFfbGVuIHRob3VnaCwgc28gaXMgY2xlYXJseSBt
b3RpdmF0ZWQKYnkgYSBETUEgbGltaXRhdGlvbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vZHJpLWRldmVs
