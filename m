Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F3B471402
	for <linux-spi@vger.kernel.org>; Fri, 16 Oct 2026 10:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146604; cv=none; b=GOP/S7pO9NFIWZwDZy8ZBa/7gytaEvIyHT7DZ2W57PDQLxqHy3XkH24C+E5LG8q6P1TYpe0aRIo0E223tYZ+J3KV7PWyJNzXQ+jPyfS5IJW+51PhpYpb4lHpRZkqdtH0rapISOhcCZWWk1sfQ1Y4mo70V/MXGLCw2398cVMeZLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146604; c=relaxed/simple;
	bh=D2b7psOXx7aXpSEZ1av8DCXbFAMQ302IX1dlH8jyuv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b27bAUe1vqfAbCN61JFFe/NmpkmEan79CV+36BnHX8xA5tz2d9DPwIT7Fn900zxoWlGe9Q0QtahDj3dSe7JE8zG8jouPGS7fqqdJKweYbQ9Cj8ij3UN31f2S3obwNybfWLVBcGcnS1aqSOoM557dZijZnOMH+ZIoIqIS+PkP+cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d2kaxmxh; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d2kaxmxh"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 69D85C62210;
	Fri, 16 Oct 2026 10:30:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A64CA6075D;
	Fri, 16 Oct 2026 10:29:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EEFA610328199;
	Fri, 16 Oct 2026 12:29:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792146598; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=dEV4JDvu9b4MI5F89XQ5tIsA7sj7WAJIIjrdLPyDVqk=;
	b=d2kaxmxhMGdRHLbQ6yco+f47yrJaolvGAYOZj5ryH9Jb0ToeKdZf/m3hyjujVOvDnj1kQX
	pOhxdZF+oqc6Fm4eu5aCjLFoyhP7pfFQo1Nkb4P29bh7rNX04zJqCPVyuVYEM+YE8HyTC5
	+vwUSlrshFuHaPKRnYPtGyV+d0AuLDlK/eZd/CWDfnw7oQ51A5+ZlS9RGrtpwFNzHmUCwA
	rdPVSeHfdhxTGMMzaL7s21a80ZhBxVIkD/591POP0Izj1X0ayqaHq9WX0FxUfgPUAGb/dG
	3Zp06EaR3ahbDuexkG5/lDGMi8i4yLY9D0qt6D8dQrChunTYQ/bPAgBvKlyawQ==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Mark Brown <broonie@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v4 2/7] mtd: spi-nor: Wait for NOR ready with poll_timeout_us()
Date: Fri, 16 Oct 2026 12:29:12 +0200
Message-ID: <20261016102917.171095-3-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016102917.171095-1-paul.cercueil@bootlin.com>
References: <20261016102917.171095-1-paul.cercueil@bootlin.com>
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
    
    v4: Also update kernel doc for new 'timeout_ms' parameter

 drivers/mtd/spi-nor/core.c | 42 +++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 8bc117b46e02..7f347141ea3f 100644
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
 
@@ -707,34 +708,25 @@ static int spi_nor_ready(struct spi_nor *nor)
  * spi_nor_wait_till_ready_with_timeout() - Service routine to read the
  * Status Register until ready, or timeout occurs.
  * @nor:		pointer to "struct spi_nor".
- * @timeout_jiffies:	jiffies to wait until timeout.
+ * @timeout_ms:		timeout value in milliseconds.
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

