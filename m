Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324898;
	b=Pv3w5TuBpDq0X9PKOzTEufT98myaOOqYeykDWg8vDTyiG0YlIhIxOLFbcRec7nYeU1bK
	 1PCVj6tETjA0WOhmUUDQgSMk/i5RR/+nUoAkYiJLYrQfA9uh/quuCZS6P+/r7QvkYOcQ5
	 OfC3UMJqUlEg47SiwkzA1CIuKr2FS64AHMkR/Fvo6cJL/OeBji876FKwAb5ESS6wqc9Kn
	 0J3mFD8Bo4wsirglfO95ElCjNIAKo2vNk4Gu/rCHe7LxL6bJzGDyoCgu3t5vqgCKn47GE
	 xhDFH/j5WKx5MjVvbv1+NCMYPWy/3tazaEF5ymN/n90JfCs1RYdyyGmG0QXxBLHPbGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324898;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=7rcgps6MImfluxSSn2WTcOL0+DvrZaGtcuT3vAlOnOU=;
	b=L0wBj+z55t/p8rJqgfgixFj9noMZzFgg0oYiVAIxFakbv2w+pJfF+5wSnSUNp6EOahRS
	 fum8dWz3CgDHKYiA+FH6ZjC+sCGGnNIg8eUqyb7Jn5E87+DtVKob1891xEmJxwWhUOwe2
	 Os6Jg6VgO3OVC9e98Ab/68QXEWkQZEiMKQexNPtP+8VXpLMha6vjOxouhYvD5h1RVCyap
	 YziNoD3hnI0l+/QOSsXm1Mf3z5ECgMkw6qorFQtPxIeDuxS7/iswDme7w0nRpRKZzghYP
	 CxPkSyEWo2jSpVWQw1h+MJaDzSlOfcyM2aj/6fmcv+2r9iTX69ZtwuYye5ZGM4i6RMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=guDkJoXd;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDAE606A33A;
	Tue, 10 Nov 2026 15:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEDAE606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=guDkJoXd
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jP9gs1vMxz57HS3;
	Tue, 10 Nov 2026 23:34:49 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794324889;
	bh=HCWfuzAN+AMe0nrrXGOghlVGYDRgVDFTNAe2SncsUIs=;
	h=Date:From:To:Cc:Subject;
	b=guDkJoXdJQvEWIe1CHP4KnQVolrmBcYfXSvRHr3Cekn82jHtDB1AQJYSD03Cttgbf
	 tpPGK2eAtixqtLlANiOHc4KyygrMATpmh0SVfmjX+I1F/CHnWVW5GMb7esYE6TXv1U
	 RAVqSjHsDPILBRbuHjlGSYVKe9b5Kxv6ybTwzTE7leRjE1N8+Ep19Wkwdnp3LP8F4o
	 yStuzEI7pk0/40Fl6MyMsEY/fDGDd2SeUqJxf1D8JtLCG6cpIcMT+FYfeAZeYbz7M2
	 sAe9l6h21VAKODQzZEkLYOPjNodP7Qdc9MPnykkSGVq8XU3z4iqHwb+fOAldP66rxv
	 Ixl+GkKsYieJg==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6AAFYkPO047648;
	Tue, 10 Nov 2026 23:34:46 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 23:34:50 +0800 (CST)
X-Zmail-TransId: 2afb6af3399a6e7-27d05
X-Mailer: Zmail v1.0
Message-ID: <20261110233450305Smji446Uhvoxa7r8SHEgl@zte.com.cn>
Date: Tue, 10 Nov 2026 23:34:50 +0800 (CST)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <pjw@kernel.org>, <samuel.holland@sifive.com>,
        <william.zhang@broadcom.com>, <kursad.oney@broadcom.com>,
        <jonas.gorski@gmail.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <anand.gore@broadcom.com>, <florian.fainelli@broadcom.com>,
        <rafal@milecki.pl>, <linux-arm-kernel@lists.infradead.org>,
        <sven@kernel.org>, <j@jannau.net>, <neal@gompa.dev>,
        <asahi@lists.linux.dev>, <ryan.wanner@microchip.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@tuxon.dev>
Subject: =?UTF-8?B?W1BBVENIIHYyIDAvNV0gc3BpOiBmaXggZGl2aXNpb24gYnkgemVybyB3aXRoIGEgemVybyB0cmFuc2ZlciBzcGVlZA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AAFYkPO047648
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 10 Nov 2026 23:34:49 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF33999.000/4jP9gs1vMxz57HS3

Five SPI controller drivers compute a clock divider from the transfer
speed without checking that it is non-zero.  A SPI device whose
max_speed_hz is zero (a DT node without spi-max-frequency, or a device
created through the spidev sysfs new_device interface without a speed)
therefore reaches the division with speed_hz == 0.  The SPI core clamps
such a device to the controller limit only when host->max_speed_hz is
set, and none of these five drivers sets it.

The series is organized by driver and is independent patch-by-patch;
each patch can be applied and reviewed on its own, and taking a subset
is fine:

  1/5 spi: sifive: clamp the clock divider to the register range
  2/5 spi: bcm63xx-hsspi: fix division by zero for devices without a max speed
  3/5 spi: bcmbca-hsspi: fix division by zero for devices without a max speed
  4/5 spi: apple: fix division by zero in clock divisor calculation
  5/5 spi: atmel: use the maximum divider for an unspecified speed

1/5 and 5/5 program the slowest clock directly when no speed is supplied;
2/5-4/5 clamp the requested rate to 1 Hz.  The division does not trap on
the SoCs these drivers run on: depending on the architecture it produces
a bogus divider, a zero quotient or an undefined value, so the patches
remove undefined arithmetic rather than a crash.

Changes in v2:
- 1/5: use the maximum SCKDIV for a zero speed and saturate an excessive
  divider instead of masking away the high bits (Mark Brown).
- 5/5: select SCBR=255 directly for a zero speed instead of dividing a
  substituted 1 Hz and then failing the range check (Mark Brown).
- 2/5, 3/5 and 4/5: unchanged.
- This series replaces the two standalone v2 patches posted on 10 Nov for
  1/5 and 5/5.
Link to v1: https://lore.kernel.org/all/20261106234751020Egf42VCVVlsSC_Msov4HO@zte.com.cn/

Shao Mingyin (5):
  spi: sifive: clamp the clock divider to the register range
  spi: bcm63xx-hsspi: fix division by zero for devices without a max speed
  spi: bcmbca-hsspi: fix division by zero for devices without a max speed
  spi: apple: fix division by zero in clock divisor calculation
  spi: atmel: use the maximum divider for an unspecified speed

 drivers/spi/spi-apple.c         | 6 +++++-
 drivers/spi/spi-atmel.c         | 5 ++++-
 drivers/spi/spi-bcm63xx-hsspi.c | 3 +++
 drivers/spi/spi-bcmbca-hsspi.c  | 3 +++
 drivers/spi/spi-sifive.c        | 9 ++++++---
 5 files changed, 21 insertions(+), 5 deletions(-)

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
