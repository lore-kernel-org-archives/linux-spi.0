From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 28/28] Blackfin SPI: init early
Date: Mon, 18 Oct 2010 02:14:28 -0400
Message-ID: <AANLkTi=AwuK8-U8+Ezm1JVrvD1Taqwq53EzahA5Ag4Uf@mail.gmail.com>
References: <1287356381-31495-1-git-send-email-vapier@gentoo.org>
	<1287356381-31495-29-git-send-email-vapier@gentoo.org>
	<20101018061211.GC19399@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
        uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <20101018061211.GC19399-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org

T24gTW9uLCBPY3QgMTgsIDIwMTAgYXQgMDI6MTIsIEdyYW50IExpa2VseSB3cm90ZToKPiBPbiBT
dW4sIE9jdCAxNywgMjAxMCBhdCAwNjo1OTo0MVBNIC0wNDAwLCBNaWtlIEZyeXNpbmdlciB3cm90
ZToKPj4gRnJvbTogTWljaGFlbCBIZW5uZXJpY2ggPG1pY2hhZWwuaGVubmVyaWNoQGFuYWxvZy5j
b20+Cj4+Cj4+IFNvbWUgc3lzdGVtcyB1c2luZyB0aGlzIGJ1cyBzb21ldGltZXMgaGF2ZSB2ZXJ5
IGJhc2ljIGRldmljZXMgb24gdGhlbQo+PiBzdWNoIGFzIHJlZ3VsYXRvcnMuIMKgU28gd2UgbmVl
ZCB0byBiZSBsb2FkZWQgZXZlbiBlYXJsaWVyIGluIGNhc2UgdGhlCj4+IGRldmljZXMgYXJlIHVz
ZWQgYmVmb3JlIHVzZXJzcGFjZSBpcyBsb2FkZWQuIMKgVGhlcmVmb3JlIHJlZ2lzdGVyIGluCj4+
IHN1YnN5c19pbml0Y2FsbCgpLgo+Cj4gVGhpcyBzaG91bGRuJ3QgaGF2ZSBhbnl0aGluZyB0byBk
byB3aXRoIHVzZXJzcGFjZSBzaW5jZSByZWdhcmRsZXNzIG9mCj4gdGhlIGluaXRjYWxsLCBhbGwg
b2YgdGhpcyBzZXR1cCBzaG91bGQgYmUgY29tcGxldGUgYmVmb3JlIHVzZXJzcGFjZQo+IHN0YXJ0
cy4gwqBSYXRoZXIgSSBleHBlY3QgaXQgaGFzIHRvIGRvIHdpdGggYW4gZWFybGllciBpbml0Y2Fs
bCB3YW50aW5nCj4gdG8gaGF2ZSB0aGUgc3BpIGJ1cyB1cCBlYXJsaWVyIHRoYW4gbW9kdWxlX2lu
aXRjYWxsLiDCoFRoZSBkZXNjcmlwdGlvbgo+IG9mIHRoaXMgcGF0Y2ggc2VlbXMgd3JvbmcuCgpw
cm9iYWJseS4gIGl0IGRvZXNudCBtYWtlIHRoZSBjaGFuZ2Ugd3JvbmcgdGhvdWdoLiAgbWFueSBz
cGkvaTJjCmJ1c3NlcyBkbyB0aGUgc2FtZSB0aGluZy4KCj4gT24gdGhhdCBub3RlLCB0aGlzIGlz
IHNvbWV0aGluZyB0aGF0IG5lZWRzIHRvIGJlIHJldmlzaXRlZC4gwqBOZWVkaW5nCj4gdG8gcGxh
eSB0aGVzZSBraW5kIG9mIGdhbWVzIGhpZ2hsaWdodHMgYSBmYWlsdXJlIG9mIHRoZSBkZXZpY2Ug
bW9kZWwsCj4gb3IgdGhlIHdheSB0aGF0IGl0IGlzIGJlaW5nIHVzZWQuIMKgKFRoZSBwYXRjaCBp
cyBva2F5OyBidXQgaXQgZG9lcwo+IGhpZ2hsaWdodCBzb21lIHVnbGluZXNzIGluIHRoZSBjdXJy
ZW50IGtlcm5lbCkKCmkgYWdyZWUsIGJ1dCBpJ20gbm90IGFib3V0IHRvIGVtYmFyayBvbiBmaXhp
bmcgdGhlc2UgZnVuZGFtZW50YWwgaXNzdWVzLgotbWlrZQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpVY2xpbnV4LWRpc3QtZGV2ZWwgbWFpbGluZyBsaXN0
ClVjbGludXgtZGlzdC1kZXZlbEBibGFja2Zpbi51Y2xpbnV4Lm9yZwpodHRwczovL2JsYWNrZmlu
LnVjbGludXgub3JnL21haWxtYW4vbGlzdGluZm8vdWNsaW51eC1kaXN0LWRldmVs
