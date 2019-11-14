From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 7/9] spi: s3c64xx: Use dma_request_chan() directly for
 channel request
Date: Thu, 14 Nov 2019 10:09:33 +0200
Message-ID: <e453c716-7658-a9fd-324d-4d95ff1aa29c@ti.com>
References: <20191113094256.1108-1-peter.ujfalusi@ti.com>
 <20191113094256.1108-8-peter.ujfalusi@ti.com>
 <20191113234049.GA1249@jack.zhora.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: jonathanh@nvidia.com, alexandre.belloni@bootlin.com, s.hauer@pengutronix.de,
 linux-arm-msm@vger.kernel.org, radu_nicolae.pirea@upb.ro, broonie@kernel.org,
 linux-kernel@vger.kernel.org, krzk@kernel.org, linux-spi@vger.kernel.org,
 vkoul@kernel.org, kgene@kernel.org, ldewangan@nvidia.com, agross@kernel.org,
 linux-tegra@vger.kernel.org, thierry.reding@gmail.com,
 bjorn.andersson@linaro.org, shawnguo@kernel.org, linus.walleij@linaro.org,
 linux-arm-kernel@lists.infradead.org
To: Andi Shyti <andi@etezian.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191113234049.GA1249@jack.zhora.eu>
Content-Language: en-US
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

CgpPbiAxNC8xMS8yMDE5IDEuNDAsIEFuZGkgU2h5dGkgd3JvdGU6Cj4gSGkgUGV0ZXIsCj4gCj4+
ICAJaWYgKCFpc19wb2xsaW5nKHNkZCkpIHsKPj4gIAkJLyogQWNxdWlyZSBETUEgY2hhbm5lbHMg
Ki8KPj4gLQkJc2RkLT5yeF9kbWEuY2ggPSBkbWFfcmVxdWVzdF9zbGF2ZV9jaGFubmVsX3JlYXNv
bigmcGRldi0+ZGV2LAo+PiAtCQkJCQkJCQkgICJyeCIpOwo+PiArCQlzZGQtPnJ4X2RtYS5jaCA9
IGRtYV9yZXF1ZXN0X2NoYW4oJnBkZXYtPmRldiwgInJ4Iik7Cj4gCj4gSSBoYXZlIGEgbGl0dGxl
IGNvbmNlcm4gaGVyZS4gV2UgaGF2ZSB0d28gZnVuY2lvbnMKPiAnZG1hX3JlcXVlc3RfY2hhbicg
YW5kICAnZG1hX3JlcXVlc3RfY2hhbm5lbCcgZG9uJ3Qgd2UgZW5kIHVwCj4gbWFraW5nIHNvbWUg
Y29uZnVzaW9uIGhlcmU/Cj4gCj4gV291bGRuJ3QgaXQgbWFrZSBtb3JlIHNlbnNlIHJlbmFtaW5n
ICdkbWFfcmVxdWVzdF9jaGFuJyB0bwo+ICdkbWFfcmVxdWVzdF9zbGF2ZV9jaGFubmVsX3JlYXNv
bic/CgpUaGUgZG1hX3JlcXVlc3RfY2hhbm5lbCgpIHNob3VsZCBnbyBhd2F5LiBJdCB3YXMgdGhl
IG9sZCBBUEkgYmVmb3JlIHdlCmdvdCB0aGUgZG1hX3NsYXZlX21hcCBmb3Igbm9uIERUIChhbmQg
bm9uIEFDUEkpIHBsYXRmb3JtcyBzbyB3ZSBjYW4gZ2V0CnJpZCBvZiB0aGUgZmlsdGVyIGZ1bmN0
aW9uIGV4cG9ydHMgZnJvbSBETUEgZHJpdmVycyB0byBjbGllbnRzIGFsbCBvdmVyCnRoZSBwbGFj
ZS4KCkkga25vdyB0aGVyZSBhcmUgdXNlcnMgd2hlcmUgdGhleSBwcm92aWRlIGR1bW15IGZpbHRl
ciBmdW5jdGlvbi4KCkF0IHRoZSBlbmQgdGhlIG1haW4gQVBJIHRvIHJlcXVlc3Qgc2xhdmUgRE1B
IGNoYW5uZWwgc2hvdWxkIGJlCmRtYV9yZXF1ZXN0X2NoYW4oKQpGb3Igbm9uIHNsYXZlIGNoYW5u
ZWxzIChub3QgSFcgdHJpZ2dlcmVkKSB3ZSBoYXZlIGRtYV9yZXF1ZXN0X2NoYW5fYnlfbWFzaygp
CgpJbW9oIHRoZSBkbWFfcmVxdWVzdF9zbGF2ZV9jaGFubmVsX2NvbXBhdCgpIHNob3VsZCBhbHNv
IGdvIGF3YXkgd2l0aCB0aW1lLgoKPiAKPiBUaGFua3MsCj4gQW5kaQo+IAo+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
PiAKCi0gUMOpdGVyCgpUZXhhcyBJbnN0cnVtZW50cyBGaW5sYW5kIE95LCBQb3Jra2FsYW5rYXR1
IDIyLCAwMDE4MCBIZWxzaW5raS4KWS10dW5udXMvQnVzaW5lc3MgSUQ6IDA2MTU1MjEtNC4gS290
aXBhaWtrYS9Eb21pY2lsZTogSGVsc2lua2kKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
