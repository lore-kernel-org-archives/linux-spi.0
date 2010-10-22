From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/bfin_sport_spi: new driver to
 emulate a SPI bus using Blackfin SPORT peripheral
Date: Fri, 22 Oct 2010 03:24:11 -0400
Message-ID: <AANLkTi=_u_0FksCzJix1Dw9Ui-Xf5C9J46CUvppSqUCJ@mail.gmail.com>
References: <1287730415-6246-1-git-send-email-vapier@gentoo.org>
	<20101022071630.GA15440@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Cliff Cai <cliff.cai-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
        spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <20101022071630.GA15440-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
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

T24gRnJpLCBPY3QgMjIsIDIwMTAgYXQgMDM6MTYsIEdyYW50IExpa2VseSB3cm90ZToKPiBPbiBG
cmksIE9jdCAyMiwgMjAxMCBhdCAwMjo1MzozNUFNIC0wNDAwLCBNaWtlIEZyeXNpbmdlciB3cm90
ZToKPj4gRnJvbTogQ2xpZmYgQ2FpIDxjbGlmZi5jYWlAYW5hbG9nLmNvbT4KPj4KPj4gVGhlIEJs
YWNrZmluIFNQT1JUIHBlcmlwaGVyYWwgaXMgYSBwcmV0dHkgZmxleGlibGUgZGV2aWNlLiDCoFdp
dGggZW5vdWdoCj4+IGNvYWNoaW5nLCB3ZSBjYW4gbWFrZSBpdCBnZW5lcmF0ZSBTUEkgY29tcGF0
aWJsZSB3YXZlZm9ybXMuIMKgVGhpcyBpcwo+PiBkZXNpcmFibGUgYXMgdGhlIFNQT1JUIGNhbiBy
dW4gYXQgbXVjaCBoaWdoZXIgY2xvY2sgZnJlcXVlbmNpZXMgdGhhbiB0aGUKPj4gZGVkaWNhdGVk
IG9uLWNoaXAgU1BJIHBlcmlwaGVyYWwsIGFuZCBpdCBjYW4gZG8gZnVsbCBkdXBsZXggRE1BLiDC
oEl0IGFsc28KPj4gb3BlbnMgdXAgdGhlIHBvc3NpYmlsaXR5IG9mIG11bHRpcGxlIFNQSSBidXNl
cyBpbiBjYXNlIHNvbWVvbmUgd2FudHMgdG8KPj4gZGVkaWNhdGUgYSB3aG9sZSBidXMgdG8gYSBz
cGVjaWZpYyBwYXJ0IHRoYXQgZG9lcyBub3QgcGxheSB3ZWxsIHdpdGgKPj4gb3RoZXJzLgo+Pgo+
PiBTaWduZWQtb2ZmLWJ5OiBDbGlmZiBDYWkgPGNsaWZmLmNhaUBhbmFsb2cuY29tPgo+PiBTaWdu
ZWQtb2ZmLWJ5OiBCcnlhbiBXdSA8Y29vbG9uZXlAa2VybmVsLm9yZz4KPj4gU2lnbmVkLW9mZi1i
eTogTWljaGFlbCBIZW5uZXJpY2ggPG1pY2hhZWwuaGVubmVyaWNoQGFuYWxvZy5jb20+Cj4+IFNp
Z25lZC1vZmYtYnk6IE1pa2UgRnJ5c2luZ2VyIDx2YXBpZXJAZ2VudG9vLm9yZz4KPj4gLS0tCj4+
IMKgZHJpdmVycy9zcGkvS2NvbmZpZyDCoCDCoCDCoCDCoCDCoHwgwqAgMTAgKwo+PiDCoGRyaXZl
cnMvc3BpL01ha2VmaWxlIMKgIMKgIMKgIMKgIHwgwqAgwqAxICsKPj4gwqBkcml2ZXJzL3NwaS9i
ZmluX3Nwb3J0X3NwaS5jIHwgwqA5MjUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrCj4KPiBSZW1pbmQgbWUgYWJvdXQgdGhpcyBvbmUgYWZ0ZXIgMi42LjM3LXJjMSBp
cyByZWxlYXNlZC4gwqBJdCBpcyB0b28gbGF0ZQo+IGZvciB0aGUgY3VycmVudCBtZXJnZSB3aW5k
b3cuCgppc250IHRoaXMgd2h5IGdpdCBzdXBwb3J0cyBtdWx0aXBsZSBicmFuY2hlcyBzbyBlYXNp
bHkgPyAgaSBkb250CmV4cGVjdCB5b3UgdG8gdGFrZSBpdCBmb3IgdGhpcyBtZXJnZSB3aW5kb3cs
IGJ1dCBpdCBzZWVtcyBzaWxseSBmb3IKc3Vic3lzIG1haW50YWluZXJzIHRvIGFsbCBoYXZlIHRo
ZWlyIG93biAibWVyZ2UiIHdpbmRvdy4KLW1pa2UKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVWNsaW51eC1kaXN0LWRldmVsIG1haWxpbmcgbGlzdApVY2xp
bnV4LWRpc3QtZGV2ZWxAYmxhY2tmaW4udWNsaW51eC5vcmcKaHR0cHM6Ly9ibGFja2Zpbi51Y2xp
bnV4Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3VjbGludXgtZGlzdC1kZXZlbA==
