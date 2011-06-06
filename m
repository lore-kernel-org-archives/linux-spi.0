From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] spi: reorganize drivers
Date: Mon, 6 Jun 2011 12:01:37 +0200
Message-ID: <BANLkTim_hZJ=eBRcGqG89-3OjQ_NB0xECQ@mail.gmail.com>
References: <20110605071725.26517.11573.stgit@ponder>
	<201106061100.38249.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Russell King <linux@arm.linux.org.uk>,
	Michael Buesch <mb@bu3sch.de>, linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org, Florian Fainelli <florian@openwrt.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Alexandre Bounine <alexandre.bounine@idt.com>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	"Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>,
	"Jean Delvare \(PC drivers, core\)" <khali@linux-fr.org>,
	spi-devel-general@lists.sourceforge.net,
	Matt Porter <mporter@kernel.crashing.org>,
	"David S. Miller" <davem@davemloft.net>
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
In-Reply-To: <201106061100.38249.arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-pcmcia/>
List-Post: <mailto:linux-pcmcia@lists.infradead.org>
List-Help: <mailto:linux-pcmcia-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=subscribe>
Sender: linux-pcmcia-bounces@lists.infradead.org
Errors-To: linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

T24gTW9uLCBKdW4gNiwgMjAxMSBhdCAxMTowMCwgQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5k
ZT4gd3JvdGU6Cj4gSSByZWNlbnRseSBsb29rZWQgYXQgdGhlIGRpcmVjdG9yeSBzdHJ1Y3R1cmUg
aW4gZHJpdmVycy8gYW5kIGZvdW5kIGEgbG90Cj4gb2YgYnVzIGRyaXZlcnMgd2l0aCB2ZXJ5IGZl
dyBmaWxlcywgcGx1cyBhIGZldyBidXMgZHJpdmVycyB3aXRoIGEgbG90Cj4gb2YgZmlsZXMgaW4g
dGhlbSBiZXNpZGVzIGRpcmVjdG9yaWVzIGZvciBub24tYnVzIHNwZWNpZmljIHN1YnN5c3RlbXMu
Cj4KPiBJIHRoaW5rIGl0IHdvdWxkIGJlIGdvb2QgdG8gbW92ZSB0aGVtIGludG8gYSBkZWVwZXIg
ZGlyZWN0b3J5IGRyaXZlcnMvYnVzLwo+IGlmIHdlIGhhdmUgc3VwcG9ydCBmcm9tIHRoZSBtYWlu
dGFpbmVycywgYW5kIGl0J3MgcHJvYmFibHkgYmV0dGVyIGlmIHdlCj4gb25seSBoYXZlIHRvIG1v
dmUgdGhlIGZpbGVzIG9uY2UgdG8gcmVkdWNlIHRoZSBhbW91bnQgb2YgY2h1cm4gb24gdGhlCj4g
TUFJTlRBSU5FUlMgZmlsZSBhbmQgYW55IG91dCBvZiB0cmVlIHBhdGNoZXMuCj4KPiBTcGVjaWZp
Y2FsbHksIEknZCBsaWtlIHRvIGRvIHRoZXNlIG1vdmVzOgo+Cj4gZHJpdmVycy97ID0+IGJ1c30v
em9ycm8KCihpZiB3ZSBnbyB0aGF0IHdheSBpbiBnZW5lcmFsKQoKQWNrZWQtYnk6IEdlZXJ0IFV5
dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+CgpHcntvZXRqZSxlZXRpbmd9cywKCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEdlZXJ0CgotLQpHZWVydCBVeXR0ZXJo
b2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4
LW02OGsub3JnCgpJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3Bs
ZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0CndoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5h
bGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDCoMKgIC0tIExpbnVzIFRv
cnZhbGRzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eCBQQ01DSUEgcmVpbXBsZW1lbnRhdGlvbiBsaXN0Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcGNtY2lhCg==
