From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: [06/10,V2] spi: Add SPI driver for mx233/mx28
Date: Wed, 1 Aug 2012 09:38:07 +0200
Message-ID: <20504.56543.699097.320114@ipc1.ka-ro>
References: <1341555449-17507-6-git-send-email-marex@denx.de>
 <201208010810.37652.marex@denx.de>
 <20120801063936.GC2764@roeck-us.net>
 <201208010845.19361.marex@denx.de>
 <20120801074051.GG1672@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Fabio Estevam <fabio.estevam@freescale.com>,
 Rob Herring <rob.herring@calxeda.com>, Marek Vasut <marek.vasut@gmail.com>,
 Stefano Babic <sbabic@denx.de>, spi-devel-general@lists.sourceforge.net,
 Chris Ball <cjb@laptop.org>, Dong Aisheng <b29396@freescale.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-arm-kernel@lists.infradead.org
To: Shawn Guo <shawn.guo@linaro.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120801074051.GG1672@S2100-06.ap.freescale.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

U2hhd24gR3VvIHdyaXRlczoKPiBPbiBXZWQsIEF1ZyAwMSwgMjAxMiBhdCAwODo0NToxOUFNICsw
MjAwLCBNYXJlayBWYXN1dCB3cm90ZToKPiA+ID4gSSBtdXN0IGJlIG1pc3Npbmcgc29tZXRoaW5n
LiAgV2h5IGRvIGFsbW9zdCBhbGwgc3BpIGRyaXZlcnMgY2FsbCBpdCBpbiB0aGUKPiA+ID4gZXJy
b3IgcGF0aCwgZXZlbiBpZiB0aGVyZSBpcyBubyBjYWxsIHRvIHNwaV9tYXN0ZXJfZ2V0ID8KPiA+
IAo+ID4gVG8gcHVzaCB0aGUgcmVmY291bnRpbmcgdG8gMCwgdG8gZGVhbGxvY2F0ZSB0aGUgZGV2
aWNlLCBJJ2Qgc2F5IC4uLgo+ID4gCj4gSXQncyBub3QgZ29pbmcgdG8gd29yayBpZiBzcGlfbWFz
dGVyX3B1dCBpcyBjYWxsZWQgd2l0aG91dAo+IHNwaV9tYXN0ZXJfZ2V0IGJlaW5nIGNhbGxlZCBi
ZWZvcmUgdGhhdC4KPiAKc3BpX2FsbG9jX21hc3RlcigpIGNhbGxzIGRldmljZV9pbml0aWFsaXpl
KCkgd2hpY2ggcmVzdWlyZXMgYQpkZXZpY2VfcHV0KCkgKGNhbGxlZCBmcm9tIHNwaV9tYXN0ZXJf
cHV0KCkpIHRvIGZyZWUgdGhlIGRldmljZS4KClRodXMgZWFjaCBjYWxsIG9mIGVpdGhlciBzcGlf
YWxsb2NfbWFzdGVyKCkgb3Igc3BpX21hc3Rlcl9nZXQoKSBtdXN0CmJlIHBhaXJlZCB3aXRoIGFu
IHNwaV9tYXN0ZXJfcHV0KCkgY2FsbCB0byBmcmVlIHRoZSByZXNvdXJjZXMuCgpUaGUga2ZyZWUo
KSBpcyB0YWtlbiBjYXJlIG9mIGJ5IHRoZSBzcGlfbWFzdGVyX3JlbGVhc2UoKSBmdW5jdGlvbiB0
aGF0CmlzIGNhbGxlZCBvbmNlIHRoZSBsYXN0IHJlZmVyZW5jZSB0byB0aGUgdW5kZXJseWluZyBz
dHJ1Y3QgZGV2aWNlIGhhcwpiZWVuIHJlbGVhc2VkLiBUaHVzIGtmcmVlKCkgbXVzdCBub3QgYmUg
Y2FsbGVkIGFmdGVyCnNwaV9hbGxvY19tYXN0ZXIoKS4KCgpMb3RoYXIgV2HDn21hbm4KLS0gCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CgpLYS1SbyBlbGVjdHJvbmljcyBHbWJIIHwgUGFzY2Fsc3RyYcOfZSAyMiB8IEQgLSA1MjA3NiBB
YWNoZW4KUGhvbmU6ICs0OSAyNDA4IDE0MDItMCB8IEZheDogKzQ5IDI0MDggMTQwMi0xMApHZXNj
aMOkZnRzZsO8aHJlcjogTWF0dGhpYXMgS2F1c3NlbgpIYW5kZWxzcmVnaXN0ZXJlaW50cmFnOiBB
bXRzZ2VyaWNodCBBYWNoZW4sIEhSQiA0OTk2Cgp3d3cua2Fyby1lbGVjdHJvbmljcy5kZSB8IGlu
Zm9Aa2Fyby1lbGVjdHJvbmljcy5kZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
