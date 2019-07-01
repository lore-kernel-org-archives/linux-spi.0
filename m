From: "Sa, Nuno" <Nuno.Sa@analog.com>
Subject: Re: [PATCH] spi: spi-bcm2835.c: Fix 3-wire mode
Date: Mon, 1 Jul 2019 14:21:21 +0000
Message-ID: <42a533cbf1e47ab8c8a44c5e865ec15193a2e956.camel@analog.com>
References: <20190628123023.4696-1-nuno.sa@analog.com>
 <1b932c61-982b-aae0-1fef-3c574e7d17eb@gmx.net>
 <20190628190022.vya4h2lihm6x2xpb@wunner.de>
 <54323339606a36febc6a8633a8d3a7db84b975c4.camel@analog.com>
 <20190701115506.42rr4o4hbuvwytjc@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
 "sbranden@broadcom.com" <sbranden@broadcom.com>,
 "rjui@broadcom.com" <rjui@broadcom.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "eric@anholt.net" <eric@anholt.net>, "broonie@kernel.org" <broonie@kernel.org>,
 "bcm-kernel-feedback-list@broadcom.com"
 <bcm-kernel-feedback-list@broadcom.com>, "wahrenst@gmx.net" <wahrenst@gmx.net>,
 "kernel@martin.sperl.org" <kernel@martin.sperl.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-rpi-kernel@lists.infradead.org" <linux-rpi-kernel@lists.infradead.org>
To: "lukas@wunner.de" <lukas@wunner.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190701115506.42rr4o4hbuvwytjc@wunner.de>
Content-Language: en-US
Content-ID: <8396F84502FD1D4AABB8932E32F898B0@namprd03.prod.outlook.com>
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

T24gTW9uLCAyMDE5LTA3LTAxIGF0IDEzOjU1ICswMjAwLCBMdWthcyBXdW5uZXIgd3JvdGU6DQo+
IEkgc2VlLiAgSW4gdGhhdCBjYXNlLCB0cnk6DQo+IA0KPiAgCS8qIGhhbmRsZSBhbGwgdGhlIDMt
d2lyZSBtb2RlICovDQo+IC0JaWYgKChzcGktPm1vZGUgJiBTUElfM1dJUkUpICYmICh0ZnItPnJ4
X2J1ZikpDQo+ICsJaWYgKChzcGktPm1vZGUgJiBTUElfM1dJUkUpICYmICh0ZnItPnJ4X2J1ZiAh
PSBjdGxyLT5kdW1teV9yeCkpDQo+ICAJCWNzIHw9IEJDTTI4MzVfU1BJX0NTX1JFTjsNCj4gIAll
bHNlDQo+ICAJCWNzICY9IH5CQ00yODM1X1NQSV9DU19SRU47DQo+IA0KDQpUaGlzIHdvcmtlZCBm
aW5lLiBBbHNvLCBJIGRpZCBhIHF1aWNrIGJhY2twb3J0IG9mIHRoZSBzdGF0ZSBvZiB5b3VyDQpk
cml2ZXIncyAoYm90aCBzcGktYmNtMjgzNSBhbmQgYmNtMjgzNS1kbWEpIGluIHJldnBpX3N0YWdp
bmcgYW5kIGl0DQphbHNvIHdvcmtlZCBmaW5lIHdpdGggbXkgZGV2aWNlLg0KU28sIGFzIGZhciBh
cyBJIHVuZGVyc3RhbmQsIHRoZSBhYm92ZSBzdWdnZXN0aW9uIChvciBteSBwYXRjaCkgaXMgbm90
DQppbnRlbmRlZCB0byBiZSB1cHN0cmVhbWVkLCByaWdodD8gSXQgaXMganVzdCBhIHRlbXBvcmFy
eSBmaXggdGhhdCBJIGNhbg0KdXNlIHdoaWxlIHlvdXIgcGF0Y2hzZXQgZ2V0cyB1cHN0cmVhbS4N
Cg0KVGhhbmtzIGZvciB5b3VyIGhlbHAhDQpOdW5vIFPDoQ0KDQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
