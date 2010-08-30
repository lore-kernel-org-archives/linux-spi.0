From: Quentin YANG <quentinyang05-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Low SPI data throughput on Phytec 3250 board? (amba-pl022.c deployed
	on Phytec 3250 board.)
Date: Mon, 30 Aug 2010 11:50:38 +1000
Message-ID: <AANLkTi=z6x38+qhgc6cuGEY3jgiUwReMURP6sFhP3Cfe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016361e834af15bc4048f00b04a
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--0016361e834af15bc4048f00b04a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

SGksCgpJIGFtIHVzaW5nIHRyYW5zZmVyKCnCoCBmdW5jdGlvbiBpbiBzcGlkZXZfdGVzdC5jIHRv
IHZlcmlmeSB0aGUgZGF0YQp0aHJvdWdocHV0IG9uIHBoeXRlYyBMUEMzMjUwIGJvYXJkLgoyS0J5
dGVzIFNQSSBtZXNzYWdlIGlzIHNlbnQgb3V0IHRvIFNQSSBTbGF2ZSBkZXZpY2UuCgpUaGVyZSBp
cyBhIGJpZyBkZWxheSAoODB1cyBvciBzbykgYWZ0ZXIgZXZlcnkgMTEgd29yZHMgdHJhbnNtaXNz
aW9uICgKMjAgdXMgb3Igc28sIHdoaWNoIGlzIHJlYXNvbmFibGUgYXQgOE1IeiBTUEkgQ2xvY2sp
Lgo9PT09IEkgYW0gd29uZGVyaW5nIHdoZXJlIGlzIHRoaXMgc2lnbmlmaWNhbnQgZGVsYXkgY29t
aW5nIGZyb20/Pz8gID09PT09PQpJdCBsYXJnZWx5IHJlZHVjZWQgdGhlIFNQSSBkYXRhIHRocm91
Z3B1dC4KSXQgZG9lcyBub3QgbG9vayBsaWtlICdMaW51eCBLZXJuZWwgQ29udGV4dCBzd2l0Y2gn
LgoKU2VlIGF0dGFjaGVkIFRpbWluZyBJbmZvIG9uIFNjb3BlLiAgKFRpbWluZ09uU2NvcGUudHh0
KQoKClNQSSBib2FyZCBzZXR0aW5nIGlzIGFzIGZvbGxvd3MgKDhNSFogc3BpIGNsb2NrLCAxNmJp
dCBkYXRhIHNpemUsCmludGVycnVwdCB0cmFuc2ZlcikKCnN0YXRpYyBzdHJ1Y3QgcGwwMjJfY29u
ZmlnX2NoaXAgc3BpMV9jaGlwX2luZm8gPSB7CsKgwqDCoCAubGJtwqDCoMKgIMKgwqDCoCDCoMKg
wqAgPSBMT09QQkFDS19ESVNBQkxFRCwKwqDCoMKgIC5jb21fbW9kZcKgwqDCoCDCoMKgwqAgPSBJ
TlRFUlJVUFRfVFJBTlNGRVIsCsKgwqDCoCAuaWZhY2XCoMKgwqAgwqDCoMKgIMKgwqDCoCA9IFNT
UF9JTlRFUkZBQ0VfTU9UT1JPTEFfU1BJLArCoMKgwqAgLmhpZXJhcmNoecKgwqDCoCDCoMKgwqAg
PSBTU1BfTUFTVEVSLArCoMKgwqAgLnNsYXZlX3R4X2Rpc2FibGXCoMKgwqAgPSAwLArCoMKgwqAg
LmVuZGlhbl90eMKgwqDCoCDCoMKgwqAgPSBTU1BfVFhfTFNCLArCoMKgwqAgLmVuZGlhbl9yeMKg
wqDCoCDCoMKgwqAgPSBTU1BfUlhfTFNCLArCoMKgwqAgLmRhdGFfc2l6ZcKgwqDCoCDCoMKgwqAg
PSBTU1BfREFUQV9CSVRTXzE2LMKgwqDCoMKgwqAgLy9TU1BfREFUQV9CSVRTXzgsCsKgwqDCoCAu
cnhfbGV2X3RyaWfCoMKgwqAgwqDCoMKgID0gU1NQX1JYXzRfT1JfTU9SRV9FTEVNLArCoMKgwqAg
LnR4X2xldl90cmlnwqDCoMKgIMKgwqDCoCA9IFNTUF9UWF80X09SX01PUkVfRU1QVFlfTE9DLArC
oMKgwqAgLmNsa19waGFzZcKgwqDCoCDCoMKgwqAgPSBTU1BfQ0xLX0ZJUlNUX0VER0UswqDCoCAv
L1NTUF9DTEtfU0VDT05EX0VER0UsCsKgwqDCoCAuY2xrX3BvbMKgwqDCoCDCoMKgwqAgPSBTU1Bf
Q0xLX1BPTF9JRExFX0xPVywKwqDCoMKgIC5jdHJsX2xlbsKgwqDCoCDCoMKgwqAgPSBTU1BfQklU
U184LArCoMKgwqAgLndhaXRfc3RhdGXCoMKgwqAgwqDCoMKgID0gU1NQX01XSVJFX1dBSVRfWkVS
TywKwqDCoMKgIC5kdXBsZXjCoMKgwqAgwqDCoMKgIMKgwqDCoCA9IFNTUF9NSUNST1dJUkVfQ0hB
Tk5FTF9GVUxMX0RVUExFWCwKwqDCoMKgIC5jc19jb250cm9swqDCoMKgIMKgwqDCoCA9IHBoeTMy
NTBfc3BpMV9jc19zZXQsCn07CgoKS2VybmVsICgyLjYuMzQpIGlzIHVzaW5nIGRlZmF1bHQgMTAw
bXMgY29udGV4dCBzd2l0Y2guICcgQ09ORklHX0haPTEwMC4gJwoKQW55IGhlbHAgaXMgYXBwcmVj
aWF0ZWQuCgoKUmVnYXJkcywKUXVlbnRpbgo=
--0016361e834af15bc4048f00b04a
Content-Type: text/plain; charset=US-ASCII; name="TimingOnScope.txt"
Content-Disposition: attachment; filename="TimingOnScope.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gdgo1q3k0

ICAgfDwtLTIwdXMgMTF3b3Jkcy0tPnw8LS0gICAgODB1cyBkZWxheSAtLT58PC0tIE5leHQgMTEg
d29yZHMuLi4uICANCiAgICBfICAgXyAgICAgICAgXyAgIF8gICAgICAgICAgICAgICAgICAgICAg
IF8gICBfDQogICB8IHwgfCB8ICAuLi4gfCB8IHwgfCAgICAgICAgIC4uLi4uICAgICAgIHwgfCB8
IHwgLi4uLi4uLi4uLi4uLi4uDQpfX198IHxffCB8XyAgICBffCB8X3wgfF9fX19fX19fXyAgICAg
X19fX19fX3wgfF98IHxfDQogICAgICAgIA0KICAgICAgICANCiAgICAgICAgDQogICAgICAgIA==
--0016361e834af15bc4048f00b04a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Sell apps to millions through the Intel(R) Atom(Tm) Developer Program
Be part of this innovative community and reach millions of netbook users 
worldwide. Take advantage of special opportunities to increase revenue and 
speed time-to-market. Join now, and jumpstart your future.
http://p.sf.net/sfu/intel-atom-d2d
--0016361e834af15bc4048f00b04a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--0016361e834af15bc4048f00b04a--
