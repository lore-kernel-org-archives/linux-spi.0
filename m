From: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] arm: mvebu: Add SPI flash on Armada XP-GP board
Date: Tue, 5 Feb 2013 16:46:10 -0300
Message-ID: <20130205194609.GA3670@localhost>
References: <1360063473-26176-1-git-send-email-ezequiel.garcia@free-electrons.com>
	<20130205123827.GG20242@lunn.ch>
	<20130205124833.GS14746@titan.lakedaemon.net>
	<20130205142720.GB2481@localhost>
	<20130205153135.GU14746@titan.lakedaemon.net>
	<20130205171701.4fcb1304@skate>
	<51113132.6000500@free-electrons.com>
	<20130205180705.5231effd@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130205180705.5231effd@skate>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

T24gVHVlLCBGZWIgMDUsIDIwMTMgYXQgMDY6MDc6MDVQTSArMDEwMCwgVGhvbWFzIFBldGF6em9u
aSB3cm90ZToKPiBEZWFyIEdyZWdvcnkgQ0xFTUVOVCwKPiAKPiBPbiBUdWUsIDA1IEZlYiAyMDEz
IDE3OjIwOjAyICswMTAwLCBHcmVnb3J5IENMRU1FTlQgd3JvdGU6Cj4gCj4gPiBTbyB0aGF0IG1l
YW5zIHdlIHNob3VsZCBlbmFibGUgdGhlIGRyaXZlcnMgZm9yIGFsbCB0aGUgZGV2aWNlcyBwcmVz
ZW50Cj4gPiBvbiBhbGwgdGhlIGJvYXJkcz8KPiAKPiBZZXMuIEZvciBleGFtcGxlIG15IG12c2Rp
byBwYXRjaCBzZXQgZW5hYmxlcyBzb21lIFdpZmkgZHJpdmVyIHRoYXQKPiBjb3JyZXNwb25kcyB0
byBhIHBhcnRpY3VsYXIgU0RJTyBXaWZpIGRldmljZSB0aGF0IGlzIHByZXNlbnQgaW4gdGhlCj4g
TWlyYWJveC4gQnV0IG5vdCBvbiBvdGhlciBib2FyZHMuCj4gCgpPa2V5LCBJJ2xsIGFkZCBldmVy
eXRoaW5nIG5lZWRlZCB0byBhY2Nlc3MgYW5kIHRlc3QgdGhlIFNQSSBmbGFzaCwKaW5jbHVkaW5n
IE1URF9DSEFSLgoKVGhhbmtzLAoKLS0gCkV6ZXF1aWVsIEdhcmPDrWEsIEZyZWUgRWxlY3Ryb25z
CkVtYmVkZGVkIExpbnV4LCBLZXJuZWwgYW5kIEFuZHJvaWQgRW5naW5lZXJpbmcKaHR0cDovL2Zy
ZWUtZWxlY3Ryb25zLmNvbQoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkZyZWUgTmV4dC1HZW4gRmly
ZXdhbGwgSGFyZHdhcmUgT2ZmZXIKQnV5IHlvdXIgU29waG9zIG5leHQtZ2VuIGZpcmV3YWxsIGJl
Zm9yZSB0aGUgZW5kIE1hcmNoIDIwMTMgCmFuZCBnZXQgdGhlIGhhcmR3YXJlIGZvciBmcmVlISBM
ZWFybiBtb3JlLgpodHRwOi8vcC5zZi5uZXQvc2Z1L3NvcGhvcy1kMmQtZmViCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCnNwaS1kZXZlbC1nZW5lcmFsIG1h
aWxpbmcgbGlzdApzcGktZGV2ZWwtZ2VuZXJhbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6
Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vc3BpLWRldmVsLWdlbmVyYWwK
