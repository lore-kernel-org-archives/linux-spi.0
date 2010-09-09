From: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv2 0/6] SPI: S3C64XX: bug fix and enhancements
Date: Thu, 9 Sep 2010 10:41:22 +0900
Message-ID: <AANLkTim0p0UzXu02N45WwnG5HK-HGzrNgFtXwo3U09pu@mail.gmail.com>
References: <1283994931-23708-1-git-send-email-jassi.brar@samsung.com>
	<5c15a9f3-0b99-44c3-b828-99c7b5deee0c@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <5c15a9f3-0b99-44c3-b828-99c7b5deee0c-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

T24gVGh1LCBTZXAgOSwgMjAxMCBhdCAxMDozNyBBTSwgR3JhbnQgTGlrZWx5IDxncmFudC5saWtl
bHlAc2VjcmV0bGFiLmNhPiB3cm90ZToKPiBIaSBKYXNzaS4gwqBJJ3ZlIGFjdHVhbGx5IGJlZW4g
d29ya2luZyB0aHJvdWdoIHRoZXNlIHRvZGF5IChJJ20gbm90IGlnbm9yaW5nIHlvdSwganVzdCBk
ZWFsaW5nIHdpdGggYmFjay10by1zY2hvb2wgZmFtaWx5IGlzc3VlcyB3aGljaCBpcyB3aHkgSSdt
IHNsb3cpLiDCoFlvdSdsbCBnZXQgZW1haWxzIGFzIEkgbWVyZ2UgdGhlbSBpbnRvIG15IHRyZWUu
CgpZb3UgZGlkbid0IGFwcGVhciBpbiB0aGUgY2MgbGlzdCBldmVuIHRob3VnaCBJIGhhZCBhZGRl
ZCBpdCwgc28gSSB0aG91Z2h0IG1heWJlCnNvbWV0aGluZyB3ZW50IHdyb25nIHdpdGggc3VibWlz
c2lvbi4KVGFrZSB5b3VyIHRpbWUgcGxlYXNlLgpUaGFua3MuCgotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KVGhpcyBTRi5uZXQgRGV2MkRldiBlbWFpbCBpcyBzcG9uc29yZWQgYnk6CgpTaG93IG9mZiB5
b3VyIHBhcmFsbGVsIHByb2dyYW1taW5nIHNraWxscy4KRW50ZXIgdGhlIEludGVsKFIpIFRocmVh
ZGluZyBDaGFsbGVuZ2UgMjAxMC4KaHR0cDovL3Auc2YubmV0L3NmdS9pbnRlbC10aHJlYWQtc2Zk
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCnNwaS1kZXZl
bC1nZW5lcmFsIG1haWxpbmcgbGlzdApzcGktZGV2ZWwtZ2VuZXJhbEBsaXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vc3BpLWRl
dmVsLWdlbmVyYWwK
