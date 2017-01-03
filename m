From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v4 3/4] arm64: dts: marvell: Add definition of SPI
 controller for Armada 3700
Date: Tue, 03 Jan 2017 16:14:15 +0100
Message-ID: <87lgusgoqg.fsf@free-electrons.com>
References: <20161208145847.7794-1-romain.perier@free-electrons.com>
 <20161208145847.7794-4-romain.perier@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, Pawel Moll <pawel.moll@arm.com>,
 devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
 Nadav Haklai <nadavh@marvell.com>, Mark Brown <broonie@kernel.org>,
 Kumar Gala <galak@codeaurora.org>, xigu@marvell.com, dingwei@marvell.com,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Romain Perier <romain.perier@free-electrons.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161208145847.7794-4-romain.perier@free-electrons.com> (Romain
 Perier's message of "Thu, 8 Dec 2016 15:58:46 +0100")
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

SGkgUm9tYWluLAogCiBPbiBqZXUuLCBkw6ljLiAwOCAyMDE2LCBSb21haW4gUGVyaWVyIDxyb21h
aW4ucGVyaWVyQGZyZWUtZWxlY3Ryb25zLmNvbT4gd3JvdGU6Cgo+IEFybWFkYSAzNzAwIFNvQyBo
YXMgYW4gU1BJIENvbnRyb2xsZXIsIHRoaXMgY29tbWl0IGFkZHMgdGhlIGRlZmluaXRpb24KPiBv
ZiB0aGUgU1BJIGRldmljZSBub2RlIGF0IHRoZSBTb0MgbGV2ZWwuCj4KPiBTaWduZWQtb2ZmLWJ5
OiBSb21haW4gUGVyaWVyIDxyb21haW4ucGVyaWVyQGZyZWUtZWxlY3Ryb25zLmNvbT4KPiBUZXN0
ZWQtYnk6IEdyZWdvcnkgQ0xFTUVOVCA8Z3JlZ29yeS5jbGVtZW50QGZyZWUtZWxlY3Ryb25zLmNv
bT4KCkFwcGxpZWQgb24gbXZlYnUvZHQ2NAoKVGhhbmtzLAoKR3JlZ29yeQo+IC0tLQo+Cj4gQ2hh
bmdlcyBpbiB2MzoKPiAgLSBGaXhlZCB3cm9uZyByZWdpc3RlciBzaXplIGZvciBzcGkwLCBhcyBz
dWdnZXN0ZWQgYnkgdGhlIG1haW50YWluZXIKPiAgICBvbiB0aGUgTUwuCj4gIC0gQWRkZWQgdGFn
ICJUZXN0ZWQtYnkiIGJ5IEdyZWdvcnkKPgo+IENoYW5nZXMgaW4gdjI6Cj4gIC0gUmVtb3ZlZCBw
cm9wZXJ0aWVzIG1heC1mcmVxdWVuY3kgYW5kIGNsb2NrLWZyZXF1ZW5jeSwgaXQgaXMgbm8KPiAg
ICBsb25nZXIgcmVxdWlyZWQgYW5kIG5vdCB1c2VkIGJ5IHRoZSBEVC1iaW5kaW5ncy4KPgo+ICBh
cmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTM3eHguZHRzaSB8IDExICsrKysrKysr
KysrCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS0zN3h4LmR0c2kgYi9hcmNoL2FybTY0
L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTM3eHguZHRzaQo+IGluZGV4IGU5YmQ1ODcuLmZjZWY5
YTUgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS0zN3h4
LmR0c2kKPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTM3eHguZHRz
aQo+IEBAIC05OCw2ICs5OCwxNyBAQAo+ICAJCQkvKiAzMk0gaW50ZXJuYWwgcmVnaXN0ZXIgQCAw
eGQwMDBfMDAwMCAqLwo+ICAJCQlyYW5nZXMgPSA8MHgwIDB4MCAweGQwMDAwMDAwIDB4MjAwMDAw
MD47Cj4gIAo+ICsJCQlzcGkwOiBzcGlAMTA2MDAgewo+ICsJCQkJY29tcGF0aWJsZSA9ICJtYXJ2
ZWxsLGFybWFkYS0zNzAwLXNwaSI7Cj4gKwkJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKPiArCQkJ
CSNzaXplLWNlbGxzID0gPDA+Owo+ICsJCQkJcmVnID0gPDB4MTA2MDAgMHhBMDA+Owo+ICsJCQkJ
Y2xvY2tzID0gPCZuYl9wZXJpcGhfY2xrIDc+Owo+ICsJCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJ
IDAgSVJRX1RZUEVfTEVWRUxfSElHSD47Cj4gKwkJCQludW0tY3MgPSA8ND47Cj4gKwkJCQlzdGF0
dXMgPSAiZGlzYWJsZWQiOwo+ICsJCQl9Owo+ICsKPiAgCQkJdWFydDA6IHNlcmlhbEAxMjAwMCB7
Cj4gIAkJCQljb21wYXRpYmxlID0gIm1hcnZlbGwsYXJtYWRhLTM3MDAtdWFydCI7Cj4gIAkJCQly
ZWcgPSA8MHgxMjAwMCAweDQwMD47Cj4gLS0gCj4gMi45LjMKPgoKLS0gCkdyZWdvcnkgQ2xlbWVu
dCwgRnJlZSBFbGVjdHJvbnMKS2VybmVsLCBkcml2ZXJzLCByZWFsLXRpbWUgYW5kIGVtYmVkZGVk
IExpbnV4CmRldmVsb3BtZW50LCBjb25zdWx0aW5nLCB0cmFpbmluZyBhbmQgc3VwcG9ydC4KaHR0
cDovL2ZyZWUtZWxlY3Ryb25zLmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
