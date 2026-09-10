Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311D1355F5F;
	Thu, 10 Sep 2026 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789031497; cv=none; b=eV//fw6pE7jjVueTe1kLOti6j/HLKLy+bd3s9+zk9zB4NsFETZJPejDE0YZP7GvheQXzEk4qLRlk4JHywxN/xNAoWoHm7kQXpEA+uH+21IuELTLs2zp5XzopjKx9TXKrdSno6Na4lsluBMZq0i3KWDwVU345h6PVsefs+si2fEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789031497; c=relaxed/simple;
	bh=Xu+ovBLPoUOc7ueWlJ/+QdACri4Bx0jLtI3Yyc4O42Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zn1uK92GjU9ASyhojs5YRS6k1fWRvIfLcGZN+aSs27SUAFdozgME7YhupxHPdBLqae8dV7ZDR1BuFpk8qevfpE5aGDk4PSIbo2vsx4YiuMtb6Yqxhz7zqELC0fWdq8dE17uiBNVrhiWv5gJ0+bZYBR4P5/aLCBcwzABwcCMH3Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=nGKUCrua; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="nGKUCrua"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68A9BFZh81359564, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1789031476; bh=Xu+ovBLPoUOc7ueWlJ/+QdACri4Bx0jLtI3Yyc4O42Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=nGKUCruax52ik9lEdrF2C1kE2qNZRN2qd8PGR59mvlXeQ5KVeBgTyPUfSl+WO0eoE
	 skePmBKmGqoO92sHxvPwPMoX+f7dzEqy0yUX5Fp3bRmnU48vfELvXmAE4+Yk+9Lsw+
	 b47A9Y8FQbA6qepwldHBwdquUOm+Zw9bw4aRhiTsmvKKvbqQ/FPiuFffXZq1tHjCbA
	 M1GEfgLkSDurWmIo2KSAyeLPQO4vJYEJjjCogahKJdGcw5hmk2WK2BjnS1GN0W4nWR
	 c4W01zWgpcIBAWP/yixLuHM7o+mS7h8hsysRHqGLDvRzcl/QgLJ3pDirCJXtqd3oCO
	 /GcwI26SBt4Jg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68A9BFZh81359564
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Sep 2026 17:11:16 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 10 Sep 2026 17:11:16 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 10 Sep 2026 17:11:15 +0800
Received: from RTKEXHMBS05.realtek.com.tw ([::1]) by
 RTKEXHMBS05.realtek.com.tw ([fe80::a236:c445:ce4a:140a%4]) with mapi id
 15.02.2562.043; Thu, 10 Sep 2026 17:11:15 +0800
From: =?utf-8?B?WXUtQ2h1biBMaW4gW+ael+elkOWQm10=?= <eleanor.lin@realtek.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, "broonie@kernel.org"
	<broonie@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>,
	=?utf-8?B?Q1lfSHVhbmdb6buD6Ymm5pmPXQ==?= <cy.huang@realtek.com>,
	=?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= <stanley_chang@realtek.com>,
	=?utf-8?B?SnlhbiBDaG91IFvlkajoirflrold?= <jyanchou@realtek.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/2] spi: spi-mem: Add Realtek SPI NOR flash controller
 driver
Thread-Topic: [PATCH v4 2/2] spi: spi-mem: Add Realtek SPI NOR flash
 controller driver
Thread-Index: AQHdQFq13CkcfsxNVEy+ga/cyUbwnrbFvsSAgAHI7qA=
Date: Thu, 10 Sep 2026 09:11:15 +0000
Message-ID: <217f74ab36be487ebe874e2fd340756b@realtek.com>
References: <20260909125701.273314-1-eleanor.lin@realtek.com>
	 <20260909125701.273314-3-eleanor.lin@realtek.com>
 <c647c66bdb3d87157a5684b755c95123fe9ba198.camel@pengutronix.de>
In-Reply-To: <c647c66bdb3d87157a5684b755c95123fe9ba198.camel@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgUGhpbGlwcCwNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCg0KPiA+ICtzdGF0aWMgaW50
IHJ0a19zcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikgew0KPiA+ICsgICAg
IHN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gKyAgICAgc3RydWN0IHNwaV9j
b250cm9sbGVyICpjdHJsOw0KPiA+ICsgICAgIHN0cnVjdCBydGtfc3BpX2hvc3QgKmhvc3Q7DQo+
ID4gKyAgICAgc3RydWN0IHJlc291cmNlICpyZXM7DQo+ID4gKyAgICAgaW50IHJldDsNCj4gPiAr
DQo+ID4gKyAgICAgY3RybCA9IGRldm1fc3BpX2FsbG9jX2hvc3QoZGV2LCBzaXplb2YoKmhvc3Qp
KTsNCj4gPiArICAgICBpZiAoIWN0cmwpDQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gLUVOT01F
TTsNCj4gPiArDQo+ID4gKyAgICAgcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgY3RybCk7DQo+
ID4gKyAgICAgaG9zdCA9IHNwaV9jb250cm9sbGVyX2dldF9kZXZkYXRhKGN0cmwpOw0KPiA+ICsg
ICAgIGhvc3QtPmRldiA9IGRldjsNCj4gPiArDQo+ID4gKyAgICAgaG9zdC0+Y2xrID0gZGV2bV9j
bGtfZ2V0KGRldiwgTlVMTCk7DQo+ID4gKyAgICAgaWYgKElTX0VSUihob3N0LT5jbGspKQ0KPiA+
ICsgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoaG9zdC0+Y2xrKTsNCj4gPiArDQo+ID4gKyAg
ICAgcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGhvc3QtPmNsayk7DQo+ID4gKyAgICAgaWYgKHJl
dCkNCj4gPiArICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsgICAgIGhvc3Qt
PnJzdGMgPSBkZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0X29wdGlvbmFsX2V4Y2x1c2l2ZShkZXYsIE5V
TEwpOw0KPiA+ICsgICAgIGlmIChJU19FUlIoaG9zdC0+cnN0YykpIHsNCj4gPiArICAgICAgICAg
ICAgIHJldCA9IFBUUl9FUlIoaG9zdC0+cnN0Yyk7DQo+ID4gKyAgICAgICAgICAgICBnb3RvIGVy
cl9kaXNhYmxlX2NsazsNCj4gDQo+IElmIHlvdSBtb3ZlZCBjbGtfcHJlcGFyZV9lbmFibGUoKSBi
ZWxvdyB0aGlzLCB5b3UgY291bGQganVzdCByZXR1cm4gaGVyZS4NCj4gDQoNCkFjay4NCg0KPiA+
ICsgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgcmVzZXRfY29udHJvbF9hc3NlcnQoaG9zdC0+cnN0
Yyk7DQo+ID4gKyAgICAgdXNsZWVwX3JhbmdlKDEwLCAyMCk7DQo+ID4gKyAgICAgcmVzZXRfY29u
dHJvbF9kZWFzc2VydChob3N0LT5yc3RjKTsNCj4gPiArDQo+ID4gKyAgICAgcmV0ID0gZG1hX3Nl
dF9tYXNrX2FuZF9jb2hlcmVudChkZXYsIERNQV9CSVRfTUFTSygzNSkpOw0KPiA+ICsgICAgIGlm
IChyZXQpIHsNCj4gPiArICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIHNldCBk
bWEgbWFza1xuIik7DQo+ID4gKyAgICAgICAgICAgICBnb3RvIGVycl9kaXNhYmxlX2NsazsNCj4g
DQo+IE5vIHJlc2V0X2NvbnRyb2xfYXNzZXJ0KCkgaW4gdGhpcyBlcnJvciBwYXRoPw0KPiANCj4g
PiArICAgICB9DQo+ID4gKw0KPiA+ICsgICAgIGhvc3QtPmJ1ZmZlciA9IGRtYW1fYWxsb2NfY29o
ZXJlbnQoZGV2LCBTRkNfRE1BX01BWF9MRU4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAmaG9zdC0+ZG1hX2J1ZmZlciwNCj4gR0ZQX0tFUk5FTCk7DQo+ID4g
KyAgICAgaWYgKCFob3N0LT5idWZmZXIpIHsNCj4gPiArICAgICAgICAgICAgIHJldCA9IC1FTk9N
RU07DQo+ID4gKyAgICAgICAgICAgICBnb3RvIGVycl9kaXNhYmxlX2NsazsNCj4gPiArICAgICB9
DQo+ID4gKw0KPiA+ICsgICAgIGhvc3QtPnJlZ2Jhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBf
cmVzb3VyY2VfYnluYW1lKHBkZXYsDQo+ICJjdHJsIik7DQo+ID4gKyAgICAgaWYgKElTX0VSUiho
b3N0LT5yZWdiYXNlKSkgew0KPiA+ICsgICAgICAgICAgICAgcmV0ID0gUFRSX0VSUihob3N0LT5y
ZWdiYXNlKTsNCj4gPiArICAgICAgICAgICAgIGdvdG8gZXJyX2Rpc2FibGVfY2xrOw0KPiA+ICsg
ICAgIH0NCj4gPiArDQo+ID4gKyAgICAgaG9zdC0+bWRiYXNlID0gZGV2bV9wbGF0Zm9ybV9pb3Jl
bWFwX3Jlc291cmNlX2J5bmFtZShwZGV2LA0KPiAiZG1hIik7DQo+ID4gKyAgICAgaWYgKElTX0VS
Uihob3N0LT5tZGJhc2UpKSB7DQo+ID4gKyAgICAgICAgICAgICByZXQgPSBQVFJfRVJSKGhvc3Qt
Pm1kYmFzZSk7DQo+ID4gKyAgICAgICAgICAgICBnb3RvIGVycl9kaXNhYmxlX2NsazsNCj4gPiAr
ICAgICB9DQo+ID4gKw0KPiA+ICsgICAgIHJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZV9ieW5h
bWUocGRldiwgSU9SRVNPVVJDRV9NRU0sDQo+ICJkaXJtYXAiKTsNCj4gPiArICAgICBob3N0LT5p
b2Jhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCByZXMpOw0KPiA+ICsgICAgIGlmIChJ
U19FUlIoaG9zdC0+aW9iYXNlKSkgew0KPiA+ICsgICAgICAgICAgICAgcmV0ID0gUFRSX0VSUiho
b3N0LT5pb2Jhc2UpOw0KPiA+ICsgICAgICAgICAgICAgZ290byBlcnJfZGlzYWJsZV9jbGs7DQo+
ID4gKyAgICAgfQ0KPiANCj4gSXQgbG9va3MgdG8gbWUgbGlrZSBhbGwgdGhlc2UgZG1hbV8gYW5k
IGRldm1fIGluaXRpYWxpemF0aW9uIGNhbGxzIHNob3VsZCBiZQ0KPiBtb3ZlZCB1cCBiZWZvcmUg
dGhlIGNsb2NrIGVuYWJsZSBhbmQgcmVzZXQgYXNzZXJ0L2RlYXNzZXJ0Lg0KPiANCj4gPiArDQo+
ID4gKyAgICAgaG9zdC0+ZGlybWFwX3NpemUgPSByZXNvdXJjZV9zaXplKHJlcyk7DQo+ID4gKyAg
ICAgaG9zdC0+Zmxhc2hfcGh5c19iYXNlID0gcmVzLT5zdGFydDsNCj4gPiArICAgICBob3N0LT5p
c180Ynl0ZSA9IGZhbHNlOw0KPiA+ICsNCj4gPiArICAgICBjdHJsLT5tb2RlX2JpdHMgPSBTUElf
UlhfRFVBTCB8IFNQSV9UWF9EVUFMOw0KPiA+ICsgICAgIGN0cmwtPmJ1c19udW0gPSAtMTsNCj4g
PiArICAgICBjdHJsLT5tZW1fb3BzID0gJnJ0a19zcGlfbWVtX29wczsNCj4gPiArICAgICBjdHJs
LT5udW1fY2hpcHNlbGVjdCA9IDE7DQo+ID4gKyAgICAgY3RybC0+YXV0b19ydW50aW1lX3BtID0g
dHJ1ZTsNCj4gPiArDQo+ID4gKyAgICAgcnRrX3NwaV9pbml0KGhvc3QpOw0KPiANCj4gVGhpcyBp
cyB0aGUgZmlyc3QgY2FsbCB0aGF0IGFjdHVhbGx5IG5lZWRzIGNsb2NrcyBydW5uaW5nIGFuZCBy
ZXNldCB0cmlnZ2VyZWQuDQo+IA0KDQpJIHdpbGwgdXBkYXRlIHRoZSBzZXF1ZW5jZSBhcyBmb2xs
b3dzOg0KDQoxLiBHZXQgdGhlIGNsb2NrIGFuZCByZXNldCBjb250cm9scywgdGhlbiBjb21wbGV0
ZSBvdGhlciByZXNvdXJjZSBpbml0aWFsaXphdGlvbi4NCjIuIEVuYWJsZSB0aGUgY2xvY2sgYW5k
IHBlcmZvcm0gdGhlIHJlc2V0IHNlcXVlbmNlLg0KMy4gQ2FsbCBydGtfc3BpX2luaXQoKS4NCg0K
PiA+ICsNCj4gPiArICAgICBwbV9ydW50aW1lX3NldF9hdXRvc3VzcGVuZF9kZWxheShkZXYsDQo+
IFNGQ19BVVRPU1VTUEVORF9USU1FT1VUKTsNCj4gPiArICAgICBwbV9ydW50aW1lX3VzZV9hdXRv
c3VzcGVuZChkZXYpOw0KPiA+ICsgICAgIHBtX3J1bnRpbWVfc2V0X2FjdGl2ZShkZXYpOw0KPiA+
ICsgICAgIHBtX3J1bnRpbWVfZW5hYmxlKGRldik7DQo+ID4gKyAgICAgcG1fcnVudGltZV9nZXRf
bm9yZXN1bWUoZGV2KTsNCj4gPiArDQo+ID4gKyAgICAgcmV0ID0gc3BpX3JlZ2lzdGVyX2NvbnRy
b2xsZXIoY3RybCk7DQo+ID4gKyAgICAgaWYgKHJldCA8IDApIHsNCj4gPiArICAgICAgICAgICAg
IGRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIHJlZ2lzdGVyIGNvbnRyb2xsZXJcbiIpOw0KPiA+ICsg
ICAgICAgICAgICAgZ290byBlcnJfcG1fZGlzYWJsZTsNCj4gPiArICAgICB9DQo+ID4gKw0KPiA+
ICsgICAgIHBtX3J1bnRpbWVfcHV0X2F1dG9zdXNwZW5kKGRldik7DQo+ID4gKw0KPiA+ICsgICAg
IHJldHVybiAwOw0KPiA+ICsNCj4gPiArZXJyX3BtX2Rpc2FibGU6DQo+ID4gKyAgICAgcG1fcnVu
dGltZV9wdXRfbm9pZGxlKGRldik7DQo+ID4gKyAgICAgcG1fcnVudGltZV9kaXNhYmxlKGRldik7
DQo+ID4gKyAgICAgcG1fcnVudGltZV9zZXRfc3VzcGVuZGVkKGRldik7DQo+ID4gKyAgICAgcG1f
cnVudGltZV9kb250X3VzZV9hdXRvc3VzcGVuZChkZXYpOw0KPiA+ICsgICAgIHJlc2V0X2NvbnRy
b2xfYXNzZXJ0KGhvc3QtPnJzdGMpOw0KPiA+ICsNCj4gPiArZXJyX2Rpc2FibGVfY2xrOg0KPiA+
ICsgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShob3N0LT5jbGspOw0KPiA+ICsNCj4gPiArICAg
ICByZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBydGtfc3BpX3Jl
bW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KSB7DQo+ID4gKyAgICAgc3RydWN0IHNw
aV9jb250cm9sbGVyICpjdHJsID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+ID4gKyAg
ICAgc3RydWN0IHJ0a19zcGlfaG9zdCAqaG9zdCA9IHNwaV9jb250cm9sbGVyX2dldF9kZXZkYXRh
KGN0cmwpOw0KPiA+ICsgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4g
Kw0KPiA+ICsgICAgIHNwaV91bnJlZ2lzdGVyX2NvbnRyb2xsZXIoY3RybCk7DQo+ID4gKw0KPiA+
ICsgICAgIHBtX3J1bnRpbWVfZ2V0X3N5bmMoZGV2KTsNCj4gPiArICAgICBwbV9ydW50aW1lX2Rp
c2FibGUoZGV2KTsNCj4gPiArICAgICByZXNldF9jb250cm9sX2Fzc2VydChob3N0LT5yc3RjKTsN
Cj4gPiArICAgICBjbGtfZGlzYWJsZV91bnByZXBhcmUoaG9zdC0+Y2xrKTsNCj4gPiArICAgICBw
bV9ydW50aW1lX3B1dF9ub2lkbGUoZGV2KTsNCj4gPiArICAgICBwbV9ydW50aW1lX3NldF9zdXNw
ZW5kZWQoZGV2KTsNCj4gDQo+IFdoeSBpcyB0aGlzIGNsZWFudXAgb3JkZXIgZGlmZmVyZW50IGZy
b20gdGhlIHByb2JlIGVycm9yIHBhdGg/DQo+IA0KDQpJIHdpbGwgdXBkYXRlIGJvdGggcGF0aHMg
dG8gdXNlIHRoZSBzYW1lIGNsZWFudXAgc2VxdWVuY2UuDQoNCkJlc3QgUmVnYXJkcywNCll1LUNo
dW4NCg0KPiANCj4gcmVnYXJkcw0KPiBQaGlsaXBwDQo=
