From: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 4/4] ARM: mvebu: Update defconfig to select SPI flash
 and MTD support
Date: Sat, 16 Feb 2013 14:34:47 -0300
Message-ID: <20130216173445.GA3440@localhost>
References: <1360155984-15397-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1360155984-15397-5-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130216150228.GR14746@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
 devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
 Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130216150228.GR14746-u4khhh1J0LxI1Ri9qeTfzeTW4wlIGRCZ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-spi.vger.kernel.org

SGkgSmFzb24sCgpPbiBTYXQsIEZlYiAxNiwgMjAxMyBhdCAxMDowMjoyOEFNIC0wNTAwLCBKYXNv
biBDb29wZXIgd3JvdGU6Cj4gT24gV2VkLCBGZWIgMDYsIDIwMTMgYXQgMTA6MDY6MjRBTSAtMDMw
MCwgRXplcXVpZWwgR2FyY2lhIHdyb3RlOgo+ID4gVGhlIEFybWFkYSBYUCBEQi1NVjc4NE1QLUdQ
IGJvYXJkIGhhcyBhbiBTUEkgZmxhc2ggZGV2aWNlLgo+ID4gVGhlc2Ugb3B0aW9ucyBhbGxvdyB0
byBhY2Nlc3MgdGhhdCBkZXZpY2Ugb3ZlciBNVEQuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IEV6
ZXF1aWVsIEdhcmNpYSA8ZXplcXVpZWwuZ2FyY2lhQGZyZWUtZWxlY3Ryb25zLmNvbT4KPiA+IC0t
LQo+ID4gRGVwZW5kcyBvbiBwYXRjaDogImFybTogbXZlYnU6IGkyYyBjb21lIGJhY2sgaW4gZGVm
Y29uZmlnIgo+ID4gCj4gPiAgYXJjaC9hcm0vY29uZmlncy9tdmVidV9kZWZjb25maWcgfCAgICAz
ICsrKwo+ID4gIDEgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygt
KQo+IAo+IEFwcGxpZWQgdG8gbXZlYnUvYm9hcmRzCj4gCgpHcmVhdCEKCkFyZSB3ZSBzdGlsbCBp
biB0aW1lIGZvciBhIHB1bGwgcmVxdWVzdCBmb3IgdjMuOQp3aXRoIGFsbCBvZiB0aGVzZSBzdHVm
Zj8KClRoYW5rcyBhIGxvdCwKLS0gCkV6ZXF1aWVsIEdhcmPDrWEsIEZyZWUgRWxlY3Ryb25zCkVt
YmVkZGVkIExpbnV4LCBLZXJuZWwgYW5kIEFuZHJvaWQgRW5naW5lZXJpbmcKaHR0cDovL2ZyZWUt
ZWxlY3Ryb25zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpkZXZpY2V0cmVlLWRpc2N1c3MgbWFpbGluZyBsaXN0CmRldmljZXRyZWUtZGlzY3Vzc0Bs
aXN0cy5vemxhYnMub3JnCmh0dHBzOi8vbGlzdHMub3psYWJzLm9yZy9saXN0aW5mby9kZXZpY2V0
cmVlLWRpc2N1c3MK
