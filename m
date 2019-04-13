From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH v5 2/4] spi: Release spi_res after finalizing message
Date: Sat, 13 Apr 2019 20:24:13 +0200
Message-ID: <20190413182415.38543-3-noralf@tronnes.org>
References: <20190413182415.38543-1-noralf@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: stefan.wahren@i2se.com, broonie@kernel.org,
 linux-rpi-kernel@lists.infradead.org, meghana.madhyastha@gmail.com,
 kernel@martin.sperl.org
To: linux-spi@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190413182415.38543-1-noralf@tronnes.org>
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

c3BpX3NwbGl0X3RyYW5zZmVyc19tYXhzaXplKCkgY2FuIGJlIHVzZWQgdG8gc3BsaXQgYSB0cmFu
c2Zlci4gVGhpcwpmdW5jdGlvbiB1c2VzIHNwaV9yZXMgdG8gbGlmZXRpbWUgbWFuYWdlIHRoZSBh
ZGRlZCB0cmFuc2ZlciBzdHJ1Y3R1cmVzLgpTbyBpbiBvcmRlciB0byBmaW5hbGl6ZSB0aGUgY3Vy
cmVudCBtZXNzYWdlIHdoaWxlIGl0IGNvbnRhaW5zIHRoZSBzcGxpdAp0cmFuc2ZlcnMsIHNwaV9y
ZXNfcmVsZWFzZSgpIG11c3QgYmUgY2FsbGVkIGFmdGVyIGZpbmFsaXppbmcuCgpTaWduZWQtb2Zm
LWJ5OiBOb3JhbGYgVHLDuG5uZXMgPG5vcmFsZkB0cm9ubmVzLm9yZz4KLS0tCiBkcml2ZXJzL3Nw
aS9zcGkuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGkuYyBiL2RyaXZlcnMvc3BpL3Nw
aS5jCmluZGV4IDA1ODc1ZTYzYmU0My4uMzU5MzlmZmRlZWJlIDEwMDY0NAotLS0gYS9kcml2ZXJz
L3NwaS9zcGkuYworKysgYi9kcml2ZXJzL3NwaS9zcGkuYwpAQCAtMTE2MiwxMCArMTE2MiwxMCBA
QCBzdGF0aWMgaW50IHNwaV90cmFuc2Zlcl9vbmVfbWVzc2FnZShzdHJ1Y3Qgc3BpX2NvbnRyb2xs
ZXIgKmN0bHIsCiAJaWYgKG1zZy0+c3RhdHVzICYmIGN0bHItPmhhbmRsZV9lcnIpCiAJCWN0bHIt
PmhhbmRsZV9lcnIoY3RsciwgbXNnKTsKIAotCXNwaV9yZXNfcmVsZWFzZShjdGxyLCBtc2cpOwot
CiAJc3BpX2ZpbmFsaXplX2N1cnJlbnRfbWVzc2FnZShjdGxyKTsKIAorCXNwaV9yZXNfcmVsZWFz
ZShjdGxyLCBtc2cpOworCiAJcmV0dXJuIHJldDsKIH0KIAotLSAKMi4yMC4xCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBs
aXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
