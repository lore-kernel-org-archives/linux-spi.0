From: "Tang, Feng" <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch 2.6.28-rc9] spi:
 spi_write_then_read() regression fix
Date: Wed, 24 Dec 2008 12:20:38 +0800
Message-ID: <EADF0A36011179459010BDF5142A45750458C815@pdsmsx502.ccr.corp.intel.com>
References: <200812202332.36281.david-b@pacbell.net>
	<200812231254.55284.david-b@pacbell.net>
	<EADF0A36011179459010BDF5142A45750458C7DD@pdsmsx502.ccr.corp.intel.com>
	<200812231953.26407.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200812231953.26407.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Tm8uIEFmdGVyIHRoYXQgaXQgZmFpbHMgb24gMi42LjI4LCBJIHdyb3RlIGEgbmV3IEFQSSBpbnNp
ZGUgbXkgZHJpdmVyIHdoaWNoIGlzIHNpbWlsYXIgdG8geW91ciAyLjYuMjggc3BpX3dyaXRlX3Ro
ZW5fcmVhZCgpLCBidXQgbW9kaWZ5IHRoZSBidWZmZXIgbGF5b3V0LiBBbmQgdGhlIG5ldyBBUEkg
d29ya3MgZmluZSBmb3IgbXkgbWF4MzExMSBkZXZpY2UuIA0KDQpUaGFua3MsDQpGZW5nDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogRGF2aWQgQnJvd25lbGwgW21haWx0bzpkYXZp
ZC1iQHBhY2JlbGwubmV0XSANClNlbnQ6IDIwMDjE6jEy1MIyNMjVIDExOjUzDQpUbzogVGFuZywg
RmVuZw0KQ2M6IExpbnVzIFRvcnZhbGRzOyBzcGktZGV2ZWwtZ2VuZXJhbEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQ7IEFuZHJldyBNb3J0b247IFZlcm5vbiBTYXVkZXINClN1YmplY3Q6IFJlOiBbc3Bp
LWRldmVsLWdlbmVyYWxdIFtwYXRjaCAyLjYuMjgtcmM5XSBzcGk6IHNwaV93cml0ZV90aGVuX3Jl
YWQoKSByZWdyZXNzaW9uIGZpeA0KDQpPbiBUdWVzZGF5IDIzIERlY2VtYmVyIDIwMDgsIFRhbmcs
IEZlbmcgd3JvdGU6DQo+IEknbSB3cml0aW5nIGEgU1BJLVVBUlQgZGV2aWNlIGRyaXZlciBmb3Ig
bWF4MzExMSwgaXRzIHdvcmtpbmcNCj4gbWVjaGFuaXNtIGlzIGlmIHlvdSB3YW50IHJlYWQgZGF0
YSBiYWNrLCB5b3UgbmVlZCB3cml0ZSAwIHRvDQo+IGl0IGZpcnN0IC4uLg0KPiANCj4gVGhlIGRy
aXZlciB3b3JrcyBpbiAyLjYuMjcgd2l0aCB5b3VyIHByZXZpb3VzIHNwaV93cml0ZV90aGVuX3Jl
YWQoKQ0KPiBpbXBsZW1lbnRhdGlvbiwgYnV0IGZhaWxzIG9uIDIuNi4yOCBhcyBpdCBkdW1wcyBh
bGwgdGhlIHJlYWRiYWNrDQo+IHZhbHVlIG9mIHRoZSB3cml0ZS4gIA0KDQpBbmQgc28gaXQgd29y
a3Mgd2l0aCB0aGUgJFNVQkpFQ1QgcGF0Y2gsIHllcz8NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpzcGktZGV2ZWwt
Z2VuZXJhbCBtYWlsaW5nIGxpc3QKc3BpLWRldmVsLWdlbmVyYWxAbGlzdHMuc291cmNlZm9yZ2Uu
bmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL3NwaS1kZXZl
bC1nZW5lcmFsCg==
