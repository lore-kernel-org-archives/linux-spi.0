From: Ken Wilson <ken.wilson@opengear.com>
Subject: Re: [PATCH] spi: orion: Add multiple chip select support for Armada
 370 and 375
Date: Wed, 7 Jan 2015 18:08:29 +1000
Message-ID: <DA2CCB3A-D11B-4861-8DE1-7316C16E561D@opengear.com>
References: <1420579846-31962-1-git-send-email-ken.wilson@opengear.com>
 <54AC5B16.9020206@free-electrons.com>
 <20150107074154.1334b5c0@free-electrons.com>
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk,
 pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
 broonie@kernel.org, ezequiel.garcia@free-electrons.com, gerg@uclinux.org,
 Gregory CLEMENT <gregory.clement@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150107074154.1334b5c0@free-electrons.com>
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

SGkgVGhvbWFzLAo+IE9uIDcgSmFuIDIwMTUsIGF0IDQ6NDEgcG0sIFRob21hcyBQZXRhenpvbmkg
PHRob21hcy5wZXRhenpvbmlAZnJlZS1lbGVjdHJvbnMuY29tPiB3cm90ZToKPiAKPiBEZWFyIEdy
ZWdvcnkgQ0xFTUVOVCwKPiAKPiBPbiBUdWUsIDA2IEphbiAyMDE1IDIzOjAwOjU0ICswMTAwLCBH
cmVnb3J5IENMRU1FTlQgd3JvdGU6Cj4gCj4+IE9uIDA2LzAxLzIwMTUgMjI6MzAsIEtlbiBXaWxz
b24gd3JvdGU6Cj4+PiBDcmVhdGUgYSBuZXcgZHQgYmluZGluZyBmb3IgdGhlIEFybWFkYSAzNzUg
dGhhdCBzdXBwb3J0cyB1cCB0bwo+Pj4gMyBjaGlwIHNlbGVjdHMgYnV0IHVzZXMgdGhlIHNhbWUg
cHJlc2NhbGVyIHZhbHVlcyBhbmQgYWxnb3JpdGhtCj4+PiBhcyB0aGUgYmFzaWMgb3Jpb24gYmlu
ZGluZy4KPj4gCj4+IFRoZXJlIHdhcyBhbHJlYWR5IGEgcGF0Y2ggdGhhdCBoYXZlIGJlZW4gc2Vu
dCBmb3IgdGhpczoKPj4gaHR0cDovL3RocmVhZC5nbWFuZS5vcmcvZ21hbmUubGludXgua2VybmVs
LnNwaS5kZXZlbC8xNzgwOC9mb2N1cz0xNzgwOQo+PiAKPj4gYnV0IGluIHRoZSBlbmQgaXQgaGFz
IG5vdCBiZWVuIG1lcmdlZC4gVGhlIGxhc3QgZW1haWwgb24gdGhlIHRocmVhZCB3YXMKPj4gYWJv
dXQgZG9pbmcgdGhlIG1hbmlwdWxhdGlvbiBpbiBzZXRfY3MgYW5kIG5vdCBpbiBzZXR1cF90cmFu
c2ZlcigpLiBBbmQgSQo+PiBkaWRuJ3QgZmluZCBhIG5ld2VyIHZlcnNpb24uCj4+IAo+PiBNYXli
ZSBpdCBqdXN0IGZlbGwgdGhyb3VnaCB0aGUgY3JhY2tzLgo+PiBUaG9tYXMgZGlkIHlvdSByZW1l
bWJlciBvZiBpdD8KPiAKPiBZZXMsIGl0IGlzIHN0aWxsIG9uIG15IFRPRE8tbGlzdCwgYnV0IEkg
aGF2ZW4ndCB5ZXQgZ290dGVuIGFyb3VuZCB0bwo+IHN1Ym1pdHRpbmcgYSBuZXcgdmVyc2lvbi4g
U28gSSBoYXZlbid0IGxvb2tlZCBhdCBLZW4ncyBjb250cmlidXRpb24sCj4gYnV0IGlmIEtlbiBp
cyB3aWxsaW5nIHRvIGJyaW5nIGl0IHVwIHRvIGEgc3RhdGUgd2hlcmUgaXQgY2FuIGJlCj4gbWFp
bmxpbmVkLCB0aGF0IHdvdWxkIGRlZmluaXRlbHkgYmUgd2VsY29tZS4KCknigJltIGhhcHB5IHRv
IGRvIHRoYXQKClRoYW5rcywKS2VuCgo+IAo+IFRoYW5rcywKPiAKPiBUaG9tYXMKPiAtLSAKPiBU
aG9tYXMgUGV0YXp6b25pLCBDVE8sIEZyZWUgRWxlY3Ryb25zCj4gRW1iZWRkZWQgTGludXgsIEtl
cm5lbCBhbmQgQW5kcm9pZCBlbmdpbmVlcmluZwo+IGh0dHA6Ly9mcmVlLWVsZWN0cm9ucy5jb20K
PiAKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1hcm0ta2VybmVsCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbAo=
