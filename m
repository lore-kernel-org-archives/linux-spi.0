From: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/5] Blackfin SPI: clean up error
	handling in client setup
Date: Thu, 1 Oct 2009 00:27:32 -0400
Message-ID: <8bd0f97a0909302127v21e1fbck28afac9e0e579063@mail.gmail.com>
References: <1253231273-16423-1-git-send-email-vapier@gentoo.org>
	<1253231273-16423-5-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1253231273-16423-5-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
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

T24gVGh1LCBTZXAgMTcsIDIwMDkgYXQgMTk6NDcsIE1pa2UgRnJ5c2luZ2VyIDx2YXBpZXJAZ2Vu
dG9vLm9yZz4gd3JvdGU6Cj4gRnJvbTogWWkgTGkgPHlpLmxpQGFuYWxvZy5jb20+Cj4KPiBNYWtl
IHN1cmUgd2UgZG9uJ3QgbGVhayBwZXJpcGhlcmFsL2dwaW8gcmVzb3VyY2VzIHdoZW4gYW4gZXJy
b3Igb2NjdXJzCj4gZHVyaW5nIHNldHVwLCBhbmQgbWFrZSBzdXJlIHdlIGRvbid0IGNhbGwga2Zy
ZWUoKSB0d2ljZSBvbiB0aGUgc2FtZQo+IG9iamVjdC4gwqBBbHNvIGFkZC9maXggc29tZSBlcnJv
ciBtZXNzYWdlcyBpbiB0aGUgcHJvY2Vzcy4KCm5vdCBzdXJlIGlmIHlvdSd2ZSBwaWNrZWQgYW55
IG9mIHRoZXNlIGNoYW5nZXMgdXAgRGF2aWQsIGJ1dCBpZiB5b3UKaGF2ZW50LCBwbGVhc2Ugc2tp
cCB0aGlzIGxhc3QgcGF0Y2guICBpdCBuZWVkcyBzb21lIHVwZGF0aW5nIGFzIGl0CmludHJvZHVj
ZXMgYXQgbGVhc3Qgb25lIE5VTEwgcHRyIGRlcmVmIGluIHRoZSBlcnJvciBwYXRoLgotbWlrZQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpVY2xpbnV4LWRp
c3QtZGV2ZWwgbWFpbGluZyBsaXN0ClVjbGludXgtZGlzdC1kZXZlbEBibGFja2Zpbi51Y2xpbnV4
Lm9yZwpodHRwczovL2JsYWNrZmluLnVjbGludXgub3JnL21haWxtYW4vbGlzdGluZm8vdWNsaW51
eC1kaXN0LWRldmVs
