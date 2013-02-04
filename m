From: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 0/2] ARM: mvebu: Add support for SPI controller in Armada
	370/XP
Date: Mon, 4 Feb 2013 16:33:16 -0300
Message-ID: <20130204193315.GB2456@localhost>
References: <1359995888-2385-1-git-send-email-ezequiel.garcia@free-electrons.com>
	<20130204165119.GA2440@localhost> <20130204190326.GA20212@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130204190326.GA20212-g2DYL2Zd6BY@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

QW5kcmV3LAoKT24gTW9uLCBGZWIgMDQsIDIwMTMgYXQgMDg6MDM6MjZQTSArMDEwMCwgQW5kcmV3
IEx1bm4gd3JvdGU6Cj4gT24gTW9uLCBGZWIgMDQsIDIwMTMgYXQgMDE6NTE6MjBQTSAtMDMwMCwg
RXplcXVpZWwgR2FyY2lhIHdyb3RlOgo+ID4gSGksCj4gPiAKPiA+IFRoaXMgcGF0Y2hzZXQgYWRk
cyBzdXBwb3J0IGZvciB0aGUgU1BJIGNvbnRyb2xsZXIKPiA+IGF2YWlsYWJsZSBpbiBBcm1hZGEg
MzcwIGFuZCBBcm1hZGEgWFAgU29DLgo+IAo+IEhpIEV6ZXF1aWVsCj4gCj4gRG8gYW55IG9mIHRo
ZSBib2FyZHMgd2UgaGF2ZSB3aXRoIG1haW5saW5lIHN1cHBvcnQgaGF2ZSBhbnkgZGV2aWNlcyBv
bgo+IHRoZSBTUEkgYnVzc2VzPyBJdHMgaGFyZCB0byB0ZXN0IG90aGVyd2lzZS4KPiAKCk1tbS4u
LiB2ZXJ5IHRydWUuCgpSZWNlbnRseSBhZGRlZCBBcm1hZGEgWFAgR1AgYm9hcmQgYXMgYW4gU1BJ
IGZsYXNoLgpQcm9iYWJseSBvdGhlciBldmFsdWF0aW9uIGJvYXJkcyBhbHNvIGhhcyBzaW1pbGFy
IFNQSSBmbGFzaGVzLApidXQgSSBzaG91bGQgY2hlY2sgdGhhdC4KCkknbGwgcHJlcGFyZSBhIHBh
dGNoIGZvciBHUCBib2FyZCB0b21vcnJvdywKYmFzZWQgb24gR3JlZ29yeSdzIHBhdGNoZXMgZm9y
IHRoYXQgYm9hcmQsCnNvIHlvdSBjYW4gdGVzdCB0aGF0LgpBbHNvLCBJIGhvcGUgdG8gcHJlcGFy
ZSBwYXRjaGVzIGZvciB0aGUgb3RoZXIKZXZhbHVhdGlvbiBib2FyZHMgc29vbi4KClJlZ2FyZHMs
CgotLSAKRXplcXVpZWwgR2FyY8OtYSwgRnJlZSBFbGVjdHJvbnMKRW1iZWRkZWQgTGludXgsIEtl
cm5lbCBhbmQgQW5kcm9pZCBFbmdpbmVlcmluZwpodHRwOi8vZnJlZS1lbGVjdHJvbnMuY29tCgot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KRXZlcnlvbmUgaGF0ZXMgc2xvdyB3ZWJzaXRlcy4gU28gZG8g
d2UuCk1ha2UgeW91ciB3ZWIgYXBwcyBmYXN0ZXIgd2l0aCBBcHBEeW5hbWljcwpEb3dubG9hZCBB
cHBEeW5hbWljcyBMaXRlIGZvciBmcmVlIHRvZGF5OgpodHRwOi8vcC5zZi5uZXQvc2Z1L2FwcGR5
bl9kMmRfamFuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CnNwaS1kZXZlbC1nZW5lcmFsIG1haWxpbmcgbGlzdApzcGktZGV2ZWwtZ2VuZXJhbEBsaXN0cy5z
b3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGlu
Zm8vc3BpLWRldmVsLWdlbmVyYWwK
