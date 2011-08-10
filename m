From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH V2 6/6] spi/spi-pl022: Request/free DMA channels as and
	when required.
Date: Wed, 10 Aug 2011 16:18:42 +0530
Message-ID: <CABb+yY2T7qEZNLH1E8U+oiLUDQC+fGfrT82KExmOtV09UcqQeQ@mail.gmail.com>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<566c0525199f498f04422d4c3b2ddd7466648c20.1312965742.git.viresh.kumar@st.com>
	<20110810090042.GE1831@n2100.arm.linux.org.uk>
	<4E424F7B.2000800@st.com>
	<CABb+yY0Qvuhrn+FUhWDHMwUjv=nR4MOfLeDfTzG17HXEuu2pmA@mail.gmail.com>
	<20110810103052.GI1831@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Pratyush ANAND <pratyush.anand@st.com>,
	Rajeev KUMAR <rajeev-dlh.kumar@st.com>, Bhavna YADAV <bhavna.yadav@st.com>,
	Bhupesh SHARMA <bhupesh.sharma@st.com>,
	Shiraz HASHIM <shiraz.hashim@st.com>, "Koul, Vinod" <vinod.koul@intel.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	Vipin KUMAR <vipin.kumar@st.com>,
	"grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
	Armando VISCONTI <armando.visconti@st.com>, Amit VIRDI <Amit.VIRDI@st.com>,
	Vipul Kumar SAMAR <vipulkumar.samar@st.com>,
	"viresh.linux@gmail.com" <viresh.linux@gmail.com>,
	Deepak SIKRI <deepak.sikri@st.com>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	Dan Williams <dan.j.williams@intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110810103052.GI1831@n2100.arm.linux.org.uk>
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

T24gV2VkLCBBdWcgMTAsIDIwMTEgYXQgNDowMCBQTSwgUnVzc2VsbCBLaW5nIC0gQVJNIExpbnV4
CjxsaW51eEBhcm0ubGludXgub3JnLnVrPiB3cm90ZToKPiBPbiBXZWQsIEF1ZyAxMCwgMjAxMSBh
dCAwMzozOToyOFBNICswNTMwLCBKYXNzaSBCcmFyIHdyb3RlOgo+PiBPbiBXZWQsIEF1ZyAxMCwg
MjAxMSBhdCAyOjU5IFBNLCB2aXJlc2gga3VtYXIgPHZpcmVzaC5rdW1hckBzdC5jb20+IHdyb3Rl
Ogo+PiA+IE9uIDA4LzEwLzIwMTEgMDI6MzAgUE0sIFJ1c3NlbGwgS2luZyAtIEFSTSBMaW51eCB3
cm90ZToKPj4gPj4+ID4gVGhleSBtdXN0IGJlIGFsbG9jYXRlZCB3aGVuIHRoZXkgYXJlIHJlcXVp
cmVkIGFuZCBtdXN0IGJlIGZyZWVkIGFmdGVyIHdlIGFyZQo+PiA+Pj4gPiBkb25lIHdpdGggdHJh
bnNmZXJzLiBTbyB0aGF0IHRoZXkgY2FuIGJlIHVzZWQgYnkgb3RoZXIgdXNlcnMuCj4+ID4+IFdo
aWNoIERNQSBlbmdpbmUgZHJpdmVyIHJlcXVpcmVzIHRoaXM/Cj4+ID4+Cj4+ID4KPj4gPiBkd19k
bWFjLmMKPj4gPgo+PiA+PiBOb3JtYWxseSwgd2hlbiB3ZSBoYXZlIERNQSBlbmdpbmUgZHJpdmVy
cyB3aXRoIG11bHRpcGxlIHJlcXVlc3Qgc2lnbmFscywKPj4gPj4gdGhlIHNsYXZlIHBlcmlwaGVy
YWwgc2lkZSBwdWJsaXNoZXMgc2V2ZXJhbCB2aXJ0dWFsIGNoYW5uZWxzIHdoaWNoIGFyZQo+PiA+
PiBjbGFpbWVkIGJ5IHRoZSBwZXJpcGhlcmFsIGRyaXZlcnMuIMKgVGhpcyAoYW1vbmdzdCBvdGhl
ciB0aGluZ3MpIGFsbG93cwo+PiA+PiB0aGUgcGVyaXBoZXJhbCBkcml2ZXJzIHRvIGhvbGQgY2xh
aW0gdG8gb25lIG9mIHRoZSB2aXJ0dWFsIGNoYW5uZWxzCj4+ID4+IGFsbCB0aGUgdGltZSB0aGF0
IGl0J3MgcmVxdWlyZWQuCj4+ID4KPj4gPiBJZiB1c2VycyBvZiBETUEgZXhwZWN0IERNQSBlbmdp
bmUgZHJpdmVycyB0byB3b3JrIHRoaXMgd2F5LCB0aGVuIHdlIHNob3VsZAo+PiA+IGhhdmUgdGhp
cyBtZW50aW9uZWQgY2xlYXJseSBpbiBETUEgc2xhdmUgZG9jdW1lbnRhdGlvbi4KPj4KPj4gVGhl
IHJlcXVpcmVtZW50IHN0ZW1zIGZyb20gdGhlIGZhY3QgdGhhdCBtb3N0IERNQUNzKGVzcCB0aGly
ZCBwYXJ0eSkgY291bGQgYmUKPj4gbWFkZSB0byByZXJvdXRlIHJlcS1zaWduYWxzIGJ5IHRoZSBw
bGF0Zm9ybSwgaXQgaGFzIG5vdCBtdWNoIHRvIGRvIHdpdGggdGhlIEFQSS4KPj4gSU1PLCBhbGwg
ZG1hYyBkcml2ZXJzIHNob3VsZCBiZSBpbXBsZW1lbnRlZCB0aGF0IHdheSB0byBiZSBvbiB0aGUg
c2FmZXIgc2lkZS4KPgo+IE5vIGl0IGlzbid0LiDCoEl0J3MgdG8gZG8gd2l0aCBob3cgdGhlIHBo
eXNpY2FsIGNoYW5uZWxzIGFyZSB1c2VkLgpJTU8sIGEgZG1hYyBkcml2ZXIgZGV2ZWxvcGVyIHNl
ZXMgb25seSB0d28gYXNwZWN0cyAtICJ2aXJ0dWFsIGNoYW5uZWwiCmF0IGZyb250ZW5kIGFuZAoi
UmVxU2lnL1BoeUNoYW4iIG1hbmFnZW1lbnQgYXQgdGhlIGJhY2tlbmQuICBXaGlsZSBSZXFTaWcg
YW5kIFBoeXNpY2FsIENoYW5uZWxzCmFyZSBkaWZmZXJlbnQgaC93IGVudGl0aWVzLCB0aGUgZHJp
dmVyIGRldmVsb3BlciB1c3VhbGx5IHdvcmtzIGhhdmluZwp0aWVkIHRoZW0gdG9nZXRoZXIuCgpG
b3IgZXgsIFBMMzMwIGhhcyA4IHBoeXNpY2FsIGNoYW5uZWxzKEFSTSBjYWxscyB0aGVtIHRocmVh
ZHMpIGFuZCAzMgpwZXJpcGhlcmFsIGludGVyZmFjZXMoUmVxU2lnKSwKd2hlcmUgYXMgdGhlIGRt
YWMgZHJpdmVyIGZyZWVseSBhbGxvY2F0ZXMgMzIgdmlydHVhbCBjaGFubmVscyBhbmQKa2VlcHMg
aW4gbWluZCB0aGF0IG9ubHkgOCBwZXJpcGhlcmFsCmludGVyZmFjZXMgY2FuIGJlIGFjdGl2ZSBh
dCBhbnkgdGltZS4KClNvIEkgYW0gdW5hYmxlIHRvIHNlZSBob3cgSSBzYWlkIHNvbWV0aGluZyBk
aWZmZXJlbnQgdGhhdCB5b3UgZG8uCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
