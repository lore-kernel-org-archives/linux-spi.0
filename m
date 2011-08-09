From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 2/6] spi/spi-pl022: Use GFP_NOWAIT for allocation from
	tasklet
Date: Tue, 9 Aug 2011 16:56:22 +0530
Message-ID: <CABb+yY3CuYqNcpvdP8fa6FsaN3EBDAXivKSP56gRh6-oPyp2Mg@mail.gmail.com>
References: <cover.1312887860.git.viresh.kumar@st.com>
	<cb966698764017627e85a4c85d1d781cf3fc9819.1312887860.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: pratyush.anand@st.com, rajeev-dlh.kumar@st.com, bhavna.yadav@st.com,
	bhupesh.sharma@st.com, armando.visconti@st.com,
	linus.walleij@linaro.org, grant.likely@secretlab.ca,
	vipin.kumar@st.com, shiraz.hashim@st.com, amit.virdi@st.com,
	vipulkumar.samar@st.com, viresh.linux@gmail.com,
	deepak.sikri@st.com, spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org
To: Viresh Kumar <viresh.kumar@st.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cb966698764017627e85a4c85d1d781cf3fc9819.1312887860.git.viresh.kumar@st.com>
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

T24gVHVlLCBBdWcgOSwgMjAxMSBhdCA0OjM1IFBNLCBWaXJlc2ggS3VtYXIgPHZpcmVzaC5rdW1h
ckBzdC5jb20+IHdyb3RlOgo+IHRhc2tsZXRzIGRvbid0IGFsbG93IGludm9jYXRpb24gdG8gc2xl
ZXBpbmcgcm91dGluZXMuIEluIGNvbmZpZ3VyZV9kbWEoKQo+IHJvdXRpbmUsIHNnX2FsbG9jX3Rh
YmxlKCkgd2FzIGNhbGxlZCB3aXRoIEdGUF9LRVJORUwgZmxhZyBhbmQgc28gdGhpcyBjYXVzZXMK
PiBjcmFzaCB3aGVuIGNhbGxlZCBmcm9tIHRhc2tsZXQuCj4KPiBSZXBsYWNlIEdGUF9LRVJORUwg
d2l0aCBHRlBfTk9XQUlUIHRvIGdldCB0aGlzIGZpeGVkLgo+Cj4gU2lnbmVkLW9mZi1ieTogVmly
ZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAc3QuY29tPgo+IC0tLQo+IMKgZHJpdmVycy9zcGkvc3Bp
LXBsMDIyLmMgfCDCoCDCoDQgKystLQo+IMKgMSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvc3BpLXBsMDIy
LmMgYi9kcml2ZXJzL3NwaS9zcGktcGwwMjIuYwo+IGluZGV4IGY2MDBkMDAuLmNiZDlhZmUgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9zcGkvc3BpLXBsMDIyLmMKPiArKysgYi9kcml2ZXJzL3NwaS9z
cGktcGwwMjIuYwo+IEBAIC0xMDE5LDExICsxMDE5LDExIEBAIHN0YXRpYyBpbnQgY29uZmlndXJl
X2RtYShzdHJ1Y3QgcGwwMjIgKnBsMDIyKQo+IMKgIMKgIMKgIMKgcGFnZXMgPSAocGwwMjItPmN1
cl90cmFuc2Zlci0+bGVuID4+IFBBR0VfU0hJRlQpICsgMTsKPiDCoCDCoCDCoCDCoGRldl9kYmco
JnBsMDIyLT5hZGV2LT5kZXYsICJ1c2luZyAlZCBwYWdlcyBmb3IgdHJhbnNmZXJcbiIsIHBhZ2Vz
KTsKPgo+IC0gwqAgwqAgwqAgcmV0ID0gc2dfYWxsb2NfdGFibGUoJnBsMDIyLT5zZ3RfcngsIHBh
Z2VzLCBHRlBfS0VSTkVMKTsKPiArIMKgIMKgIMKgIHJldCA9IHNnX2FsbG9jX3RhYmxlKCZwbDAy
Mi0+c2d0X3J4LCBwYWdlcywgR0ZQX05PV0FJVCk7Cj4gwqAgwqAgwqAgwqBpZiAocmV0KQo+IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBlcnJfYWxsb2Nfcnhfc2c7Cj4KPiAtIMKgIMKgIMKg
IHJldCA9IHNnX2FsbG9jX3RhYmxlKCZwbDAyMi0+c2d0X3R4LCBwYWdlcywgR0ZQX0tFUk5FTCk7
Cj4gKyDCoCDCoCDCoCByZXQgPSBzZ19hbGxvY190YWJsZSgmcGwwMjItPnNndF90eCwgcGFnZXMs
IEdGUF9OT1dBSVQpOwo+IMKgIMKgIMKgIMKgaWYgKHJldCkKPiDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGdvdG8gZXJyX2FsbG9jX3R4X3NnOwoKU2luY2UgdGhpcyBjb3VsZCBiZSBjYWxsZWQgZnJv
bSB3aGVuIHdlIGFjdHVhbGx5IG5lZWQgdGhlIHRyYW5zZmVyIHN0YXJ0LAptYXliZSB3ZSBjb3Vs
ZCB0cnkgaGFyZGVyIHVzaW5nIEdGUF9BVE9NSUMgaW5zdGVhZCA/CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
