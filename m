From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC 00/25] arm64: realtek: Add Xnano X5 and implement
 TM1628/FD628/AiP1618 LED controllers
Date: Fri, 13 Dec 2019 15:36:24 +0100
Message-ID: <CAMuHMdXddQ4v8-by_SmcS09EYykoBZ2G2vcFUpqPadHFaasy7A@mail.gmail.com>
References: <20191212033952.5967-1-afaerber@suse.de>
 <7110806f-ddbd-f055-e107-7a1f7e223102@arm.com>
 <c86c6bc0-b0e5-c46e-da87-9d910b95f9f3@suse.de>
 <04e7d7cd-a8bc-621b-9205-1a058521cabe@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, csd@princeton.com.tw,
 linux-realtek-soc@lists.infradead.org,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 sales@fdhisi.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linux-spi <linux-spi@vger.kernel.org>,
 Dan Murphy <dmurphy@ti.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 zypeng@titanmec.com,
 "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, linux-leds@vger.kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
To: Robin Murphy <robin.murphy@arm.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <04e7d7cd-a8bc-621b-9205-1a058521cabe@arm.com>
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

SGkgUm9iaW4sCgpPbiBGcmksIERlYyAxMywgMjAxOSBhdCAzOjA4IFBNIFJvYmluIE11cnBoeSA8
cm9iaW4ubXVycGh5QGFybS5jb20+IHdyb3RlOgo+IE9uIDEyLzEyLzIwMTkgODo1NSBwbSwgQW5k
cmVhcyBGw6RyYmVyIHdyb3RlOgo+ID4gQW0gMTIuMTIuMTkgdW0gMTQ6MTQgc2NocmllYiBSb2Jp
biBNdXJwaHk6Cj4gPj4gYW5kIGFzIGZhciBhcyBJCj4gPj4gY291bGQgdGVsbCB0aGUgY29tbWFu
ZCBzZXQgYXBwZWFycyB0byBkZXJpdmUgZnJvbSAob3IgaXMgYXQgbGVhc3QgY29tbW9uCj4gPj4g
dG8pIHNvbWUgb2xkIEhvbHRlayBWRkQgY29udHJvbGxlcnMuCj4gPgo+ID4gSG1tLCBIVDE2NTE1
IGxvb2tzIHNpbWlsYXIgYW5kIGhhcyBtb3JlIGxpbmVzLCBSQU0gYW5kIG1vZGUgYml0cyB0aGFu
IEkKPiA+IHByZXBhcmVkIGhlcmUuCj4gPiBodHRwczovL3d3dy5ob2x0ZWsuY29tL3Byb2R1Y3Rk
ZXRhaWwvLS92Zy9odDE2NTE1Cj4gPgo+ID4gU28gSSdkIG5lZWQgdG8gbWFrZSBtb3JlIG51bWJl
cnMgbW9kZWwtZGVwZW5kZW50IGFuZCBhbGxvY2F0ZSB0aGUKPiA+IERpc3BsYXkgUkFNIGJ1ZmZl
ciBkeW5hbWljYWxseS4KPiA+Cj4gPiBXaGVyZWFzIEhUMTZEMzVBIHNlZW1zIGluY29tcGF0aWJs
ZSBjb21tYW5kLXdpc2UsIGFuZCBIVDE2NTI4IGFwcGVhcnMgdG8KPiA+IGJlIG91dCBvZiBzY29w
ZSwgZm9yIGRvdCBkaXNwbGF5cyBhbmQgd2l0aCBmYW5jeSBlbWJlZGRlZCBjaGFyYWN0ZXIgbWFw
Lgo+ID4KPiA+IE5vIEhvbHRlayBlbWFpbCBhbGlhcyB0aGF0IEkgY2FuIHF1aWNrbHkgc3BvdC4K
PiA+Cj4gPiBCdXQgZ2l2ZW4gdGhhdCBJJ20gcHJvcG9zaW5nIHZlbmRvci1zcGVjaWZpYyBjb21w
YXRpYmxlcyBqdXN0IGluIGNhc2UsCj4gPiB0aGUgbWFpbiBkZWNpc2lvbnMgd2lsbCBiZSB0aGUg
S2NvbmZpZyBzeW1ib2wgYW5kIG1vZHVsZSBuYW1lLiBUaGUKPiA+IGRyaXZlciBjb2RlIGl0c2Vs
ZiB3ZSBjb3VsZCBhbHdheXMgcmVmYWN0b3IgYWZ0ZXIgbWVyZ2luZywgYW5kIHJlbmFtaW5nCj4g
PiB0aGUgc2NoZW1hIGZpbGUgKGFzIG9wcG9zZWQgdG8gY29tcGF0aWJsZSkgc2hvdWxkIGFsc28g
YmUgcG9zc2libGUuCj4KPiBZZWFoLCBJJ20gbm90IHN1cmUgdGhhdCBpdCByZWFsbHkgbWF0dGVy
cywgYXMgSSBkb3VidCB0aGVyZSBhcmUgbWFueQo+IExpbnV4LWNhcGFibGUgZGV2aWNlcyB3aXRo
IGEgcmVhbCBWRkQgYW55d2F5OyBpdCBqdXN0IHNlZW1lZCBsaWtlIGFuCj4gaW50ZXJlc3Rpbmcg
ZGF0YXBvaW50IHRoYXQgZmVsbCBvdXQgb2Ygc2NvdXJpbmcgdGhlIHdlYiB0cnlpbmcgdG8gZmlu
ZAo+IGFueSBldmlkZW5jZSBmb3Igd2hpY2ggdGhlICJjYW5vbmljYWwiIDE2MTggbWlnaHQgYmUg
KGFuZCB0aGUgSG9sdGVrCj4gY29ubmVjdGlvbiB3YXMgYWN0dWFsbHkgYSBjb2luY2lkZW5jZSBm
cm9tIGEgbWlzaWRlbnRpZmljYXRpb24gb2YgdGhlCj4gQVJUU0NISVAgcGFydCBudW1iZXIpLgoK
TXkgU29ueSBCbHUtUmF5L0hvbWUgVGhlYXRyZSBoYXMgYSBuaWNlIG9uZSAoMTQtc2VnbWVudCEp
LCBhbHNvIGRyaXZlbgpieSBhbiBIVDE2NTE1LiAgV2hpbGUgdGhlIHNwZWNpZmljIG1vZGVsIHBy
ZWRhdGVzIHRoZSBhcnJpdmFsIG9mIExpbnV4CmluIHRoZSBuZXh0IHN0ZXBwaW5nIG9mIHRoZSBo
YXJkd2FyZSwgaXQgc2hvdWxkIGJlIHN1ZmZpY2llbnRseSBwb3dlcmZ1bAp0byBydW4gTGludXgu
CgpVbmZvcnR1bmF0ZWx5IGl0J3MgaW4gYWN0aXZlIHVzZSwgc28gaGFja2luZyBleHBlcmltZW50
cyB3b3VsZCBiZSB2ZXRvZWQgYnkKdGhlIGZhbWlseSA7LSkKCkdye29ldGplLGVldGluZ31zLAoK
ICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQKCi0tIApHZWVydCBVeXR0ZXJob2V2ZW4gLS0g
VGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3Jn
CgpJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxs
IG15c2VsZiBhIGhhY2tlci4gQnV0CndoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBq
dXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxp
c3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
