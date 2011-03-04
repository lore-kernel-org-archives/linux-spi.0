From: Kevyn-Alexandre =?ISO-8859-1?Q?Par=E9?= <kapare-7qmld2CjetYf4mhTGKTGE9BPR1lH4CV8@public.gmane.org>
Subject: Re: Sending one byte transfers using SPI bus with linux-2.6.32
Date: Fri, 04 Mar 2011 15:56:36 -0500
Message-ID: <1299272196.2338.56.camel@andromeda>
References: <E4CEDCEF-66BE-4C94-A27D-5088882A1E0C@mac.com>
	<e9d13c1c-1e50-4b0c-bd95-60c8398142f6@email.android.com>
	<7974B5C3-662C-40A9-AB44-722A84190886@mac.com>
	<1299267497.2338.4.camel@andromeda> <1299268583.2338.6.camel@andromeda>
	<1299268719.2338.7.camel@andromeda>
	<B9012B37-7DAE-4D5D-B3F5-FFD675C89648@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: SPI Developer Mailing List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Elvis Dowson <elvis.dowson-ee4meeAH724@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <B9012B37-7DAE-4D5D-B3F5-FFD675C89648-ee4meeAH724@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

c2ltcGx5IHRbMV0gSSByZXVzZSAtcyBvcHRpb24ganVzdCBkaWZmIGl0IHdpdGggdGhlIG9yaWdp
bmFsCgpodHRwOi8vcGFzdGViaW4uY29tL1lzNndNRDFTCgpEaWQgeW91IHRyeSBsYXRlciB2ZXJz
aW9uIG9mIGtlcm5lbD8KCktldnluLUFsZXhhbmRyZSBQYXLDqQoKCgpPbiBTYXQsIDIwMTEtMDMt
MDUgYXQgMDA6MTEgKzA0MDAsIEVsdmlzIERvd3NvbiB3cm90ZToKPiBPbiBNYXIgNCwgMjAxMSwg
YXQgMTE6NTggUE0sIEtldnluLUFsZXhhbmRyZSBQYXLDqSB3cm90ZToKPiAKPiA+IEp1c3QgdG8g
bWVudGlvbiB0aGF0IEkgd2FzIHdpdGggT01BUCAzNTMwCj4gPiAyLjYuMzQgYW5kIGtub3cgMi42
LjM2IChndW1zdGl4IG92ZXJvKQo+IAo+IE9rLCAyLjYuMzIgZGlkbid0IHdvcmsgZm9yIDEgYnl0
ZSB0cmFuc2ZlcnMuCj4gCj4gRG8geW91IGhhdmUgYSBzYW1wbGUgY29kZSBzbmlwcGV0IHRoYXQg
eW91IGNhbiBzaGFyZSwgb3Igd2FzIGl0IGp1c3QgcHV0dGluZyB0eFsxXSBhbmQgcmUtdXNpbmcg
dGhlIHNwaWRldl90ZXN0LmMgZXhhbXBsZS4KPiAKPiBFbHZpcyBEb3dzb24KCgoKLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tCldoYXQgWW91IERvbid0IEtub3cgQWJvdXQgRGF0YSBDb25uZWN0aXZpdHkg
Q0FOIEh1cnQgWW91ClRoaXMgcGFwZXIgcHJvdmlkZXMgYW4gb3ZlcnZpZXcgb2YgZGF0YSBjb25u
ZWN0aXZpdHksIGRldGFpbHMKaXRzIGVmZmVjdCBvbiBhcHBsaWNhdGlvbiBxdWFsaXR5LCBhbmQg
ZXhwbG9yZXMgdmFyaW91cyBhbHRlcm5hdGl2ZQpzb2x1dGlvbnMuIGh0dHA6Ly9wLnNmLm5ldC9z
ZnUvcHJvZ3Jlc3MtZDJkCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCnNwaS1kZXZlbC1nZW5lcmFsIG1haWxpbmcgbGlzdApzcGktZGV2ZWwtZ2VuZXJhbEBs
aXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMv
bGlzdGluZm8vc3BpLWRldmVsLWdlbmVyYWwK
