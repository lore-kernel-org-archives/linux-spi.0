Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010118;
	b=i0ANFwV+wM0TH0geH/zYrZ3YNTK7snLJ343Z2fTRmeH7QvTqtQU8rVjQmwS1/klirMq1
	 CubZBMv/BG7OmRNMnKFTPQ6aJWltfk2pH9oVFKsLtTyoJYXD94GdFsVcd1hzVfmB3md3E
	 ykgOTQpP1Bv5fzQN6zSRpVyjQd8qsze3MUJFf5kbYb17MNWAIIC4YKAa5gzLeHKsUOaNx
	 U8pIfn0jJgdVtbIZUssEfQUzkc75ceNCTCDXK37slLJQe0GcWKg2pkblU+/dYCJz5um37
	 /9naDVJn0ChtEFbwniK5MbX8LC7j0/wXEFCRUtk8zlNPe//GryctzDXbJXL/dOUk2sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010118;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=BNHb2upVNRY1oGSJTHZzcy5zKsk+4JwuCx/BHx8TrMs=;
	b=CrvQdcefCgFC0BLUMMDCMZI5aJbALnnxdHXW4M6kMIpBTYge0fb+XWAnLuMOFljzRhai
	 lEAtqH3J6lo1uxf5acdJ6FoJs33MnwNm7ChfNNT16Ze6UTxQaVlVpVTnzpM7V3x0RLAYr
	 cRB+wLk+kjqx9GC8oGTRztd+IROmDoe3Wo2518Whof86nl7JhChqZzEpNtCotZ96pgdnj
	 V1vdeKDN7UEMactLhnTx6tReovH+BoYgW4o6TXAz5twZkFlh13+MAU2Kzd6g+PlDv3eOi
	 z+Ka+Uc59GtI+8rdPdDRXKvYmjgrkxC9fS25LMwh5fvU4nv9SHaiUpRZnpGMiJATI3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=1qPAgq9+;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44D160A2608
	for <linux-spi@vger.kernel.org>; Wed, 18 Nov 2026 13:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C44D160A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=1qPAgq9+
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7B5CF1A16D0;
	Wed, 18 Nov 2026 13:55:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 41D435FE9B;
	Wed, 18 Nov 2026 13:55:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E80A811BC0D19;
	Wed, 18 Nov 2026 14:55:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795010111; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BNHb2upVNRY1oGSJTHZzcy5zKsk+4JwuCx/BHx8TrMs=;
	b=1qPAgq9+GFSv/Un0KX3shDlC84r25LP5ddJJ/+Xz4sH6rqddbyR/7o3HxtN7uidbJmQ+3a
	UpaOWuUhbF3yw/Z7VGf73VfN0z7nNLJw1C3FIQRTFbyDeBMgD5OnbmYUOUv8nvvB117Zod
	lZ57zwXAN0YYSflc/4Z0D1WtEt9Qctjt9aLpezb8/QUlsv4mCBafvIbhT1XOWF2kJoN4iH
	xfK0oOTjkmskMCI5LV2bSWmdHIe1iCSUEMWrbc6DhiZbUjkEDFadTHHXWeFULp7qCRLPKf
	Hrh9qQghPazm3NekrIV8HAFm1ybXB3xN/ixliH9EVbpxNwY0MTA5UvMzHzcXaw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 18 Nov 2026 14:54:56 +0100
Subject: [PATCH 2/3] spi: ma35d1-qspi: reschedule during long PIO transfers
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
Message-Id: <20261118-winbond-upstreaming-ma35d1-qspi-cont-read-fix-v1-2-e5066ad2efe3@bootlin.com>
References: <20261118-winbond-upstreaming-ma35d1-qspi-cont-read-fix-v1-0-e5066ad2efe3@bootlin.com>
In-Reply-To: <20261118-winbond-upstreaming-ma35d1-qspi-cont-read-fix-v1-0-e5066ad2efe3@bootlin.com>
To: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <stlin2@winbond.com>, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The driver performs every transfer byte by byte in PIO mode, polling the
FIFO status between each byte. Since spi-mem operations can span over an
entire block (128 or 256 kiB), the CPU may be kept in this loop for a
long time.

The spi-mem ->exec_op() path does not go through __spi_pump_messages(),
which is where the SPI core adds a cond_resched() after a transfer. On
kernels without involuntary preemption (unlikely on embedded systems
with this controller, but still), nothing would yield in between. To
avoid keeping the CPU for ourselves for too long in these cases, add a
cond_resched() point every 4 KiB in the data loop.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-ma35d1-qspi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-ma35d1-qspi.c b/drivers/spi/spi-ma35d1-qspi.c
index 1ec631afa403..65dbad6f63c7 100644
--- a/drivers/spi/spi-ma35d1-qspi.c
+++ b/drivers/spi/spi-ma35d1-qspi.c
@@ -328,6 +328,9 @@ static int nuvoton_qspi_txrx(struct nuvoton_qspi *qspi, const void *txbuf,
 		val = nuvoton_qspi_read(qspi, NUVOTON_QSPI_RX_OFFSET);
 		if (rxbuf)
 			nuvoton_qspi_rx_byte(rxbuf, i, val);
+
+		if (i && !(i % NUVOTON_QSPI_MAX_TRANSFER_SIZE))
+			cond_resched();
 	}
 
 	ret = nuvoton_qspi_wait_ready(qspi);

-- 
2.56.0

