From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH V2 6/6] spi/spi-pl022: Request/free DMA channels as and
	when required.
Date: Wed, 10 Aug 2011 15:39:28 +0530
Message-ID: <CABb+yY0Qvuhrn+FUhWDHMwUjv=nR4MOfLeDfTzG17HXEuu2pmA@mail.gmail.com>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<566c0525199f498f04422d4c3b2ddd7466648c20.1312965742.git.viresh.kumar@st.com>
	<20110810090042.GE1831@n2100.arm.linux.org.uk>
	<4E424F7B.2000800@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Pratyush ANAND <pratyush.anand@st.com>,
	Rajeev KUMAR <rajeev-dlh.kumar@st.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Bhupesh SHARMA <bhupesh.sharma@st.com>,
	Shiraz HASHIM <shiraz.hashim@st.com>, "Koul, Vinod" <vinod.koul@intel.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	Vipin KUMAR <vipin.kumar@st.com>, "spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
	Armando VISCONTI <armando.visconti@st.com>, Amit VIRDI <Amit.VIRDI@st.com>,
	Vipul Kumar SAMAR <vipulkumar.samar@st.com>,
	"viresh.linux@gmail.com" <viresh.linux@gmail.com>,
	Deepak SIKRI <deepak.sikri@st.com>, Bhavna YADAV <bhavna.yadav@st.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
To: viresh kumar <viresh.kumar@st.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4E424F7B.2000800@st.com>
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

T24gV2VkLCBBdWcgMTAsIDIwMTEgYXQgMjo1OSBQTSwgdmlyZXNoIGt1bWFyIDx2aXJlc2gua3Vt
YXJAc3QuY29tPiB3cm90ZToKPiBPbiAwOC8xMC8yMDExIDAyOjMwIFBNLCBSdXNzZWxsIEtpbmcg
LSBBUk0gTGludXggd3JvdGU6Cj4+PiA+IFRoZXkgbXVzdCBiZSBhbGxvY2F0ZWQgd2hlbiB0aGV5
IGFyZSByZXF1aXJlZCBhbmQgbXVzdCBiZSBmcmVlZCBhZnRlciB3ZSBhcmUKPj4+ID4gZG9uZSB3
aXRoIHRyYW5zZmVycy4gU28gdGhhdCB0aGV5IGNhbiBiZSB1c2VkIGJ5IG90aGVyIHVzZXJzLgo+
PiBXaGljaCBETUEgZW5naW5lIGRyaXZlciByZXF1aXJlcyB0aGlzPwo+Pgo+Cj4gZHdfZG1hYy5j
Cj4KPj4gTm9ybWFsbHksIHdoZW4gd2UgaGF2ZSBETUEgZW5naW5lIGRyaXZlcnMgd2l0aCBtdWx0
aXBsZSByZXF1ZXN0IHNpZ25hbHMsCj4+IHRoZSBzbGF2ZSBwZXJpcGhlcmFsIHNpZGUgcHVibGlz
aGVzIHNldmVyYWwgdmlydHVhbCBjaGFubmVscyB3aGljaCBhcmUKPj4gY2xhaW1lZCBieSB0aGUg
cGVyaXBoZXJhbCBkcml2ZXJzLiDCoFRoaXMgKGFtb25nc3Qgb3RoZXIgdGhpbmdzKSBhbGxvd3MK
Pj4gdGhlIHBlcmlwaGVyYWwgZHJpdmVycyB0byBob2xkIGNsYWltIHRvIG9uZSBvZiB0aGUgdmly
dHVhbCBjaGFubmVscwo+PiBhbGwgdGhlIHRpbWUgdGhhdCBpdCdzIHJlcXVpcmVkLgo+Cj4gSWYg
dXNlcnMgb2YgRE1BIGV4cGVjdCBETUEgZW5naW5lIGRyaXZlcnMgdG8gd29yayB0aGlzIHdheSwg
dGhlbiB3ZSBzaG91bGQKPiBoYXZlIHRoaXMgbWVudGlvbmVkIGNsZWFybHkgaW4gRE1BIHNsYXZl
IGRvY3VtZW50YXRpb24uCgpUaGUgcmVxdWlyZW1lbnQgc3RlbXMgZnJvbSB0aGUgZmFjdCB0aGF0
IG1vc3QgRE1BQ3MoZXNwIHRoaXJkIHBhcnR5KSBjb3VsZCBiZQptYWRlIHRvIHJlcm91dGUgcmVx
LXNpZ25hbHMgYnkgdGhlIHBsYXRmb3JtLCBpdCBoYXMgbm90IG11Y2ggdG8gZG8gd2l0aCB0aGUg
QVBJLgpJTU8sIGFsbCBkbWFjIGRyaXZlcnMgc2hvdWxkIGJlIGltcGxlbWVudGVkIHRoYXQgd2F5
IHRvIGJlIG9uIHRoZSBzYWZlciBzaWRlLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
