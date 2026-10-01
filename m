Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E614AF9D2
	for <linux-spi@vger.kernel.org>; Thu,  1 Oct 2026 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860723; cv=none; b=gKtK2b51Yj5//JVXwO6OF8Rp1i0OqcrDFET/HyyFc0kkHJfzXdqntRppHUwuViVaLCX4APWkxbYZjq91WXhV0JUWhAU1IoyiQQbkvX6oY8gY3Gz1NO1rv2fmGbsZylGDObyEqIMBRpfXKWN7Bb6qUmggTX7JfbKaYzDwqIrdFlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860723; c=relaxed/simple;
	bh=sFkXBSnLk+vZbRKQdCAmvra4Fypns8vJgfKHZ9ztqDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C5o9XUFMIhUKzt9hVioVazcqI6rtu00Aj4agPn+VLGSamZxgxgXd8i16+0l0dgSoVPhUoHiM3EtFfCVWySd21sJzJVNaq8zVs11GPlfpYLJvCdntHMCk4nxOECqGnsX1XPrK+8OWtP9YRa499KB+WM/yb05XFPICS9PSwjbXKa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSCrTMuc; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSCrTMuc"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccc02279so3767204a91.1
        for <linux-spi@vger.kernel.org>; Thu, 01 Oct 2026 06:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790860720; x=1791465520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DIgme/hli59wBCI5OwyN88StS5WzrGGP4qMfY50DT24=;
        b=NSCrTMucKye39BuqMlLMOaWpl/1zFQenbpy7dRUVpFyfddArSjZw1rTQS9I5ungoA8
         uj5smN2tuEwC405VqXFqtKRqkCh15HwfZWO4urPdmbfACdclOjWK/EKTeat3KHusVNdX
         X9m5GxFOLvPXIaZGUgtEn+HElgwQBWMqKU0QeHdfMRdLm7JF3xfCTW66PLDeMTE563Bh
         Gn0PoOjr7cVbjMDpwFGD2eFR22/OmC/vQT4e5I1skxk3PsMig4js5tBfCxlnorpSiK2A
         Suaki5gPNF20TvOQgXMrwVkM+D2lyqtZPEJswXItocnxnnkbfvS8dwVOC+qQZAyzIIbR
         MHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790860720; x=1791465520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DIgme/hli59wBCI5OwyN88StS5WzrGGP4qMfY50DT24=;
        b=nlY3FUdL235DhCDMqxXqWPF+3TvuVrM97i46xFIidsdM9oQ9u5Lv0i4ZlHHnE6QGKx
         Wr7XOOe9o3N4zCBaoyHsjXcDymrcmbHj4/H7s/4dV5+T4ZOhNkXSqfN3xq4jcT7DEc1Z
         RFmI8uGu+LJrwKORqpJ+C8weg3HwIJPWvEkZlAv3rXYfhCjLQO6zcdQy7k+6cj2D7Jpo
         rPJYXuNGaYdzPFVMHoeMaSLaAHSlyI7orYajUZcLyJw343bWRRsTSQ8o5lU0twkNupzG
         cQZv6IDx0lwLiOsGT5i57rLUkHeXdsczXcy6WI8VPWBs+buuVyIxaDwZRxJY6YTB01Rl
         DrvQ==
X-Forwarded-Encrypted: i=1; AKwUvBzdDZ7MPdAWMhgdnDAfDWpK9XXrOmFgCLdycfX42mVbqbMTHzwQTr2FgpjGdA4aIi+81+zpR0rdup4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLlBQ79GSHSj6Rpz7jsnMiUmy7/cQr8B3HkpqGRDDk+CzKk23/S
	tNyodhsPsiGccK7quj6cYl8tDBoK1X7Bc85dMAz0LBgbJ1SXQ0FBcdKY
X-Gm-Gg: AYBFou1PYUWTyGklImp8iNr/P9f61ycWfYpeR72yUk3iOGNFo3CNpTe+w3PQD++xhbu
	eFJPRQT5C0Q2CGH1tl0OwaqP0lH8m1//IQP4BV0qYJy4h0Nd3uh2/FckwcwelQ0X1vlTMMq7zkv
	7s5JFakjQO++zk7uAxUtyWgUArAGaN6ZcJBL6g0j1zG1H9+Eecy2HuJn/59vSQb5E0XITrH9QaT
	jie6cQQDOUiBKLD99N0T6GC1M2FsYazaJh0L1bZWPYaPRMZXfbRDwgY2TmcA87MQk0mD5BAM+Sq
	z3syYh0PN9PDQhAFhJ7daDUKEe+B+13Tysxqj/OCGa04R9VerWiGnCvF2Xt0yGqSPLURLQ/jByF
	NdExiTMa3/VXpTBdwM5eO7o0LpJ7V8EMioqWFYYSmZkOmKlHG15l3aDQaVYsiJct2JNJGd6wRFY
	eU6zKD+QdPltXjBPrza1nlvcz+H32RdyX1BFpBa0nNDRv21UW2f+i1viyhjH9UPar7oQW6ye78o
	CVitS4B1cbCYzsvZWU/OxTQ/YgZ2wgQdk96ybIBK3fGsdnnSA23WdP9rgtRHp9i3XQv9Eo=
X-Received: by 2002:a17:90b:2b4f:b0:3a4:bda6:16d0 with SMTP id 98e67ed59e1d1-3a4fb2ba95bmr1983848a91.55.1790860719369;
        Thu, 01 Oct 2026 06:18:39 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f46bb550sm5016692a91.5.2026.10.01.06.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 06:18:38 -0700 (PDT)
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
Subject: [PATCH v2 3/3] spi: ma35d1-qspi: Add GPIO chip select support
Date: Thu,  1 Oct 2026 21:18:18 +0800
Message-Id: <20261001131818.110028-4-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261001131818.110028-1-cwweng.linux@gmail.com>
References: <20261001131818.110028-1-cwweng.linux@gmail.com>
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

Enable GPIO chip-select support and specify that the controller provides
two native chip selects. Add a setup callback to reject active-high
polarity only for native chip selects, while allowing GPIO chip selects
to use the polarity handled by the GPIO subsystem.

This keeps the binding capable of describing valid board wiring while
preserving the active-low limitation of the controller's native chip
selects.

Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
---
 drivers/spi/spi-ma35d1-qspi.c | 39 ++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-ma35d1-qspi.c b/drivers/spi/spi-ma35d1-qspi.c
index 30e3239f777d..0644bb2990b8 100644
--- a/drivers/spi/spi-ma35d1-qspi.c
+++ b/drivers/spi/spi-ma35d1-qspi.c
@@ -62,7 +62,7 @@
 #define NUVOTON_QSPI_STATUS_RXEMPTY_MASK	BIT(8) /* Receive FIFO Empty */
 #define NUVOTON_QSPI_STATUS_BUSY_MASK	BIT(0) /* Busy Status */
 
-#define NUVOTON_QSPI_MAX_NUM_CS		2
+#define NUVOTON_QSPI_MAX_NATIVE_CS	2
 #define NUVOTON_QSPI_DEFAULT_NUM_CS	2
 #define NUVOTON_QSPI_DEFAULT_BPW	8
 /* Bound PIO operations to avoid long atomic polling loops. */
@@ -442,13 +442,35 @@ static void nuvoton_qspi_set_cs_level(struct nuvoton_qspi *qspi,
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
+	 * GPIO chip selects are handled by the SPI core. For native chip
+	 * selects, the core passes the physical CS level to ->set_cs().
+	 * Native chip selects are active low.
 	 */
 	nuvoton_qspi_set_cs_level(qspi, spi_get_chipselect(spi, 0), !level);
 }
@@ -457,7 +479,11 @@ static void nuvoton_qspi_mem_set_cs(struct spi_device *spi, bool assert)
 {
 	struct nuvoton_qspi *qspi = spi_controller_get_devdata(spi->controller);
 
-	/* The direct spi-mem path passes a logical assertion state. */
+	/*
+	 * Direct spi-mem operations are only executed for native chip
+	 * selects. GPIO chip selects use the regular SPI fallback path.
+	 * This helper takes a logical assertion state.
+	 */
 	nuvoton_qspi_set_cs_level(qspi, spi_get_chipselect(spi, 0), assert);
 }
 
@@ -638,18 +664,21 @@ static int nuvoton_qspi_probe(struct platform_device *pdev)
 		goto err_assert;
 	}
 
-	if (!num_cs || num_cs > NUVOTON_QSPI_MAX_NUM_CS) {
+	if (!num_cs || num_cs > NUVOTON_QSPI_MAX_NATIVE_CS) {
 		ret = dev_err_probe(dev, -EINVAL, "invalid num-cs %u\n",
 				     num_cs);
 		goto err_assert;
 	}
 
 	ctlr->num_chipselect = num_cs;
+	ctlr->max_native_cs = NUVOTON_QSPI_MAX_NATIVE_CS;
+	ctlr->use_gpio_descriptors = true;
 	ctlr->max_transfer_size = nuvoton_qspi_max_transfer_size;
 	ctlr->max_message_size = nuvoton_qspi_max_message_size;
 	ctlr->mem_ops = &nuvoton_qspi_mem_ops;
 	ctlr->mem_caps = &nuvoton_qspi_mem_caps;
 	ctlr->dtr_caps = true;
+	ctlr->setup = nuvoton_qspi_setup;
 	ctlr->set_cs = nuvoton_qspi_set_cs;
 	ctlr->transfer_one = nuvoton_qspi_transfer_one;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
-- 
2.25.1

