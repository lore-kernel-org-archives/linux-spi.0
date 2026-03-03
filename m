Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E52F4B8DE8;
	Tue,  3 Mar 2026 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555409; cv=none; b=AOKinxofrkunhvoHZFtNmbChOG1XfNyS9tw1E3lw0a/gn999/f3L/sNx6PSnMFLiz+IEOmI6xoD34ERJak7oTcnp40PQ9QKFGEE1/rxKdhEaJsus7UbcJgoJL4P/Y6rbt10q1o6qiQc52aZLJ0GuOKhr9pmi+H8z4t4kPxUZR/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555409; c=relaxed/simple;
	bh=hhA/kekrHLYT7uqa4N13c7/4irrilRSPetcEkoldtSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oaOt8n6ttGexVTt6S3Iko1J6XSwG4Xxc8Zrh6ZI62QHcCnEHfTCLgDp9ig0KOBomENB96eZZrwUoklwSvdMfnlae7GLR7nJIJLuc5huyddoRIpH9ttJZgfoL04QRiWKWJjRP6e+T6TP+1Mh+GzdWhrJ9+ajytE8MstwqUoV0a8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=Pp6Nc3Cp; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="Pp6Nc3Cp"
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
	t=1772555397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9cQhV2OiJ4DlfedZpH/R3rEHE14PIfUJqqPTZYp7QUU=;
	b=Pp6Nc3CpwIIn5asGLiOHOSd3GqtpgaZC1ICn9uIEQ91cLlYda6UlSL/49xQ271caQwXLlq
	hMpMUJrpIzQIvd2vpheuMxHuaVFcwBbtz+aVFlJYnYnlZo9JtVISZr6O/dsk9rs7zuDAQ4
	WXYlPvXYaFP3RreuqBjioZqs/iUaS2cuArJ2RZoI9fYOtwfNXPfLHCgzxGLfSljp5+P24L
	VkQChDTAf21LAJE/5LKxGteLJbi0HkFyEET7o/l5Aiviam6y5RC1NNEv1862EkCtcRfzcR
	DM8tJCWBige64Ri4I+nqm7o3E1x/bU1miPv2RjGx13OQr/S20Nkb8XophmrYXA==
Date: Tue, 03 Mar 2026 17:29:26 +0100
Subject: [PATCH RFC 5/7] spi: Add RX sampling point adjustment
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-fsl-qspi-rx-sampling-delay-v1-5-9326bbc492d6@kontron.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5737;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=rxgCw1+pDnvqWT9mh/JJrKWrgFwnOW+QIMt7NVQjShA=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIXM5T1PNxMPcscmFyyfYnjr8/q6q+a90g/o38crb2qQ8d
 mxaWDi7o5SFQYyLQVZMkUWK3+K1rVmsj/yx6iiYOaxMIEMYuDgFYCJ96xkZlh+yqPtidcB03rWP
 ajO+6vJd0BOUEqnI/r9s4Q9/UanKs4wMd4uyjh3jXLjs4ctnxz0k1pSpc7WKLkh7zKlYdNoncFc
 UOwA=
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Some SPI devices such as SPI NAND chips specify a clock-to-RX-sampling
delay constraint, which means that for the data read from the device
at a certain clock rate, we need to make sure that the point at
which the data is sampled is correct.

The default is to assume that the data can be sampled one half clock
cycle after the triggering clock edge. For high clock rates, this
can be too early.

To check this we introduce a new core function spi_set_rx_sampling_point()
and a handler set_rx_sampling_point() in the SPI controller.

Controllers implementing set_rx_sampling_point() can calculate the
sampling point delay using the helper spi_calc_rx_sampling_point()
and store the value to set the appropriate registers during transfer.

In case the controller capabilities are not sufficient to compensate
the RX delay, spi_set_rx_sampling_point() returns a reduced clock
rate value that is safe to use.

This commit does not introduce generic logic for controllers that
don't implement set_rx_sampling_point() in order to reduce the clock
rate if the RX sampling delay requirement can not be met.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/spi/spi.c       | 73 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h |  8 ++++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 61f7bde8c7fbb..b039007ed430f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3988,6 +3988,77 @@ static int spi_set_cs_timing(struct spi_device *spi)
 	return status;
 }
 
+/**
+ * spi_calc_rx_sampling_point - calculate RX sampling delay cycles
+ * @spi: the device that requires specific a RX sampling delay
+ * @freq: pointer to the clock frequency setpoint for the calculation. This gets
+ *        altered to a reduced value if required.
+ * @max_delay_cycles: the upper limit of supported delay cycles
+ * @delay_cycles_per_clock_cycle: the ratio between delay cycles and
+ *				  master clock cycles
+ *
+ * This function takes in the rx_sampling_delay_ns value from the SPI device
+ * and the given clock frequency setpoint and calculates the required sampling
+ * delay cycles to meet the device's spec. It uses the given controller
+ * constraints and if those are exceeded, it adjusts the clock frequency
+ * setpoint to a lower value that is safe to be used.
+ *
+ * Return: calculated number of delay cycles
+ */
+unsigned int spi_calc_rx_sampling_point(struct spi_device *spi, unsigned int *freq,
+					u16 max_delay_cycles,
+					u16 delay_cycles_per_clock_cycle)
+{
+	unsigned long long temp;
+	u16 delay_cycles;
+
+	/* if sampling delay is zero, we assume the default sampling point can be used */
+	if (!spi->rx_sampling_delay_ns)
+		return 0;
+
+	temp = *freq * delay_cycles_per_clock_cycle * spi->rx_sampling_delay_ns;
+	do_div(temp, 1000000000UL);
+	delay_cycles = temp;
+
+	if (delay_cycles > max_delay_cycles) {
+		/*
+		 * Reduce the clock to the point where the sampling delay requirement
+		 * can be met.
+		 */
+		delay_cycles = max_delay_cycles;
+		temp = (1000000000UL * delay_cycles);
+		do_div(temp, spi->rx_sampling_delay_ns * delay_cycles_per_clock_cycle);
+		*freq = temp;
+	}
+
+	dev_dbg(&spi->controller->dev, "calculated RX sampling point delay: %u cycle(s) at %lu KHz", delay_cycles, *freq / 1000);
+
+	return delay_cycles;
+}
+EXPORT_SYMBOL_GPL(spi_calc_rx_sampling_point);
+
+/**
+ * spi_set_rx_sampling_point - set the RX sampling delay in the controller driver
+ * @spi: the device that requires specific a RX sampling delay
+ * @freq: the clock frequency setpoint for the RX sampling delay calculation
+ *
+ * This function calls the set_rx_sampling_point() handle in the controller
+ * driver it is available. This makes sure that the controller uses the proper
+ * RX sampling point adjustment. This function should be called whenever
+ * the devices rx_sampling_delay_ns or the currently used clock frequency
+ * changes.
+ *
+ * Return: adjusted clock frequency
+ */
+unsigned int spi_set_rx_sampling_point(struct spi_device *spi, unsigned int freq)
+{
+	if (spi->controller->set_rx_sampling_point)
+		return spi->controller->set_rx_sampling_point(spi, spi->max_speed_hz);
+
+	return freq;
+}
+EXPORT_SYMBOL_GPL(spi_set_rx_sampling_point);
+
 /**
  * spi_setup - setup SPI mode and clock rate
  * @spi: the device whose settings are being modified
@@ -4090,6 +4161,8 @@ int spi_setup(struct spi_device *spi)
 		}
 	}
 
+	spi->max_speed_hz = spi_set_rx_sampling_point(spi, spi->max_speed_hz);
+
 	status = spi_set_cs_timing(spi);
 	if (status) {
 		mutex_unlock(&spi->controller->io_mutex);
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 4f8a0c28e1d46..f5be4f54d1424 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -685,6 +685,9 @@ struct spi_controller {
 	 */
 	int (*set_cs_timing)(struct spi_device *spi);
 
+	/* set RX sampling point */
+	unsigned int (*set_rx_sampling_point)(struct spi_device *spi, unsigned int freq);
+
 	/*
 	 * Bidirectional bulk transfers
 	 *
@@ -1337,6 +1340,11 @@ extern int spi_setup(struct spi_device *spi);
 extern int spi_async(struct spi_device *spi, struct spi_message *message);
 extern int spi_target_abort(struct spi_device *spi);
 
+unsigned int spi_calc_rx_sampling_point(struct spi_device *spi, unsigned int *freq,
+					       u16 max_delay_cycles,
+					       u16 delay_cycles_per_clock_cycle);
+unsigned int spi_set_rx_sampling_point(struct spi_device *spi, unsigned int freq);
+
 static inline size_t
 spi_max_message_size(struct spi_device *spi)
 {

-- 
2.53.0

