From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/7] spi: zynq-qspi: Clarify and fix the chip selection
Date: Fri,  8 Nov 2019 11:59:13 +0100
Message-ID: <20191108105920.19014-1-miquel.raynal@bootlin.com>
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
cywKTWlxdcOobAoKTWlxdWVsIFJheW5hbCAoNyk6CiAgc3BpOiB6eW5xLXFzcGk6IEFueXRoaW5n
IGVsc2UgdGhhbiBDUzAgaXMgbm90IHN1cHBvcnRlZCB5ZXQKICBzcGk6IHp5bnEtcXNwaTogS2Vl
cCB0aGUgbmFtaW5nIGNvbnNpc3RlbnQgYWNyb3NzIHRoZSBkcml2ZXIKICBzcGk6IHp5bnEtcXNw
aTogS2VlcCB0aGUgYml0ZmllbGRzIG5hbWluZyBjb25zaXN0ZW50CiAgc3BpOiB6eW5xLXFzcGk6
IEVuaGFuY2UgdGhlIExpbmVhciBDRkcgYml0IGRlZmluaXRpb25zCiAgc3BpOiB6eW5xLXFzcGk6
IENsYXJpZnkgdGhlIHNlbGVjdCBjaGlwIGZ1bmN0aW9uCiAgc3BpOiB6eW5xLXFzcGk6IERvIHRo
ZSBhY3R1YWwgaGFyZHdhcmUgaW5pdGlhbGl6YXRpb24gbGF0ZXIgaW4gdGhlCiAgICBwcm9iZQog
IHNwaTogenlucS1xc3BpOiBTdXBwb3J0IHR3byBjaGlwIHNlbGVjdHMKCiBkcml2ZXJzL3NwaS9z
cGktenlucS1xc3BpLmMgfCA4NCArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0t
CiAxIGZpbGUgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKSwgMzMgZGVsZXRpb25zKC0pCgotLSAK
Mi4yMC4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
