From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v4 4/4] arm64: dts: marvell: Enable spi0 on the board
 Armada-3720-db
Date: Tue, 03 Jan 2017 16:14:52 +0100
Message-ID: <87a8b8gopf.fsf@free-electrons.com>
References: <20161208145847.7794-1-romain.perier@free-electrons.com>
 <20161208145847.7794-5-romain.perier@free-electrons.com>
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
In-Reply-To: <20161208145847.7794-5-romain.perier@free-electrons.com> (Romain
 Perier's message of "Thu, 8 Dec 2016 15:58:47 +0100")
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
aW4ucGVyaWVyQGZyZWUtZWxlY3Ryb25zLmNvbT4gd3JvdGU6Cgo+IFRoaXMgY29tbWl0IGVuYWJs
ZXMgdGhlIGRldmljZSBub2RlIHNwaTAgb24gdGhlIG9mZmljaWFsIGRldmVsb3BtZW50Cj4gYm9h
cmQgZm9yIHRoZSBNYXJ2ZWxsIEFybWFkYSAzNzAwLiBJdCBhbHNvIGFkZHMgc3ViLW5vZGUgZm9y
IHRoZSAxMjhNYgo+IFNQSS1OT1IgcHJlc2VudCBvbiB0aGUgYm9hcmQuCj4KPiBTaWduZWQtb2Zm
LWJ5OiBSb21haW4gUGVyaWVyIDxyb21haW4ucGVyaWVyQGZyZWUtZWxlY3Ryb25zLmNvbT4KPiBU
ZXN0ZWQtYnk6IEdyZWdvcnkgQ0xFTUVOVCA8Z3JlZ29yeS5jbGVtZW50QGZyZWUtZWxlY3Ryb25z
LmNvbT4KCkFwcGxpZWQgb24gbXZlYnUvZHQ2NAoKVGhhbmtzLAoKR3JlZ29yeQo+IC0tLQo+Cj4g
Q2hhbmdlcyBpbiB2MzoKPiAgLSBBZGRlZCB0YWcgIlRlc3RlZC1ieSIgYnkgR3JlZ29yeQo+Cj4g
IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtMzcyMC1kYi5kdHMgfCAzMCArKysr
KysrKysrKysrKysrKysrKysrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygr
KQo+Cj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtMzcy
MC1kYi5kdHMgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTM3MjAtZGIuZHRz
Cj4gaW5kZXggMTM3MmU5YTYuLjBjNGViOTggMTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm02NC9ib290
L2R0cy9tYXJ2ZWxsL2FybWFkYS0zNzIwLWRiLmR0cwo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvbWFydmVsbC9hcm1hZGEtMzcyMC1kYi5kdHMKPiBAQCAtNjcsNiArNjcsMzYgQEAKPiAgCXN0
YXR1cyA9ICJva2F5IjsKPiAgfTsKPiAgCj4gKyZzcGkwIHsKPiArCXN0YXR1cyA9ICJva2F5IjsK
PiArCj4gKwltMjVwODBAMCB7Cj4gKwkJY29tcGF0aWJsZSA9ICJqZWRlYyxzcGktbm9yIjsKPiAr
CQlyZWcgPSA8MD47Cj4gKwkJc3BpLW1heC1mcmVxdWVuY3kgPSA8MTA4MDAwMDAwPjsKPiArCQlz
cGktcngtYnVzLXdpZHRoID0gPDQ+Owo+ICsJCXNwaS10eC1idXMtd2lkdGggPSA8ND47Cj4gKwo+
ICsJCXBhcnRpdGlvbnMgewo+ICsJCQljb21wYXRpYmxlID0gImZpeGVkLXBhcnRpdGlvbnMiOwo+
ICsJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKPiArCQkJI3NpemUtY2VsbHMgPSA8MT47Cj4gKwkJ
CXBhcnRpdGlvbkAwIHsKPiArCQkJCWxhYmVsID0gImJvb3Rsb2FkZXIiOwo+ICsJCQkJcmVnID0g
PDB4MCAweDIwMDAwMD47Cj4gKwkJCX07Cj4gKwkJCXBhcnRpdGlvbkAyMDAwMDAgewo+ICsJCQkJ
bGFiZWwgPSAiVS1ib290IEVudiI7Cj4gKwkJCQlyZWcgPSA8MHgyMDAwMDAgMHgxMDAwMD47Cj4g
KwkJCX07Cj4gKwkJCXBhcnRpdGlvbkAyMTAwMDAgewo+ICsJCQkJbGFiZWwgPSAiTGludXgiOwo+
ICsJCQkJcmVnID0gPDB4MjEwMDAwIDB4REYwMDAwPjsKPiArCQkJfTsKPiArCQl9Owo+ICsJfTsK
PiArfTsKPiArCj4gIC8qIEV4cG9ydGVkIG9uIHRoZSBtaWNybyBVU0IgY29ubmVjdG9yIENPTjMy
IHRocm91Z2ggYW4gRlRESSAqLwo+ICAmdWFydDAgewo+ICAJc3RhdHVzID0gIm9rYXkiOwo+IC0t
IAo+IDIuOS4zCj4KCi0tIApHcmVnb3J5IENsZW1lbnQsIEZyZWUgRWxlY3Ryb25zCktlcm5lbCwg
ZHJpdmVycywgcmVhbC10aW1lIGFuZCBlbWJlZGRlZCBMaW51eApkZXZlbG9wbWVudCwgY29uc3Vs
dGluZywgdHJhaW5pbmcgYW5kIHN1cHBvcnQuCmh0dHA6Ly9mcmVlLWVsZWN0cm9ucy5jb20KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK
