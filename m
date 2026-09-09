Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C2F2D12EC;
	Wed,  9 Sep 2026 03:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788924023; cv=none; b=MpyaCLkQ34ROY5je2xlogl3j/PIUOhrY4IgGy5GkpZLPCdA3AM3xd27binlNIVqFYgQvfVdMfLVjSEf4g9xageKmYEfRVeRo2hvAmcIS7wzyVakEcMe8ax16wea6u1OwkdFGoNtUV5hIe1d08W/vUH456ClJ7Rdcu8WwCrsFvq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788924023; c=relaxed/simple;
	bh=SkBTBjYGn401hwaudL1ax6Vqhw3ttD1573QC4X77+1w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MSnb7DyLl2AZm9J2VAj6bnPhkg2SoMKBYoZcRClbIc2kJQRB/8Kik8LT2ALvMCaECRSfJmdtEPh+T9r5BYh5rTZ/rAZ/WK61WDVkkCwQTmnOZClw5n8q0wYXyuRYI0s9dMtRRuC6J0XQjztIolKroW/crvuFEibsGxRhTrvVkoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Z0ZLcwnn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Z0ZLcwnn"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6893K7epC255337, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788924008; bh=SkBTBjYGn401hwaudL1ax6Vqhw3ttD1573QC4X77+1w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Z0ZLcwnnpRa5dnFdmsPdH/YjDB2bJ2s5Yr3ZFtQBYxW0KiozKRAn00G27ycXxH2El
	 c6TJ4zFKYLhvtWMlCmC3W7fZBKtDnYenqDJXFcs5o9j6DG+7UXbBKdwqtqJS7vxKmJ
	 U+Q5Bpfc+niRrEWLx30RzP8LlHgjKUOxWUT19zXEO2d3cfkiUmNB9ZZQwgHWyv6Oda
	 nk20rbbzKTJX8hKigRLqau/J4iW7/y5A/ef+cEk9IEpLXH4z3yLJs7bQ/PNIz7cm42
	 b1hoTFh5aU5ihlsR4NiBmGlrumAvzgutuMDMSawa8hhRZ0eleDFLe+e4B+lwdh0ZA5
	 WHd7gJN1/Re4A==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6893K7epC255337
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 9 Sep 2026 11:20:08 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 9 Sep 2026 11:20:07 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 9 Sep 2026 11:20:07 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::126f:59ad:658:674d%10]) with mapi id
 15.02.2562.043; Wed, 9 Sep 2026 11:20:07 +0800
From: =?big5?B?WXUtQ2h1biBMaW4gW6pMr6enZ10=?= <eleanor.lin@realtek.com>
To: =?big5?B?WXUtQ2h1biBMaW4gW6pMr6enZ10=?= <eleanor.lin@realtek.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	=?big5?B?SmFtZXMgVGFpIFvAuafTrnBd?= <james.tai@realtek.com>,
	=?big5?B?Q1lfSHVhbmdbtsDgsq7LXQ==?= <cy.huang@realtek.com>,
	=?big5?B?U3RhbmxleSBDaGFuZ1up96h8vHdd?= <stanley_chang@realtek.com>,
	=?big5?B?SnlhbiBDaG91IFupUKrppndd?= <jyanchou@realtek.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/2] spi: realtek: Add support for RTD1625 SPI NOR
 Flash Controller
Thread-Topic: [PATCH v3 0/2] spi: realtek: Add support for RTD1625 SPI NOR
 Flash Controller
Thread-Index: AQHdP4OF65yhmvO3fEK+nHFI+NB2erbFlHug
Date: Wed, 9 Sep 2026 03:20:06 +0000
Message-ID: <9957b93157274a88a1161debaa6a76fc@realtek.com>
References: <20260908111640.2032749-1-eleanor.lin@realtek.com>
In-Reply-To: <20260908111640.2032749-1-eleanor.lin@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiBIaSBhbGwsDQo+IA0KPiBUaGlzIHBhdGNoIHNlcmllcyBpbnRyb2R1Y2VzIHN1cHBvcnQgZm9y
IHRoZSBSZWFsdGVrIFJURDE2MjUgU1BJIE5PUiBGbGFzaA0KPiBjb250cm9sbGVyLg0KPiANCj4g
VGhhbnNrLA0KPiBZdS1DaHVuDQo+IC0tLQ0KDQpNeSBhcG9sb2dpZXMsIHRoaXMgcGF0Y2ggc2Vy
aWVzIHdhcyBhY2NpZGVudGFsbHkgZ2VuZXJhdGVkIGZyb20gdGhlDQp3cm9uZyBicmFuY2guIFBs
ZWFzZSBpZ25vcmUgaXQuDQoNCkkgd2lsbCBzZW5kIHRoZSB2NCBwYXRjaCBzZXJpZXMuDQoNCkJl
c3QgcmVnYXJkcywNCll1LUNodW4gTGluDQo=
