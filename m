From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH V2 01/12] spi/mxs: Always set LOCK_CS
Date: Wed, 10 Jul 2013 17:29:26 +0200
Message-ID: <20957.32214.721252.361301@ipc1.ka-ro>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
 <201304030118.42976.marex@denx.de>
 <CAOMZO5AEU3D3o-8fKLQJvsRSwBMNn0jfwZFC6R93TKaUpxffSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@freescale.com>,
 Shawn Guo <shawn.guo@linaro.org>, spi-devel-general@lists.sourceforge.net,
 Trent Piepho <tpiepho@gmail.com>, linux-arm-kernel@lists.infradead.org
To: Fabio Estevam <festevam@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOMZO5AEU3D3o-8fKLQJvsRSwBMNn0jfwZFC6R93TKaUpxffSw@mail.gmail.com>
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

SGksCgpGYWJpbyBFc3RldmFtIHdyaXRlczoKPiBPbiBUdWUsIEFwciAyLCAyMDEzIGF0IDg6MTgg
UE0sIE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPiB3cm90ZToKPiA+IERlYXIgVHJlbnQgUGll
cGhvLAo+ID4KPiA+PiBUaGVyZSBhcmUgdHdvIGJpdHMgd2hpY2ggY29udHJvbCB0aGUgQ1MgbGlu
ZSBpbiB0aGUgQ1RSTDAgcmVnaXN0ZXI6Cj4gPj4gTE9DS19DUyBhbmQgSUdOT1JFX0NSQy4gIFRo
ZSBsYXR0ZXIgd291bGQgYmUgYmV0dGVyIG5hbWVkIERFQVNTRVJUX0NTCj4gPj4gaW4gU1BJIG1v
ZGUuCj4gPj4KPiA+PiBMT0NLX0NTIGtlZXBzIENTIGFzc2VydGVkIHRob3VnaCB0aGUgZW50aXJl
IHRyYW5zZmVyLiAgVGhpcyBzaG91bGQKPiA+PiBhbHdheXMgYmUgc2V0LiAgVGhlIERNQSBjb2Rl
IHdpbGwgYWx3YXlzIHNldCBpdCwgZXhwbGljaXRseSBvbiB0aGUKPiA+PiBmaXJzdCBzZWdtZW50
IG9mIHRoZSBmaXJzdCB0cmFuc2ZlciwgYW5kIHRoZW4gaW1wbGljaXRseSBvbiBhbGwgdGhlCj4g
Pj4gcmVzdCBieSBuZXZlciBjbGVhcmluZyB0aGUgYml0IGZyb20gdGhlIHZhbHVlIHJlYWQgZnJv
bSB0aGUgY3RybDAKPiA+PiByZWdpc3Rlci4KPiA+Pgo+ID4+IFRoZSBvbmx5IHJlYXNvbiB0byBu
b3Qgc2V0IExPQ0tfQ1Mgd291bGQgYmUgdG8gYXR0ZW1wdCBhbiBhbHRlcmVkCj4gPj4gcHJvdG9j
b2wgd2hlcmUgQ1MgcHVsc2VzIGJldHdlZW4gZWFjaCB3b3JkLiAgVGhvdWdoIGRvbid0IGdldCB5
b3VyCj4gPj4gaG9wZXMgdXAgaWYgeW91IHdhbnQgdG8gZG8gdGhpcywgYXMgdGhlIGhhcmR3YXJl
IGRvZXNuJ3QgYXBwZWFyIHRvIGRvCj4gPj4gdGhpcyBpbiBhbnkgc2FuZSBtYW5uZXIuCj4gPgo+
ID4gQ2FuIHlvdSBwbGVhc2UgZWxhYm9yYXRlIG9uIHRoaXMgcGFydCBhYm92ZT8gVGhlIGRlc2Ny
aXB0aW9uIGlzIHZlcnkgdmFndWUuCj4gPgpGcm9tIG15IGV4cGVyaWVuY2UgdGhlIEhXIGRlYXNz
ZXJ0cyBDUyB3aGVuZXZlciB0aGUgb3V0cHV0IGZpZm8gcnVucwplbXB0eS4KCgpMb3RoYXIgV2HD
n21hbm4KLS0gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCgpLYS1SbyBlbGVjdHJvbmljcyBHbWJIIHwgUGFzY2Fsc3RyYcOfZSAyMiB8
IEQgLSA1MjA3NiBBYWNoZW4KUGhvbmU6ICs0OSAyNDA4IDE0MDItMCB8IEZheDogKzQ5IDI0MDgg
MTQwMi0xMApHZXNjaMOkZnRzZsO8aHJlcjogTWF0dGhpYXMgS2F1c3NlbgpIYW5kZWxzcmVnaXN0
ZXJlaW50cmFnOiBBbXRzZ2VyaWNodCBBYWNoZW4sIEhSQiA0OTk2Cgp3d3cua2Fyby1lbGVjdHJv
bmljcy5kZSB8IGluZm9Aa2Fyby1lbGVjdHJvbmljcy5kZQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxp
c3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
