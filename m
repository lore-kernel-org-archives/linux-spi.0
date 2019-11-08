From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 1/7] spi: zynq-qspi: Anything else than CS0 is not
 supported yet
Date: Fri, 8 Nov 2019 14:31:34 +0100
Message-ID: <20191108143134.1490f092@xps13>
References: <20191108105920.19014-1-miquel.raynal@bootlin.com>
 <20191108105920.19014-2-miquel.raynal@bootlin.com>
 <20191108120732.GB5532@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>,
 Michal Simek <michal.simek@xilinx.com>, linux-spi@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191108120732.GB5532@sirena.co.uk>
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

SGkgTWFyaywKCk1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4gd3JvdGUgb24gRnJpLCA4
IE5vdiAyMDE5IDEyOjA3OjMyICswMDAwOgoKPiBPbiBGcmksIE5vdiAwOCwgMjAxOSBhdCAxMTo1
OToxNEFNICswMTAwLCBNaXF1ZWwgUmF5bmFsIHdyb3RlOgo+ID4gVW5saWtlIHdoYXQgdGhlIGRy
aXZlciBpcyBjdXJyZW50bHkgYWR2ZXJ0aXppbmcsIENTMCBvbmx5IGNhbiBiZSB1c2VkLAo+ID4g
Q1MxIGlzIG5vdCBzdXBwb3J0ZWQgYXQgYWxsLiBQcmV2ZW50IHBlb3BsZSB0byB1c2UgQ1MxLiAg
Cj4gCj4gVGhpcyAoYW5kIHRoZSByZXN0IG9mIHRoZSBzZXJpZXMpIGRvZXNuJ3QgYXBwbHkgYWdh
aW5zdCBjdXJyZW50IGNvZGUsCj4gcGxlYXNlIGNoZWNrIGFuZCByZXNlbmQuCgpNeSBiYWQsIEkg
dGhvdWdodCBJIHdhcyB3b3JraW5nIG9uIGEgdjUuMyB3aGlsZSBJIHdhcyBvbiBhIHY1LjEuIExl
dCBtZQpyZWJhc2UgYW5kIHJlc2VuZCB0aGUgd2hvbGUgcGF0Y2hzZXQuIFNvcnJ5IGZvciB0aGUg
bWlzdGFrZS4KClRoYW5rcywKTWlxdcOobAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
