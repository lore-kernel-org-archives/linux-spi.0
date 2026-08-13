Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FBB372EF0
	for <linux-spi@vger.kernel.org>; Thu, 13 Aug 2026 08:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608064; cv=none; b=DJ6XORk6Zg907ajv//AUhPU8Sj68bNHHjiGoVcGRuzHPqLDW22JIcOQzYV0Yju3iwQGD35kLH6DsQd+zPbmwwqSXmS+pfDQrSmfJ6OLNMCc+4moK+DIoKauNMuUPeo/zgvappPyFFYqdT6SYkruGp1rnk5QA2IGd60NNjQ4UhVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608064; c=relaxed/simple;
	bh=mnQ46co/9iuYUM/Yd5Z6+Uo7JC6kFiKYVYth8cN9zPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MyDcRVDdPY7m5653IO1UUV/+5/iWc+ADBWulbOianaz3p7k87ny1S7nEQDecJj48BlUBY4IrBbiuX13HJ5ixvGfJeoLqUe+kZe8FKIe7AxY3CkyULElor+iMoVtj2tQm+VgxjUcwjsN4/AE8rkKI/ZJwIiSeUnRbyPxLkFlvjXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bwAboqmH; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bwAboqmH"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 06AE71A15EF;
	Thu, 13 Aug 2026 08:00:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CF57F602B8;
	Thu, 13 Aug 2026 08:00:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3CFA211C4DA93;
	Thu, 13 Aug 2026 10:00:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786608052; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xx36mDPNFgstttg20qSUlurhDbVJ78nN9n4MYm6WP0k=;
	b=bwAboqmHaigF17vxw6fNyWDm2Xf5/hEIncR+VdBQqhYrOUVg+J3C8/87O81nBcLVwLjxGr
	sFJYDpBjyD2Qmk/IUgj9YZvs7NeCTzIHxZ/7zNgbiqNOvDkGaeQh83OvwL+RmKUbvWcKjv
	zUEL+XQt72bPRJ0SalMB9LGv3N+blRnHwv7rz+tDZ+985cySpRdhmXpimW89ce25FPjA2Q
	pblHlQr3yl4yA4Bu5FFKjw+lQTypgxHAuSQCoUSQDdsuNGehu8KwX76CGAYgyIsqwnTVR6
	rFlEWgmy/ZJ0aR2pvPHHYGGygLf7BnXYqoNCxyIkeVU00KV5FHqWq4zAWcxwZQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 13 Aug 2026 10:00:24 +0200
Subject: [PATCH 4/5] spi: ma35d1-qspi: Add DTR support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-perso-ma35d1-upstream-qspi-v1-4-b217b9870eb1@bootlin.com>
References: <20260813-perso-ma35d1-upstream-qspi-v1-0-b217b9870eb1@bootlin.com>
In-Reply-To: <20260813-perso-ma35d1-upstream-qspi-v1-0-b217b9870eb1@bootlin.com>
To: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The controller has DTR support, a bit must be set for it. The behaviour
is interesting though, as the speed won't improve when enabled. This is
because there seems to be an internal divisor (/2) which keeps the rate
equal when DTR is enabled. As a result, this commit also doubles the
target bus speed, which in practice does not happen. This way, there is
a real gain:

Before:
$ flash_speed /dev/mtd0 -dc10
eraseblock write speed is 1000 KiB/s
[...]
eraseblock read speed is 1199 KiB/s
[...]

After:
$ flash_speed /dev/mtd0 -dc10
eraseblock write speed is 985 KiB/s
[...]
eraseblock read speed is 1540 KiB/s
[...]

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-ma35d1-qspi.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-ma35d1-qspi.c b/drivers/spi/spi-ma35d1-qspi.c
index 027a9433f2b1..9965a11573d8 100644
--- a/drivers/spi/spi-ma35d1-qspi.c
+++ b/drivers/spi/spi-ma35d1-qspi.c
@@ -31,6 +31,7 @@
 #define NUVOTON_QSPI_RX_OFFSET		0x30 /* Data Receive Register, RO */
 
 /* QSPI Control Register bit masks */
+#define NUVOTON_QSPI_CTL_DTREN_MASK	BIT(23) /* DTR I/O Mode Enable */
 #define NUVOTON_QSPI_CTL_QUADIOEN_MASK	BIT(22) /* Quad I/O Mode Enable */
 #define NUVOTON_QSPI_CTL_DUALIOEN_MASK	BIT(21) /* Dual I/O Mode Enable */
 #define NUVOTON_QSPI_CTL_DATDIR_MASK	BIT(20) /* Data Port Direction Control */
@@ -131,7 +132,7 @@ static int nuvoton_qspi_reset_fifo(struct nuvoton_qspi *qspi)
 					 1, NUVOTON_QSPI_TIMEOUT_US);
 }
 
-static int nuvoton_qspi_set_speed(struct spi_device *spi, u32 speed_hz)
+static int nuvoton_qspi_set_speed(struct spi_device *spi, u32 speed_hz, bool dtr)
 {
 	struct nuvoton_qspi *qspi = spi_controller_get_devdata(spi->controller);
 	unsigned long clk_rate;
@@ -143,6 +144,10 @@ static int nuvoton_qspi_set_speed(struct spi_device *spi, u32 speed_hz)
 	if (!speed_hz)
 		return -EINVAL;
 
+	/* Experimentally, when enabling DTR the frequency is cut in half */
+	if (dtr)
+		speed_hz *= 2;
+
 	if (qspi->speed_hz == speed_hz)
 		return 0;
 
@@ -215,16 +220,19 @@ static int nuvoton_qspi_setup_transfer(struct spi_device *spi, u8 bpw)
 static int nuvoton_qspi_configure_bus(struct spi_device *spi,
 				      unsigned int buswidth,
 				      enum spi_mem_data_dir dir,
-				      u32 speed_hz)
+				      u32 speed_hz, bool dtr)
 {
 	struct nuvoton_qspi *qspi = spi_controller_get_devdata(spi->controller);
 	u32 ctl = 0;
 	int ret;
 
-	ret = nuvoton_qspi_set_speed(spi, speed_hz);
+	ret = nuvoton_qspi_set_speed(spi, speed_hz, dtr);
 	if (ret)
 		return ret;
 
+	if (dtr)
+		ctl |= NUVOTON_QSPI_CTL_DTREN_MASK;
+
 	if (buswidth == 4)
 		ctl |= NUVOTON_QSPI_CTL_QUADIOEN_MASK;
 	else if (buswidth == 2)
@@ -234,6 +242,7 @@ static int nuvoton_qspi_configure_bus(struct spi_device *spi,
 		ctl |= NUVOTON_QSPI_CTL_DATDIR_MASK;
 
 	nuvoton_qspi_update_bits(qspi, NUVOTON_QSPI_CTL_OFFSET,
+				 NUVOTON_QSPI_CTL_DTREN_MASK |
 				 NUVOTON_QSPI_CTL_QUADIOEN_MASK |
 				 NUVOTON_QSPI_CTL_DUALIOEN_MASK |
 				 NUVOTON_QSPI_CTL_DATDIR_MASK, ctl);
@@ -470,7 +479,7 @@ static int nuvoton_qspi_mem_exec_op(struct spi_mem *mem,
 		cmd[i] = op->cmd.opcode >> (8 * (op->cmd.nbytes - i - 1));
 
 	ret = nuvoton_qspi_configure_bus(spi, op->cmd.buswidth, SPI_MEM_DATA_OUT,
-					 op->max_freq);
+					 op->max_freq, op->cmd.dtr);
 	if (ret)
 		goto out_deassert_cs;
 
@@ -483,7 +492,7 @@ static int nuvoton_qspi_mem_exec_op(struct spi_mem *mem,
 			addr[i] = op->addr.val >> (8 * (op->addr.nbytes - i - 1));
 
 		ret = nuvoton_qspi_configure_bus(spi, op->addr.buswidth, SPI_MEM_DATA_OUT,
-						 op->max_freq);
+						 op->max_freq, op->addr.dtr);
 		if (ret)
 			goto out_deassert_cs;
 
@@ -494,7 +503,7 @@ static int nuvoton_qspi_mem_exec_op(struct spi_mem *mem,
 
 	if (op->dummy.nbytes) {
 		ret = nuvoton_qspi_configure_bus(spi, op->dummy.buswidth, SPI_MEM_DATA_OUT,
-						 op->max_freq);
+						 op->max_freq, op->dummy.dtr);
 		if (ret)
 			goto out_deassert_cs;
 
@@ -505,7 +514,7 @@ static int nuvoton_qspi_mem_exec_op(struct spi_mem *mem,
 
 	if (op->data.nbytes) {
 		ret = nuvoton_qspi_configure_bus(spi, op->data.buswidth, op->data.dir,
-						 op->max_freq);
+						 op->max_freq, op->data.dtr);
 		if (ret)
 			goto out_deassert_cs;
 
@@ -531,6 +540,7 @@ static const struct spi_controller_mem_ops nuvoton_qspi_mem_ops = {
 
 static const struct spi_controller_mem_caps nuvoton_qspi_mem_caps = {
 	.per_op_freq = true,
+	.dtr = true,
 };
 
 static int nuvoton_qspi_transfer_one(struct spi_controller *ctlr,
@@ -567,7 +577,8 @@ static int nuvoton_qspi_transfer_one(struct spi_controller *ctlr,
 			buswidth = 2;
 	}
 
-	ret = nuvoton_qspi_configure_bus(spi, buswidth, dir, xfer->speed_hz);
+	ret = nuvoton_qspi_configure_bus(spi, buswidth, dir, xfer->speed_hz,
+					 xfer->dtr_mode);
 	if (ret)
 		return ret;
 

-- 
2.54.0

