From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH v4 1/4] spi: Remove warning in spi_split_transfers_maxsize()
Date: Thu, 11 Apr 2019 18:42:32 +0200
Message-ID: <20190411164235.49771-2-noralf@tronnes.org>
References: <20190411164235.49771-1-noralf@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: stefan.wahren@i2se.com, broonie@kernel.org,
 linux-rpi-kernel@lists.infradead.org, meghana.madhyastha@gmail.com,
 kernel@martin.sperl.org
To: linux-spi@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190411164235.49771-1-noralf@tronnes.org>
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

RG9uJ3Qgd2FybiBhYm91dCBzcGxpdHRpbmcgdHJhbnNmZXJzLCB0aGUgaW5mbyBpcyBhdmFpbGFi
bGUgaW4gdGhlCnN0YXRpc3RpY3MgaWYgbmVlZGVkLgoKU2lnbmVkLW9mZi1ieTogTm9yYWxmIFRy
w7hubmVzIDxub3JhbGZAdHJvbm5lcy5vcmc+Ci0tLQogZHJpdmVycy9zcGkvc3BpLmMgfCA1IC0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L3NwaS9zcGkuYyBiL2RyaXZlcnMvc3BpL3NwaS5jCmluZGV4IDlhN2RlZjdjMzIzNy4uMDU4NzVl
NjNiZTQzIDEwMDY0NAotLS0gYS9kcml2ZXJzL3NwaS9zcGkuYworKysgYi9kcml2ZXJzL3NwaS9z
cGkuYwpAQCAtMjY5MiwxMSArMjY5Miw2IEBAIHN0YXRpYyBpbnQgX19zcGlfc3BsaXRfdHJhbnNm
ZXJfbWF4c2l6ZShzdHJ1Y3Qgc3BpX2NvbnRyb2xsZXIgKmN0bHIsCiAJc2l6ZV90IG9mZnNldDsK
IAlzaXplX3QgY291bnQsIGk7CiAKLQkvKiB3YXJuIG9uY2UgYWJvdXQgdGhpcyBmYWN0IHRoYXQg
d2UgYXJlIHNwbGl0dGluZyBhIHRyYW5zZmVyICovCi0JZGV2X3dhcm5fb25jZSgmbXNnLT5zcGkt
PmRldiwKLQkJICAgICAgInNwaV90cmFuc2ZlciBvZiBsZW5ndGggJWkgZXhjZWVkIG1heCBsZW5n
dGggb2YgJXp1IC0gbmVlZGVkIHRvIHNwbGl0IHRyYW5zZmVyc1xuIiwKLQkJICAgICAgeGZlci0+
bGVuLCBtYXhzaXplKTsKLQogCS8qIGNhbGN1bGF0ZSBob3cgbWFueSB3ZSBoYXZlIHRvIHJlcGxh
Y2UgKi8KIAljb3VudCA9IERJVl9ST1VORF9VUCh4ZmVyLT5sZW4sIG1heHNpemUpOwogCi0tIAoy
LjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRy
aS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
