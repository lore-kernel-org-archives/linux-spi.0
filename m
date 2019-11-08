From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 0/7] spi: zynq-qspi: Clarify and fix the chip selection
Date: Fri,  8 Nov 2019 15:07:37 +0100
Message-ID: <20191108140744.1734-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Michal Simek <michal.simek@xilinx.com>,
 Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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

SGVsbG8sCgpXaGlsZSB3b3JraW5nIG9uIFNQSS1OT1Igc3VwcG9ydCBJIGZpZ3VyZWQgdGhlIGNo
aXAgc2VsZWN0IGhhbmRsaW5nIG9mCnRoZSBaeW5xIDcwMDAgUVNQSSBkcml2ZXIgd2FzIG5vdCBi
ZWhhdmluZyBhcyBJIHdvdWxkIGhhdmUKZXhwZWN0ZWQuIFdoaWxlIGNoZWtpbmcgb3V0IHdoYXQg
d2FzIHdyb25nIEkgZGVjaWRlZCB0byBjbGFyaWZ5IHRoaW5ncwphcm91bmQgc28gSSBkaWQgYSBi
aXQgb2YgY2xlYW5pbmcuIFRoZSBzdGVwLWJ5LXN0ZXAgY2hhbmdlcyBhcmUgdGhlCnJlYXNvbiBm
b3IgcGF0Y2hlcyBbMS02XS4gVGhpcyB3YXksIHRoZSBsYXN0IHBhdGNoIGFjdHVhbGx5IGFkZGlu
ZwpzdXBwb3J0IGZvciBib3RoIENTIGlzIG11Y2ggbW9yZSB1bmRlcnN0YW5kYWJsZS4KClRoYW5r
cywKTWlxdcOobAoKQ2hhbmdlcyBzaW5jZSB2MToKKiBSZWJhc2VkIG9uIHRvcCBvZiB2NS40LXJj
NiBhbmQgZml4ZWQgYWxsIHRoZSBjb25mbGljdHMKICAobWlub3JzKS4gQ29tcGlsZSB0ZXN0ZWQg
b25seSAoYWN0dWFsIHRlc3RpbmcgZG9uZSBvbiBhIHY1LjEpLgoKTWlxdWVsIFJheW5hbCAoNyk6
CiAgc3BpOiB6eW5xLXFzcGk6IEFueXRoaW5nIGVsc2UgdGhhbiBDUzAgaXMgbm90IHN1cHBvcnRl
ZCB5ZXQKICBzcGk6IHp5bnEtcXNwaTogS2VlcCB0aGUgbmFtaW5nIGNvbnNpc3RlbnQgYWNyb3Nz
IHRoZSBkcml2ZXIKICBzcGk6IHp5bnEtcXNwaTogS2VlcCB0aGUgYml0ZmllbGRzIG5hbWluZyBj
b25zaXN0ZW50CiAgc3BpOiB6eW5xLXFzcGk6IEVuaGFuY2UgdGhlIExpbmVhciBDRkcgYml0IGRl
ZmluaXRpb25zCiAgc3BpOiB6eW5xLXFzcGk6IENsYXJpZnkgdGhlIHNlbGVjdCBjaGlwIGZ1bmN0
aW9uCiAgc3BpOiB6eW5xLXFzcGk6IERvIHRoZSBhY3R1YWwgaGFyZHdhcmUgaW5pdGlhbGl6YXRp
b24gbGF0ZXIgaW4gdGhlCiAgICBwcm9iZQogIHNwaTogenlucS1xc3BpOiBTdXBwb3J0IHR3byBj
aGlwIHNlbGVjdHMKCiBkcml2ZXJzL3NwaS9zcGktenlucS1xc3BpLmMgfCA4MyArKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNTAgaW5zZXJ0aW9u
cygrKSwgMzMgZGVsZXRpb25zKC0pCgotLSAKMi4yMC4xCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QK
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
