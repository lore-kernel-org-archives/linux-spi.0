Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB0EB67E
	for <linux-spi@vger.kernel.org>; Fri, 31 Jul 2026 03:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785466909; cv=none; b=Mdg0rRbGzmF3ueYU3PW9zv4z2Rn+UPfd0fsouUChLM/XkkVvH0wbA3ZNirfsoL+La5MYXakbOSNGy0s5R/Svq8LMeWJ85dSMCWvvh9UF0q5lazB/2gvlqc4T6Im+GeMFAX2ClxhlipfpyCGpvjDFYKuG7+pP4mPScUYDYomICjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785466909; c=relaxed/simple;
	bh=xVuqwWU/Hq3MBmHMIsPrY63b1CZKh/6uMm+MeXqTnE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ADKlFEHlLoRjzP8RKzR64449TKdLKUU55SThJ5pJ3qjdQ8Iqomw+PwzG2JZH6WdUFMXEWxPl5SblHjAj8+bfT4hQJMHP58VNb/yGrh8Qg1HsIZIsnjjTb/3ECUHRzeW5cm0F/dt0cb6JHlvEPFOoecCPsbkh9FseIijn1nzBzSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maticrobots.com; spf=pass smtp.mailfrom=matician.com; dkim=pass (2048-bit key) header.d=maticrobots.com header.i=@maticrobots.com header.b=K9y3WDxd; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maticrobots.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matician.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maticrobots.com header.i=@maticrobots.com header.b="K9y3WDxd"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso417279a91.1
        for <linux-spi@vger.kernel.org>; Thu, 30 Jul 2026 20:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maticrobots.com; s=google; t=1785466906; x=1786071706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JEAKmo/im2A7ohLUafUy0tFuJN05tlf0xDV2jrhpBRI=;
        b=K9y3WDxd/1QLqi6kUNMrZ2EAoKIvNN4BUNh13mTCisvZWHrc+CQNc6RzX72BNhu8B2
         Ih4/rY+o0j2IgwND/KycdecOxU+DpS9b4khWeLdVgwWZ67xxvVMGGcE4DJlf7k7IyMOk
         wbhA91X7K6DfrGlXeIwH8LK1poYEPfsZ9ZpFXye5zr2xXF1uO6ukwkkRvG1mziSbgfHV
         Y971mSAuCntPBOG7S2AXjwTDBa0CiwXB3GHHjVmSK1C0yNfkxitvtGs161XEK+Np3mlK
         iscoYdbxcTJM3gZUMFMae2hjGe/4lz3zHJP7C3QWYkySXEXB1twoZjUPMYiWOL8UzSrL
         k3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785466906; x=1786071706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JEAKmo/im2A7ohLUafUy0tFuJN05tlf0xDV2jrhpBRI=;
        b=TTvypO/fyc0PJHz0skztmfGfBOML7mKlfxQ0uMNbnDgS0lwMara/coMJiHP2FRkubC
         ypn6T6DJdLO4EMfpYWpiBSi0gVkWpBYlRL7xm5pi/fl1HUK7/70kUQWpct6jPhYpR8Nc
         708SUy2uyyKFozif4MIxqdghwy/KDJQ8YCeaId3SR5yFT9uWSgHqS21k3GOH3ovB+CyK
         Q7wEofyHB1DOrYksIeO+6uaEZ6bOiYqbHE+LbdSxW9sarEN50T2XyD8v+XFV0sQlj+WI
         QAae6czoPxQudX1C8H2n4iNrFc5O/duP7Lg61QE9aTRkraRqzit4feDeUmlrF5Bv+Lcs
         +W5A==
X-Forwarded-Encrypted: i=1; AHgh+RrODo0oKixOPLFH5g6p4nGsd+HNenJ1G9Pffxojv2CSh98jZCXtxFbZUiKi1v6miOcvLbycUYCXGVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx07aDbG0qX5D8kJFX4orcFQeeC8i8LFcC8xfFCQKXjkfHXzA17
	fcZq9PdyKeXyXloPWOqt9gsB2+V438u2yXYGbOxhxMlalvvWnUtNPi/XdOWl1S0a+K0=
X-Gm-Gg: AR+sD13oU6VgZ+pPFYcsbDzK9810mGoD1PFnx+kgLJDiL0oEpGuHuh84XhsSCA5g5oS
	ps624XvNDyK+Kzu0yZazIiG3pxyjY6zenOctUyOsyx6UbaVVqANL4AZJ3V/pxxyDR1XL153c04x
	YsgXohoA1jrichv9ekV5/0klJu1fg3IzkZPpMuVZtidp+H/rNNR6Jj6c086yYUAk7kqFdotDF67
	u6hCW5HlWeonMEWZ9XJh+WxrA+zTtaU6kGvfAgLotX7jOn38Quh763eCn2Ligc/CGZsxCfJuVlb
	0vnu9mWYXYb39K/0KXYfBj2a2D4zxi9IIEysyj5VLIhQrwE2/7KiwXVA4Ya59nVjGDtfFJPsS1d
	3UUlbkX8Ks5TNMrKT3RiIkqwXahI6xrOkzEaCJomeM7/TEG7xIOv+BIVrTUEtE1lfvC48+HHj/y
	X9qRmHMJUZ16hJ/bGvGdZFd7jmwzFpZAblq57UkhFp9gkUO5gBEWtUtqu388bJ+eR+I8jziQqPo
	9imTUuwkf2s7MPWrmC/l7XVtvyDxSbVWSYkBw==
X-Received: by 2002:a17:90b:33ce:b0:38e:7a05:9c0a with SMTP id 98e67ed59e1d1-38fb11ce2a4mr321583a91.18.1785466906395;
        Thu, 30 Jul 2026 20:01:46 -0700 (PDT)
Received: from abeMaticDesktop.1020marsh.offices.matician.com ([2600:1700:471:807f:4328:dce4:fe00:16d4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153aee77c2sm974003eec.30.2026.07.30.20.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 20:01:45 -0700 (PDT)
From: Abraham Zukor <abe@maticrobots.com>
To: Mark Brown <broonie@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>
Cc: Abraham Zukor <abe@maticrobots.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-spi@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] spi: tegra114: initialize native chip selects inactive
Date: Thu, 30 Jul 2026 20:01:28 -0700
Message-ID: <20260731030134.4182688-1-abe@maticrobots.com>
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
written and set CS_POL_INACTIVE for each native chip select a child
claims without spi-cs-high. That is the level tegra_spi_setup() programs
for the same device later, so the line is already deasserted when the
first child transfers and does not change level when setup runs.

Disabled children are walked too. The core only registers available
children, so tegra_spi_setup() never runs for a disabled one and probe
is the only chance to park its chip select at the level its hardware
needs.

Every other bit keeps the zero the driver has always written. A chip
select with no child in the device tree, one whose child asks for
spi-cs-high, and one driven by a GPIO are all left as before. An
active-low device on a chip select the device tree does not describe is
therefore still asserted while a declared device probes, which is a
pre-existing problem this does not address.

Fixes: f333a331adfa ("spi/tegra114: add spi driver")
Assisted-by: Claude:Opus-5
Signed-off-by: Abraham Zukor <abe@maticrobots.com>
---
v2: derive the inactive level per chip select from the device tree rather
than setting the whole CS_POL_INACTIVE field. A single constant is wrong
for an active-high or a mixed-polarity bus, as Jon pointed out on v1.

Tested on a Jetson Orin Nano carrier board with active-low devices on CS0
and CS1, and with the CS1 node disabled to confirm its chip select is
still parked inactive.

v1: https://lore.kernel.org/r/20260725042944.1204409-1-abe@maticrobots.com/

 drivers/spi/spi-tegra114.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index aa44ffd09e61..d82b88c4fa9b 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1395,6 +1395,31 @@ static int tegra_spi_probe(struct platform_device *pdev)
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
+		/* Only an active-low native chip select needs its bit set. */
+		if (of_property_read_bool(np, "spi-cs-high") ||
+		    of_property_read_u32(np, "reg", &cs) ||
+		    cs >= MAX_CHIP_SELECT ||
+		    !of_parse_phandle_with_args(pdev->dev.of_node, "cs-gpios",
+						"#gpio-cells", cs, NULL))
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

