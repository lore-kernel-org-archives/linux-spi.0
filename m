From: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/5] spi: spi_lock_bus and
	spi_unlock_bus
Date: Tue, 16 Feb 2010 19:40:20 -0500
Message-ID: <8bd0f97a1002161640u58a6dc70s8cfb63bb4e729f83@mail.gmail.com>
References: <20100216204450.e043eed8.eschwab@online.de>
	<20100216205720.ebe949a1.eschwab@online.de>
	<fa686aa41002161243y6e24e439yff54a28cbe295de3@mail.gmail.com>
	<8bd0f97a1002161607m3c748ccegaffb83c42667287a@mail.gmail.com>
	<C97ECEF9A58744F8A9140FAC483AC090@pces>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
To: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <C97ECEF9A58744F8A9140FAC483AC090@pces>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

T24gVHVlLCBGZWIgMTYsIDIwMTAgYXQgMTk6MjEsIEVybnN0IFNjaHdhYiB3cm90ZToKPiBNaWtl
IEZyeXNpbmdlciB3cm90ZToKPj4gdGhpcyBpcyB3aGF0IGkgcHJvcG9zZWQgbGFzdCB0aW1lLCBi
dXQgd2UgaGF2ZW50IGdvdHRlbiBhcm91bmQgdG8KPj4gaW1wbGVtZW50aW5nIGl0Ogo+Pgo+PiDC
oC0gYWRkIGEgbmV3IHNwaV9tYXN0ZXIgZmxhZyB0byBzcGkuaCBsaWtlIFNQSV9NQVNURVJfSEFM
Rl9EVVBMRVggLS0KPj4gU1BJX01BU1RFUl9MT0NLX0JVUwo+PiDCoC0gaGF2ZSB0aGUgbW1jX3Nw
aSBjb2RlIGNoZWNrIHRoYXQgYml0IGluIHRoZSBtYXN0ZXIgYmVmb3JlIGZhbGxpbmcKPj4gYmFj
ayB0byBpdHMgaGFjawo+Cj4gVGhpcyB3b3VsZCBsaW1pdCB0aGUgYnVzIGxvY2tpbmcgY2FwYWJp
bGl0eSBvZiB0aGUgX0FQSV8gdG8gYSBzaW5nbGUKPiBkcml2ZXIgKHRoZSBtbWNfc3BpKSwgb3Ig
ZGlkIEkgbWlzcyBzb21ldGhpbmc/Cgp0aGUgbW1jX3NwaSBjb2RlIGNoZWNrcyBmb3IgZXhjbHVz
aXZlbmVzcyBhdCBsb2FkIHRpbWUgLi4uIGl0IG5lZWRzIHRvCmhhdmUgdGhlIGxvY2svdW5sb2Nr
IHN0ZXBzIHB1c2hlZCBkb3duIHRvIHdoZXJlIGl0IGFjdHVhbGx5IG5lZWRzIGl0Ci1taWtlCgot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KU09MQVJJUyAxMCBpcyB0aGUgT1MgZm9yIERhdGEgQ2VudGVy
cyAtIHByb3ZpZGVzIGZlYXR1cmVzIHN1Y2ggYXMgRFRyYWNlLApQcmVkaWN0aXZlIFNlbGYgSGVh
bGluZyBhbmQgQXdhcmQgV2lubmluZyBaRlMuIEdldCBTb2xhcmlzIDEwIE5PVwpodHRwOi8vcC5z
Zi5uZXQvc2Z1L3NvbGFyaXMtZGV2MmRldgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpzcGktZGV2ZWwtZ2VuZXJhbCBtYWlsaW5nIGxpc3QKc3BpLWRldmVs
LWdlbmVyYWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2Uu
bmV0L2xpc3RzL2xpc3RpbmZvL3NwaS1kZXZlbC1nZW5lcmFsCg==
