Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980079;
	b=LstZ3ITvd5S14jS9bNvVXzVJrG3JsnFhunCy/bu13f5Hxhg7OM6CgZDqV7HMTkAduEtM
	 sB8j2iCuOQG9oasXRxNMdlHvCzaNhRzLsYHW+pshFMG6eQGadKrTNLRBBECk3G9ORdcQG
	 k3V84SedPq4TH7C/T4rPYnylW4cr3Ra69RF7x8Hgqbz0dYljNVRNFRHKxSJ/zyJqql1AW
	 0ufA0ceNdj3Ws5nLGMVKLNx1Am+iMypeE70PJXl01+M6JU/DOrmIpIJx4pLQMGBpj09f3
	 AnO15HHrvQPFRbcLQ0vLL8Eo2X4yQNP9Kv8dvT+y6G7zDkfUVnGz11I0GlDrS7AJOBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980079;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=QrSS4RlyaBM4FHvHozkdG4FXIui6GgotEYZEXG8ABEw=;
	b=nKVVrhc1kgWGWi3+fPiS80OFCzC9R3f1WZJCsMvEb1XogRALFPElsmtMvAGztNhEa/+U
	 8ST9Zdan38w2Ay/qGaTTehc3gckOIVUwbxntFd+hdxr0tCSCBJiGfliGsb6Cnz+nGx05K
	 Mv1ivd8eM0U3OB3lTQqbrAaRu+geZc6+7lA5YQmsnm9FaTlILADUQljUP476eUVLqYVZn
	 c/SysXJH2/XoMRzpE3jXXY4Y0RtHcU4+radK6qqoFmK0qLTsOP2AfB8qOAOm33J1SF9dT
	 kHC+49C09BtmdBEoVRlsBUM74lfSxNk8EqNMvvtgMxVqQkHtMf2E1NjOc4F21cKE8yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EA1606A32C;
	Fri,  6 Nov 2026 15:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60EA1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jLk8q5Qxvz5B12h;
	Fri, 06 Nov 2026 23:47:55 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6A6FlljR080906;
	Fri, 6 Nov 2026 23:47:47 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 6 Nov 2026 23:47:51 +0800 (CST)
X-Zmail-TransId: 2afa6aedf6a75dc-a6563
X-Mailer: Zmail v1.0
Message-ID: <20261106234751020Egf42VCVVlsSC_Msov4HO@zte.com.cn>
Date: Fri, 6 Nov 2026 23:47:51 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDAvNV0gc3BpOiBmaXggZGl2aXNpb24gYnkgemVybyB3aXRoIGEgemVybyB0cmFuc2ZlciBzcGVlZA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A6FlljR080906
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Fri, 06 Nov 2026 23:47:55 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEDF6AB.000/4jLk8q5Qxvz5B12h

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

  1/5 spi: sifive: fix division by zero in clock divisor calculation
  2/5 spi: bcm63xx-hsspi: fix division by zero for devices without a max speed
  3/5 spi: bcmbca-hsspi: fix division by zero for devices without a max speed
  4/5 spi: apple: fix division by zero in clock divisor calculation
  5/5 spi: atmel: fix division by zero when transfer speed is zero

All five clamp the divisor to 1 Hz, the same approach as the recent
spi-jcore fix.  The division does not trap on the SoCs these drivers run
on: depending on the architecture it produces a bogus divider, a zero
quotient or an undefined value, so the patches remove undefined
arithmetic rather than a crash.

Shao Mingyin (5):
  spi: sifive: fix division by zero in clock divisor calculation
  spi: bcm63xx-hsspi: fix division by zero for devices without a max speed
  spi: bcmbca-hsspi: fix division by zero for devices without a max speed
  spi: apple: fix division by zero in clock divisor calculation
  spi: atmel: fix division by zero when transfer speed is zero

 drivers/spi/spi-apple.c         | 6 +++++-
 drivers/spi/spi-atmel.c         | 3 ++-
 drivers/spi/spi-bcm63xx-hsspi.c | 3 +++
 drivers/spi/spi-bcmbca-hsspi.c  | 3 +++
 drivers/spi/spi-sifive.c        | 6 +++++-
 5 files changed, 18 insertions(+), 3 deletions(-)

---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
