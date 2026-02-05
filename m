Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5A13148AE
	for <linux-spi@vger.kernel.org>; Thu,  5 Feb 2026 19:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770318434; cv=none; b=uVHHZVXlq55PW7fqAETKI3a0FZE/LC+SNppibLZvv+0sjwH5PK661x0GfL1lTCXCJDLsrJGn9IbnMAPe52P2IBd6joyv9Bup5rqK0ti31sxsun864XRHg0M8uOAlv8SSQqotFT2D0KrOyhlrB8JI2HBTQkyogqNXhvLUKpFeFh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770318434; c=relaxed/simple;
	bh=FknqC59Pjh4glzE0SB6TxNJb2mBOqsygzb2ElZBtEW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nBrAwWcQZOF64NaECpW+jZNN4s95gh9qAL/R4kBsof5h5ttQogSBOiKqUQ8BiU5iliDs2bdakd0QaVEvWPzPkPWLwf/FwmjXTWGqV3voHvhwb+j0177zWCufbbCNwVSYBTWPDs8JaWQnS3EGY7uVROdoyS3eKTw08xsGBkYjjeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zrZK+Cko; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zrZK+Cko"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1E3EEC243B3;
	Thu,  5 Feb 2026 19:07:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D311B6074D;
	Thu,  5 Feb 2026 19:07:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7685D119D1700;
	Thu,  5 Feb 2026 20:07:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770318431; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6dF/17CA4aFWIO+80ewE32jYEzEuuauKlwQf6WYBUQo=;
	b=zrZK+CkoK6bofm8eBAttaZNEVv+aghn2O+YH3IE6CEniuKxy+0xH+AvY2yoOupOC89/1Qw
	8q/dYNe0ot67DvC/Mez8n2kC2kKlzFarAChTp9UmekqBWSuDuNwG+Y4coLudRK7GaR4XS1
	YvMNZFM3SBioejL93oslTNqneiXuPlKdWjh3L46AZ9AMiEnxsVQFWncmdX5ndE0J8xVgnv
	zziGK0E7pFSYwi8bAe6fY0vNYgJ2g6npvTUBTXFd1b5SYh7bcan2wKGWQAlP/PHHebLMS3
	XoYCOs9CSJy0SDjs+OPL5DYA2sOgi/5RoHoWKdu9JCL6VzEFQlI9pXm+qqE0ZA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 05 Feb 2026 20:06:58 +0100
Subject: [PATCH RFC 1/4] spi: spi-mem: Flag DQS capability
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-winbond-nand-next-phy-tuning-v1-1-5e7d3976f0f1@bootlin.com>
References: <20260205-winbond-nand-next-phy-tuning-v1-0-5e7d3976f0f1@bootlin.com>
In-Reply-To: <20260205-winbond-nand-next-phy-tuning-v1-0-5e7d3976f0f1@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, praneeth@ti.com, 
 u-kumar1@ti.com, p-mantena@ti.com, a-dutta@ti.com, s-k6@ti.com, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

DQS is a typical SPI memory signal used to help with reading the data on
the bus at high speeds (especially in DTR mode) by avoiding clock
skews. The chip generates a clock signal synchronized with its data
output fronts, also called data strobe.

SPI NOR and SPI NAND cores must set this flag in order to indicate to
other layers that DQS is available.

Create a getter and a setter to reach this capability.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mem.c       | 32 ++++++++++++++++++++++++++++++++
 include/linux/spi/spi-mem.h |  4 ++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 444bd8ec34f5..b746a821c984 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -534,6 +534,38 @@ const char *spi_mem_get_name(struct spi_mem *mem)
 }
 EXPORT_SYMBOL_GPL(spi_mem_get_name);
 
+/**
+ * spi_mem_set_dqs() - Mark DQS as being available
+ * @mem: the SPI memory
+ *
+ * When reading at high frequencies (> 100MHz), especially when DTR is enabled,
+ * transfer speed is limited due to clock skews. In particular, the controller
+ * does not know the board propagation delay nor the memory chip internal delay
+ * (clock in to data out) and thus cannot optimize its sampling points.
+ * Mitigating this limitation is possible with the addition of a data strobe
+ * signal, commonly named DQS.
+ *
+ * Set the DQS boolean if the feature is available and configured at the chip
+ * level. Controllers may query this value.
+ */
+void spi_mem_set_dqs(struct spi_mem *mem)
+{
+	mem->dqs = true;
+}
+EXPORT_SYMBOL_GPL(spi_mem_set_dqs);
+
+/**
+ * spi_mem_has_dqs() - Query whether the DQS is available or not
+ * @mem: the SPI memory
+ *
+ * Return: a boolean indicating whether the DQS signal is available or not.
+ */
+bool spi_mem_has_dqs(struct spi_mem *mem)
+{
+	return mem->dqs;
+}
+EXPORT_SYMBOL_GPL(spi_mem_has_dqs);
+
 /**
  * spi_mem_adjust_op_size() - Adjust the data size of a SPI mem operation to
  *			      match controller limitations
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index a0543ca09da4..b58963242ba6 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -259,6 +259,7 @@ struct spi_mem_dirmap_desc {
  * @spi: the underlying SPI device
  * @drvpriv: spi_mem_driver private data
  * @name: name of the SPI memory device
+ * @dqs: extra data trobe pin available for high frequency read operations
  *
  * Extra information that describe the SPI memory device and may be needed by
  * the controller to properly handle this device should be placed here.
@@ -270,6 +271,7 @@ struct spi_mem {
 	struct spi_device *spi;
 	void *drvpriv;
 	const char *name;
+	bool dqs;
 };
 
 /**
@@ -440,6 +442,8 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 }
 #endif /* CONFIG_SPI_MEM */
 
+void spi_mem_set_dqs(struct spi_mem *mem);
+bool spi_mem_has_dqs(struct spi_mem *mem);
 int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
 void spi_mem_adjust_op_freq(struct spi_mem *mem, struct spi_mem_op *op);
 u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op *op);

-- 
2.51.1

