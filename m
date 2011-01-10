From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: Re: [Uclinux-dist-devel] [PATCH]
 spi/bfin_sport_spi: new driver to emulate a SPI bus using Blackfin SPORT
 peripheral
Date: Mon, 10 Jan 2011 09:39:40 -0500
Message-ID: <AANLkTikpQHNRinCXOPFKfCqwCaNGa2VavFHG9juDw9cK@mail.gmail.com>
References: <1287730415-6246-1-git-send-email-vapier@gentoo.org>
	<20101101055600.GC17587@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Cliff Cai <cliff.cai-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
        spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <20101101055600.GC17587-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
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

T24gTW9uLCBOb3YgMSwgMjAxMCBhdCAwMTo1NiwgR3JhbnQgTGlrZWx5IHdyb3RlOgo+IE9uIEZy
aSwgT2N0IDIyLCAyMDEwIGF0IDAyOjUzOjM1QU0gLTA0MDAsIE1pa2UgRnJ5c2luZ2VyIHdyb3Rl
Ogo+PiArIMKgIMKgIC8qIFNQSSBmcmFtZXdvcmsgaG9va3VwICovCj4+ICsgwqAgwqAgc3RydWN0
IHNwaV9tYXN0ZXIgKm1hc3RlcjsKPj4gKwo+PiArIMKgIMKgIC8qIFJlZ3MgYmFzZSBvZiBTUEkg
Y29udHJvbGxlciAqLwo+PiArIMKgIMKgIHZvbGF0aWxlIHN0cnVjdCBzcG9ydF9yZWdpc3RlciBf
X2lvbWVtICpyZWdzOwo+Cj4gRHJvcCB0aGUgdm9sYXRpbGUuIMKgUmVnaXN0ZXJzIG11c3QgbmV2
ZXIgYmUgZGVyZWZlcmVuY2VkIGRpcmVjdGx5Cj4gYW55d2F5Lgo+Cj4+ICtzdGF0aWMgdm9pZCBi
ZmluX3Nwb3J0X3NwaV9lbmFibGUoc3RydWN0IG1hc3Rlcl9kYXRhICpkcnZfZGF0YSkKPj4gK3sK
Pj4gKyDCoCDCoCBkcnZfZGF0YS0+cmVncy0+dGNyMSB8PSBUU1BFTjsKPj4gKyDCoCDCoCBkcnZf
ZGF0YS0+cmVncy0+cmNyMSB8PSBUU1BFTjsKPgo+IElsbGVnYWwgZGlyZWN0IGRlcmVmZXJlbmNl
OyB1c2UgaW9yZWFkL2lvd3JpdGUgaW5zdGVhZC4gwqBEaXR0byB0aHJvdWdoCj4gcmVzdCBvZiBm
aWxlLgoKdGhhdCdzIG5vdCBjb3JyZWN0LiAgaW9yZWFkL2lvd3JpdGUgYXJlIGZpbmUgaWYgdGhl
IGRldmljZXMgd2VyZQpnZW5lcmljYWxseSBtYXBwZWQgdGhyb3VnaCBzYXkgdGhlIGFzeW5jaHJv
bm91cyBtZW1vcnkgYnVzLCBidXQgdGhlc2UKcmVnaXN0ZXJzIGFyZW50LiAgdGhleSdyZSBtYXBw
ZWQgZGlyZWN0bHkgaW50byB0aGUgQmxhY2tmaW4gaGFyZHdhcmUKc3lzdGVtIGJ1cyBhbmQgaGF2
ZSBkaWZmZXJlbnQgc2VtYW50aWNzIHRoYW4gdGhlIGFzeW5jIG1lbW9yeSBidXMuCgo+PiArIMKg
IMKgIFNTWU5DKCk7Cj4KPiBUaGUgU1NZTkMgc2hvdWxkbid0IGJlIG5lY2Vzc2FyeSB3aXRoIHRo
ZSBjb3JyZWN0IGFjY2Vzc29ycy4KCmluZGVwZW5kZW50bHkgaW5jb3JyZWN0IGZyb20gdGhlIGlv
cmVhZC9pb3dyaXRlIGNvbW1lbnQuICB0aGVyZSdzIG5vCndheSBhbnkgcmVnaXN0ZXIgYWNjZXNz
b3JzIGZ1bmN0aW9uIHdvdWxkIGV2ZXIgaW1wb3NlIGEgU1NZTkMgb24gdGhlCkJsYWNrZmluIGFy
Y2hpdGVjdHVyZS4gIHRoaXMgY2F1c2VzIGEgKnN5c3RlbSogd2lkZSBzeW5jIG9mICphbGwqCnJl
Z2lzdGVycyBhbmQgYXMgc3VjaCwgaXMgdXNlZCBvbmx5IHdoZW4gbmVjZXNzYXJ5LiAgaWYgd2Ug
ZGlkIGFzIHlvdQpwcm9wb3NlZCBhbmQgYWRkZWQgdGhlbSB0byBldmVyeSBzaW5nbGUgcmVhZC93
cml0ZSwgaXQgd291bGQga2lsbApwZXJmb3JtYW5jZS4KCnRoZSByZXN0IGxvb2tlZCBmaW5lIGFu
ZCBzaG91bGQgYmUgZG9hYmxlIGluIHRpbWUKLW1pa2UKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVWNsaW51eC1kaXN0LWRldmVsIG1haWxpbmcgbGlzdApV
Y2xpbnV4LWRpc3QtZGV2ZWxAYmxhY2tmaW4udWNsaW51eC5vcmcKaHR0cHM6Ly9ibGFja2Zpbi51
Y2xpbnV4Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3VjbGludXgtZGlzdC1kZXZlbA==
