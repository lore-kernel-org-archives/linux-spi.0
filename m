Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8EE34EF0E
	for <linux-spi@vger.kernel.org>; Tue, 31 Mar 2026 02:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774924560; cv=none; b=Nt020MvbtFRj1shLCZpXUEhNHmJC9cyCEHF93Wymff6caKcPMPNzdKpj6IfTwnO+qSXnRCfVKxunfg33jeifBFC9Go2yamTptN/mOJgjMKK4BpcfFNcn9dJyPKhrj6K5zal3W7olZzeMSS/WQk/ltDPe7u3VREZFhC7BRZCHrKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774924560; c=relaxed/simple;
	bh=YpcVpIS8fT9GkMEgK5RH9Wgc/zKMqdbSNJCaW/LpaAA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IuWoy2SzyT23uiwK1TDN5DI0Mtn2XeHzDcOOKca1n2C74jBy6EdayeFoTzI/Wg/yMvDfKJH9rW5sfuKbELZSHnbb5+Yk3LlwfEKM4v4ccuckvT+1nTrQwtQOF5VntmPXeDkIO4JrIpbxaUhXzMiQHGkEhRYo9cVLmI4pu7JOis0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=OYLwrLri; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="OYLwrLri"
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 764352C038B;
	Tue, 31 Mar 2026 15:35:50 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1774924550;
	bh=YpcVpIS8fT9GkMEgK5RH9Wgc/zKMqdbSNJCaW/LpaAA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=OYLwrLriyk1gvzd5D0mxy4zYt4ix+fnlOeyAS/+k3grS75Q5iOSxTmQ+ofolNK1pB
	 4jGhsPgTlnx2cwgPs5vvgLF6nwUB1K9k7FaGLaUBfhB2L4SGFDE1Gk/qll6CtUfmn9
	 GWvDTYnDOuv5MYIwZM00iwdkGtnRXav8P5ICAmvoJS5vwmPo+30r9gKg1j/Os6paUL
	 H8D5rURA5T7hobq7u8emKBUGlmwrKQfj4mhEtSVLYoHJoFpvDo4zgEM4oUHEhSATHt
	 c7UQxqjbyu6W/oTrepH77W6EVeuf92Ck5sMZcv4yIfXDiHPYTz3DaY96ejFuXODOA+
	 NX9Y7iSAWtCiw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B69cb33060001>; Tue, 31 Mar 2026 15:35:50 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Tue, 31 Mar 2026 15:35:50 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1748.039; Tue, 31 Mar 2026 15:35:50 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Conor Dooley <conor@kernel.org>
CC: "broonie@kernel.org" <broonie@kernel.org>, "kdasu.kdev@gmail.com"
	<kdasu.kdev@gmail.com>, "bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] spi: spi-mem: fallback to using transfers when CS
 gpios are used
Thread-Topic: [PATCH 2/2] spi: spi-mem: fallback to using transfers when CS
 gpios are used
Thread-Index: AQHVlSXI5kn5hlFDW0GmX3LQbcWwK7XQKvyAgANDKwCAAfeqgIAABCCA
Date: Tue, 31 Mar 2026 02:35:49 +0000
Message-ID: <633ce181-4282-427a-b1bc-97981323fa92@alliedtelesis.co.nz>
References: <20191107044235.4864-1-chris.packham@alliedtelesis.co.nz>
 <20191107044235.4864-3-chris.packham@alliedtelesis.co.nz>
 <20260327-renewal-poking-7ae0f0345cb9@spud>
 <1bc86691-dc6b-43ea-958b-6bd7db94777c@alliedtelesis.co.nz>
 <20260330-maturing-clamor-0dca2a6a400d@spud>
In-Reply-To: <20260330-maturing-clamor-0dca2a6a400d@spud>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <65C65885C37A4E43BB5953DFDB3359B6@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=EcprQ+mC c=1 sm=1 tr=0 ts=69cb3306 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=drD7vYo3kbIA:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=ywD30NgdXQkCUEIbtRsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAzMS8wMy8yMDI2IDE1OjIxLCBDb25vciBEb29sZXkgd3JvdGU6DQo+IE9uIFN1biwgTWFy
IDI5LCAyMDI2IGF0IDA4OjE4OjIyUE0gKzAwMDAsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+PiBI
aSBDb25ub3IsDQo+Pg0KPj4gT24gMjgvMDMvMjAyNiAwNzoyOSwgQ29ub3IgRG9vbGV5IHdyb3Rl
Og0KPj4+IE9uIFRodSwgTm92IDA3LCAyMDE5IGF0IDA1OjQyOjM1UE0gKzEzMDAsIENocmlzIFBh
Y2toYW0gd3JvdGU6DQo+Pj4+IERldmljZXMgd2l0aCBjaGlwIHNlbGVjdHMgZHJpdmVuIHZpYSBH
UElPIGFyZSBub3QgY29tcGF0aWJsZSB3aXRoIHRoZQ0KPj4+PiBzcGktbWVtIG9wZXJhdGlvbnMu
IEZhbGxiYWNrIHRvIHVzaW5nIHN0YW5kYXJkIHNwaSB0cmFuc2ZlcnMgd2hlbiB0aGUNCj4+Pj4g
ZGV2aWNlIGlzIGNvbm5lY3RlZCB3aXRoIGEgZ3BpbyBDUy4NCj4+PiBCaXR0YSBuZWNyb21hbmN5
LCBidXQgd2h5IGFyZSB0aGV5IG5vdCBjb21wYXRpYmxlPw0KPj4+IENvdWxkbid0IHlvdSBoYXZl
IGp1c3QgZG9uZSBhbiBpZi9lbHNlIGluIHlvdXIgZHJpdmVyIHRvIGNhbGwNCj4+PiBncGlvZF9z
ZXRfdmFsdWUoc3BpX2dldF9jc2dwaW9kKCkpPw0KPj4+DQo+Pj4gRm9yIHNvbWUgY29udGV4dCwg
SSd2ZSBiZWVuIHRyeWluZyB0byByZXNvbHZlIHNvbWUgaXNzdWVzIHdpdGggdXNpbmcNCj4+PiB0
aGUgc3RhbmRhcmQgdHJhbnNmZXJzIGNvZGUgd2hlbiB1c2VkIHdpdGggZmxhc2ggZGV2aWNlcyBp
biB0aGUNCj4+PiBtaWNyb2NoaXAtY29yZS1xc3BpIGRyaXZlciwgYnV0IGlmIEkgZGVsZXRlIHRo
aXMgIW1lbS0+c3BpLT5jc19ncGlvZA0KPj4+IGNoZWNrLCBhbmQgYWRkIHRoZSBhZm9yZW1lbnRp
b25lZCBpZi9lbHNlIGluIG15IGRyaXZlciwgdGhlIG1lbSBvcHMNCj4+PiB3b3JrIGZpbmUuDQo+
IFR1cm5zIG91dCwgSSBnb29mZWQgYW5kIGl0IGRvZXNuJ3QgbWFnaWNhbGx5IHNvbHZlIG15IHBy
b2JsZW0uIEkgYmxhbWUNCj4gd29ya2luZyB0b28gbGF0ZSBvbiBhIEZyaWRheSBldmVuaW5nLiBC
dXQgaXQgc2hvdWxkIHdvcmsgb24gbXkgcGxhdGZvcm0sDQo+IG9uY2UgSSBnZXQgdG8gdGhlIGJv
dHRvbSBvZiB3aGF0J3MgYnJlYWtpbmcgaXQgZm9yIGJvdGggY2FzZXMuDQo+DQpJIGNlcnRhaW5s
eSBuZXZlciBwdXNoIGFueXRoaW5nIGFmdGVyIDRwbSBvbiBhIEZyaWRheSA6UA0KDQo+Pj4gV2hh
dCBhbSBJIG1pc3NpbmcgdGhhdCBtYWtlcyB0aGVtIGluY29tcGF0aWJsZT8NCj4+IFRoZSBjb3Zl
ciBsZXR0ZXIgZnJvbSB0aGlzIHNlcmllc1sxXSBhZGRzIGEgbGl0dGxlIGNvbnRleHQuIEJhc2lj
YWxseQ0KPj4gdGhlIGhhcmR3YXJlIGRlc2lnbiBJIHdhcyBkZWFsaW5nIHdpdGggaXMgYSBiaXQg
b2RkLiBJdCBkb2Vzbid0IHdpcmUgdXANCj4+IEdQSU9zIGFzIGNoaXAgc2VsZWN0cyBkaXJlY3Rs
eSBpdCB1c2VzIGEgR1BJTyBhbmQgc29tZSBleHRyYSBsb2dpYyB0bw0KPj4gc3RlZXIgdGhlIG5h
dGl2ZSBDUy4gT24gdGhlIEJDTTU4NTI1IHRoZSBDUyBhcHBlYXJzIHRvIGJlIGRyaXZlbg0KPj4g
YXV0b21hdGljYWxseSAob3RoZXIgU29DcyB0aGF0IHVzZSB0aGUgYmNtLXFzcGkgZHJpdmVyIGFw
cGVhciB0byBiZSBhYmxlDQo+PiB0byBleHBsaWNpdGx5IGNvbnRyb2wgdGhlIGNoaXAgc2VsZWN0
KS4gVGhpcyBjb21iaW5lZCB3aXRoIHRoZSBhYmlsaXR5DQo+PiB0byBvZmZsb2FkIHRoZSB2YXJp
b3VzIHNwaS1tZW0gb3BlcmF0aW9ucyBtZWFucyB3ZSBuZWVkIHRoZSBzcGkgY29yZSB0bw0KPj4g
ZHJpdmUgdGhlIEdQSU/CoENTIGFuZCB1c2UgdGhlIHN0YW5kYXJkIHNwaSBvcGVyYXRpb25zLg0K
Pj4NCj4+IEkgdGhpbmsgdGhhdCBjaGVjayBjb3VsZCBwcm9iYWJseSBiZSByZXBsYWNlZCB3aXRo
IHNvbWUgZmxhZyB0aGF0DQo+PiBhbW91bnRzIHRvIGRpc2FibGluZyB0aGUgc3BpLW1lbSBvcHMg
d2hlbiB3ZSBkb24ndCBoYXZlIGZ1bGwgY29udHJvbA0KPj4gb3ZlciB0aGUgbmF0aXZlIENTLg0K
PiBJIGR1bm5vLCB0aGF0IHNlZW1zIGxpa2VseSB0byBjYXVzZSByZWdyZXNzaW9ucywgbm8/IERl
dmljZXMgdGhhdCBkaWRuJ3QNCj4gYWRkIGhhbmRpbmcgb2YgZ3BpbyBjaGlwIHNlbGVjdHMgaW4g
dGhlaXIgbWVtIG9wcyBjb2RlLCBjb3MgaXQgd2Fzbid0DQo+IGV2ZXIgY2FsbGVkIGluIHRoYXQg
Y2FzZSwgd291bGQgcmVncmVzcy4NCg0KWWVzLCBub3cgaXQgd291bGQuIEkgc3RpbGwgaGF2ZSBh
Y2Nlc3MgdG8gdGhlIHBsYXRmb3JtIHRoYXQgSSB3YXMgDQp3b3JraW5nIG9uIGZvciB0aGlzIHNv
IEkgY2FuIHJlLXRlc3QgbXkgb3JpZ2luYWwgdXNlLWNhc2UuIEl0IGlzIA0KZGVwZW5kZW50IG9u
IGhvdyB0aGUgc3BpIGNvbnRyb2xsZXIgZG9lcyBzcGktbWVtIG9wcyBzbyB0aGVyZSBpcyBhIA0K
Y2hhbmNlIHRoYXQgcGxhdGZvcm1zIHRoYXQgaGF2ZSBiZWVuIGFkZGVkIHNpbmNlIHJlbHkgb24g
dGhlIGN1cnJlbnQgDQpiZWhhdmlvdXIuDQoNCj4gR3Vlc3MgY291bGQgZ28gdGhyb3VnaCBhbmQN
Cj4gbW9kaWZ5IGFueXRoaW5nIHdpdGggdGhlIGdwaW9fZGVzY3JpcHRvcnMgKG9yIHcvZSBpdCBp
cyBjYWxsZWQpIGZsYWcsDQo+IGJ1dCBvcHQtaW4gbWlnaHQgYmUgc2FmZXIuIEknbGwgdGhpbmsg
YWJvdXQgaXQgd2hlbiBteSBzdHVmZiB3b3Jrcy4uLg0KDQpJIGp1c3Qgd2FudGVkIHRvIG9mZmVy
IHlvdSB0aGUgb3B0aW9uLiBJZiBpdCB0dXJucyBvdXQgbXkgY2hhbmdlIGlzIA0KZ2V0dGluZyBp
biB5b3VyIHdheSB3ZSBjYW4gd29yayBvbiBhbiBhbHRlcm5hdGl2ZS4NCg0KPg0KPj4+IENoZWVy
cywNCj4+PiBDb25vci4NCj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBQYWNraGFtIDxj
aHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQo+Pj4+IC0tLQ0KPj4+PiAgICBkcml2
ZXJzL3NwaS9zcGktbWVtLmMgfCAyICstDQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9z
cGkvc3BpLW1lbS5jIGIvZHJpdmVycy9zcGkvc3BpLW1lbS5jDQo+Pj4+IGluZGV4IDlmMGZhOWYz
MTE2ZC4uZTVhNDZmMGViOTNiIDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktbWVt
LmMNCj4+Pj4gKysrIGIvZHJpdmVycy9zcGkvc3BpLW1lbS5jDQo+Pj4+IEBAIC0yODYsNyArMjg2
LDcgQEAgaW50IHNwaV9tZW1fZXhlY19vcChzdHJ1Y3Qgc3BpX21lbSAqbWVtLCBjb25zdCBzdHJ1
Y3Qgc3BpX21lbV9vcCAqb3ApDQo+Pj4+ICAgIAlpZiAoIXNwaV9tZW1faW50ZXJuYWxfc3VwcG9y
dHNfb3AobWVtLCBvcCkpDQo+Pj4+ICAgIAkJcmV0dXJuIC1FTk9UU1VQUDsNCj4+Pj4gICAgDQo+
Pj4+IC0JaWYgKGN0bHItPm1lbV9vcHMpIHsNCj4+Pj4gKwlpZiAoY3Rsci0+bWVtX29wcyAmJiAh
bWVtLT5zcGktPmNzX2dwaW9kKSB7DQo+Pj4+ICAgIAkJcmV0ID0gc3BpX21lbV9hY2Nlc3Nfc3Rh
cnQobWVtKTsNCj4+Pj4gICAgCQlpZiAocmV0KQ0KPj4+PiAgICAJCQlyZXR1cm4gcmV0Ow0KPj4+
PiAtLSANCj4+Pj4gMi4yNC4wDQo+Pj4+
