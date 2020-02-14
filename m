From: "Srivastava, Shobhit" <shobhit.srivastava@intel.com>
Subject: RE: Re: [PATCH] spi: pxa2xx: Add CS control clock quirk
Date: Fri, 14 Feb 2020 06:26:42 +0000
Message-ID: <CB4ED07B85D6BB40B8B44F6D5442E4F6572C38D7@BGSMSX101.gar.corp.intel.com>
References: <CB4ED07B85D6BB40B8B44F6D5442E4F6572C1523@BGSMSX101.gar.corp.intel.com>
 <20200213171836.GD10400@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Rajat Jain <rajatja@google.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "Mark Brown" <broonie@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        "rajatxjain@gmail.com" <rajatxjain@gmail.com>,
        "evgreen@google.com" <evgreen@google.com>,
        "Muthukrishnan, Porselvan" <porselvan.muthukrishnan@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200213171836.GD10400@smile.fi.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

PiANCj4gT24gVGh1LCBGZWIgMTMsIDIwMjAgYXQgMDQ6NTc6MjRQTSArMDAwMCwgU3JpdmFzdGF2
YSwgU2hvYmhpdCB3cm90ZToNCj4gPiA+IE9uIDIvMTIvMjAgMTI6MzQgQU0sIFJhamF0IEphaW4g
d3JvdGU6DQo+IA0KPiAuLi4NCj4gDQo+ID4gPiBJIHdvbmRlciBpcyBpdCBlbm91Z2ggdG8gaGF2
ZSB0aGlzIHF1aWNrIHRvZ2dsaW5nIG9ubHkgb3IgaXMgdGltZSBvcg0KPiA+ID4gYWN0dWFsbHkg
bnVtYmVyIG9mIGNsb2NrIGN5Y2xlcyBkZXBlbmRlbnQ/IE5vdyB0aGVyZSBpcyBubyBkZWxheQ0K
PiA+ID4gYmV0d2VlbiBidXQgSSdtIHRoaW5raW5nIGlmIGl0IG5lZWRzIGNlcnRhaW4gbnVtYmVy
IGN5Y2xlcyBkb2VzIHRoaXMNCj4gPiA+IHN0aWxsIHdvcmsgd2hlbiB1c2luZyBsb3cgc3NwX2Ns
ayByYXRlcyBzaW1pbGFyIHRoYW4gaW4gY29tbWl0DQo+IGQwMjgzZWIyZGJjMSAoInNwaToNCj4g
PiA+IHB4YTJ4eDogQWRkIG91dHB1dCBjb250cm9sIGZvciBtdWx0aXBsZSBJbnRlbCBMUFNTIGNo
aXAgc2VsZWN0cyIpLg0KPiA+ID4NCj4gPiA+IEknbSB0aGlua2luZyBjYW4gdGhpcyBiZSBkb25l
IG9ubHkgb25jZSBhZnRlciByZXN1bWUgYW5kIG1heSBvdGhlcg0KPiA+ID4gTFBTUyBibG9ja3Mg
bmVlZCB0aGUgc2FtZT8gSS5lLiBzaG91bGQgdGhpcyBiZSBkb25lIGluIGRyaXZlcnMvbWZkL2lu
dGVsLQ0KPiBscHNzLmM/DQo+IA0KPiA+IFRoaXMgYmVoYXZpb3IgaXMgc2VlbiBhZnRlciBTMGl4
IHJlc3VtZSwgYnV0IGl0IGlzIG5vdCBzZWVuIGFmdGVyIFMzIHJlc3VtZS4NCj4gDQo+IEkgYWxy
ZWFkeSBjb21tZW50ZWQgaW4gdGhlIG90aGVyIHRocmVhZCBhYm91dCB0aGlzLg0KPiANCj4gSGF2
ZSB5b3UgY2hlY2tlZCB3aGF0J3MgZ29pbmcgb24gaW4gaW50ZWxfbHBzc19zdXNwZW5kKCkgYW5k
DQo+IGludGVsX2xwc3NfcmVzdW1lKCkgZm9yIHlvdXIgY2FzZT8NClllcywgSSBjaGVja2VkIHRo
b3NlIGZ1bmN0aW9ucyBhbmQgdGhleSBsb29rIGZpbmUuDQpJIGV2ZW4gZHVtcGVkIGFsbCB0aGUg
cmVsZXZhbnQgcmVnaXN0ZXJzIGZvciBib3RoIFMzIHJlc3VtZSAmIFMwaXggcmVzdW1lIGNhc2Uu
DQpBbGwgcmVnaXN0ZXJzIHdlcmUgc2FtZSBleGNlcHQgdGhlIFNTQ1IwLg0KDQo+IElzIGludGVs
X2xwc3NfcHJlcGFyZSgpIGNhbGxlZCBkdXJpbmcgUzBpeCBleGl0Pw0KWWVzLCBpdCBpcyBjYWxs
ZWQgZHVyaW5nIFMwaXggZW50cnksIGJlZm9yZSB0aGUgc3VzcGVuZCBjYWxsYmFjay4NCg0KPiA+
IEkgYW0gdGhpbmtpbmcgdGhhdCBpdCBoYXBwZW5zIGJlY2F1c2Ugd2UgYXJlIG5vdCBlbmFibGlu
ZyB0aGUgU1NQIGFmdGVyDQo+IHJlc3VtZS4NCj4gPiBJdCBpcyBkZWZlcnJlZCB1bnRpbCB3ZSBu
ZWVkIHRvIHNlbmQgZGF0YS4gQnkgZW5hYmxpbmcgdGhlIFNTUCBpbiByZXN1bWUsIEkNCj4gZG9u
4oCZdCBzZWUgdGhlIGlzc3VlLg0KPiA+IEZvciBTMywgSSB0aGluayBCSU9TIHJlLWVuYWJsZXMg
dGhlIFNTUCBpbiByZXN1bWUgZmxvdy4NCj4gDQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0K
PiBBbmR5IFNoZXZjaGVua28NCj4gDQoNCg==
