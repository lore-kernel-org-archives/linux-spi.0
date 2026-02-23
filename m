Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587292EAB61;
	Mon, 23 Feb 2026 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860683; cv=none; b=N1gzd4P9FsUyHKbuLn8rDPU7Hen0obO/APHgv2KCRjMvsyaYrHQFgqk5A52ayjmCRcpzI4KID2FDUqz9YKB62t2yVHym+W52WNHa67BPvB6qHrElF7aQb1hlnyLjeoI87MFk+uheRzafgkZv5INsAp0C9uhvUcmpMerRg/B4VvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860683; c=relaxed/simple;
	bh=RTrWdFZssRl42W6iXmUkyx50O+uru7AE76dymReZQyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HgZIqP5a9zABcKvtbBod4l2OatchqpEEe3bhOSB/K3zKzExLUVNfyTI6ZgrvfNGEk1P92p5y8DOxt8AIzknCLKNUO+4R8K3vW4L9PTPxZ+04aFdYmFY7ORfRwXFUaUohtbPTojta78T00k55iyWKiTsL/s2i3sm0Weq9/4vUVBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1gPSrQF; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1gPSrQF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771860682; x=1803396682;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RTrWdFZssRl42W6iXmUkyx50O+uru7AE76dymReZQyE=;
  b=m1gPSrQFj0Erb09Ii++NpuhCQVHLJXhBjTOmmFa2mVkaOkbzwPx3/duf
   36ATTO5qcOmAPJetHMsuj5Z6DHUkbP6nrpqY8b/1bHEeGDgYTrmLzNvPk
   FObAV0Xtcj9ANgAZOxDan4jSzqG3e3LDEEK0WLlLmnLQOExZkbtgC5Eto
   D3KT8HhfjTvgiYzeGMm2ZT+JWfRIKQEZsP7+p0qYhGTXlDufwgrUQAVX7
   LclFX+VttueKoESDXQps8pr+RRmLioNmq7VlpoYoigb4k+DNXsPiYtKfO
   Y23qfOASNbmGtZZ0aiGk4Eq4UCsI4Xmvd+vR7+NhEBZBO8jUjZyqwb408
   w==;
X-CSE-ConnectionGUID: VhbkT15/Tpii9aF84ZuhEg==
X-CSE-MsgGUID: zU9S+h41TGKrx1wue3JhsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72760307"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="72760307"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 07:31:21 -0800
X-CSE-ConnectionGUID: 5J+watY/SiuJkLEqas+JOg==
X-CSE-MsgGUID: bGt+aK5aTOmSsieGJwTZWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="213524184"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 23 Feb 2026 07:31:19 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id BDE4B99; Mon, 23 Feb 2026 16:31:18 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 1/1] spi: pxa2xx: use min() instead of min_t()
Date: Mon, 23 Feb 2026 16:30:54 +0100
Message-ID: <20260223153117.2838840-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

min_t(int, a, b) casts an 'u32' to 'int'. This might lead to
the cases when big number is wrongly chosen. On the other hand,
the SPI transfer speed rate is unsigned and driver uses signed type
for an unknown reason. Change the type of the SPI transfer speed
to be unsigned and convert to use min() instead of min_t().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: used u32 instead of unsigned long (David)

 drivers/spi/spi-pxa2xx.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index f7881a31e4cc..6291d7c2e06f 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -796,7 +796,7 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
  * The function calculates parameters for all cases and chooses the one closest
  * to the asked baud rate.
  */
-static unsigned int quark_x1000_get_clk_div(int rate, u32 *dds)
+static unsigned int quark_x1000_get_clk_div(u32 rate, u32 *dds)
 {
 	unsigned long xtal = 200000000;
 	unsigned long fref = xtal / 2;		/* mandatory division by 2,
@@ -885,12 +885,12 @@ static unsigned int quark_x1000_get_clk_div(int rate, u32 *dds)
 	return q - 1;
 }
 
-static unsigned int ssp_get_clk_div(struct driver_data *drv_data, int rate)
+static unsigned int ssp_get_clk_div(struct driver_data *drv_data, u32 rate)
 {
-	unsigned long ssp_clk = drv_data->controller->max_speed_hz;
+	u32 ssp_clk = drv_data->controller->max_speed_hz;
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
+static unsigned int pxa2xx_ssp_get_clk_div(struct driver_data *drv_data, u32 rate)
 {
 	struct chip_data *chip =
 		spi_get_ctldata(drv_data->controller->cur_msg->spi);
-- 
2.50.1

