Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA3F35F197
	for <linux-spi@vger.kernel.org>; Sun, 29 Mar 2026 20:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774816068; cv=none; b=aPpdSYgf7SupiFXodl9rs49VJUpkb4bWxB0kDq51ImWyqn7AoC1BbcsqZsYGpbs/hF7H4MUAsziRK35Nn35y035EMN5no/G5N01nWShuJATn8S1ohyXqUkldMdVf8i2JC1OuRSjUtTal7DEY/mJRJrYrIqjA5mOEfvHieqVnx3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774816068; c=relaxed/simple;
	bh=Ps0hk1+yiNFaXZRp7In8fXGkNnT3byDPyb2iRjEXgv0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NuGGIblMOGal45IJUtDJrEDzA6x15ErYPmfoqlr+mKHnITBdLKCDjXLkYxNnkW97vpEI8kh2aP4t8OdEqU0quiHEBPMVK0dUczkHJhIhv1K0ifFBdI+FZ8iAkQ3DRX80giCLPlWlt/BLnHxgrpkr5MjsS+os3qhmjnSL3G/6IqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=CUymILjw; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="CUymILjw"
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2D8A62C0433;
	Mon, 30 Mar 2026 09:18:23 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1774815503;
	bh=Ps0hk1+yiNFaXZRp7In8fXGkNnT3byDPyb2iRjEXgv0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=CUymILjwBHElmjANgHuSHYi81Azm094seZ4aO6VsmimK14JSIKos0ILoDhDr7IKdM
	 89h4JiooGJQc7yIv/8fuLTju/1HsHAj0kaQvoUeo9q8hzfmAAuSDhtsvAv2BG1iuDD
	 L0maWlhvr0GgE73eCSH0k4EB9423bBKoC2Uabt/R45H5Iha7cri8DbmPDF3QX4mQcs
	 j8A7J1S3rHVN0z3WQY6RNe2V4+jmgvIChWfxvfszjdVqN4jZO7oSI5KB+Kcv6B66wb
	 mqkshBZPO56pRSM7NFM2UeI4ddwlGFuClZLTkjF2syOpJO9gX45+Me09HUHnbDv8mF
	 5LSrrUhM1Jkzw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B69c9890f0001>; Mon, 30 Mar 2026 09:18:23 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 30 Mar 2026 09:18:22 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1748.039; Mon, 30 Mar 2026 09:18:22 +1300
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
Thread-Index: AQHVlSXI5kn5hlFDW0GmX3LQbcWwK7XQKvyAgANDKwA=
Date: Sun, 29 Mar 2026 20:18:22 +0000
Message-ID: <1bc86691-dc6b-43ea-958b-6bd7db94777c@alliedtelesis.co.nz>
References: <20191107044235.4864-1-chris.packham@alliedtelesis.co.nz>
 <20191107044235.4864-3-chris.packham@alliedtelesis.co.nz>
 <20260327-renewal-poking-7ae0f0345cb9@spud>
In-Reply-To: <20260327-renewal-poking-7ae0f0345cb9@spud>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A26432275FFCF48B507B865260B9EF7@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=EcprQ+mC c=1 sm=1 tr=0 ts=69c9890f a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=drD7vYo3kbIA:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VwQbUJbxAAAA:8 a=obx0k2kj_ffIeMMiSuoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

SGkgQ29ubm9yLA0KDQpPbiAyOC8wMy8yMDI2IDA3OjI5LCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIFRodSwgTm92IDA3LCAyMDE5IGF0IDA1OjQyOjM1UE0gKzEzMDAsIENocmlzIFBhY2toYW0g
d3JvdGU6DQo+PiBEZXZpY2VzIHdpdGggY2hpcCBzZWxlY3RzIGRyaXZlbiB2aWEgR1BJTyBhcmUg
bm90IGNvbXBhdGlibGUgd2l0aCB0aGUNCj4+IHNwaS1tZW0gb3BlcmF0aW9ucy4gRmFsbGJhY2sg
dG8gdXNpbmcgc3RhbmRhcmQgc3BpIHRyYW5zZmVycyB3aGVuIHRoZQ0KPj4gZGV2aWNlIGlzIGNv
bm5lY3RlZCB3aXRoIGEgZ3BpbyBDUy4NCj4gQml0dGEgbmVjcm9tYW5jeSwgYnV0IHdoeSBhcmUg
dGhleSBub3QgY29tcGF0aWJsZT8NCj4gQ291bGRuJ3QgeW91IGhhdmUganVzdCBkb25lIGFuIGlm
L2Vsc2UgaW4geW91ciBkcml2ZXIgdG8gY2FsbA0KPiBncGlvZF9zZXRfdmFsdWUoc3BpX2dldF9j
c2dwaW9kKCkpPw0KPg0KPiBGb3Igc29tZSBjb250ZXh0LCBJJ3ZlIGJlZW4gdHJ5aW5nIHRvIHJl
c29sdmUgc29tZSBpc3N1ZXMgd2l0aCB1c2luZw0KPiB0aGUgc3RhbmRhcmQgdHJhbnNmZXJzIGNv
ZGUgd2hlbiB1c2VkIHdpdGggZmxhc2ggZGV2aWNlcyBpbiB0aGUNCj4gbWljcm9jaGlwLWNvcmUt
cXNwaSBkcml2ZXIsIGJ1dCBpZiBJIGRlbGV0ZSB0aGlzICFtZW0tPnNwaS0+Y3NfZ3Bpb2QNCj4g
Y2hlY2ssIGFuZCBhZGQgdGhlIGFmb3JlbWVudGlvbmVkIGlmL2Vsc2UgaW4gbXkgZHJpdmVyLCB0
aGUgbWVtIG9wcw0KPiB3b3JrIGZpbmUuDQo+DQo+IFdoYXQgYW0gSSBtaXNzaW5nIHRoYXQgbWFr
ZXMgdGhlbSBpbmNvbXBhdGlibGU/DQoNClRoZSBjb3ZlciBsZXR0ZXIgZnJvbSB0aGlzIHNlcmll
c1sxXSBhZGRzIGEgbGl0dGxlIGNvbnRleHQuIEJhc2ljYWxseSANCnRoZSBoYXJkd2FyZSBkZXNp
Z24gSSB3YXMgZGVhbGluZyB3aXRoIGlzIGEgYml0IG9kZC4gSXQgZG9lc24ndCB3aXJlIHVwIA0K
R1BJT3MgYXMgY2hpcCBzZWxlY3RzIGRpcmVjdGx5IGl0IHVzZXMgYSBHUElPIGFuZCBzb21lIGV4
dHJhIGxvZ2ljIHRvIA0Kc3RlZXIgdGhlIG5hdGl2ZSBDUy4gT24gdGhlIEJDTTU4NTI1IHRoZSBD
UyBhcHBlYXJzIHRvIGJlIGRyaXZlbiANCmF1dG9tYXRpY2FsbHkgKG90aGVyIFNvQ3MgdGhhdCB1
c2UgdGhlIGJjbS1xc3BpIGRyaXZlciBhcHBlYXIgdG8gYmUgYWJsZSANCnRvIGV4cGxpY2l0bHkg
Y29udHJvbCB0aGUgY2hpcCBzZWxlY3QpLiBUaGlzIGNvbWJpbmVkIHdpdGggdGhlIGFiaWxpdHkg
DQp0byBvZmZsb2FkIHRoZSB2YXJpb3VzIHNwaS1tZW0gb3BlcmF0aW9ucyBtZWFucyB3ZSBuZWVk
IHRoZSBzcGkgY29yZSB0byANCmRyaXZlIHRoZSBHUElPwqBDUyBhbmQgdXNlIHRoZSBzdGFuZGFy
ZCBzcGkgb3BlcmF0aW9ucy4NCg0KSSB0aGluayB0aGF0IGNoZWNrIGNvdWxkIHByb2JhYmx5IGJl
IHJlcGxhY2VkIHdpdGggc29tZSBmbGFnIHRoYXQgDQphbW91bnRzIHRvIGRpc2FibGluZyB0aGUg
c3BpLW1lbSBvcHMgd2hlbiB3ZSBkb24ndCBoYXZlIGZ1bGwgY29udHJvbCANCm92ZXIgdGhlIG5h
dGl2ZSBDUy4NCg0KWzFdIC0gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAxOTExMDcw
NDQyMzUuNDg2NC0xLWNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uei8NCg0KPg0KPiBD
aGVlcnMsDQo+IENvbm9yLg0KPg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8Y2hy
aXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvc3Bp
L3NwaS1tZW0uYyB8IDIgKy0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL3NwaS1tZW0uYyBi
L2RyaXZlcnMvc3BpL3NwaS1tZW0uYw0KPj4gaW5kZXggOWYwZmE5ZjMxMTZkLi5lNWE0NmYwZWI5
M2IgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktbWVtLmMNCj4+ICsrKyBiL2RyaXZl
cnMvc3BpL3NwaS1tZW0uYw0KPj4gQEAgLTI4Niw3ICsyODYsNyBAQCBpbnQgc3BpX21lbV9leGVj
X29wKHN0cnVjdCBzcGlfbWVtICptZW0sIGNvbnN0IHN0cnVjdCBzcGlfbWVtX29wICpvcCkNCj4+
ICAgCWlmICghc3BpX21lbV9pbnRlcm5hbF9zdXBwb3J0c19vcChtZW0sIG9wKSkNCj4+ICAgCQly
ZXR1cm4gLUVOT1RTVVBQOw0KPj4gICANCj4+IC0JaWYgKGN0bHItPm1lbV9vcHMpIHsNCj4+ICsJ
aWYgKGN0bHItPm1lbV9vcHMgJiYgIW1lbS0+c3BpLT5jc19ncGlvZCkgew0KPj4gICAJCXJldCA9
IHNwaV9tZW1fYWNjZXNzX3N0YXJ0KG1lbSk7DQo+PiAgIAkJaWYgKHJldCkNCj4+ICAgCQkJcmV0
dXJuIHJldDsNCj4+IC0tIA0KPj4gMi4yNC4wDQo+Pg==
