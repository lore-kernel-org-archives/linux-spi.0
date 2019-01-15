From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 6/7] mtd: spinand: Use the spi-mem dirmap API
Date: Tue, 15 Jan 2019 17:45:38 +0100
Message-ID: <20190115174538.0922e193@xps13>
References: <20181106160536.13415-1-boris.brezillon@bootlin.com>
 <20181106160536.13415-7-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 Vignesh R <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@microchip.com>,
 Richard Weinberger <richard@nod.at>,
 Cyrille Pitchen <cyrille.pitchen@microchip.com>, linux-spi@vger.kernel.org,
 Marek Vasut <marek.vasut@gmail.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>, Mark Brown <broonie@kernel.org>,
 linux-mtd@lists.infradead.org, Piotr Bugalski <bugalski.piotr@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20181106160536.13415-7-boris.brezillon@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

SGkgQm9yaXMsCgpCb3JpcyBCcmV6aWxsb24gPGJvcmlzLmJyZXppbGxvbkBib290bGluLmNvbT4g
d3JvdGUgb24gVHVlLCAgNiBOb3YgMjAxOAoxNzowNTozNSArMDEwMDoKCj4gTWFrZSB1c2Ugb2Yg
dGhlIHNwaS1tZW0gZGlyZWN0IG1hcHBpbmcgQVBJIHRvIGxldCBhZHZhbmNlZCBjb250cm9sbGVy
cwo+IG9wdGltaXplIHJlYWQvd3JpdGUgb3BlcmF0aW9ucyB3aGVuIHRoZXkgc3VwcG9ydCBkaXJl
Y3QgbWFwcGluZy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBCb3JpcyBCcmV6aWxsb24gPGJvcmlzLmJy
ZXppbGxvbkBib290bGluLmNvbT4KPiBSZXZpZXdlZC1ieTogTWlxdWVsIFJheW5hbCA8bWlxdWVs
LnJheW5hbEBib290bGluLmNvbT4KPiAtLS0KCkFwcGxpZWQgdG8gbmFuZC9uZXh0LgoKVGhhbmtz
LApNaXF1w6hsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTGludXggTVREIGRpc2N1c3Npb24gbWFpbGluZyBsaXN0Cmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbXRkLwo=
