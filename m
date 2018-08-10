From: Trent Piepho <tpiepho@impinj.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI based
 QUP
Date: Fri, 10 Aug 2018 17:55:50 +0000
Message-ID: <1533923749.2283.330.camel@impinj.com>
References: <24b3ef71-18c1-1704-e324-5581fd18a998@codeaurora.org>
         <152700759909.210890.13296077062705155869@swboyd.mtv.corp.google.com>
         <20180522173000.GG24776@sirena.org.uk>
         <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
         <20180524162940.GA4828@sirena.org.uk>
         <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
         <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org>
         <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
         <20180810105205.GC20971@sirena.org.uk>
         <CAD=FV=XXyL5q1quxUtBohn2GrcadbY9hr6sdw+4qShQnYTgVwA@mail.gmail.com>
         <20180810161329.GF20971@sirena.org.uk>
         <c1bc416ba407b5a3cc098e78a529752e@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "sdharia@codeaurora.org" <sdharia@codeaurora.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "kramasub@codeaurora.org" <kramasub@codeaurora.org>,
        "girishm@codeaurora.org" <girishm@codeaurora.org>
To: "dkota@codeaurora.org" <dkota@codeaurora.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c1bc416ba407b5a3cc098e78a529752e@codeaurora.org>
Content-Language: en-US
Content-ID: <DDAB15AE04AEB94090DBD4692C1F106F@namprd06.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

T24gRnJpLCAyMDE4LTA4LTEwIGF0IDIxOjU5ICswNTMwLCBka290YUBjb2RlYXVyb3JhLm9yZyB3
cm90ZToNCj4gDQo+IEhlcmUgYXJlIG15IGNvdXBsZSBvZiBjZW50czoNCj4gU1BJIGNvbnRyb2xs
ZXIgbWF4aW11bSBmcmVxdWVuY3kgY2FuIGJlIGxlc3NlciB0aGFuIG9yIGVxdWFsIHRvIENsb2Nr
IA0KPiBmcmFtZXdvcmsncyBtYXhpbXVtDQo+IGZyZXF1ZW5jeSwgc28gc2hvdWxkIG5vdCByZWx5
IG9uIHRoZSBDbG9jayBmcmFtZXdvcmsuDQoNCkJ1dCB0aGVyZSBpcyBwcm9iYWJseSBzb21lIG1l
YW5zLCB2aWEgdGhlIGNvbnRyb2xsZXIncyBJUCBibG9jayBpbnB1dA0KY2xvY2ssIGNvbWJpbmVk
IHdpdGggdGhlIGNvbnRyb2xsZXIncyBJUCB2ZXJzaW9uIChmcm9tIHRoZSBjb21wYXRpYmxlDQpz
dHJpbmcgYW5kIGEgZGV2aWNlIGRhdGEgdGFibGUpLCB0byBkZXJpdmUgdGhlIGNvbnRyb2xsZXIn
cyBtYXggY2xvY2suDQoNCkF0IGxlYXN0LCBBRkFJQ1QsIHRoaXMgaGFzIGJlZW4gdGhlIGNhc2Ug
Zm9yIGFsbCBleGlzdGluZyBtYXN0ZXINCmRyaXZlcnMuDQoNCj4gDQo+IE5vdyB0aGUgbmVlZCBp
cywgaG93IHRvIGNvbW11bmljYXRlIHRoZSBTUEkgY29udHJvbGxlciBtYXhpbXVtIGZyZXF1ZW5j
eSANCj4gdG8gU1BJIGNvcmUgZnJhbWV3b3JrPw0KPiBJcyBpdCBieSBEVFNJIGVudHJ5IG9yIGhh
cmRjb2RpbmcgaW4gdGhlIFNQSSBjb250cm9sbGVyIGRyaXZlcj8NCj4gDQo+IE15IHN0YW5kIGlz
IGZvciBwcm92aWRpbmcgdGhlIERUU0kgZW50cnkuDQo+IFdoeSBiZWNhdXNlLCB0aGlzIGtlZXBz
IFNQSSBjb250cm9sbGVyIGRyaXZlciBnZW5lcmljIGFjcm9zcyB0aGUgYm9hcmRzIA0KPiBhbmQg
cG9ydGFibGUuDQo+IEFsc28gaXQgaXMgbm90IGFnYWluc3QgdG8gRGV2aWNlIHRyZWUgdXNhZ2Ug
YmVjYXVzZSBtYXhpbXVtIGZyZXF1ZW5jeQ0KPiBpcyBkZXNjcmliaW5nIHRoZSBwcm9wZXJ0eSBv
ZiB0aGUgaGFyZHdhcmUuDQoNCk15IHBvaW50IGlzIHRoYXQgbm90IGV2ZXJ5dGhpbmcgdGhhdCBw
b3NzaWJseSBjYW4gZ28gaW4gdGhlIGRldmljZSB0cmVlDQpzaG91bGQgYmUgcGxhY2VkIHRoZXJl
LCBqdXN0IGJlY2F1c2UgaXQgY2FuIGJlLiAgSWYgdGhlIG1hc3RlciBkcml2ZXINCmNhbiBmaWd1
cmUgb3V0IGl0cyBtYXggc3BlZWQsIGxldCBpdCBkbyB0aGF0Lg0K
