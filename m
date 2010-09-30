From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH v3 6/7] mtd: m25p80: add a read function to read page
	by page
Date: Thu, 30 Sep 2010 19:06:33 +0400
Message-ID: <20100930150633.GA13741@oksana.dev.rtsoft.ru>
References: <841976.76219.qm@web180306.mail.gq1.yahoo.com>
	<AANLkTinBDdEyMDt3KoauNdmTCz1ZAJ5mZ23iMWiwsUm4@mail.gmail.com>
	<AANLkTi=GydTyhf3TOzCZOtrme1Jh0UmNDHqTVP59q=LH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: kumar.gala@freescale.com, David Brownell <david-b@pacbell.net>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net,
	Mingkai Hu <Mingkai.hu@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=GydTyhf3TOzCZOtrme1Jh0UmNDHqTVP59q=LH@mail.gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org

T24gVGh1LCBTZXAgMzAsIDIwMTAgYXQgMTE6NDE6NDBQTSArMDkwMCwgR3JhbnQgTGlrZWx5IHdy
b3RlOgo+IE9uIFRodSwgU2VwIDMwLCAyMDEwIGF0IDExOjE2IFBNLCBHcmFudCBMaWtlbHkKPiA8
Z3JhbnQubGlrZWx5QHNlY3JldGxhYi5jYT4gd3JvdGU6Cj4gPiBPbiBUaHUsIFNlcCAzMCwgMjAx
MCBhdCA3OjQ2IFBNLCBEYXZpZCBCcm93bmVsbCA8ZGF2aWQtYkBwYWNiZWxsLm5ldD4gd3JvdGU6
Cj4gPj4KPiA+PiAtLS0gT24gVGh1LCA5LzMwLzEwLCBNaW5na2FpIEh1IDxNaW5na2FpLmh1QGZy
ZWVzY2FsZS5jb20+IHdyb3RlOgo+ID4+Cj4gPj4+IEZyb206IE1pbmdrYWkgSHUgPE1pbmdrYWku
aHVAZnJlZXNjYWxlLmNvbT4KPiA+Pj4gU3ViamVjdDogW1BBVENIIHYzIDYvN10gbXRkOiBtMjVw
ODA6IGFkZCBhIHJlYWQgZnVuY3Rpb24gdG8gcmVhZCBwYWdlIGJ5IHBhZ2UKPiA+Pgo+ID4+IE5B
Sy4KPiA+Pgo+ID4+IFdlIHdlbnQgb3ZlciB0aGlzIGJlZm9yZS4KPiA+Cj4gPiBZZXMsIEkgYWdy
ZWUgd2l0aCBEYXZpZCBvbiB0aGlzLiDCoElmIGxhcmdlIHRyYW5zZmVycyBkb24ndCB3b3JrLCB0
aGVuCj4gPiBpdCBpcyB0aGUgU1BJIG1hc3RlciBkcml2ZXIgdGhhdCBpcyBidWdneS4KPiAKPiBC
eSB0aGUgd2F5LCBkb2VzIHRoaXMgZml4IHlvdXIgcHJvYmxlbT8KPiAKPiBodHRwczovL3BhdGNo
d29yay5rZXJuZWwub3JnL3BhdGNoLzE4NDc1Mi8KCkl0IHNob3VsZG4ndC4gQUZBSUssIGVTUEkg
aXMgUElPLW9ubHkgY29udHJvbGxlciwgYW5kIHRoZSBvdmVycnVuCmZpeCBpcyBmb3IgdGhlIERN
QSBtb2RlLgoKVGhhbmtzLAoKcC5zLiBCdHcsIGluIHBhdGNoIDMvNywgaXNfZG1hX21hcHBlZCBh
cmd1bWVudCBvZiBmc2xfZXNwaV9idWZzKCkKaXMgdW5uZWVkZWQuCgotLSAKQW50b24gVm9yb250
c292CmVtYWlsOiBjYm91YXRtYWlscnVAZ21haWwuY29tCmlyYzovL2lyYy5mcmVlbm9kZS5uZXQv
YmQyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
cHBjLWRldiBtYWlsaW5nIGxpc3QKTGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcKaHR0cHM6
Ly9saXN0cy5vemxhYnMub3JnL2xpc3RpbmZvL2xpbnV4cHBjLWRldg==
