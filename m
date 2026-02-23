Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE8829DB64;
	Mon, 23 Feb 2026 14:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771857884; cv=none; b=YyemajyyrdWCZzNo5fwTHSHHj1omYsZieJvY0Ndq3eQLNCo/KqZ96lenBkmZ/MSBo33n1zJYzyyc78K21YKCGwNlOmHKKJYMdN2fUHD/UaSCaa5/ihsZpGtQsDDAEsDDlO28vorwTBhf2ihKfQ+z8flqOAcfar6OSJ/ZHgQeJAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771857884; c=relaxed/simple;
	bh=Y32WQTAqs2UW8D2aV2XoqsENrdmy1i9tl4k6oIU2vyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B2vnSxffnX1gOEXGkY2EYCTNt8SaONYKZlNQ1fDRwprQq1miKryAk9JA3wGi5GxUTvoNw9asw9vYJzi69xkfx5wKZD7QgtjAEhRzzQX8qR+gfsPPZvgU5/K8eRMf3VGrRSHwV61Vmi7tBdC0g0vt2QWT4z2Rdic6qDLjVsD9Lng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V4HbwEH4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V4HbwEH4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771857883; x=1803393883;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y32WQTAqs2UW8D2aV2XoqsENrdmy1i9tl4k6oIU2vyM=;
  b=V4HbwEH4Omegga27CSORb8w/lS0FSK3OjY0gjhYClwVAbbgQ2jnlZmts
   1nkDsE3HQmlbkUYZKBIuWqx/L1tu1d3rnr4v31d1mVg1NbOjFR9XNEErI
   AIYiEQ3gfaeb/6Z8x1KrBocAfevEGug5fYZ0En/+dXsB4xijNH8O1X1yF
   c4l23Z69p+60X7XuOuyfAPAUGWBKpgRIGluZ/E94LqFXkr3mvxVnMGO0B
   apHqXaeEGleuwh8aOvcwA+WR0iHDRLjOb+dKgQRKNNFPQ0IWjJaPoTDBf
   H84c4jhesNWMJ3C3JeFaac2WgRTGIoMT2tvxBVyPHGHT3EdfmCCy1obPC
   A==;
X-CSE-ConnectionGUID: VKgs5RaVSM+sl+f1/U6tcA==
X-CSE-MsgGUID: ecYOxfXxQmSzByOWAqOuew==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72952936"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="72952936"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 06:44:43 -0800
X-CSE-ConnectionGUID: sz06HygHSkKYk9AzfMvJnQ==
X-CSE-MsgGUID: QE4nOGsiTn6o4l29nknJHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="215600415"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 23 Feb 2026 06:44:41 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 060CC99; Mon, 23 Feb 2026 15:44:40 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/1] spi: pxa2xx: use min() instead of min_t()
Date: Mon, 23 Feb 2026 15:44:37 +0100
Message-ID: <20260223144437.2836369-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

min_t(int, a, b) casts an 'unsigned long' to 'int'. This might lead
to the cases when big number is wrongly chosen. On the other hand,
the SPI transfer speed rate is unsigned and driver uses signed type
for an unknown reason. Change the type of the SPI transfer speed
to be unsigned and convert to use min() instead of min_t().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index f7881a31e4cc..23e40f410814 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -796,7 +796,7 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
  * The function calculates parameters for all cases and chooses the one closest
  * to the asked baud rate.
  */
-static unsigned int quark_x1000_get_clk_div(int rate, u32 *dds)
+static unsigned int quark_x1000_get_clk_div(unsigned long rate, u32 *dds)
 {
 	unsigned long xtal = 200000000;
 	unsigned long fref = xtal / 2;		/* mandatory division by 2,
@@ -885,12 +885,12 @@ static unsigned int quark_x1000_get_clk_div(int rate, u32 *dds)
 	return q - 1;
 }
 
-static unsigned int ssp_get_clk_div(struct driver_data *drv_data, int rate)
+static unsigned int ssp_get_clk_div(struct driver_data *drv_data, unsigned long rate)
 {
 	unsigned long ssp_clk = drv_data->controller->max_speed_hz;
 	const struct ssp_device *ssp = drv_data->ssp;
 
-	rate = min_t(int, ssp_clk, rate);
+	rate = min(ssp_clk, rate);
 
 	/*
 	 * Calculate the divisor for the SCR (Serial Clock Rate), avoiding
@@ -902,8 +902,7 @@ static unsigned int ssp_get_clk_div(struct driver_data *drv_data, int rate)
 		return (DIV_ROUND_UP(ssp_clk, rate) - 1)  & 0xfff;
 }
 
-static unsigned int pxa2xx_ssp_get_clk_div(struct driver_data *drv_data,
-					   int rate)
+static unsigned int pxa2xx_ssp_get_clk_div(struct driver_data *drv_data, unsigned long rate)
 {
 	struct chip_data *chip =
 		spi_get_ctldata(drv_data->controller->cur_msg->spi);
-- 
2.50.1

