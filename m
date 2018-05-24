From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 6/7] mtd: spi-nor: Use the spi_mem_xx() API
Date: Thu, 24 May 2018 09:43:27 +0200
Message-ID: <CAMuHMdX1QzEu9i6mpamzUth7VMfJVLJ_0TzVcess7UJ=YvCxRg@mail.gmail.com>
References: <20180426161820.2852-1-boris.brezillon@bootlin.com>
 <20180426161820.2852-7-boris.brezillon@bootlin.com>
 <6a39f071-186e-7009-994d-af845ce3f75d@microchip.com>
 <4ecb6215-699b-b714-cab5-cb237e883ec7@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, Vignesh R <vigneshr@ti.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-spi <linux-spi@vger.kernel.org>, Peter Pan <peterpansjtu@gmail.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>, Mark Brown <broonie@kernel.org>,
 MTD Maling List <linux-mtd@lists.infradead.org>,
 Kamal Dasu <kdasu.kdev@gmail.com>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Cyrille Pitchen <cyrille.pitchen@microchip.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <4ecb6215-699b-b714-cab5-cb237e883ec7@microchip.com>
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

SGkgQ3lyaWxsZSwKCk9uIFdlZCwgTWF5IDIzLCAyMDE4IGF0IDU6NTYgUE0sIEN5cmlsbGUgUGl0
Y2hlbgo8Y3lyaWxsZS5waXRjaGVuQG1pY3JvY2hpcC5jb20+IHdyb3RlOgo+IExlIDIzLzA1LzIw
MTggw6AgMTc6NDQsIEN5cmlsbGUgUGl0Y2hlbiBhIMOpY3JpdCA6Cj4+IExlIDI2LzA0LzIwMTgg
w6AgMTg6MTgsIEJvcmlzIEJyZXppbGxvbiBhIMOpY3JpdCA6Cj4+PiAgc3RhdGljIGludCBtMjVw
ODBfd3JpdGVfcmVnKHN0cnVjdCBzcGlfbm9yICpub3IsIHU4IG9wY29kZSwgdTggKmJ1ZiwgaW50
IGxlbikKPj4+ICB7Cj4+PiAgICAgIHN0cnVjdCBtMjVwICpmbGFzaCA9IG5vci0+cHJpdjsKPj4+
IC0gICAgc3RydWN0IHNwaV9kZXZpY2UgKnNwaSA9IGZsYXNoLT5zcGk7Cj4+PiAtCj4+PiAtICAg
IGZsYXNoLT5jb21tYW5kWzBdID0gb3Bjb2RlOwo+Pj4gLSAgICBpZiAoYnVmKQo+Pj4gLSAgICAg
ICAgICAgIG1lbWNweSgmZmxhc2gtPmNvbW1hbmRbMV0sIGJ1ZiwgbGVuKTsKPj4+ICsgICAgc3Ry
dWN0IHNwaV9tZW1fb3Agb3AgPSBTUElfTUVNX09QKFNQSV9NRU1fT1BfQ01EKG9wY29kZSwgMSks
Cj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTUElfTUVNX09QX05P
X0FERFIsCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTUElfTUVN
X09QX05PX0RVTU1ZLAo+Pgo+PiBJIGRpZG4ndCB0ZXN0IG5vciBjb21waWxlZCB0byB2ZXJpZnkg
YnV0IEkgaGF2ZSBzb21lIGRvdWJ0Ogo+PiBoZXJlIHRoZSAnb3AnIHZhcmlhYmxlIGlzIGFsbG9j
YXRlZCBvbiB0aGUgc3RhY2sgYW5kIGJvdGggZGVmaW5pdGlvbnMKPj4gb2YgU1BJX01FTV9PUF9O
T19BRERSIGFuZCBTUElfTUVNX09QX05PX0RVTU1ZIG1hY3JvcyBhcmUgeyB9Lgo+Pgo+PiBJdCBt
aWdodCBiZSBzb21lIHJ1bGUgb2YgdGhlIEMgbGFuZ3VhZ2UgdGhhdCBJIGlnbm9yZSBidXQgYXJl
IHdlIGd1YXJhbnRlZWQKPj4gdGhhdCB0aGUgLm5ieXRlcyBtZW1iZXIgb2YgYm90aCBzdHJ1Y3R1
cmVzIGlzIGFjdHVhbGx5IGluaXRpYWxpemVkIHRvIDAgPwo+Pgo+PiBJIHdvdWxkIHNheSBubzog
SSB0aGluayBzaW5jZSB0aGUgc3RydWN0dXJlIGlzIGFsbG9jYXRlZCBvbiB0aGUgc3RhY2sgYWxs
Cj4+IG1lbWJlcnMgbm90IGJlaW5nIGV4cGxpY2l0bHkgaW5pdGlhbGl6ZWQgYXJlIGxlZnQgdW5p
bml0aWFsaXplZCBieSB0aGUKPj4gY29tcGlsZXIgd2hlbiBpdCBnZW5lcmF0ZXMgdGhlIGFzc2Vt
YmxlciBjb2RlLiBIb3dldmVyLCBJJ20gbm90IDEwMCUgc3VyZSBvZgo+PiB0aGF0Lgo+Cj4gQWN0
dWFsbHksIEknbSByZWFkaW5nIHRoYXQgd2l0aCBDOTkgZXh0ZW5zaW9ucywgIm9taXR0ZWQgZmll
bGQgbWVtYmVycyBhcmUKPiBpbXBsaWNpdGx5IGluaXRpYWxpemVkIHRoZSBzYW1lIGFzIG9iamVj
dHMgdGhhdCBoYXZlIHN0YXRpYyBzdG9yYWdlIGR1cmF0aW9uLiIKPiBodHRwczovL2djYy5nbnUu
b3JnL29ubGluZWRvY3MvZ2NjL0Rlc2lnbmF0ZWQtSW5pdHMuaHRtbAoKSkZUUiwgb21pdHRlZCBm
aWVsZCBtZW1iZXJzIGFyZS4KQnV0IElJUkMsIGltcGxpY2l0IGdhcHMgZHVlIHRvIGFsaWdubWVu
dCBydWxlcyBhcmVuJ3QsIHdoaWNoIG1vc3RseSBtYXR0ZXJzCmZvciBsZWFraW5nIHJhbmRvbSBk
YXRhIHRvIHVzZXJzcGFjZS4KCkdye29ldGplLGVldGluZ31zLAoKICAgICAgICAgICAgICAgICAg
ICAgICAgR2VlcnQKCi0tIApHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExp
bnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnCgpJbiBwZXJzb25hbCBjb252
ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4g
QnV0CndoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1l
ciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAtLSBMaW51cyBUb3J2YWxkcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4IE1URCBkaXNjdXNzaW9uIG1haWxpbmcgbGlzdApodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW10ZC8K
