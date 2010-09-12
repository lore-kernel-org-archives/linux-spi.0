From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: Analog Digital Converter - ADS1256 extreme newbie questions
Date: Sun, 12 Sep 2010 14:30:33 -0600
Message-ID: <20ea3e76-bd98-4885-9bc1-b99b426beb20@email.android.com>
References: <AANLkTi=iQVwpd-PymaWSKapfntmf4aRrt51Jutsz=D_g@mail.gmail.com>
	<20100910171858.GA11284@angua.secretlab.ca>
	<AANLkTikXq6Wm0kA_cHiAyZc+5kOJQBvP_2gOSbnihv5i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: =?ISO-8859-1?Q?Fl=E1vio_Alberto_Lopes_Soares?= <flavioalsoares-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTikXq6Wm0kA_cHiAyZc+5kOJQBvP_2gOSbnihv5i-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

CgoiRmzDoXZpbyBBbGJlcnRvIExvcGVzIFNvYXJlcyIgPGZsYXZpb2Fsc29hcmVzQGdtYWlsLmNv
bT4gd3JvdGU6ClvigKZdCj5CdXQsIGNvbXBhcmluZyBkcml2ZXJzL3N0YWdpbmcvaWlvL2FjY2Vs
L2t4c2Q5LmMKPmFuZCBkcml2ZXJzL21pc2MvZWVwcm9tL2F0MjUuYyB3aHkga3hzZDkgZHJpdmVy
IGRvZXNuJ3QgdXNlcyB0aGUKPnBsYXRmb3JtX2RhdGEgc3RydWN0ID8gVGhlcmUncyBzb21lIGZ1
bmN0aW9uYWwgZGlmZmVyZW5jZSBpbiB0aGVzZSAyIGRyaXZlcnMKPmluIHRoZSB3YXkgdGhhdCB0
aGV5IGFjY2VzcyB0aGUgU1BJIHN1YnN5c3RlbSA/CgpwbGF0Zm9ybV9kYXRhIGlzIGEgbWV0aG9k
IGZvciBwYXNzaW5nIGFkZGl0aW9uYWwgZGF0YSB0byBhIGRyaXZlciB0aGF0IGRvZXNuJ3QgZml0
IGluIHRoZSBzcGlfZGV2aWNlIHN0cnVjdHVyZS4gIERyaXZlcnMgYXJlIG5vdCByZXF1aXJlZCB0
byB1c2UgcGxhdGZvcm1fZGF0YS4KCmcuCgotLSAKU2VudCBmcm9tIG15IEFuZHJvaWQgcGhvbmUg
d2l0aCBLLTkgTWFpbC4gUGxlYXNlIGV4Y3VzZSBteSBicmV2aXR5LgoKLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tClN0YXJ0IHVuY292ZXJpbmcgdGhlIG1hbnkgYWR2YW50YWdlcyBvZiB2aXJ0dWFsIGFw
cGxpYW5jZXMKYW5kIHN0YXJ0IHVzaW5nIHRoZW0gdG8gc2ltcGxpZnkgYXBwbGljYXRpb24gZGVw
bG95bWVudCBhbmQKYWNjZWxlcmF0ZSB5b3VyIHNoaWZ0IHRvIGNsb3VkIGNvbXB1dGluZwpodHRw
Oi8vcC5zZi5uZXQvc2Z1L25vdmVsbC1zZmRldjJkZXYKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18Kc3BpLWRldmVsLWdlbmVyYWwgbWFpbGluZyBsaXN0CnNw
aS1kZXZlbC1nZW5lcmFsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJj
ZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9zcGktZGV2ZWwtZ2VuZXJhbAo=
