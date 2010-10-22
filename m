From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi/bfin_spi: only request
 GPIO on first load
Date: Fri, 22 Oct 2010 02:41:12 -0400
Message-ID: <AANLkTi=-yDBTJPhSgP7XjaKpqp7T+=inf5F1DCMZT4CZ@mail.gmail.com>
References: <1287727308-26653-1-git-send-email-vapier@gentoo.org>
	<20101022063004.GA3311@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
        uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <20101022063004.GA3311-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
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

T24gRnJpLCBPY3QgMjIsIDIwMTAgYXQgMDI6MzAsIEdyYW50IExpa2VseSB3cm90ZToKPiBPbiBG
cmksIE9jdCAyMiwgMjAxMCBhdCAwMjowMTo0N0FNIC0wNDAwLCBNaWtlIEZyeXNpbmdlciB3cm90
ZToKPj4gRnJvbTogTWljaGFlbCBIZW5uZXJpY2ggPG1pY2hhZWwuaGVubmVyaWNoQGFuYWxvZy5j
b20+Cj4+Cj4+IFRoZSBncGlvbGliIGNvZGUgZG9lcyBub3QgYWxsb3cgcGVvcGxlIHRvIGRvIGdw
aW9fcmVxdWVzdCgpIG9uIGEgR1BJTwo+PiBvbmNlIGl0IGhhcyBhbHJlYWR5IGJlZW4gcmVxdWVz
dGVkLiDCoFNvIG1ha2Ugc3VyZSB3ZSBvbmx5IHJlcXVlc3QgdGhlCj4+IHBpbiBvbiB0aGUgZmly
c3Qgc2V0dXAgb2YgYSBTUEkgZGV2aWNlLiDCoE90aGVyd2lzZSwgaWYgeW91IGF0dGVtcHRzIHRv
Cj4+IHJlY29uZmlndXJlIGEgU1BJIGRldmljZSBvbiB0aGUgZmx5IChsaWtlIGNoYW5nZSBiaXQg
c2l6ZXMpLCB0aGUgc2V0dXAKPj4gZnVuY3Rpb24gaW5jb3JyZWN0bHkgZmFpbHMuCj4KPiBEb2Vz
bid0IHRoYXQgbWVhbiB0aGF0IHRoZSBncGlvIHBpbiBiZSByZXF1ZXN0ZWQgYXQgZGV2aWNlIHBy
b2JlIHRpbWUKPiBpbnN0ZWFkIG9mIGluIGEgZnVuY3Rpb24gdGhhdCBjYW4gYmUgcmVwZWF0ZWRs
eSBjYWxsZWQ/Cgpub3Qgc3VyZSB3aGF0IHlvdSBtZWFuLiAgdGhpcyBpcyBhIHBpbiBzcGVjaWZp
YyB0byBhIHNwaSBzbGF2ZSBkZXZpY2UuCiB0aGVyZSBpcyBubyAic3BpIHByb2JlIiBmdW5jdGlv
biBmb3Igc3BpIHNsYXZlIGRldmljZXMsIG9ubHkgdGhlICJzcGkKc2V0dXAiIGZ1bmN0aW9uLgoK
aWYgdGhlcmUncyBzb21ldGhpbmcgc3BlY2lmaWMgeW91J3JlIHJlZmVycmluZyB0bywgeW91J2xs
IGhhdmUgdG8gZWxhYm9yYXRlIC4uLgotbWlrZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpVY2xpbnV4LWRpc3QtZGV2ZWwgbWFpbGluZyBsaXN0ClVjbGlu
dXgtZGlzdC1kZXZlbEBibGFja2Zpbi51Y2xpbnV4Lm9yZwpodHRwczovL2JsYWNrZmluLnVjbGlu
dXgub3JnL21haWxtYW4vbGlzdGluZm8vdWNsaW51eC1kaXN0LWRldmVs
