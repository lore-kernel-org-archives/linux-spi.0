From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH v4 5/5] mtd: m25p80: add support to parse the
	partitions by OF node
Date: Sat, 16 Oct 2010 22:17:27 +0300
Message-ID: <1287256647.1781.34.camel@brekeke>
References: <1286878714-13090-1-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-2-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-3-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-4-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-5-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-6-git-send-email-Mingkai.hu@freescale.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: david-b@pacbell.net, kumar.gala@freescale.com, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org, spi-devel-general@lists.sourceforge.net
To: Mingkai Hu <Mingkai.hu@freescale.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1286878714-13090-6-git-send-email-Mingkai.hu@freescale.com>
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

T24gVHVlLCAyMDEwLTEwLTEyIGF0IDE4OjE4ICswODAwLCBNaW5na2FpIEh1IHdyb3RlOgo+IFNp
Z25lZC1vZmYtYnk6IE1pbmdrYWkgSHUgPE1pbmdrYWkuaHVAZnJlZXNjYWxlLmNvbT4KPiBBY2tl
ZC1ieTogR3JhbnQgTGlrZWx5IDxncmFudC5saWtlbHlAc2VjcmV0bGFiLmNhPgo+IC0tLQo+IHY0
Ogo+ICAtIFVwZGF0ZWQgdG8gbGF0ZXN0IGtlcm5lbCBiYXNlKExpbnV4IDIuNi4zNi1yYzcpLgo+
ICAtIE1hZGUgY2hhbmdlcyBhY2NvcmRpbmcgdG8gR3JhbnQncyBjb21tZW50cy4KCkxvb2tzIGdv
b2QgdG8gbWUsIHB1c2hlZCB0byBsMi1tdGQtMi42LmdpdCwgdGhhbmtzLgoKLS0gCkJlc3QgUmVn
YXJkcywKQXJ0ZW0gQml0eXV0c2tpeSAo0JHQuNGC0Y7RhtC60LjQuSDQkNGA0YLRkdC8KQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMtZGV2
IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xpc3Rz
Lm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2
