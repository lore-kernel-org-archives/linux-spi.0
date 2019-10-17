From: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v2 05/11] drm/tinydrm: Remove
 tinydrm_spi_max_transfer_size()
Date: Thu, 17 Oct 2019 09:58:35 +0300
Message-ID: <20191017065835.GZ32742@smile.fi.intel.com>
References: <20190719155916.62465-1-noralf@tronnes.org>
 <20190719155916.62465-6-noralf@tronnes.org>
 <20191015143236.GA5363@smile.fi.intel.com>
 <253aec49-e51c-b35b-4e7d-53a8a948655d@tronnes.org>
 <20191015155720.GQ11828@phenom.ffwll.local>
 <20191016161300.GW32742@smile.fi.intel.com>
 <CAKMK7uEp39uvLtgyTTj31u-GYVoPiVJDTVbUThtn7NU_EoKk3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: David Lechner <david@lechnology.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Mark Brown <broonie@kernel.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, Sam Ravnborg <sam@ravnborg.org>,
 Daniel Mack <daniel@zonque.org>
To: Daniel Vetter <daniel@ffwll.ch>
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <CAKMK7uEp39uvLtgyTTj31u-GYVoPiVJDTVbUThtn7NU_EoKk3A@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
List-Id: linux-spi.vger.kernel.org

T24gV2VkLCBPY3QgMTYsIDIwMTkgYXQgMDc6NDQ6NTFQTSArMDIwMCwgRGFuaWVsIFZldHRlciB3
cm90ZToKPiBPbiBXZWQsIE9jdCAxNiwgMjAxOSBhdCA2OjEzIFBNIEFuZHkgU2hldmNoZW5rbwo+
IDxhbmRyaXkuc2hldmNoZW5rb0BpbnRlbC5jb20+IHdyb3RlOgo+ID4gT24gVHVlLCBPY3QgMTUs
IDIwMTkgYXQgMDU6NTc6MjBQTSArMDIwMCwgRGFuaWVsIFZldHRlciB3cm90ZToKCj4gPiBtYXhf
dHJhbnNmZXJfc2l6ZSBzaG91bGQgYmUgYSBmdW5jdGlvbi4gSW4gdGhhdCBjYXNlIGl0IHdvcmtz
Lgo+IAo+IFdoeSBkbyB5b3Ugd2FudCB0byBtYWtlIGl0IGEgZnVuY3Rpb24/CgpNZT8hCgpjb21t
aXQgNGFjYWQ0YWFlMTBkMWZhNzlhMDc1YjM4YjVjNzM3NzJjNDRmNTc2YwpBdXRob3I6IE1pY2hh
bCBTdWNoYW5layA8aHJhbXJhY2hAZ21haWwuY29tPgpEYXRlOiAgIFdlZCBEZWMgMiAxMDozODoy
MSAyMDE1ICswMDAwCgogICAgc3BpOiBleHBvc2UgbWFzdGVyIHRyYW5zZmVyIHNpemUgbGltaXRh
dGlvbi4KCi0tIApXaXRoIEJlc3QgUmVnYXJkcywKQW5keSBTaGV2Y2hlbmtvCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcg
bGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
