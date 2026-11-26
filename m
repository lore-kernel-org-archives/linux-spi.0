Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795720258;
	b=qrR1VB/WlkVI9k+EXEZ/UhBnoQV7N3ScIBqpf1Hky/ISvZ6asR1Gco5hLE2sZCoKGEoS
	 Cm8CrUFKnmzsa4aXG0X9NNDu9RyitJFhF4CVqi/LMMCKTs3uzXy8VKd1idSZS+DKm8SH6
	 TPFbAT4FDTxm97vIHj9kt4193Yu+3eh3vB5S8ze497p00NLKrkzjhl0X3BaIwRgFACFPS
	 6xjSABHum7SXLnzjqHvbh4ObI/pCcd0YMpg9PtatpJYH+1NAe2CfhEZ60qayk6EEoN95U
	 UI+DyqW6bqRwfntgn4wLUCtoqmnuTjMfqby7ggfURqF0C1Bxlh3e8cTAfiQdbOdj3UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795720258;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=fejE54wjl8pNmBwZZ3oMj7oENLwjgt5QRFDy7wYzURY=;
	b=jMBjb2WfAebyvThar6L1DWWrpNBFiEUPCMZicxyX8sWfZaZCGy/uheVp01IK7SWSNteT
	 S0iKmxZYygH2Sr2ZZ77tKV4jdYKAabxtjScLmbEMvLAyEPL+VOuzcjh131s1Bkju2m2I9
	 yuglAv5cHF9JP976WCC2aXfjPHJBaS6hXV6J37bPZUmjcv9fkQ9pucoIvTftRAUY2SRAT
	 EEV2iIzEz0N3TTEoZ6s73LmSFiq8T8ZNu1GZuJj0NMY5Q+yO+i9Fx+Y7hZeE8iXWop9yF
	 SvCW3VUvdYvaKfZ0fGohd+Ri4pEsP+kQo15rvWh/1Nuvaif432KgFMSC05as8VXuD8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=oj4WkvGj;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D43606A31C
	for <linux-spi@vger.kernel.org>; Thu, 26 Nov 2026 19:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12D43606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=oj4WkvGj
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 523021A181E;
	Thu, 26 Nov 2026 19:10:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 24F0360558;
	Thu, 26 Nov 2026 19:10:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AC92C11E691C1;
	Thu, 26 Nov 2026 20:10:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795720248; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=fejE54wjl8pNmBwZZ3oMj7oENLwjgt5QRFDy7wYzURY=;
	b=oj4WkvGjpbEtCXPXvNYdoiZmxVhE6DjkCqZq0eOfEiUFId5EcyjXmi4+P6Koqyi5JkVTKe
	M7A+g43HhTLnx2u5ekqs+lz94vuYcuMxDNgxPmy5+iJcNdkM/uBGv1ugIK4TgXOR8r6Nf3
	kXb0wpd2BGkBxjUnK0aMg0qZ8dQIrlsWhKIFkcOT5HpHHp3wRXW1u3fMqO5cQc5Bj6+CpA
	rR1z5AOoNbbiNUiJTHsqRfSfqir6IXN9J9KvjrXzbAJ2bDqlIC1SlbnQ6BfNU7GKqAE8Uq
	QehLkdjxDtvfc486eBghnDQ5cah8AN3WtAhVwur1im9H/KCTC9hloLnpMF1xDQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 00/12] spi: Misc fixes around the dummy buswidth handling
Date: Thu, 26 Nov 2026 20:10:19 +0100
Message-Id: <20261126-macronix-upstreaming-spi-driver-fixes-v1-0-ca8e924cca1b@bootlin.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNQQ6DMAwEvxL5XFclVED5SsUhBEN9SEJtQEiIv
 zcqx5mVZg9QEiaF1hwgtLFyihmKmwH/cXEi5CEz2IetisJWGJyXFHnHddZFyAWOE+rMOAhvJDj
 yTor9qxybsa8bV5eQW7PQf8ipd3ex0HfNd8sloXdK6FMIvLRmq+9PFF9Cd54/hr90GKMAAAA=
X-Change-ID: 20261126-macronix-upstreaming-spi-driver-fixes-b93f8fb78a73
To: Raju Rangoju <Raju.Rangoju@amd.com>, 
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, 
 Mark Brown <broonie@kernel.org>, CL Wang <cl634@andestech.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Yang Shen <shenyang39@huawei.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Cheng Ming Lin <linchengming884@gmail.com>, 
 Alvin Zhou <alvinzhou@mxic.com.tw>, 
 Cheng Ming Lin <chengminglin@mxic.com.tw>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-riscv@lists.infradead.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

While working on the dummy.nbytes -> dummy.ncycles conversion and
especially the conversion of the spi controller drivers, I realized
there were many misuses of the buswidth (plus some misc enhancements).

This series is sometimes limiting the dummy buswidth to be the same as
the data buswidth, which means I am now flagging controllers (or at
least drivers) which I believe do not support 1-1-2, 1-1-4 or 1-1-8
transfers. This is required to avoid issues on the number of dummy
cycles on controllers handling the dummy phase as an amount of data
("bytes"). For the controllers managing cycles we now have a much
cleaner alternative, which will be implemented in a following series.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Miquel Raynal (12):
      spi: amd: Validate the dummy buswidth
      spi: amlogic-spifc-a1: Fix a typo in a macro
      spi: atcspi200: Validate the dummy buswidth
      spi: ath79: Validate the dummy buswidth
      spi: atmel-quadspi: Drop redundant address buswidth check
      spi: atmel-quadspi: Reject SDR address with DDR data
      spi: atmel-quadspi: Advertise DTR for the octal controller
      spi: hisi-sfc-v3xx: Validate the dummy buswidth
      spi: mtk-nor: Validate the dummy buswidth
      spi: sg2044-nor: Validate the dummy buswidth
      spi: ti-qspi: Validate the dummy buswidth
      spi: zynq-qspi: Validate the dummy buswidth

 drivers/spi/atmel-quadspi.c        |  6 +++++-
 drivers/spi/spi-amd.c              |  3 +++
 drivers/spi/spi-amlogic-spifc-a1.c |  6 +++---
 drivers/spi/spi-atcspi200.c        | 13 +++++++++++++
 drivers/spi/spi-ath79.c            |  3 ++-
 drivers/spi/spi-hisi-sfc-v3xx.c    |  3 +++
 drivers/spi/spi-mtk-nor.c          |  3 +++
 drivers/spi/spi-sg2044-nor.c       | 13 +++++++++++++
 drivers/spi/spi-ti-qspi.c          | 13 +++++++++++++
 drivers/spi/spi-zynq-qspi.c        |  4 ++++
 10 files changed, 62 insertions(+), 5 deletions(-)
---
base-commit: 19d1b4de6d37bccecc3ad9144d279f1baa405eb1
change-id: 20261126-macronix-upstreaming-spi-driver-fixes-b93f8fb78a73

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

