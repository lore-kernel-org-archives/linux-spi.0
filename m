Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2DF27A476
	for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 22:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130619; cv=none; b=Hm/gEkR7CQfLGO2+0jzjaiUbS/aHvoSQAODMdwur95AxJJC29GteeR+GJQINLBq8SaQelq8HP8pA2sK/cuyL1OCU9TokBvTAehk386jgJ0kHuiekwy1GC7uifda8tojcBS+TfkujVjHqf89pmBrlSkS7gr4TPlU3bRWc52txyTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130619; c=relaxed/simple;
	bh=mzAWIUVQpAyNhjSPyXeR72rjEsQPNyK6Zrhgi4okbsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XfHDieOyJz3MsO0qYXgMrlAeRZ4Tikjb/MWRKEME2/VJwhQ2iP975P7vnWZgGiY9CWNpBXwELRV77E540B0kKG4WdDYRot6u8+6p0Uh19TB7e6mmVZcaYo5YTeEQMnO12TYN3Cr49T3TOoJ0sEY4PsAvB0N/GaWpBVlggTCmW0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DjYoIIQy; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DjYoIIQy"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781130613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=92wJFFcdHhQ/IevfjM861RVw77vb4wy88VlkKgJ8Bpw=;
	b=DjYoIIQycVpbv2gWYgGnJFL2BJ/hVcsCkLbx7HtgGEYvG7EgNvX7VGLhwTRuG4aNzKdrHH
	JuFqjk6ftRW3gF8rVn8yrlu6nFUO+a2zQzs2ueF5XwT9kUQztI6Dhu5YO14/dys0d9nMmA
	onGByl3Zd+pS4rYblL9SUzFUtyMEh9o=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Cc: linux-spi@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH] spi: xilinx: let transfers timeout in case of no IRQ
Date: Wed, 10 Jun 2026 22:28:43 +0000
Message-ID: <20260610222843.782337-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In case of failed HW the driver may not see an interrupt and will stuck
in waiting forever. We can avoid such situation by timing out of
transfers if the interrupt is not seen in a reasonable time.

This problem can be found on unload of ptp_ocp driver for TimeCard which
uses Xilinx SPI AXI and SPI-NOR flash memory. During tear-down process
spi-nor drivers send soft reset command which is not triggering an
interrupt stalling the unload process completely.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/spi/spi-xilinx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 9f065d4e27d1..471936a7bb75 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -285,7 +285,11 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 
 		if (use_irq) {
 			xspi->write_fn(cr, xspi->regs + XSPI_CR_OFFSET);
-			wait_for_completion(&xspi->done);
+			if (!wait_for_completion_timeout(&xspi->done, secs_to_jiffies(1))) {
+				dev_err(&spi->dev, "SPI transfer timed out\n");
+				xspi_init_hw(xspi);
+				return -ETIMEDOUT;
+			}
 			/* A transmit has just completed. Process received data
 			 * and check for more data to transmit. Always inhibit
 			 * the transmitter while the Isr refills the transmit
-- 
2.47.3

