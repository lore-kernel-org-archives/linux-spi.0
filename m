From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 1/2] mtd: m25p80: get rid of spi_get_device_id
Date: Wed, 1 Oct 2014 11:43:03 -0700
Message-ID: <20141001184303.GX1193@ld-irv-0074>
References: <1411984074-3850-1-git-send-email-zajec5@gmail.com>
 <20141001182003.GB17974@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Andrew Lunn <andrew@lunn.ch>, David Woodhouse <David.Woodhouse@intel.com>,
 Artem Bityutskiy <dedekind1@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>,
 =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 linux-spi <linux-spi@vger.kernel.org>, linux-mtd@lists.infradead.org,
 Huang Shijie <shijie8@gmail.com>, Ian Campbell <ijc@hellion.org.uk>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 debian-kernel <debian-kernel@lists.debian.org>,
 Ben Hutchings <ben@decadent.org.uk>, linux-arm-kernel@lists.infradead.org,
 Jason Cooper <jason@lakedaemon.net>
To: Mark Brown <broonie@debian.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20141001182003.GB17974@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

T24gV2VkLCBPY3QgMDEsIDIwMTQgYXQgMDc6MjA6MDNQTSArMDEwMCwgTWFyayBCcm93biB3cm90
ZToKPiBPbiBNb24sIFNlcCAyOSwgMjAxNCBhdCAxMTo0Nzo1M0FNICswMjAwLCBSYWZhxYIgTWnF
gmVja2kgd3JvdGU6Cj4gPiBUaGlzIHNpbXBsaWZpZXMgdGhlIHdheSB3ZSB1c2Ugc3BpX25vciBm
cmFtZXdvcmsgYW5kIHdpbGwgYWxsb3cgdXMgdG8KPiA+IGRyb3Agc3BpX25vcl9tYXRjaF9pZC4K
PiAKPiBQbGVhc2UgZG9uJ3QgQ0MgbGludXgtc3BpIG9uIHNwaS1ub3IgcGF0Y2hlcyB0aGF0IGRv
bid0IGhhdmUgU1BJIGxldmVsCj4gY2hhbmdlcywgaXQganVzdCBjbG9ncyB1cCBwYXRjaHdvcmsu
CgorMSBmcm9tIG1lLiBJIGFwcHJlY2lhdGUgdGhlIGNvbnZlcnNlLCBhcyBJIGRvbid0IG5lZWQg
dW5yZWxhdGVkIG5vaXNlCm9uIGxpbnV4LW10ZC4KCihJIGZlZWwgc29ycnkgZm9yIHBlb3BsZSBv
dmVyIGF0IGxpbnV4LWFybS1rZXJuZWwgYW5kIGRldmljZXRyZWUsIHNpbmNlCnRoZXkgZ2V0IEND
J2Qgb24gYSBsYXJnZSB2YXJpZXR5IG9mIHVucmVsYXRlZCB0aGluZ3MsIGl0IHNlZW1zLiBJJ20g
c3VyZQp0aGUgZmlyZWhvc2UgZ2V0cyB0byBiZSBhbG1vc3QgYXMgYmFkIGFzIExLTUwgc29tZXRp
bWVzLikKCkJyaWFuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsCg==
