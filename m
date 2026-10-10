Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B378364935
	for <linux-spi@vger.kernel.org>; Sat, 10 Oct 2026 19:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791662130; cv=none; b=YWhqW7hABCXFKvM7DlWE63SgiHO3NA1TbEMeHwkyOvGMofh8dKOB1cgRLKjv74+jDZi/CZVIkIdjE7qk68bU2eFrJz+xl2bGNkupJ85GWOKQaeevmfZO0l8WtqBOqB+AXVN/gXLmFuPEQcLkQGJvBWnB5rceO3LKIlNj4RpVB7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791662130; c=relaxed/simple;
	bh=VvVh33q/LcRioaEUOAFFjkFOJPBDmzqONfWQOUP9HVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XQgZCLh+VWB49yqbvjMWDECj4JE7tyXwnpm1hxdc35f/h8LJxzQ+9GK9wKmAHzOejN8FAzubHoNtFAcTXDjLtL2cCgVQEsH9TDZcQQc+kUo6A1XhM3hbnUjRqJdwyj10ZLZq4zSTGy9K07NJJGC+qnokEn2qUJzMHafQ1kk2BrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maticrobots.com; spf=pass smtp.mailfrom=matician.com; dkim=pass (2048-bit key) header.d=maticrobots.com header.i=@maticrobots.com header.b=gQB1zRK2; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maticrobots.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matician.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maticrobots.com header.i=@maticrobots.com header.b="gQB1zRK2"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1419d3416ceso1273397c88.0
        for <linux-spi@vger.kernel.org>; Sat, 10 Oct 2026 12:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maticrobots.com; s=google; t=1791662127; x=1792266927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gVa5PKFZG05oCr1W6VnQbp7u/39NDlzVBtH1WKIfORk=;
        b=gQB1zRK2qSPeJUanOjQchZajT8gOROIfT/PiTsWk5xUhFum3ejOdbahqz/svAjqKm0
         Kv0k4ZUi97rL87YkxsDOBpOsKjp2mCzWS3fy+BU8MUuj8IUeQdPiecN2/BBZmE8vAttP
         w06vfvqOYb3VsX4YUrWdLOEJJRPmn7s8qxUEk3R46b9GzrLqrXHWmobAN3kTMJkK8obp
         V0U2Wz+Il6kb6jmIZPvntyeqncLL4CE6TvsdALmQg1OoSZ/CdL8zxSvEKB4cow0AokhT
         6uXRO91MspinKugizFllJ80bbtzSH8frP9U+pLk4mGviyGjYWiHM2PMqxZl93GkGaISz
         Wgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791662127; x=1792266927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gVa5PKFZG05oCr1W6VnQbp7u/39NDlzVBtH1WKIfORk=;
        b=pkwbAswujGK98CNwLqBq2yRopprwPjloCPdERYVia5m8/yIxrr/C8A0J1FXlSn6ZTN
         0TijapDpymx2+YxiREys1ziTCK8FdLgYtOJ/w/yXg2olvoiEaLF3jwfo0x5YC6qjglxm
         f63RYMRrVfp/UKIQNabb1weu5DR1KNZjfEYlheNTOHv+sDUDNCrbnMFOmuQbKEiGbPg8
         Xm48UAempvAPuhvFS58W7hPHXqZgcDXgPxCETWd1bDcIBAbdGF+hs4Imll8JC1rZLZV1
         gh6Fg4KkxPQg9dhzLK1cpBRI2boBFGFpJZldLq26mBATX4OHackddDndew0+0+DqiuUa
         2buA==
X-Forwarded-Encrypted: i=1; AKwUvBzErBLVtMv4xNp5HPccHTl2UV6NnBi5H7oeAE/WbJEH4MVdNo2ZWjbYz2oDjTLmRsbY7AtiJeYjuHE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcKtdGUo6hAvyLlKJF3GJdhnxpB7LKKGSKjVay+y7+iPEkiQUS
	PEGiLsTRQ7R0bwqOi/Dp7gpJtRS1Y+J6YwzlOpxkGlkR1/O5YtLaatJxhy8cZScYdTU=
X-Gm-Gg: AYBFou04p1isQmmg4hG5UpKAGtYZV7pHCIj5RV1R6UduOw0JGVKVkuKfICV8DW32K+2
	nVOjxGu/Jzb4Aq29ripua7raDGpScr7o6YwiUfSqpR7qUyEeuAXTzQtI63M2meFUZSj8pCeG9lx
	f16XYOLuFgPAk0mLfZHJmmZg4C6Vl8pffNTh37rRMR1GcjAOK/uQ9jf3PEUpITl47neEgkxkqAO
	m4FsGFZRzneX1c+Q3+Z+u9VR4FJbzauyfrtFd3eQR76YpEIAne/MA1v1KYD5rLlNWvITx7ijlzs
	/NXq0aivmYwK9X6qhDi2A2VUUwMT2ERM+7QVznntuMlf7TI/1/KGub72fTALeDxAvE1kLKX532r
	nfcHIPib4GtyvFVv/RkfNBzGVENMSVlh6PWx6o/0pYXabSK5QUVGl63SzvhhoI+LxzQbONb5R0v
	AyKBOYI9woMwsCsrLBnROs36Fgw7WNBJmlK+GnehCzgs0BH2RdkzQYWtmsW8Rela76o8Wbxzyxg
	qlw689e3zo+j8Uk8iBkzDBWDxej0sMiFACIOcZCYrDRKq8=
X-Received: by 2002:a05:7022:43a3:b0:14f:b5ac:ace4 with SMTP id a92af1059eb24-16a62ea9574mr9846984c88.44.1791662126977;
        Sat, 10 Oct 2026 12:55:26 -0700 (PDT)
Received: from abeMaticDesktop.1020marsh.offices.matician.com ([2600:1700:471:807f:88c:2ee5:394c:5592])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841648sm20211705eec.3.2026.10.10.12.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 12:55:26 -0700 (PDT)
From: Abraham Zukor <abe@maticrobots.com>
To: Mark Brown <broonie@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>
Cc: Abraham Zukor <abe@maticrobots.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-spi@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] spi: tegra114: initialize native chip selects inactive
Date: Sat, 10 Oct 2026 12:54:05 -0700
Message-ID: <20261010195503.623287-1-abe@maticrobots.com>
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

If an enabled child shares a chip select with disabled ones, its
polarity takes priority. If only disabled children use a chip select
and they disagree, warn and leave the line inactive high.

Fixes: f333a331adfa ("spi/tegra114: add spi driver")
Assisted-by: Claude:Opus-5
Signed-off-by: Abraham Zukor <abe@maticrobots.com>
---
v4:
- Let an enabled child's polarity take priority over disabled children
  on the same chip select (Jon Hunter, Mark Brown).
- Warn when only disabled children use a chip select and they disagree
  on polarity.
- Link to v3: https://lore.kernel.org/all/20260826000517.631736-1-abe@maticrobots.com/

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

 drivers/spi/spi-tegra114.c | 49 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index aa44ffd09..ebf568d0f 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1301,6 +1301,9 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	struct resource		*r;
 	int ret, spi_irq;
 	int bus_num;
+	u32 conflicting_cs;
+	u32 enabled_child_cs_polarity = 0, disabled_child_cs_low = 0, disabled_child_cs_high = 0;
+	u32 enabled_cs_mask = 0;
 
 	host = devm_spi_alloc_host(&pdev->dev, sizeof(*tspi));
 	if (!host) {
@@ -1395,6 +1398,52 @@ static int tegra_spi_probe(struct platform_device *pdev)
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
+	 * select at the level their hardware needs. An enabled child on the
+	 * same CS takes priority.
+	 */
+	for_each_child_of_node_scoped(pdev->dev.of_node, np) {
+		u32 cs;
+		u32 polarity_bitmask;
+		u32 cs_polarity = 0;
+
+		if (of_property_read_u32(np, "reg", &cs))
+			continue;
+
+		if (cs >= MAX_CHIP_SELECT)
+			continue;
+
+		polarity_bitmask = SPI_CS_POL_INACTIVE(cs);
+		if (!of_property_read_bool(np, "spi-cs-high"))
+			cs_polarity = polarity_bitmask;
+
+		if (of_device_is_available(np)) {
+			enabled_cs_mask |= polarity_bitmask;
+			enabled_child_cs_polarity |= cs_polarity;
+		} else {
+			if (cs_polarity)
+				disabled_child_cs_low |= polarity_bitmask;
+			else
+				disabled_child_cs_high |= polarity_bitmask;
+		}
+	}
+	conflicting_cs = disabled_child_cs_low & disabled_child_cs_high & ~enabled_cs_mask;
+	for (u32 cs = 0; cs < MAX_CHIP_SELECT; cs++) {
+		if (SPI_CS_POL_INACTIVE(cs) & conflicting_cs)
+			dev_warn(&pdev->dev,
+				 "Conflicting CS polarity on disabled nodes at cs %u\n", cs);
+	}
+
+	tspi->def_command1_reg |= enabled_child_cs_polarity |
+		(disabled_child_cs_low & ~enabled_cs_mask);
 	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
 	tspi->spi_cs_timing1 = tegra_spi_readl(tspi, SPI_CS_TIMING1);
 	tspi->spi_cs_timing2 = tegra_spi_readl(tspi, SPI_CS_TIMING2);
-- 
2.52.0

