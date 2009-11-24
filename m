From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 7/8] spi_mpc8xxx: Turn qe_mode into flags
Date: Tue, 24 Nov 2009 18:41:45 +0300
Message-ID: <20091124154145.GA23040@oksana.dev.rtsoft.ru>
References: <20091012164841.GA32214@oksana.dev.rtsoft.ru>
	<20091012164925.GG4578@oksana.dev.rtsoft.ru>
	<3E303C4F-CE29-470F-B34A-3413F31BC23C@kernel.crashing.org>
	<1259039016.16367.118.camel@pasglop>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <1259039016.16367.118.camel@pasglop>
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

T24gVHVlLCBOb3YgMjQsIDIwMDkgYXQgMDQ6MDM6MzZQTSArMTEwMCwgQmVuamFtaW4gSGVycmVu
c2NobWlkdCB3cm90ZToKWy4uLl0KPiBUaGlzIHBhdGNoIGJyZWFrcyBteSA2eHggY29uZmlnOgo+
IAo+IC9ob21lL2JlbmgvbGludXgtcG93ZXJwYy10ZXN0L2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMv
ODN4eC9tcGM4MzJ4X3JkYi5jOiBJbiBmdW5jdGlvbiDigJhvZl9mc2xfc3BpX3Byb2Jl4oCZOgo+
IC9ob21lL2JlbmgvbGludXgtcG93ZXJwYy10ZXN0L2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvODN4
eC9tcGM4MzJ4X3JkYi5jOjc3OiBlcnJvcjog4oCYc3RydWN0IGZzbF9zcGlfcGxhdGZvcm1fZGF0
YeKAmSBoYXMgbm8gbWVtYmVyIG5hbWVkIOKAmHFlXwo+IAo+IFRoZSByZWFzb24gaXMgdGhhdCB0
aGUgbXBjODMyeF9yZGIuYyBjb2RlIHN0aWxsIHVzZXMgdGhlIGxlZ2FjeSBwcm9iaW5nCj4gbWV0
aG9kLiBUaGUgZml4IGlzIG5vdCB0b3RhbGx5IHRyaXZpYWwgYXMgdGhlIG5ldyBmbGFncyBhcmUg
ZGVmaW5lZCBpbnNpZGUKPiBzcGlfbXBjOHh4eC5jCgpUaGFua3MgZm9yIG5vdGljaW5nLiBJIGlu
ZGVlZCBmb3Jnb3QgYWJvdXQgdGhlIGxlZ2FjeSBzdHVmZi4gOi0vCgo+IElmIHlvdSBhcmUgZ29p
bmcgdG8ga2VlcCB0aGUgZmxhZ3MgaW4gdGhlIC5jIGZpbGUgeW91IHByb2JhYmx5IGFsc28gd2Fu
dAo+IHRvIHJlbW92ZSB0aGUgcGxhdGZvcm0gZGV2aWNlIGRlZmluaXRpb24gZnJvbSBmc2xfZGV2
aWNlcy5oIGFueXdheXMgYXMKPiB0aGVyZSdzIG5vIHBvaW50IGV4cG9zaW5nIHRvIHRoZSB3b3Js
ZCBhIHN0cnVjdHVyZSB3aXRoIGEgImZsYWdzIiBtZW1iZXIKPiBpZiB0aGUgZGVmaW5pdGlvbiBv
ZiB0aG9zZSBmbGFncyBpc24ndCBhbHNvIGV4cG9zZWQuCgpZZXAuIFRob3VnaCwgSUlSQyBKb2Fr
aW0gYXNrZWQgdG8ga2VlcCB0aGUgbGVnYWN5IGJpbmRpbmdzIGZvciBzb21lCnRpbWUgKHVudGls
IHdlIGltcGxlbWVudCBTUEkgY2hpcC1zZWxlY3QgZnJhbWV3b3JrPykuLi4gc28gZm9yIG5vdwp3
ZSdsbCBoYXZlIHRvIGxlYXZlIHdlIHRoZSBleHBvc2VkIGZsYWdzLgoKVGhhbmtzIGFnYWluLAoK
LS0gCkFudG9uIFZvcm9udHNvdgplbWFpbDogY2JvdWF0bWFpbHJ1QGdtYWlsLmNvbQppcmM6Ly9p
cmMuZnJlZW5vZGUubmV0L2JkMgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eHBwYy1kZXYgbWFpbGluZyBsaXN0CkxpbnV4cHBjLWRldkBsaXN0cy5v
emxhYnMub3JnCmh0dHBzOi8vbGlzdHMub3psYWJzLm9yZy9saXN0aW5mby9saW51eHBwYy1kZXY=
