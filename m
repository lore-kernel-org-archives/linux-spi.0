Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583363;
	b=zqtlwxXEybXMzRfHV1V5RCFFs6kI2p721nB14SPpXw3s6jBPX8id8h5T/hhBXTrh1XYS
	 fbDtDYvU6HgtIvuKKCDL6u7ehMNrHB2AL5/wjoIIkKx4IohGzaEf3hMDTtqv4HJh+bCYk
	 HLuIc3/Pf8F0fH1hQgt0dGE9AkmP2jrWPa+QfkRLTmOFc3gQx6C+7N6aq0BOKSWODQo1J
	 YF+WHpb2HhghcKyFCJa8l9QBc6QxYkAVyoQXbbrLwLwt97Te1P1WBHc9Wc1VnaZLTnna6
	 4AJKeIHYY8I6Avb9pg7fGP6ATrNT15Vaik8yhMnSZzpL3krWgRI/eh2SJVJc+UVsJNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583363;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:X-B4-Tracking:To:CC:X-Mailer;
	bh=JcR0yzIY7Avjw5dM5OpUaEfboB1lvkpzLohI8a5q8T4=;
	b=PHyyqqhIjcyn9SWIaFColRbkDUWhjdu3Wjcn2pzisKeMrYnnoyXqAsEaeKTIHfhU2idX
	 BphCTIG647148qWTj/Hl4aYl0OJV9Un7IEzUbswXuRQXYFVaQDDm3jPC79uoy1z2d90/L
	 Y9/hmophoieEYSVeclD9VvVpKXnEVB6p0DmswlvtGrNgBrHR/eW1DJh+gfw9hCBrOuvee
	 6Tldp/N98QX1Vgo4fNvDDKAv93FlxsDDNmkqWpcZBP5TXHRGpt6yiiVe2VzWN2zmE2gG0
	 9+IQJGlZ7lLN1Ofxp1yefcBRxo31faPins5ZQ7FgPlc33PNC6ZPX2dLDzc9vHjVYV7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=PO3b7Ysn;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19394606A32D;
	Fri, 13 Nov 2026 15:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19394606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=PO3b7Ysn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794583370; x=1826119370;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=yK1v7SYypYtxMYlBOK+reDEg6ri+YCAaPK6wJTbMxnU=;
  b=PO3b7YsnpUaWtPrddnI4l1v7YEXGWzILOvMNDWJ5IyJkeMYJABgfNaEm
   fxmGz4XPH+hYozJbvXiX/syxbDZclqHP4BgfT3zs4YfEBaFqr8h8f5XH7
   Kk7JNvuLqiYeYzqFDNTq68+6eBAUpa8ztwisOB3J19NwmhVndmi0q80RO
   N17g9ietCZtLwewa3CdJfKwYooTe4+sqARqCwomF4Iufr6gCETdPK1yEj
   1a7sXHNWu3wzMEqBkEU9sbWstr5MYiscqKSR7iVeiYuvSOKkczbU20uS+
   X0K7zRsi6rma8sAaXy99kWqcc0lY+4A12aK2FABuH0eASn7hLvCQ0qu0o
   Q==;
X-CSE-ConnectionGUID: vLFyY87STx+IHUXMC/WZyg==
X-CSE-MsgGUID: qsDzMb4CTFqyVRSfxDtNtw==
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="297886620"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2026 08:21:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 13 Nov 2026 08:20:42 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Fri, 13 Nov 2026 08:20:40 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Fri, 13 Nov 2026 16:20:32 +0100
Subject: [PATCH v2] spi: atmel: poll short PIO transfers
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
Content-Transfer-Encoding: 8bit
Message-ID: <20261113-spi-atmel-poll-short-pio-transfers-v2-1-f280762685e2@microchip.com>
X-B4-Tracking: v=1; b=H4sIAL8q92oC/5WNQQ6CMBAAv0L27BpaDQFP/sNwoEuxmwBtdhuiI
 fzd6g88zhxmdlAv7BVu1Q7iN1aOawF7qoDCsD498lgYbG0bY4xFTYxDXvyMKc4zaoiSMXHELMO
 qkxdFN7YTuY5M5xyUUBI/8es3efSFA2uO8v49N/O1f+U3gwbttSaitmmJLveFSSIFTmeKC/THc
 XwAxBWKrtgAAAA=
To: Ryan Wanner <ryan.wanner@microchip.com>, Mark Brown <broonie@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
CC: <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.15-dev

Every PIO transfer enables the controller interrupt and sleeps in
wait_for_completion_timeout() until the interrupt handler has drained the
receive data. For a transfer of a few bytes, the interrupt, the
completion and the two context switches take several times longer than
the transfer on the wire. Devices that do their register IO over SPI,
such as SPI attached Ethernet switches, issue one message of a few short
transfers per register access, so this overhead dominates their register
access time.

Busy-wait on the status register instead of enabling the interrupt when
the transfer is estimated to take less than 30 us, which is the limit
spi-bcm2835, spi-imx and spi-stm32 use. The estimate uses the effective
clock rate and the word delay.

An earlier interrupt driven transfer, for example one that timed out,
can leave the receive and overrun interrupts enabled. Such an interrupt
can be delivered while a poll is in progress, and with PREEMPT_RT its
threaded handler can run at any later time.

Set the poll flag and mask these interrupts under the controller lock
before a polled transfer is started. Take the lock in the interrupt
handler before it reads the status register, and return without touching
the controller while the poll flag is set, so that the handler cannot
consume the status we are polling for.

Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
Changes in v2:
- Drop the polling_limit_us module parameter, poll below a fixed 30 us
- Set the poll flag and mask the interrupts under the lock, and let the
  interrupt handler take the lock and return while a poll is in progress
- Drop the remaining-bytes check in the poll, the interrupt handler no
  longer runs while a poll is in progress
- Link to v1: https://lore.kernel.org/r/20261112-spi-atmel-poll-short-pio-transfers-v1-1-240ccc868cc3@microchip.com
---
 drivers/spi/spi-atmel.c | 85 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 79 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index ffc1292b08c1..ea89a75850b6 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -234,6 +234,8 @@
  */
 #define DMA_MIN_BYTES	16
 
+#define POLL_LIMIT_US	30
+
 #define AUTOSUSPEND_TIMEOUT	2000
 
 struct atmel_spi_caps {
@@ -274,6 +276,7 @@ struct atmel_spi {
 
 	bool			use_dma;
 	bool			use_pdc;
+	bool			poll;
 
 	bool			keep_cs;
 
@@ -706,7 +709,8 @@ static void atmel_spi_next_xfer_single(struct spi_controller *host,
 		xfer->bits_per_word);
 
 	/* Enable relevant interrupts */
-	spi_writel(as, IER, SPI_BIT(RDRF) | SPI_BIT(OVRES));
+	if (!as->poll)
+		spi_writel(as, IER, SPI_BIT(RDRF) | SPI_BIT(OVRES));
 }
 
 /*
@@ -776,7 +780,8 @@ static void atmel_spi_next_xfer_fifo(struct spi_controller *host,
 	 * Enable RX FIFO Threshold Flag interrupt to be notified about
 	 * transfer completion.
 	 */
-	spi_writel(as, IER, SPI_BIT(RXFTHF) | SPI_BIT(OVRES));
+	if (!as->poll)
+		spi_writel(as, IER, SPI_BIT(RXFTHF) | SPI_BIT(OVRES));
 }
 
 /*
@@ -1151,6 +1156,13 @@ atmel_spi_pio_interrupt(int irq, void *dev_id)
 	struct spi_transfer	*xfer;
 	int			ret = IRQ_NONE;
 
+	atmel_spi_lock(as);
+
+	if (as->poll) {
+		atmel_spi_unlock(as);
+		return IRQ_NONE;
+	}
+
 	imr = spi_readl(as, IMR);
 	status = spi_readl(as, SR);
 	pending = status & imr;
@@ -1178,8 +1190,6 @@ atmel_spi_pio_interrupt(int irq, void *dev_id)
 		complete(&as->xfer_completion);
 
 	} else if (pending & (SPI_BIT(RDRF) | SPI_BIT(RXFTHF))) {
-		atmel_spi_lock(as);
-
 		if (as->current_remaining_bytes) {
 			ret = IRQ_HANDLED;
 			xfer = as->current_transfer;
@@ -1189,14 +1199,14 @@ atmel_spi_pio_interrupt(int irq, void *dev_id)
 
 			complete(&as->xfer_completion);
 		}
-
-		atmel_spi_unlock(as);
 	} else {
 		WARN_ONCE(pending, "IRQ not handled, pending = %x\n", pending);
 		ret = IRQ_HANDLED;
 		spi_writel(as, IDR, pending);
 	}
 
+	atmel_spi_unlock(as);
+
 	return ret;
 }
 
@@ -1375,6 +1385,56 @@ static void atmel_spi_set_cs(struct spi_device *spi, bool enable)
 
 }
 
+static bool atmel_spi_use_poll(struct atmel_spi *as,
+			       struct spi_transfer *xfer)
+{
+	u32 hz = xfer->effective_speed_hz ?: xfer->speed_hz;
+	int word_delay_ns;
+	u32 words;
+	u64 us;
+
+	if (as->use_pdc || atmel_spi_use_dma(as, xfer) || !hz)
+		return false;
+
+	us = div_u64((u64)xfer->len * BITS_PER_BYTE * USEC_PER_SEC, hz);
+
+	word_delay_ns = spi_delay_to_ns(&xfer->word_delay, xfer);
+	if (word_delay_ns > 0) {
+		words = xfer->len / DIV_ROUND_UP(xfer->bits_per_word,
+						 BITS_PER_BYTE);
+		us += div_u64((u64)words * word_delay_ns, NSEC_PER_USEC);
+	}
+
+	return us < POLL_LIMIT_US;
+}
+
+static int atmel_spi_poll_xfer(struct atmel_spi *as,
+			       struct spi_transfer *xfer)
+{
+	u32 done = as->fifo_size ? SPI_BIT(RXFTHF) : SPI_BIT(RDRF);
+	u32 status;
+	int ret;
+
+	ret = readl_poll_timeout(as->regs + SPI_SR, status,
+				 status & (done | SPI_BIT(OVRES)),
+				 0, POLL_LIMIT_US * 10);
+	if (ret) {
+		dev_err(&as->pdev->dev, "spi transfer timeout\n");
+		return -EIO;
+	}
+
+	if (status & SPI_BIT(OVRES)) {
+		dev_warn(&as->pdev->dev, "overrun\n");
+		return -EIO;
+	}
+
+	atmel_spi_lock(as);
+	atmel_spi_pump_pio_data(as, xfer);
+	atmel_spi_unlock(as);
+
+	return 0;
+}
+
 static int atmel_spi_one_transfer(struct spi_controller *host,
 					struct spi_device *spi,
 					struct spi_transfer *xfer)
@@ -1409,9 +1469,15 @@ static int atmel_spi_one_transfer(struct spi_controller *host,
 
 	atmel_spi_set_xfer_speed(as, spi, xfer);
 
+	atmel_spi_lock(as);
 	as->done_status = 0;
 	as->current_transfer = xfer;
 	as->current_remaining_bytes = xfer->len;
+	as->poll = atmel_spi_use_poll(as, xfer);
+	if (as->poll)
+		spi_writel(as, IDR, (as->fifo_size ? SPI_BIT(RXFTHF) :
+				     SPI_BIT(RDRF)) | SPI_BIT(OVRES));
+	atmel_spi_unlock(as);
 	while (as->current_remaining_bytes) {
 		reinit_completion(&as->xfer_completion);
 
@@ -1437,6 +1503,13 @@ static int atmel_spi_one_transfer(struct spi_controller *host,
 			atmel_spi_lock(as);
 			atmel_spi_next_xfer_pio(host, xfer);
 			atmel_spi_unlock(as);
+
+			if (as->poll) {
+				as->done_status = atmel_spi_poll_xfer(as, xfer);
+				if (as->done_status)
+					break;
+				continue;
+			}
 		}
 
 		dma_timeout = msecs_to_jiffies(spi_controller_xfer_timeout(host, xfer));

---
base-commit: 2bc7eb398cd0f89fd2331d5a1a8fe7ed17addd35
change-id: 20261112-spi-atmel-poll-short-pio-transfers-bd8fcb9c19bb

Best regards,
-- 
Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>

