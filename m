From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] spi: fsl-spi: Allow dynamic allocation of CPM1
 parameter RAM
Date: Fri, 3 Oct 2014 15:24:18 -0500
Message-ID: <1412367858.13320.432.camel@snotra.buserror.net>
References: <20141003125609.5BEA11AB276@localhost.localdomain>
 <20141003144420.GC24441@sirena.org.uk> <542F03CF.8010900@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
To: christophe leroy <christophe.leroy@c-s.fr>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <542F03CF.8010900@c-s.fr>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Id: linux-spi.vger.kernel.org

T24gRnJpLCAyMDE0LTEwLTAzIGF0IDIyOjE1ICswMjAwLCBjaHJpc3RvcGhlIGxlcm95IHdyb3Rl
Ogo+IExlIDAzLzEwLzIwMTQgMTY6NDQsIE1hcmsgQnJvd24gYSDDqWNyaXQgOgo+ID4gT24gRnJp
LCBPY3QgMDMsIDIwMTQgYXQgMDI6NTY6MDlQTSArMDIwMCwgQ2hyaXN0b3BoZSBMZXJveSB3cm90
ZToKPiA+Cj4gPj4gK2NvbmZpZyBDUE0xX1JFTE9DU1BJCj4gPj4gKwlib29sICJEeW5hbWljIFNQ
SSByZWxvY2F0aW9uIgo+ID4+ICsJZGVmYXVsdCBuCj4gPj4gKwloZWxwCj4gPj4gKwkgIE9uIHJl
Y2VudCBNUEM4eHggKGF0IGxlYXN0IE1QQzg2NiBhbmQgTVBDODg1KSBTUEkgY2FuIGJlIHJlbG9j
YXRlZAo+ID4+ICsJICB3aXRob3V0IG1pY3JvcGF0Y2guIFRoaXMgYWN0aXZhdGVzIHJlbG9jYXRp
b24gdG8gYSBkeW5hbWljYWxseQo+ID4+ICsJICBhbGxvY2F0ZWQgYXJlYSBpbiB0aGUgQ1BNIER1
YWwgcG9ydCBSQU0uCj4gPj4gKwkgIFdoZW4gY29tYmluZWQgd2l0aCBTUEkgcmVsb2NhdGlvbiBw
YXRjaCAoZm9yIG9sZGVyIE1QQzh4eCkgaXQgYXZvaWRzCj4gPj4gKwkgIHRoZSAibG9zcyIgb2Yg
YWRkaXRpb25hbCBEdWFsIHBvcnQgUkFNIHNwYWNlIGp1c3QgYWJvdmUgdGhlIHBhdGNoLAo+ID4+
ICsJICB3aGljaCBtaWdodCBiZSBuZWVkZWQgZm9yIGV4YW1wbGUgd2hlbiB1c2luZyB0aGUgQ1BN
IFFNQy4KPiA+IFNvbWV0aGluZyBsaWtlIHRoaXMgc2hvdWxkbid0IGJlIGEgY29tcGlsZSB0aW1l
IG9wdGlvbi4gIEVpdGhlciBpdAo+ID4gc2hvdWxkIGJlIHVuY29uZGl0aW9uYWwgb3IgaXQgc2hv
dWxkIGJlIHRyaWdnZXJlZCBpbiBzb21lIHN5c3RlbQo+ID4gc3BlY2lmaWMgbWFubmVyIChmcm9t
IERULCBmcm9tIGtub3dpbmcgYWJvdXQgb3RoZXIgdXNlcnMgb3Igc2ltaWxhcikuCj4gQ2FuJ3Qg
YmUgdW5jb25kaXRpb25hbCBhcyBvbGRlciB2ZXJzaW9ucyBvZiBtcGM4eHggKGVnIE1QQzg2MCkg
ZG9uJ3QgCj4gc3VwcG9ydCByZWxvY2F0aW9uIHdpdGhvdXQgYSBtaWNyb3BhdGNoLgo+IEkgaGF2
ZSB0aGVyZWZvcmUgc3VibWl0dGVkIGEgdjIgYmFzZWQgb24gYSBEVFMgY29tcGF0aWJsZSBwcm9w
ZXJ0eS4KClNvIHRoZSBkZXZpY2UgdHJlZSBjaGFuZ2UgaXMgYWJvdXQgd2hldGhlciByZWxvY2F0
aW9uIGlzIHN1cHBvcnRlZCwgbm90CndoZXRoZXIgaXQgaXMgcmVxdWlyZWQ/ICBJcyB0aGlzIHNw
ZWNpZmljIHRvIFNQSSBvciBkb2VzIHRoZSByZWxvY2F0aW9uCm1lY2hhbmlzbSB3b3JrIGZvciBv
dGhlciB0aGluZ3M/CgpIb3cgYWJvdXQgY2hlY2tpbmcgZm9yIHRoZSBleGlzdGluZyBzcGVjaWZp
Yy1Tb0MgY29tcGF0aWJsZXM/CgotU2NvdHQKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eHBwYy1kZXYgbWFpbGluZyBsaXN0CkxpbnV4cHBjLWRl
dkBsaXN0cy5vemxhYnMub3JnCmh0dHBzOi8vbGlzdHMub3psYWJzLm9yZy9saXN0aW5mby9saW51
eHBwYy1kZXY=
