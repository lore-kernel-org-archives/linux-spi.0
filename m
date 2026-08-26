Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96064171BB
	for <linux-spi@vger.kernel.org>; Wed, 26 Aug 2026 00:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787702742; cv=none; b=SDzx9JBlYA86wt13eZ227KkcWzcdnoaFSy9C7RvsnwDnlE9Td8AIMTeRdWCZ6FG3EdwBP/xQdLLTapMd7ltEsA8jONO3avYgZPWY/WR+/zkFW2RMYKZX2JXdEoQguOMWFe5wgBCxm26k56PvPqcfQAfWmUIht3v9hvXsAT9NhE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787702742; c=relaxed/simple;
	bh=rt83UHicrKw7lr4xO0XXvIXqk2CwSJUfqCAq2gx1VxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XI8O9ftvoXk6cniPbzhQQgeuxtxqVzJLCykHUE5p6inp1eplV8jIWe9SQB18I1C5XDoqfOAohzCR7iFzACOU3BJp6ddLS/uEqSeEeS+CcKh5P2AD/52xFaeu34k5zlKzHr37OW0rdyKICH/r4wAZur0T7uci+U3nnWRtuiMS434=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maticrobots.com; spf=pass smtp.mailfrom=matician.com; dkim=pass (2048-bit key) header.d=maticrobots.com header.i=@maticrobots.com header.b=GkPyJ2jk; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maticrobots.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matician.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maticrobots.com header.i=@maticrobots.com header.b="GkPyJ2jk"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8520161fdb9so560044b3a.3
        for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 17:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maticrobots.com; s=google; t=1787702740; x=1788307540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cSqeNF7Pcjc0PjDHs0LlnCxF9PEmfZ8hQZhY1ZU8wAk=;
        b=GkPyJ2jkM+NyMk0YTpEEChnPQN7HPFGpJZTYX8UooPIBfwqvFCjkzWdk5sJTsvi142
         UirVtjC2/4851tynopetgcLjV576f2aarbADsL9obWtvBIj0utRz0XBVDdMCMKMos8uE
         EvZLIgVjGXiIrLDcIRRjBfpCj51KyPXqvCVebnHhu89Ckwg+dviYTfWDljYxsGGlG10e
         MPICXc1of9Hs9Fpc3P03pzDCnN+K3bEhkt8h5XuNPiAaUWy4sjsMPeQO0ChHPqkBYx2/
         wCwDJznxkWLsNHgzrXU9w6cNuYxD9O2gi6Vnc1niZ6RPMMP761T6EU9QQV1LAU/FJqcN
         WYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787702740; x=1788307540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cSqeNF7Pcjc0PjDHs0LlnCxF9PEmfZ8hQZhY1ZU8wAk=;
        b=qJUGQ8hmyfxjFw0F6+DfWgVtX/QK1wasvxY9sSyQBr1SjC2KqRIlmSwXGHlUj6QXgD
         s3Da9BjvDChhS6Atg2g01dDIIy0UeZxax+DRQdATlAJ92UYuOLh8KPwB4Yt8pxQPqhwg
         sS4j/DgAT8+4ATuEnaMCf8/trmq2rxmm4ZDQwtDHuUlpX2efMKKCmMNi3u4csleJSczU
         gqxwKKlZb5/h+FbEvOejEUwgoE8JX34eujDmsr+9WwhFDtC1+GB3LGkOxtJBmKrNo5Oo
         UHGjadQE1TTEeg5zN/QDmF95hC6NUAukr7+t+s5FXBFYldDojC7w/iGG1x3AzL0+ywV3
         pq0w==
X-Forwarded-Encrypted: i=1; AHgh+RrGr4tKKIh/Q+/P0Z1wZVYqbtdP0AsSpx8OoOX0m4Yx3eVypv83VNjRKX6KWj8iHpM88y7zzIMFrEs=@vger.kernel.org
X-Gm-Message-State: AFuF++lNJHy1zOWC01tZn8+Kscls41esGCyS0Mex72pVjopZlCsqU/r0
	PpwLLmzmjZxuwE/XKk9zEpV3kjSrS+rYVA6xGcqqLuUpGVqB3e1rAtanfKBaB227yEE=
X-Gm-Gg: AR+sD10xCodkFKcNlc23z/ap9puNI4BsMnMNe1X5Y8OmEwix2leggyEEXnfMqCh4rNg
	8U+TUi2/SpryoYtPdmut/qrllK3k89fVjZcEg2yb2rtpJUw9qZVfWxHGg+D0d2LgRA22rjEHIWJ
	vq5mN6ugX0VmdYsnTN76S9ASWJ01nvz7k45zYqj6DhcXyAtgQ9aS/DP5X1idwExbXmCkhuYd9f8
	If+EZCYBaiQsJVh13S3KeYLBi/87GzFJKyGXLs6In1zq51Dwdrgyvfk+WT6HPRPPTKyHgqezNxO
	C+sq2CkHj7KdwHDBOyyLCs6Xehsdkq95x1bMgSYh/PZgvpRNyc98enGWNkuXuXZ+wuYQTv9IlaQ
	ppF02DDmYZsAbImtM7rCxrKbxRSCD7vIOIuRLjBe4W2WIdvNZOdN8qj4i9JSvfZiTEEwC0qfKCl
	ua4NpTDNSwFd5aC6UdrtB6wDbdPgYpH3y0KchOBhuTfwNht9VEorsCK8gfrS2wKVkr4gz2pvgzd
	R05CCnx1/URHghtilgebfkUJ6O6gThLo1XbqKlks7NwvHFt
X-Received: by 2002:a05:6a21:9202:b0:3c3:64cb:9b99 with SMTP id adf61e73a8af0-3cf76283ed6mr4541841637.6.1787702739862;
        Tue, 25 Aug 2026 17:05:39 -0700 (PDT)
Received: from abeMaticDesktop.1020marsh.offices.matician.com ([2600:1700:471:807f:6b81:bc26:604c:6f42])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d9e4ba6sm2442772eec.26.2026.08.25.17.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 17:05:39 -0700 (PDT)
From: Abraham Zukor <abe@maticrobots.com>
To: Mark Brown <broonie@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-spi@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abraham Zukor <abe@maticrobots.com>
Subject: [PATCH v3] spi: tegra114: initialize native chip selects inactive
Date: Tue, 25 Aug 2026 17:05:17 -0700
Message-ID: <20260826000517.631736-1-abe@maticrobots.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tegra_spi_probe() initializes SPI_COMMAND1 with only SPI_M_S, leaving
CS_POL_INACTIVE clear for every chip select. This drives every native
active-low chip select low until tegra_spi_setup() runs for that device.

SPI children are registered and probed one at a time. A synchronous
probe of an earlier child can therefore transfer while a later child's
chip select is still asserted. On a Tegra234 system with active-low
devices on CS0 and CS1, this caused both devices to be selected when the
CS1 device probed first. Its initialization then intermittently failed.
A logic analyzer showed CS0 remained low throughout the CS1 transfer and
went high only after the CS1 probe failed.

Walk the controller's device tree children before SPI_COMMAND1 is
written and set CS_POL_INACTIVE for each valid chip select without
spi-cs-high. That way the line is already deasserted when the first
child transfers and does not change level when setup runs.

Disabled children are walked too. The core only registers available
children, so tegra_spi_setup() never runs for a disabled one and probe
is the only chance to park its chip select at the level its hardware
needs.

Fixes: f333a331adfa ("spi/tegra114: add spi driver")
Assisted-by: Claude:Opus-5
Signed-off-by: Abraham Zukor <abe@maticrobots.com>
---
v3:
- Drop the cs-gpios check; programming an unused native chip select does
  not affect a device using a GPIO chip select.
- Split the compound condition into separate checks for readability.
- Retest on a Jetson Orin Nano with CS1 disabled. The old module left CS1
  asserted, while the patched module parked both chip selects inactive.

v2:
- Derive the inactive level per chip select from the device tree instead
  of setting the whole CS_POL_INACTIVE field, which is incorrect for an
  active-high or mixed-polarity bus.

drivers/spi/spi-tegra114.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index aa44ffd09e61..463bb7e61b6e 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1395,6 +1395,32 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	udelay(2);
 	reset_control_deassert(tspi->rst);
 	tspi->def_command1_reg  = SPI_M_S;
+
+	/*
+	 * SPI_COMMAND1 is written before any child is registered, so a chip
+	 * select with CS_POL_INACTIVE clear stays asserted until
+	 * tegra_spi_setup() runs for that device. Program the level the
+	 * device tree asks for up front instead.
+	 *
+	 * Disabled children are included deliberately. The core never
+	 * registers them, so this is the only chance to park their chip
+	 * select at the level their hardware needs.
+	 */
+	for_each_child_of_node_scoped(pdev->dev.of_node, np) {
+		u32 cs;
+
+		if (of_property_read_bool(np, "spi-cs-high"))
+			continue;
+
+		if (of_property_read_u32(np, "reg", &cs))
+			continue;
+
+		if (cs >= MAX_CHIP_SELECT)
+			continue;
+
+		tspi->def_command1_reg |= SPI_CS_POL_INACTIVE(cs);
+	}
+
 	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
 	tspi->spi_cs_timing1 = tegra_spi_readl(tspi, SPI_CS_TIMING1);
 	tspi->spi_cs_timing2 = tegra_spi_readl(tspi, SPI_CS_TIMING2);
-- 
2.54.0
