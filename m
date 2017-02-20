From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v4 1/2] mtd: spi-nor: Added spi-nor init function
Date: Mon, 20 Feb 2017 09:15:34 +0100
Message-ID: <c2212635-69ae-5d47-3356-2ec8e24f5457@denx.de>
References: <1487086368-4118-1-git-send-email-kdasu.kdev@gmail.com>
 <1487086368-4118-2-git-send-email-kdasu.kdev@gmail.com>
 <CACna6rzV3xNSyGGmDvTvbfMVp=iAZdXBQpniKFULKOtBW_6aow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 linux-spi <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 Cyrille Pitchen <cyrille.pitchen@atmel.com>
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Kamal Dasu <kdasu.kdev@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <CACna6rzV3xNSyGGmDvTvbfMVp=iAZdXBQpniKFULKOtBW_6aow@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

T24gMDIvMjAvMjAxNyAwOToxMiBBTSwgUmFmYcWCIE1pxYJlY2tpIHdyb3RlOgo+IE9uIDE0IEZl
YnJ1YXJ5IDIwMTcgYXQgMTY6MzIsIEthbWFsIERhc3UgPGtkYXN1LmtkZXZAZ21haWwuY29tPiB3
cm90ZToKPj4gUmVmYWN0b3JlZCBzcGlfbm9yX3NjYW4oKSBjb2RlIHRvIGFkZCBzcGlfbm9yX2lu
aXQoKSBmdW5jdGlvbiB0aGF0Cj4+IHByb2dyYW1zIHRoZSBzcGktbm9yIGZsYXNoIHRvOgo+PiAx
KSByZW1vdmUgZmxhc2ggcHJvdGVjdGlvbiBpZiBhcHBsaWNhYmxlCj4+IDIpIHNldCByZWFkIG1v
ZGUgdG8gcXVhZCBtb2RlIGlmIGNvbmZpZ3VyZWQgc3VjaAo+PiAzKSBzZXQgdGhlIGFkZHJlc3Mg
d2lkdGggYmFzZWQgb24gdGhlIGZsYXNoIHNpemUgYW5kIHZlbmRvcgo+Pgo+PiBzcGlfbm9yX3Nj
YW4oKSBub3cgY2FsbHMgc3BpX25vcl9pbml0KCkgdG8gc2V0dXAgbm9yIGZsYXNoLgo+Pgo+PiBT
aWduZWQtb2ZmLWJ5OiBLYW1hbCBEYXN1IDxrZGFzdS5rZGV2QGdtYWlsLmNvbT4KPiAKPiBJZGVh
bGx5IGEgc2hvcnQgcmVhc29uIGluZm8gc2hvdWxkIGdvIHRoZXJlLgo+ICJUaGlzIGFsbG93cyBy
ZXVzaW5nIHNwaV9ub3JfaW5pdCBkdXJpbmcgcmVzdW1lIgo+IG9yIHdoYXRldmVyIDopCj4gCkl0
IHJlaW5pdHMgdGhlIFNQSSBOT1IgKGlmIEkgdW5kZXJzdGFuZCBpdCBjb3JyZWN0bHkpLiBCZWlu
ZyBhYmxlIHRvIHVzZQppdCBvbiBzb21lIGJvYXJkcyBhZnRlciByZXN1bWUgaXMgYSBzaWRlLWVm
ZmVjdCwgc28gaXQgc2hvdWxkIGJlIGxpc3RlZAphcyBzdWNoLgoKLS0gCkJlc3QgcmVnYXJkcywK
TWFyZWsgVmFzdXQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eCBNVEQgZGlzY3Vzc2lvbiBtYWlsaW5nIGxpc3QKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1tdGQvCg==
