From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH V2 6/6] spi/spi-pl022: Request/free DMA channels as and
	when required.
Date: Wed, 10 Aug 2011 16:01:13 +0530
Message-ID: <CABb+yY3SnqKN78U7vLbom1i00m=ThnRVQDVM_iX1TPu=+XzSNQ@mail.gmail.com>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<566c0525199f498f04422d4c3b2ddd7466648c20.1312965742.git.viresh.kumar@st.com>
	<20110810090042.GE1831@n2100.arm.linux.org.uk>
	<4E424F7B.2000800@st.com>
	<438BB0150E931F4B9CE701519A4463010871804A15@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "pratyush.anand@st.com" <pratyush.anand@st.com>,
	"rajeev-dlh.kumar@st.com" <rajeev-dlh.kumar@st.com>,
	"bhavna.yadav@st.com" <bhavna.yadav@st.com>,
	"bhupesh.sharma@st.com" <bhupesh.sharma@st.com>,
	"armando.visconti@st.com" <armando.visconti@st.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"vipin.kumar@st.com" <vipin.kumar@st.com>,
	"shiraz.hashim@st.com" <shiraz.hashim@st.com>,
	"Amit.VIRDI@st.com" <Amit.VIRDI@st.com>,
	"vipulkumar.samar@st.com" <vipulkumar.samar@st.com>,
	"viresh.linux@gmail.com" <viresh.linux@gmail.com>,
	"deepak.sikri@st.com" <deepak.sikri@st.com>,
	"linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Williams,
	Dan J" <dan.j.williams@intel.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel
To: "Koul, Vinod" <vinod.koul@intel.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <438BB0150E931F4B9CE701519A4463010871804A15@bgsmsx502.gar.corp.intel.com>
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

T24gV2VkLCBBdWcgMTAsIDIwMTEgYXQgMzozMSBQTSwgS291bCwgVmlub2QgPHZpbm9kLmtvdWxA
aW50ZWwuY29tPiB3cm90ZToKPiBPbiBXZWQsIDIwMTEtMDgtMTAgYXQgMTQ6NTkgKzA1MzAsIHZp
cmVzaCBrdW1hciB3cm90ZToKPj4gT24gMDgvMTAvMjAxMSAwMjozMCBQTSwgUnVzc2VsbCBLaW5n
IC0gQVJNIExpbnV4IHdyb3RlOgo+PiA+PiA+IFRoZXkgbXVzdCBiZSBhbGxvY2F0ZWQgd2hlbiB0
aGV5IGFyZSByZXF1aXJlZCBhbmQgbXVzdCBiZSBmcmVlZCBhZnRlciB3ZSBhcmUKPj4gPj4gPiBk
b25lIHdpdGggdHJhbnNmZXJzLiBTbyB0aGF0IHRoZXkgY2FuIGJlIHVzZWQgYnkgb3RoZXIgdXNl
cnMuCj4+ID4gV2hpY2ggRE1BIGVuZ2luZSBkcml2ZXIgcmVxdWlyZXMgdGhpcz8KPj4gPgo+Pgo+
PiBkd19kbWFjLmMKPj4KPj4gPiBOb3JtYWxseSwgd2hlbiB3ZSBoYXZlIERNQSBlbmdpbmUgZHJp
dmVycyB3aXRoIG11bHRpcGxlIHJlcXVlc3Qgc2lnbmFscywKPj4gPiB0aGUgc2xhdmUgcGVyaXBo
ZXJhbCBzaWRlIHB1Ymxpc2hlcyBzZXZlcmFsIHZpcnR1YWwgY2hhbm5lbHMgd2hpY2ggYXJlCj4+
ID4gY2xhaW1lZCBieSB0aGUgcGVyaXBoZXJhbCBkcml2ZXJzLiDCoFRoaXMgKGFtb25nc3Qgb3Ro
ZXIgdGhpbmdzKSBhbGxvd3MKPj4gPiB0aGUgcGVyaXBoZXJhbCBkcml2ZXJzIHRvIGhvbGQgY2xh
aW0gdG8gb25lIG9mIHRoZSB2aXJ0dWFsIGNoYW5uZWxzCj4+ID4gYWxsIHRoZSB0aW1lIHRoYXQg
aXQncyByZXF1aXJlZC4KPj4KPj4gSWYgdXNlcnMgb2YgRE1BIGV4cGVjdCBETUEgZW5naW5lIGRy
aXZlcnMgdG8gd29yayB0aGlzIHdheSwgdGhlbiB3ZSBzaG91bGQKPj4gaGF2ZSB0aGlzIG1lbnRp
b25lZCBjbGVhcmx5IGluIERNQSBzbGF2ZSBkb2N1bWVudGF0aW9uLgo+Pgo+PiBARGFuL1Zpbm9k
OiBXaGF0IGRvIHlvdSBzYXk/Cj4gSSB3b3VsZCBhZ3JlZSBvbiBib3RoIGNvdW50cyA6KQo+Cj4g
SW4gc29tZSBjYXNlcyBpdCBkb2VzIG1ha2Ugc2Vuc2UgdG8gaG9sZCB0aGUgY2hhbm5lbCBmb3Ig
dGhlIGxpZmV0aW1lCj4gbGlrZSB1YXJ0IG9yIHdoZXJlIHRoZSBjaGFubmVsIGhhcyBiZWVuIHRp
ZWQgdG8gYW4gaW50ZXJmYWNlIGJ5IFNvQwo+IGRlc2lnbmVyLgo+IEJ1dCBpbiBzb21lIGNhc2Vz
IGxpa2UgZHdfZG1hYyBpdCBzZWVtcyB5b3UgY2FuIGFzc2lnbiBjaGFubmVscwo+IGR5bmFtaWNh
bGx5IHRvIGVhY2ggdXNhZ2UsIGFuZCBydW50aW1lIGFsbG9jYXRpb24gZW5zdXJlcyB3ZSBoYXZl
IGJlc3QKPiB1dGlsaXphdGlvbi4KPiBTbyBpIHdvdWxkIGFyZ3VlIHRoYXQgdGhlcmUgaXMgbm8g
Im9uZSBzaXplIGZpdHMgYWxsIiBoZXJlLCBpZiB5b3UgY2FuCj4gbWFuYWdlIGNoYW5uZWxzIGR5
bmFtaWNhbGx5IGFuZCB1dGlsaXplIG1vcmUgZWZmaWNpZW50bHkgdGhlbiBnbyBhaGVhZCwKPiBi
dXQgaWYgeW91IGNhbnQgKGgvdyBhbmQgdXNhZ2UgY29uc3RyYWludCkgdGhlbiB5b3Ugc2hvdWxk
IG5vdCBiZSBmb3JjZWQKPiB0byBkbyBzby4KClRoZSBpZGVhIGlzIHRvIGhhdmUgY2hhbm5lbCBh
bGxvY2F0aW9uIGFzIHB1cmVseSBhIHMvdyB0aGluZyAtIG5vCmFjdHVhbCBjb21taXRtZW50Cm9m
IGgvdyByZXNvdXJjZXMuIFNvIHdlIGNhbiBhZmZvcmQgdG8gaGF2ZSBjaGFubmVsIGFsbG9jYXRl
ZCBmb3IgdGhlCndob2xlIGxpZmV0aW1lCm9mIGEgY2xpZW50LgoKU29tZSBkbWFjIGRyaXZlcnMg
YXJlIHdyaXR0ZW4gJ2ltcHJvcGVybHknLCBrZWVwaW5nIGluIG1pbmQgdGhlCnBsYXRmb3JtcyB0
aGF0IGhhdmUgZml4ZWQKUmVxU2lnLT5QZXJpIG1hcCBhbmQgbm8gbW9yZSBjbGllbnRzIHRoYW4g
YWN0dWFsIHJlcS1zaWdzIGFyZSBhY3RpdmUKc2ltdWx0YW5lb3VzbHkuCkJ1dCBzdWNoIGRtYWMg
ZHJpdmVycyB3aWxsIGZhaWwgaWYgYSBuZXcgcGxhdGZvcm0gZGVjaWRlcyB0byBoaWphY2sgcmVx
LXNpZ25hbHMuCgpTbywgaW1obywgaXQgaXMgYWJzb2x1dGVseSBhIGdvb2QgdGhpbmcgZm9yIGV2
ZXJ5IGRtYWMgZHJpdmVyIHRvIGJlCmRlc2lnbmVkIGZvciByZS1yb3V0YWJsZQpSZXFTaWctPlBl
cmkgbWFwLi4uIHdoaWNoIHdvdWxkIGZvcmNlIHRoZWlyIGRlc2lnbiB0byBhbGxvY2F0ZQp2aXJ0
dWFsL3NvZnR3YXJlIGNoYW5uZWxzIHRvIGNsaWVudHMKd2l0aG91dCBjb21taXQgbXVjaChhbnk/
KSBoL3cgcmVzb3VyY2VzLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbAo=
