Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E1B1E515;
	Fri, 12 Jun 2026 21:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781301028; cv=none; b=FulNi74wdgsX+HYvkh2m6RJuRY40ZANv5fB6SPIefBVCwuJqTFypfOwrh2B1/aQuiK/XLSjRxBdikTYHeiCDghRiADFuyJWsZ0nMq8zp+GVa53aCJJ7IO2A65npJVgFH40ngFHtZ3M+7Gm4hfAid0HaK7FPVJHF/U/mSs1fRE7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781301028; c=relaxed/simple;
	bh=i/wHNoodhrU1B3cNl9zD9a+RagaSs0rpmpKRUiQ5q2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e18QNmkF3b2xgtu0AJbMUjBv+/ODD3RHnHNU5J6j+fYDQjMJWtQUHUQry2AhKgnSR/lATXbwidjfF6Cmjdf8cBqV60XcOC0FC5j1zLDyp6JPLMSB5b0qPphEQ6H2t7wlxTQFsHIPjPRbqenoFOEHLrG6p5WdfNoTFWIQVwQYthI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZiStwjz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZiStwjz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B661F000E9;
	Fri, 12 Jun 2026 21:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781301027;
	bh=4Hn4uLCtKpOnnO7Qnufe45nqMw1oy32p0a+DXoYU3EM=;
	h=From:To:Cc:Subject:Date;
	b=cZiStwjzVjMWD9i4RKp6wI6Ahe92clSB7vcj54S49ToIYt+gZkVJupoLQK4N7b0rD
	 DZmQf1F0e33eWsfPKtHDWrJDGrAVe9s33Mcf0JAwUcRSvq9Vl+SHH6wpaw9jSY1ZvB
	 7uRzV42RmKwzoyNN4BbzCacrkeT+4pwBylH5oQY7U1raopBdkl08B/XDSgYyQG4H8/
	 e77nD72mguzUmT7AJm6PKyqNaEZwBJQfJU1xKX0YBzdDsUoc3QSCgOBoKTdfU0fHGT
	 i8ucTC/avelb6oUe7Z6Ih1jlrPkxtvC8XIiK0ZVg8hdeMcHr33xoXdBzGa/vtNT6ot
	 a1IC9sGH3JIMA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Yang Shen <shenyang39@huawei.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: Fix mismatched DT property access types
Date: Fri, 12 Jun 2026 16:50:17 -0500
Message-ID: <20260612215017.1884893-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SPI drivers read properties whose bindings use normal uint32 cells.
Using boolean or u16 helpers makes the access look like a different DT
encoding and causes the property checker to flag the call sites.

Use presence checks for unsupported properties and read numeric cell
properties through u32 helpers before assigning to driver fields.

Assisted-by: Codex:gpt-5-5
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/spi/spi-fsl-espi.c     | 2 +-
 drivers/spi/spi-hisi-kunpeng.c | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 45b9974ae911..7e8c1a124463 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -760,7 +760,7 @@ static int of_fsl_espi_probe(struct platform_device *ofdev)
 	unsigned int irq, num_cs;
 	int ret;
 
-	if (of_property_read_bool(np, "mode")) {
+	if (of_property_present(np, "mode")) {
 		dev_err(dev, "mode property is not supported on ESPI!\n");
 		return -EINVAL;
 	}
diff --git a/drivers/spi/spi-hisi-kunpeng.c b/drivers/spi/spi-hisi-kunpeng.c
index 046bd894040b..0e61bf0bf2a4 100644
--- a/drivers/spi/spi-hisi-kunpeng.c
+++ b/drivers/spi/spi-hisi-kunpeng.c
@@ -463,6 +463,7 @@ static int hisi_spi_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct spi_controller *host;
 	struct hisi_spi *hs;
+	u32 num_cs;
 	int ret, irq;
 
 	irq = platform_get_irq(pdev, 0);
@@ -495,10 +496,11 @@ static int hisi_spi_probe(struct platform_device *pdev)
 	if (host->max_speed_hz == 0)
 		return dev_err_probe(dev, -EINVAL, "spi-max-frequency can't be 0\n");
 
-	ret = device_property_read_u16(dev, "num-cs",
-					&host->num_chipselect);
+	ret = device_property_read_u32(dev, "num-cs", &num_cs);
 	if (ret)
 		host->num_chipselect = DEFAULT_NUM_CS;
+	else
+		host->num_chipselect = num_cs;
 
 	host->use_gpio_descriptors = true;
 	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
-- 
2.53.0

