Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680C655C315
	for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992663; cv=none; b=RaWEL/dY9GuwAku93EjsgCSAG8QalijkJJUv02L1jtnxafYwrb+cYyTyEsIjvUmGxg03bNKE4HMEqPvkaj1GiTGEv5KW9qyvbkJczUKdffpowjASOKYYIx81wUWmTr2fdtkh3LF+2rdkwNji0Rx4F8hlOJZu8N9DMCO3N/W22MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992663; c=relaxed/simple;
	bh=s4CYB/5c6lZ7Zm2WmfhbIHufOZSnlS3OK2XVFacxqgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6/3usgqTUSSTYT1PXYTP4tzHDg5u4tQt62BHCR+vgEExSRgwcKOmcDnDm/5AYepfhMtV3Xz8bZGirl0lbGR+xkDaUU2X17TftexlfBsmMf+d417C+tZ4CQt73OYxB93BrmaJMEeomxYtQunNGNTRLysXdX7m6xExPDuxfkwXoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=it6MIToY; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="it6MIToY"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D25441A1232;
	Wed, 14 Oct 2026 15:44:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9E80F60368;
	Wed, 14 Oct 2026 15:44:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 35E8F103284ED;
	Wed, 14 Oct 2026 17:44:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791992652; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=L3yzdkIIoXv+mg+K4J6YhHul2QjJeOxkn+qRFdP45OA=;
	b=it6MIToYsynzobACp4L5OJp1WnYlJ7aazkBmu4Zj5E6nddHy4iQ5K2pWaZhEpIf31lCCfs
	AetRiCanK/zzhBFbgPS+DAsw5nZF4wWtojnNd29rV4f0O/pw05S9/MXEmWVVdY5msS5A+o
	wX2eVxMgizrO5A1KrURLqeNXzecPnP4q+t9gHLppGxdJ6pVyW7ahK7m6IAqRgysjIVqvjs
	8p89hu4s0nHH9Abpmw4UHUieKvB0K5pmywQX4sXaIv7Pp/wPQZIkv4rR1gGP6Pya9sxF23
	bOw8bQMUdEuHjyixpunzIF3EcWUJL/xibTZEX74DhkYJzBEVTK6FHr1+QMl/kw==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v3 2/7] mtd: spi-nor: Wait for NOR ready with poll_timeout_us()
Date: Wed, 14 Oct 2026 17:42:56 +0200
Message-ID: <20261014154301.157755-3-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261014154301.157755-1-paul.cercueil@bootlin.com>
References: <20261014154301.157755-1-paul.cercueil@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Tanmay Jagdale <tanmay@marvell.com>

Instead of polling for the spi_nor_ready() with a custom loop, use
poll_timeout_us(). The sleep period between two polls is set to 100 us
which I think should be fine.

This will make it simpler to support waiting for the SPI NOR in atomic
context later.

Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>
---

Notes:
    v2: New patch
    
    v3: Set 'timeout_ms' parameter to u64 to prevent u32 overflow

 drivers/mtd/spi-nor/core.c | 40 +++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 8bc117b46e02..58257cc21c68 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -12,6 +12,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/iopoll.h>
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mtd/mtd.h>
@@ -32,13 +33,13 @@
  * For everything but full-chip erase; probably could be much smaller, but kept
  * around for safety for now
  */
-#define DEFAULT_READY_WAIT_JIFFIES		(40UL * HZ)
+#define DEFAULT_READY_TIMEOUT_MS		40000UL
 
 /*
  * For full-chip erase, calibrated to a 2MB flash (M25P16); should be scaled up
  * for larger flash
  */
-#define CHIP_ERASE_2MB_READY_WAIT_JIFFIES	(40UL * HZ)
+#define CHIP_ERASE_2MB_READY_TIMEOUT_MS		40000UL
 
 #define SPI_NOR_MAX_ADDR_NBYTES	4
 
@@ -711,30 +712,21 @@ static int spi_nor_ready(struct spi_nor *nor)
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int spi_nor_wait_till_ready_with_timeout(struct spi_nor *nor,
-						unsigned long timeout_jiffies)
+static int spi_nor_wait_till_ready_with_timeout(struct spi_nor *nor, u64 timeout_ms)
 {
-	unsigned long deadline;
-	int timeout = 0, ret;
+	int ret, status;
 
-	deadline = jiffies + timeout_jiffies;
-
-	while (!timeout) {
-		if (time_after_eq(jiffies, deadline))
-			timeout = 1;
-
-		ret = spi_nor_ready(nor);
-		if (ret < 0)
-			return ret;
-		if (ret)
-			return 0;
-
-		cond_resched();
+	ret = poll_timeout_us(status = spi_nor_ready(nor), status,
+			      100, timeout_ms * 1000, false);
+	if (ret < 0) {
+		dev_dbg(nor->dev, "flash operation timed out\n");
+		return ret;
 	}
 
-	dev_dbg(nor->dev, "flash operation timed out\n");
+	if (status < 0)
+		return status;
 
-	return -ETIMEDOUT;
+	return 0;
 }
 
 /**
@@ -747,7 +739,7 @@ static int spi_nor_wait_till_ready_with_timeout(struct spi_nor *nor,
 int spi_nor_wait_till_ready(struct spi_nor *nor)
 {
 	return spi_nor_wait_till_ready_with_timeout(nor,
-						    DEFAULT_READY_WAIT_JIFFIES);
+						    DEFAULT_READY_TIMEOUT_MS);
 }
 
 /**
@@ -1781,8 +1773,8 @@ static int spi_nor_erase_dice(struct spi_nor *nor, loff_t addr,
 	 * pull these from CFI/SFDP, but these values should be good
 	 * enough for now.
 	 */
-	timeout = max(CHIP_ERASE_2MB_READY_WAIT_JIFFIES,
-		      CHIP_ERASE_2MB_READY_WAIT_JIFFIES *
+	timeout = max(CHIP_ERASE_2MB_READY_TIMEOUT_MS,
+		      CHIP_ERASE_2MB_READY_TIMEOUT_MS *
 		      (unsigned long)(nor->mtd.size / SZ_2M));
 
 	do {
-- 
2.47.3

