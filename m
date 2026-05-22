Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8983B38E8C5;
	Fri, 22 May 2026 07:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779434196; cv=none; b=bCwGj4g9oS8l8+Z8MksZliI0mWCPPCzNlzB774CarGlr4Dw0s8lKpDsxj/skcYEVfq9TN2LVLawk2gt9PoTHWROyWVcFRmik/XGnKpEAZzyH8we653to14l2ElIex50Vc0ThvOnrQ4De9lBNOeL4OF2/MjovUqsNhpSZyUEeYwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779434196; c=relaxed/simple;
	bh=YE3+4tOwU8pg0VTtcTwjReAYrzSP06ELupdbffnK1eU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PpfNjUREAH9RCnzIsqIthpXIzHjs6dZwRRmg/K/GeoxB4HdzMbqyiYXATIu+hNcX/uywb5CF/tO/944xK072X7tts8eoVUARGOZsb/AAkFsbpHxDp0/cf+VXTPkxMWCLG6pB40VNkjKmL4jtPEJ8fXdeWXjuF2k+feg5exdCOxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 22 May
 2026 15:16:21 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 22 May 2026 15:16:21 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <clg@kaod.org>, <broonie@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <linux-aspeed@lists.ozlabs.org>,
	<openbmc@lists.ozlabs.org>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<david.laight.linux@gmail.com>, <BMC-SW@aspeedtech.com>
CC: kernel test robot <lkp@intel.com>
Subject: [PATCH v2 2/2] spi: aspeed: Replace VLA parameter with flat pointer in calibration helper
Date: Fri, 22 May 2026 15:16:21 +0800
Message-ID: <20260522071621.102507-3-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260522071621.102507-1-chin-ting_kuo@aspeedtech.com>
References: <20260522071621.102507-1-chin-ting_kuo@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

aspeed_spi_ast2600_optimized_timing() declared its buffer argument as a
variable-length array parameter (u8 buf[rows][cols]), which causes a
sparse warning. Replace the VLA parameter with a plain u8 * and compute
the 2-D index manually. The corresponding call site is also updated.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605180441.uD3toFRJ-lkp@intel.com/
Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 drivers/spi/spi-aspeed-smc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 808659a1f460..027caa2eeb5c 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -1467,8 +1467,7 @@ static int aspeed_spi_do_calibration(struct aspeed_spi_chip *chip)
  * must contains the highest number of consecutive "pass"
  * results and not span across multiple rows.
  */
-static u32 aspeed_spi_ast2600_optimized_timing(u32 rows, u32 cols,
-					       u8 buf[rows][cols])
+static u32 aspeed_spi_ast2600_optimized_timing(u32 rows, u32 cols, u8 *buf)
 {
 	int r = 0, c = 0;
 	int max = 0;
@@ -1478,7 +1477,7 @@ static u32 aspeed_spi_ast2600_optimized_timing(u32 rows, u32 cols,
 		for (j = 0; j < cols;) {
 			int k = j;
 
-			while (k < cols && buf[i][k])
+			while (k < cols && buf[(i * cols) + k])
 				k++;
 
 			if (k - j > max) {
@@ -1541,7 +1540,7 @@ static int aspeed_spi_ast2600_calibrate(struct aspeed_spi_chip *chip, u32 hdiv,
 		}
 	}
 
-	calib_point = aspeed_spi_ast2600_optimized_timing(6, 17, calib_res);
+	calib_point = aspeed_spi_ast2600_optimized_timing(6, 17, &calib_res[0][0]);
 	/* No good setting for this frequency */
 	if (calib_point == 0)
 		return -1;
-- 
2.34.1

