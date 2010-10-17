From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH v4 5/5] mtd: m25p80: add support to parse the
	partitions by OF node
Date: Sun, 17 Oct 2010 10:44:50 +0300
Message-ID: <1287301490.1951.0.camel@localhost>
References: <1286878714-13090-1-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-2-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-3-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-4-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-5-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-6-git-send-email-Mingkai.hu@freescale.com>
	<1287256647.1781.34.camel@brekeke>
	<AANLkTimr03KAKnz5sfwm19=KzB-ik95WM_qQO0YP9qVs@mail.gmail.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: kumar.gala@freescale.com, david-b@pacbell.net, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org, spi-devel-general@lists.sourceforge.net,
	Mingkai Hu <Mingkai.hu@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <AANLkTimr03KAKnz5sfwm19=KzB-ik95WM_qQO0YP9qVs@mail.gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org

T24gU2F0LCAyMDEwLTEwLTE2IGF0IDE5OjA1IC0wNjAwLCBHcmFudCBMaWtlbHkgd3JvdGU6Cj4g
T24gU2F0LCBPY3QgMTYsIDIwMTAgYXQgMToxNyBQTSwgQXJ0ZW0gQml0eXV0c2tpeSA8ZGVkZWtp
bmQxQGdtYWlsLmNvbT4gd3JvdGU6Cj4gPiBPbiBUdWUsIDIwMTAtMTAtMTIgYXQgMTg6MTggKzA4
MDAsIE1pbmdrYWkgSHUgd3JvdGU6Cj4gPj4gU2lnbmVkLW9mZi1ieTogTWluZ2thaSBIdSA8TWlu
Z2thaS5odUBmcmVlc2NhbGUuY29tPgo+ID4+IEFja2VkLWJ5OiBHcmFudCBMaWtlbHkgPGdyYW50
Lmxpa2VseUBzZWNyZXRsYWIuY2E+Cj4gPj4gLS0tCj4gPj4gdjQ6Cj4gPj4gIC0gVXBkYXRlZCB0
byBsYXRlc3Qga2VybmVsIGJhc2UoTGludXggMi42LjM2LXJjNykuCj4gPj4gIC0gTWFkZSBjaGFu
Z2VzIGFjY29yZGluZyB0byBHcmFudCdzIGNvbW1lbnRzLgo+ID4KPiA+IExvb2tzIGdvb2QgdG8g
bWUsIHB1c2hlZCB0byBsMi1tdGQtMi42LmdpdCwgdGhhbmtzLgo+IAo+IFdhaXQhICBJdCB3aWxs
IGJyZWFrIHdoZW5ldmVyIENPTkZJR19PRiBpcyBub3Qgc2V0LiAgSSBicm9rZQo+IGxpbnV4LW5l
eHQgd2l0aCB0aGlzIHBhdGNoLiAgSXQgY2FuIGJlIHNvbHZlZCBieSB3cmFwcGluZyB0aGUgYmxv
Y2sKPiB3aXRoICNpZmRlZiBDT05GSUdfT0YsIGJ1dCBJJ2QgbGlrZSB0byBmaW5kIGEgYmV0dGVy
IHNvbHV0aW9uLgoKT0ssIHJlbW92ZWQuCgotLSAKQmVzdCBSZWdhcmRzLApBcnRlbSBCaXR5dXRz
a2l5ICjQkNGA0YLRkdC8INCR0LjRgtGO0YbQutC40LkpCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eHBwYy1kZXYgbWFpbGluZyBsaXN0CkxpbnV4
cHBjLWRldkBsaXN0cy5vemxhYnMub3JnCmh0dHBzOi8vbGlzdHMub3psYWJzLm9yZy9saXN0aW5m
by9saW51eHBwYy1kZXY=
