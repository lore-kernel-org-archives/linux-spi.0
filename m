Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5A939185E
	for <linux-spi@vger.kernel.org>; Mon,  3 Aug 2026 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785743386; cv=none; b=rHxulIt9c/vUFB7CVdpsVLFJT8i5EXjoEjH/Fi7KWp4ouwu29Ywvhq8Mez0Kp/cUi0/hPSItr9TjgI7JjLRskt/1mdz8fAEY6lYZUt/xcCRe6Y6cBWFWpJiK4Z0k/lj3Jb4/Tc8Y/zYnFvtmkMge0zJlD1mNwxzWWiVCpZEEaQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785743386; c=relaxed/simple;
	bh=GO3Sz/cw7cI0HCk+Bed3MtNGnWNHKZUKealu4ttJIp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PrEa7jDy4tH5T4RWca9BcqdUx5s/tJkqULx705We/TPFeG+lz/nL0jC3mN/42ApEfFyEoGhgUC2fDcgKp05KCPe4d2nkmv1M7E88WjXS+k5uv3LWRbVYf2BGWLjDTmXorncHiQ+Tg6SykGmpqbkpm56Qe4Qh7nCYRvgMNM2n5tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiJrzgIP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiJrzgIP"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ce7d2adef4so50694045ad.3
        for <linux-spi@vger.kernel.org>; Mon, 03 Aug 2026 00:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785743384; x=1786348184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mh0zq1YTh3UJhLL40JBJykkOmBY5F9aAuS/qMZKEofk=;
        b=NiJrzgIPYFhc2/us9ghPkcRkp5HcupJzWqyhgtMu+uRP2dfBWIfg6yfIEfLEnhyrId
         49cTGO5fZ8UHi7wJs4VNT8FwVDZqvrOht99wac0PQppr5ZLf4QHP73ILMvXGE7akngxo
         9acVt17rVets2HdclsdpJIv3nXzopyZU5qJ1cNrYYXCQetvseuVc76MRFXSkM9jfZY1W
         BhgaylV6iI3PajbMqouAya26xWcUvHELSqP4jlQyiwakKN139QT4FvlP/FJRcr+7vpTZ
         X4DgvY5ZZXC5YK7cbDTnAJRVSskbFoTiJh4MaupJvyFiGzuhUr7JZOHCq/PuOX6x55S3
         m5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785743384; x=1786348184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mh0zq1YTh3UJhLL40JBJykkOmBY5F9aAuS/qMZKEofk=;
        b=aR2A6FCBSThenlCToyXqggyfQ4kLcODmq/n/GSbZ7IZzkok2izTYfbTaiRDxLS8gMa
         6HbOpuoR9V9ntn8ctXgrWSNivCKM6FhFXE74RBaYCwR/VSlwX+kw+g7rGtwsczk12/I4
         2XPC8CwEwgBmynElTY+xi6V7ILwDERtc8BV84Gcr7UlY9SVVJeXwdLChyL22dFE0a2Eh
         EaZXzQIbhAMkiJb8RSkfKtRYebhQB+SYy4cqxauQIOmzLmaClPmR5rc2OK44fhmzJ5nd
         Wo6j5BBtBi58qSmI1iKeeAa0DUjRSnz68KzdoW8hvW5HyZb7RGYXwAK3wI1eETvw82G/
         wI6A==
X-Forwarded-Encrypted: i=1; AHgh+RoaPk9V2ITG5WyjCgUOkV/T6bQTMZrAWc+8s8y6ol8R56a9Qt0xTHBWvbBXZAXwpa1D3ab6jVEujPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YysCm+qh0j7XvR9xGB4pSVVKIbdFSJiqN+ISLBsYqUDg3r9AlWv
	mXT6DWatuY430Rf8GlNizAvk4IvuzzrCq2FvHgTfjnQBbQM5N7nf9JGV
X-Gm-Gg: AR+sD1004TeHSJpK5n0fsBR+ZBODRp5dQhb0KdCSd7m8Sbucv5PcbCbI05t+AXIbQp2
	L11v5Xx1IG+GaujMFwuCAG13pdlXXnVrDsTDp88cSIRRxSuEZ12I+KE1x53fhYyo1ABKvpbj9ub
	/zt7USmBjp9JpSXgUNDQLWTGM/UFI5OQjO8FEb60lHO6YRnr9KCt/w4LTDPN8ssPDuV+74J1G8m
	1mmYvpGnI1XAQn0RaeSMaoVjpOByL0PNIr6fh0ahXkyp4+FQy3FWXDaXcGg3swXGBPfEx8xYdWV
	xd3ZkwrIFmKDBpLTZvQcjpqmoTkbi8ZK7mPwV8U/8qQOj12kFDyC7jXoCFHhh3trA3rEAt0Gy7E
	PpQNrOBvtg+F6WNnFcldLgAZvFoqBi8lDvWDKnm9DV70wUc9zfWnQKpCQ1GTGpPErHNBXihYkm9
	C4Z8xGbSAxXtwtuRKd+Bh4jx2GsXneHcVC9cgaB3WZcX+lV+F/9rk1NkDacXyLw1frZ0eDJL+BR
	tP3uZ5tfQ/NR97LxiCKZixUUv0AX7M52oPo5PpARV/MsTHLzdw=
X-Received: by 2002:a17:902:e84d:b0:2cf:84bb:1ebc with SMTP id d9443c01a7336-2d0521e9e05mr90498015ad.15.1785743384392;
        Mon, 03 Aug 2026 00:49:44 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b120f2fsm33679845ad.64.2026.08.03.00.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 00:49:43 -0700 (PDT)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com,
	cwweng.linux@gmail.com
Subject: [PATCH v3 2/2] spi: ma35d1-qspi: Enable GPIO chip selects
Date: Mon,  3 Aug 2026 15:49:13 +0800
Message-Id: <20260803074913.1656675-3-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260803074913.1656675-1-cwweng.linux@gmail.com>
References: <5769eae0-1b40-419f-8311-0d919bf619fa@sirena.org.uk>
 <20260803074913.1656675-1-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chi-Wen Weng <cwweng@nuvoton.com>

The generic SPI controller binding allows GPIO-based chip selects, but
the MA35D1 QSPI driver does not currently enable the SPI core's GPIO
descriptor handling.

Enable GPIO chip-select support and distinguish the total number of chip
selects from the controller's two native chip selects. Allow num-cs to
include additional GPIO chip selects and set max_native_cs to the native
hardware limit.

Add a setup callback that rejects chip-select indices beyond the native
limit when no GPIO descriptor is present. Also reject active-high
polarity only for native chip selects, while allowing GPIO chip-select
polarity to be handled by the GPIO subsystem.

Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
---
 drivers/spi/spi-ma35d1-qspi.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-ma35d1-qspi.c b/drivers/spi/spi-ma35d1-qspi.c
index 541d5d72484c..f893a4160528 100644
--- a/drivers/spi/spi-ma35d1-qspi.c
+++ b/drivers/spi/spi-ma35d1-qspi.c
@@ -61,7 +61,7 @@
 #define NUVOTON_QSPI_STATUS_RXEMPTY_MASK	BIT(8) /* Receive FIFO Empty */
 #define NUVOTON_QSPI_STATUS_BUSY_MASK	BIT(0) /* Busy Status */
 
-#define NUVOTON_QSPI_MAX_NUM_CS		2
+#define NUVOTON_QSPI_MAX_NATIVE_CS	2
 #define NUVOTON_QSPI_DEFAULT_NUM_CS	2
 #define NUVOTON_QSPI_DEFAULT_BPW	8
 /* Bound PIO operations to avoid long atomic polling loops. */
@@ -430,13 +430,34 @@ static void nuvoton_qspi_set_cs_level(struct nuvoton_qspi *qspi,
 	spin_unlock_irqrestore(&qspi->ssctl_lock, flags);
 }
 
+static int nuvoton_qspi_setup(struct spi_device *spi)
+{
+	unsigned int cs = spi_get_chipselect(spi, 0);
+
+	if (spi_get_csgpiod(spi, 0))
+		return 0;
+
+	if (cs >= NUVOTON_QSPI_MAX_NATIVE_CS) {
+		dev_err(&spi->dev, "invalid native chip select %u\n", cs);
+		return -EINVAL;
+	}
+
+	if (spi->mode & SPI_CS_HIGH) {
+		dev_err(&spi->dev,
+			"active-high native chip select is not supported\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void nuvoton_qspi_set_cs(struct spi_device *spi, bool level)
 {
 	struct nuvoton_qspi *qspi = spi_controller_get_devdata(spi->controller);
 
 	/*
-	 * The SPI core passes the physical CS level to ->set_cs(). This
-	 * initial driver only supports active-low native chip selects.
+	 * The SPI core passes the physical CS level to ->set_cs(). Native
+	 * chip selects are active low.
 	 */
 	nuvoton_qspi_set_cs_level(qspi, spi_get_chipselect(spi, 0), !level);
 }
@@ -608,15 +629,18 @@ static int nuvoton_qspi_probe(struct platform_device *pdev)
 	if (ret && ret != -EINVAL)
 		return dev_err_probe(dev, ret, "failed to read num-cs\n");
 
-	if (!num_cs || num_cs > NUVOTON_QSPI_MAX_NUM_CS)
+	if (!num_cs)
 		return dev_err_probe(dev, -EINVAL, "invalid num-cs %u\n",
 				     num_cs);
 
 	ctlr->num_chipselect = num_cs;
+	ctlr->max_native_cs = NUVOTON_QSPI_MAX_NATIVE_CS;
+	ctlr->use_gpio_descriptors = true;
 	ctlr->max_transfer_size = nuvoton_qspi_max_transfer_size;
 	ctlr->max_message_size = nuvoton_qspi_max_message_size;
 	ctlr->mem_ops = &nuvoton_qspi_mem_ops;
 	ctlr->mem_caps = &nuvoton_qspi_mem_caps;
+	ctlr->setup = nuvoton_qspi_setup;
 	ctlr->set_cs = nuvoton_qspi_set_cs;
 	ctlr->transfer_one = nuvoton_qspi_transfer_one;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
-- 
2.25.1

