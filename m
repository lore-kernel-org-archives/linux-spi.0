From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Fix race condition in stop_queue()
Date: Thu, 7 Apr 2011 02:12:22 -0400
Message-ID: <BANLkTin8_WF4beQKP7fEF_wBPXZrgHOFHA@mail.gmail.com>
References: <201104061746.44134.anarsoul@gmail.com>
	<1302101355-31187-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Vasily Khoruzhick <anarsoul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1302101355-31187-1-git-send-email-anarsoul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

T24gV2VkLCBBcHIgNiwgMjAxMSBhdCAxMDo0OSwgVmFzaWx5IEtob3J1emhpY2sgd3JvdGU6Cj4g
wqBkcml2ZXJzL3NwaS9zcGlfYmZpbjV4eC5jIHwgwqAgwqAyICstCgpzZWVtcyB0byBwYXN0IG15
IHNtb2tlIHRlc3QuCkFja2VkLWJ5OiBNaWtlIEZyeXNpbmdlciA8dmFwaWVyQGdlbnRvby5vcmc+
Ci1taWtlCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KWHBlcmlhKFRNKSBQTEFZCkl0J3MgYSBtYWpv
ciBicmVha3Rocm91Z2guIEFuIGF1dGhlbnRpYyBnYW1pbmcKc21hcnRwaG9uZSBvbiB0aGUgbmF0
aW9uJ3MgbW9zdCByZWxpYWJsZSBuZXR3b3JrLgpBbmQgaXQgd2FudHMgeW91ciBnYW1lcy4KaHR0
cDovL3Auc2YubmV0L3NmdS92ZXJpem9uLXNmZGV2Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCnNwaS1kZXZlbC1nZW5lcmFsIG1haWxpbmcgbGlzdApzcGkt
ZGV2ZWwtZ2VuZXJhbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vm
b3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vc3BpLWRldmVsLWdlbmVyYWwK
