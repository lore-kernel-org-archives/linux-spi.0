From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: spi_mpc8xxx.c: chip select polarity problem
Date: Thu, 26 Nov 2009 22:01:01 +0300
Message-ID: <20091126190101.GA19404@oksana.dev.rtsoft.ru>
References: <200911161742.46663.to-fleischer@t-online.de>
	<200911211708.47253.to-fleischer@t-online.de>
	<fa686aa40911241633q38dc0cf8x8b23038fe2fdf10d@mail.gmail.com>
	<200911252141.59549.to-fleischer@t-online.de>
	<fa686aa40911251411t13dd0131od6b497399641ce3d@mail.gmail.com>
	<20091126121204.GA3558@oksana.dev.rtsoft.ru>
	<fa686aa40911261016p489981a2g1fac393264c4d1c7@mail.gmail.com>
	<20091126184157.GA16607@oksana.dev.rtsoft.ru>
	<fa686aa40911261050g3f7ae231mc82c41f058ff8530@mail.gmail.com>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Torsten Fleischer <to-fleischer@t-online.de>,
	spi-devel-general@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <fa686aa40911261050g3f7ae231mc82c41f058ff8530@mail.gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org

T24gVGh1LCBOb3YgMjYsIDIwMDkgYXQgMTE6NTA6MDVBTSAtMDcwMCwgR3JhbnQgTGlrZWx5IHdy
b3RlOgo+IE9uIFRodSwgTm92IDI2LCAyMDA5IGF0IDExOjQxIEFNLCBBbnRvbiBWb3JvbnRzb3YK
PiA8YXZvcm9udHNvdkBydS5tdmlzdGEuY29tPiB3cm90ZToKPiA+IE9uIFRodSwgTm92IDI2LCAy
MDA5IGF0IDExOjE2OjM0QU0gLTA3MDAsIEdyYW50IExpa2VseSB3cm90ZToKPiA+IFsuLi5dCj4g
Pj4gVGhlIHNwaS1jcy1oaWdoIHByb3BlcnR5IGlzIGRlZmluZWQgaW4KPiA+PiBEb2N1bWVudGF0
aW9uL3Bvd2VycGMvZHRzLWJpbmRpbmdzL3NwaS1idXMudHh0LCBidXQgaXQgZGVmaW5pdGVseSB3
YXMKPiA+PiBhIG1pc3Rha2UKPiA+Cj4gPiBZdXAuCj4gPgo+ID4+IEN1cnJlbnRseSB0aGUgc3Bp
LWNzLWhpZ2ggcHJvcGVydHkgaXMgcGFyc2VkIGluIHRoZQo+ID4+IG9mX3JlZ2lzdGVyX3NwaV9k
ZXZpY2VzKCkgZnVuY3Rpb24sIGJ1dCB0aGUgQ1MgcG9sYXJpdHkgbmVlZHMgdG8gYmUKPiA+PiBr
bm93biBiZWZvcmUgcmVnaXN0ZXJpbmcgZGV2aWNlcy4gwqBJdCBuZWVkcyB0byBiZSBmYWN0b3Jl
ZCBvdXQgaW50bwo+ID4+IGFub3RoZXIgdXRpbGl0eSBmdW5jdGlvbiBjYWxsYWJsZSBieSBzcGkg
YnVzIGRyaXZlcnMgc28gdGhhdCBpdCBjYW4KPiA+PiBnZXQgcG9sYXJpdHkgZGF0YSBhdCBwcm9i
ZSB0aW1lLgo+ID4KPiA+IFVudGlsbCB3ZSBoYXZlIHRoaXMsIFRvcnN0ZW4ncyBwYXRjaCBpcyBh
IHJlYWwgaW1wcm92ZW1lbnQsIGFuZAo+ID4gd29ya3MgZm9yIG5vbi1icm9rZW4gaHcvZncuCj4g
Pgo+ID4gU28gSSB0aGluayBpdCBzaG91bGQgYmUgYXBwbGllZC4KPiAKPiBJIGRpc2FncmVlIHNp
bmNlIGl0IG9ubHkgYmFuZC1haWRzIHRoZSBwcm9ibGVtIGFuZCB1Z2xpZmllcyB0aGUgZHJpdmVy
Cj4gaW4gdGhlIHByb2Nlc3MuICBJbiB0aGUgaW1tZWRpYXRlIHRlcm0gdGhlIGRyaXZlciBuZWVk
cyB0byBiZSBjaGFuZ2VkCj4gdG8gcmVhZCB0aGUgc3BpLWNzLWhpZ2ggcHJvcGVydHkgb3V0IG9m
IHRoZSBjaGlsZCBub2RlcyBiZWZvcmUKPiByZWdpc3RlcmluZyB0aGUgZGV2aWNlcy4KCkhtLiBJ
IHRob3VnaHQgd2UgYWdyZWVkIHRoYXQgc3BpLWNzLWhpZ2ggaXMgbm90IGdvb2Q/IFdoeSBkbyB5
b3UKZW5jb3VyYWdlIHVzaW5nIGl0IHRoZW4/IFdlJ2xsIGhhdmUgdG8gdWdsaWZ5IHRoZSBkcml2
ZXIgd2l0aApsZWdhY3kgZGV2aWNlLXRyZWUgaGFuZGxpbmcgY29kZS4KCi0tIApBbnRvbiBWb3Jv
bnRzb3YKZW1haWw6IGNib3VhdG1haWxydUBnbWFpbC5jb20KaXJjOi8vaXJjLmZyZWVub2RlLm5l
dC9iZDIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXhwcGMtZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRw
czovL2xpc3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2
