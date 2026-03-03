Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9344F796C;
	Tue,  3 Mar 2026 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555832; cv=none; b=Q/tL0VKXrJSVicSvruF/ofNKBD8x+OV5Bjb82WdDAZ2YgSzfARSmNBa6I60sBuxytxKkhc5sWH/m4uwbv2x95OfN4Gr0v8XbbEZE5JNrD4tnmBf51QsfCxt+pPfa4ZjVA+0wY0I/DG0t3kvw1dN8O4Cn2XqSfE3R8BcgrhmWyq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555832; c=relaxed/simple;
	bh=ZnYngTlVQzycdtY2m/RKcREfQ/63W022ZEx/xYzEu6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JfL2bYJb20PpUDQmRvcOG9Cllbl26FC2wNK/ou8wBLhz1jXhhVvj+fFJlXjbjJ+IcM+9nsyR2w+5WearGx4aq/ky/+hra72c8oh32tNK7QV5JK5GMYEoAHMpWQxOqa1VO+vCbXBGjdlfOW8/NLbSym3mFk0+RuFUhhnsaLL6OOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=RJ7ZVyJG; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="RJ7ZVyJG"
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
	t=1772555396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BQpGPSsrmt5iFf8ycx5AlTFs3GDIIi8/v45rG7lvG9E=;
	b=RJ7ZVyJG+KcCDsqtEKVaft96gFljbG0QnrDqcEaQhES+7duAAfX9XINpkZukPWPpxkQAiT
	ObisQQAu7sFaBTTgu0IgG9BsNECNUic/ml4yyp0cjs2sr+vTF6boKHhnZ167h4+WexxYRc
	qXpCUxRKwiKqJ8ftvhF5jIjwC3MaO94llQMZ1JZOEbjKRwG7Z63eTESJFx9jxEr/p0LfRL
	xw0t/xF5P+4PsdGnOkw3Ed8B2ZQC1+FPr3dxDyIdqixE2tuKRjfHMgW/0pZ3WkNtBz2tX/
	y/ijtE6uisHrTzbbHXhx7leBJv2D3sEarAbLex26HU8x+n2r7ahL7pUogiwnZQ==
Date: Tue, 03 Mar 2026 17:29:22 +0100
Subject: [PATCH RFC 1/7] spi: Add 'rx_sampling_delay_ns' parameter for
 clock to RX delay
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-fsl-qspi-rx-sampling-delay-v1-1-9326bbc492d6@kontron.de>
References: <20260303-fsl-qspi-rx-sampling-delay-v1-0-9326bbc492d6@kontron.de>
In-Reply-To: <20260303-fsl-qspi-rx-sampling-delay-v1-0-9326bbc492d6@kontron.de>
To: Mark Brown <broonie@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Han Xu <han.xu@nxp.com>
Cc: Eberhard Stoll <eberhard.stoll@kontron.de>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, imx@lists.linux.dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2060;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=XlqBJm6qGT+yufD3x6JPfqlL1/qFkwpILnGBWgECzFk=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIXM5T9OFDXvSpisb72j5uznvPbPw02vpJ/ZntCx4pCG9w
 v3sRnaPjlIWBjEuBlkxRRYpfovXtmaxPvLHqqNg5rAygQxh4OIUgImcfsbwPzT+ugjrrn1B97v9
 9zXN3j/Rr5G/wptL/tuMrt+SLF8vXWJk2Hr1cm7jOe9JRpKBu2ecjPu7OXmiaPC77y1v1MQDEn5
 N4gUA
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216

From: Eberhard Stoll <eberhard.stoll@kontron.de>

Some high speed SPI devices require a delay between the controller
clock and the sampling point of the client device. This 'clock to
receive data delay' value is often referenced as tCLQV in SPI device
data sheets.

Not respecting this can lead to data being sampled too early when
the client doesn't yet reflect the correct level at the data out
pin(s).

There are two ways to handle the situation:

1. Reduce the controller clock to the amount where the sampling
   point requirement of the client is still met, meaning the
   clock period being greater than two times tCLQV.

2. If the host controller supports it, compensate by delaying the
   sampling point to meet the tCLQV requirement of the client.

Add a parameter 'rx_sampling_delay_ns' in struct spi_device to enable
setting the clock to RX data delay for each SPI device, so drivers
can check and act upon this timing requirement.

Signed-off-by: Eberhard Stoll <eberhard.stoll@kontron.de>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 include/linux/spi/spi.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index af7cfee7b8f60..4f8a0c28e1d46 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -181,6 +181,7 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  * @num_tx_lanes: Number of transmit lanes wired up.
  * @rx_lane_map: Map of peripheral lanes (index) to controller lanes (value).
  * @num_rx_lanes: Number of receive lanes wired up.
+ * @rx_sampling_delay_ns: spi clk to spi rx data delay
  *
  * A @spi_device is used to interchange data between an SPI target device
  * (usually a discrete chip) and CPU memory.
@@ -235,6 +236,8 @@ struct spi_device {
 	struct spi_delay	cs_setup;
 	struct spi_delay	cs_hold;
 	struct spi_delay	cs_inactive;
+	/* Transfer characteristics */
+	u32			rx_sampling_delay_ns; /* clk to rx data delay */
 
 	u8			chip_select[SPI_DEVICE_CS_CNT_MAX];
 	u8			num_chipselect;

-- 
2.53.0

