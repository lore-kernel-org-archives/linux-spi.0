From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 11/28] Blackfin SPI: convert struct
 names to something more logical
Date: Mon, 18 Oct 2010 02:28:23 -0400
Message-ID: <AANLkTi=pBYVLCYVtwd3L=O31O4FxOPwQLJQK5WUkdRS9@mail.gmail.com>
References: <1287356381-31495-1-git-send-email-vapier@gentoo.org>
	<1287356381-31495-12-git-send-email-vapier@gentoo.org>
	<20101018060253.GA19399@angua.secretlab.ca>
	<AANLkTimJtoRWL0auw1xHthXbkBc6L2b1ph18WZA+_PdY@mail.gmail.com>
	<20101018062025.GD19399@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <20101018062025.GD19399-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
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

T24gTW9uLCBPY3QgMTgsIDIwMTAgYXQgMDI6MjAsIEdyYW50IExpa2VseSB3cm90ZToKPiBPbiBN
b24sIE9jdCAxOCwgMjAxMCBhdCAwMjoxMDoxN0FNIC0wNDAwLCBNaWtlIEZyeXNpbmdlciB3cm90
ZToKPj4gT24gTW9uLCBPY3QgMTgsIDIwMTAgYXQgMDI6MDIsIEdyYW50IExpa2VseSB3cm90ZToK
Pj4gPiBPbiBTdW4sIE9jdCAxNywgMjAxMCBhdCAwNjo1OToyNFBNIC0wNDAwLCBNaWtlIEZyeXNp
bmdlciB3cm90ZToKPj4gPj4gLXN0cnVjdCBkcml2ZXJfZGF0YSB7Cj4+ID4+ICtzdHJ1Y3QgbWFz
dGVyX2RhdGEgewo+PiA+Cj4+ID4gT3IgYmV0dGVyIHlldCwgdG8gcHJvdGVjdCBhZ2FpbnN0IGds
b2JhbCBjb2xsaXNpb25zLCBiZmluNXh4X21hc3RlciBwZXJoYXBzPwo+Pgo+PiBpJ2QgcmF0aGVy
IG5vdC4gwqB0aGVyZSBpcyB0b28gbXVjaCAiYmZpbjV4eCIgc3R1ZmYgYWxyZWFkeSB3aGljaAo+
PiBzaG91bGRudCBleGlzdC4gwqB3aGF0IGNvbGxpc2lvbiBjb3VsZCB0aGVyZSBwb3NzaWJseSBi
ZSA/Cj4KPiBGb3IgZHJpdmVyIGNvZGUsIGFueXRoaW5nIGF0IHRoZSBmaWxlIHNjb3BlIGhhcyBh
IHBvdGVudGlhbCBjb25mbGljdAo+IHdpdGggdGhlIGdsb2JhbCBzY29wZS4gwqBJZiBhbnkgaGVh
ZGVyIGluIGluY2x1ZGUvbGludXggd2VyZSB0byBkZWZpbmUKPiBhICJtYXN0ZXJfZGF0YSIgb3Ig
YSAic2xhdmVfZGF0YSIgc3RydWN0dXJlLCAodGhvc2UgYXJlIHByZXR0eSBnZW5lcmljCj4gbmFt
ZXMsIGl0IGlzIHdlbGwgd2l0aGluIHRoZSByZWFsbSBvZiBwb3NzaWJpbGl0aWVzKSB0aGVuIGl0
IHdvdWxkCj4gY29uZmxpY3QuCgppIGRvbnQgdGhpbmsgZ2VuZXJpYyBuYW1lcyBsaWtlIHRoYXQg
d291bGQgYmUgYWxsb3dlZCBpbiBnbG9iYWwgc3BhY2UKZm9yIHRoaXMgZXhhY3QgcmVhc29uLiAg
aXZlIGFscmVhZHkgbWFkZSBzdXJlIGFsbCB0aGUgZGF0YS9mdW5jdGlvbgpzeW1ib2xzIHRoYXQg
YXJlIHZpc2libGUgZnJvbSBhIGxpbmthZ2Ugc3RhbmQgcG9pbnQgYXJlIHByb3Blcmx5Cm5hbWVz
cGFjZWQgYmVjYXVzZSB1bmxpa2Ugc3RydWN0dXJlcywgdGhvc2UgYXJlIGV4dGVybmFsbHkgdmlz
aWJsZSBieQp0b29scyBzdWNoIGFzIGthbGxzeW1zLgoKaSdkIHJlYWxseSBwcmVmZXIgdG8gbm90
IGhhdmUgdG8gcmVkbyBhbGwgdGhlc2UgcGF0Y2hlcyBjb25zaWRlcmluZwp0aGlzIG9uZSBjaGFu
Z2Ugd2lsbCBjYXNjYWRlIGludG8gbGlrZSAyMCBvdGhlcnMuICBpJ2QgYmUgYSBsb3QgbW9yZQph
bWVuZGFibGUgdG8gYSBwYXRjaCBvbiB0b3Agb2YgYWxsIG9mIHRoZXNlIHRoYXQgbmFtZXNwYWNl
cyB0aGUKc3RydWN0cy4KLW1pa2UKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVWNsaW51eC1kaXN0LWRldmVsIG1haWxpbmcgbGlzdApVY2xpbnV4LWRpc3Qt
ZGV2ZWxAYmxhY2tmaW4udWNsaW51eC5vcmcKaHR0cHM6Ly9ibGFja2Zpbi51Y2xpbnV4Lm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3VjbGludXgtZGlzdC1kZXZlbA==
