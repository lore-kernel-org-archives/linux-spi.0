From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: mxs: Provide a common header file for SSP
	controller
Date: Fri, 20 Apr 2012 00:07:24 -0300
Message-ID: <CAOMZO5AOmAA93LLQnzHrOf+prH5rmNw7C-ZSpYzpKGUrZ74G1g@mail.gmail.com>
References: <1334795434-8780-1-git-send-email-festevam@gmail.com>
	<20120420025918.GI22219@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, snijsure-4jo+YWezP1RWk0Htik3J/w@public.gmane.org,
	marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120420025918.GI22219-rvtDTF3kK1ictlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

T24gVGh1LCBBcHIgMTksIDIwMTIgYXQgMTE6NTkgUE0sIFNoYXduIEd1byA8c2hhd24uZ3VvQGxp
bmFyby5vcmc+IHdyb3RlOgoKPiBXZSBhcmUgdHJ5aW5nIHRvIHJlbW92ZSA8bWFjaC8qLmg+IGZy
b20gZHJpdmVycy4gwqBBbmQgdGhpcyBwYXRjaCBtb3Zlcwo+IHRvIHRoZSBvcHBvc2l0ZSBkaXJl
Y3Rpb24uCgpXaGVyZSB3b3VsZCBiZSBhIGdvb2QgbG9jYXRpb24gZm9yIHNzcC1yZWdzLmggdGhl
bj8KClJlZ2FyZHMsCgpGYWJpbyBFc3RldmFtCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KRm9yIERl
dmVsb3BlcnMsIEEgTG90IENhbiBIYXBwZW4gSW4gQSBTZWNvbmQuCkJvdW5kYXJ5IGlzIHRoZSBm
aXJzdCB0byBLbm93Li4uYW5kIFRlbGwgWW91LgpNb25pdG9yIFlvdXIgQXBwbGljYXRpb25zIGlu
IFVsdHJhLUZpbmUgUmVzb2x1dGlvbi4gVHJ5IGl0IEZSRUUhCmh0dHA6Ly9wLnNmLm5ldC9zZnUv
Qm91bmRhcnktZDJkdnMyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCnNwaS1kZXZlbC1nZW5lcmFsIG1haWxpbmcgbGlzdApzcGktZGV2ZWwtZ2VuZXJhbEBs
aXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMv
bGlzdGluZm8vc3BpLWRldmVsLWdlbmVyYWwK
