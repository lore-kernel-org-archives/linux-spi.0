Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BA43803FD;
	Mon,  5 Oct 2026 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187951; cv=none; b=pGEByLclDTK+hs1BS7b94SqbY2KvD2/ty/83tyHmnD4vDF+QRAJ1TS/2my3c0tfWC8wSkD9mmvCLE4zpT/K4WOba2vfGw2cYz+dRY4dJ+tM9XMo226cfR+a8Is3834UeL17er/mlNB6fTSU+buhKCQIPef5oeqfC5Z06SqYxaQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187951; c=relaxed/simple;
	bh=YY1xeFnm3Ho6GD8lzWCKAqQt34xIKPSne8MhWlFtbII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pj7FrtCBl3f9ZuE5pvcoISXhG/9bphL2gHqxnvrrNkccUnc3+TslQwg24HzPha8qc9V0e/CJ9Qpz7IHrY7R97llFQeox4zef2buume/gPvajRoGXUCe3zUG7oIyqovM9C6oGb/vhGYzdB41ePci7UUoRelAnWJKoNBeEcUb2gwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GbLNfpBC; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GbLNfpBC"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0F8474E4118F;
	Mon,  5 Oct 2026 08:12:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D819A604FE;
	Mon,  5 Oct 2026 08:12:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 86CC310330458;
	Mon,  5 Oct 2026 10:12:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791187945; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=3Jyg9mafP/xQd217t3sw8G3s1vYRGBrmEWmcRl72N0Y=;
	b=GbLNfpBCrtjyhwwLPZxtqvWQOVgk1Hb+V7yEmwuSEgYzQmzGCrIHWR9d1hjTn4hgDYlcEy
	WH/R8jQBcZ9axb25/55kRI21ocAJWGAS4WmYdn/EeYKUEtWBCHYZAQDW1ysG2owteUaPY/
	sjbPbvtzmDL46ZvglHQVz2spvCfkwFXu8v9GQAFW+6RrUvvYSHLEoYO3kmAC34Br3c0hQ+
	/uIdkARHhv2clmoVo6PeppTN7hcw8UuOAyCWBEtMZRjjm/R+mSd99iXtkG1PqDktERu5CR
	P05zhTdSGQcNLsQzpPyeKTW/8/xM61uzg1UuXTFEbR+2nfb6A9X/AJDFScUUQA==
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
	Tanmay Jagdale <tanmay@marvell.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH 2/5] mtd: spi-nor: Add support for panic writes
Date: Mon,  5 Oct 2026 10:11:37 +0200
Message-ID: <20261005081141.33688-3-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005081141.33688-1-paul.cercueil@bootlin.com>
References: <20261005081141.33688-1-paul.cercueil@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Tanmay Jagdale <tanmay@marvell.com>

If the SPI controller supports it, provide the functionality of doing a
panic write.

Update the spi-nor core code and controllers to make sure they won't try
to grab locked mutexes or sleep when doing a panic write, as preemption
and IRQs are disabled.

The information is carried down to the SPI controller driver through the
spi_mem_op structure. If the corresponding flag is set there, and the
SPI driver does support panic writes, it then has to respect the same
rules.

Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>
---
 drivers/mtd/spi-nor/core.c | 67 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 8bc117b46e02..2cdeebf3e25b 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -96,6 +96,9 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
 	if (op->data.nbytes)
 		op->data.buswidth = spi_nor_get_protocol_data_nbits(proto);
 
+	if (nor->mtd.oops_panic_write)
+		op->panic_write = true;
+
 	if (spi_nor_protocol_is_dtr(proto)) {
 		/*
 		 * SPIMEM supports mixed DTR modes, but right now we can only
@@ -281,7 +284,7 @@ static ssize_t spi_nor_spimem_write_data(struct spi_nor *nor, loff_t to,
 	if (spi_nor_spimem_bounce(nor, &op))
 		memcpy(nor->bouncebuf, buf, op.data.nbytes);
 
-	if (nor->dirmap.wdesc) {
+	if (nor->dirmap.wdesc && !nor->mtd.oops_panic_write) {
 		nbytes = spi_mem_dirmap_write(nor->dirmap.wdesc, op.addr.val,
 					      op.data.nbytes, op.data.buf.out);
 	} else {
@@ -664,6 +667,9 @@ static void spi_nor_rww_end_rdst(struct spi_nor *nor)
 
 static int spi_nor_lock_rdst(struct spi_nor *nor)
 {
+	if (nor->mtd.oops_panic_write)
+		return 0;
+
 	if (spi_nor_use_parallel_locking(nor))
 		return spi_nor_rww_start_rdst(nor);
 
@@ -672,6 +678,9 @@ static int spi_nor_lock_rdst(struct spi_nor *nor)
 
 static void spi_nor_unlock_rdst(struct spi_nor *nor)
 {
+	if (nor->mtd.oops_panic_write)
+		return;
+
 	if (spi_nor_use_parallel_locking(nor)) {
 		spi_nor_rww_end_rdst(nor);
 		wake_up(&nor->rww.wait);
@@ -729,7 +738,10 @@ static int spi_nor_wait_till_ready_with_timeout(struct spi_nor *nor,
 		if (ret)
 			return 0;
 
-		cond_resched();
+		if (nor->mtd.oops_panic_write)
+			cpu_relax();
+		else
+			cond_resched();
 	}
 
 	dev_dbg(nor->dev, "flash operation timed out\n");
@@ -1291,6 +1303,9 @@ static void spi_nor_rww_end_io(struct spi_nor *nor)
 
 static int spi_nor_lock_device(struct spi_nor *nor)
 {
+	if (nor->mtd.oops_panic_write)
+		return 0;
+
 	if (!spi_nor_use_parallel_locking(nor))
 		return 0;
 
@@ -1299,6 +1314,9 @@ static int spi_nor_lock_device(struct spi_nor *nor)
 
 static void spi_nor_unlock_device(struct spi_nor *nor)
 {
+	if (nor->mtd.oops_panic_write)
+		return;
+
 	if (spi_nor_use_parallel_locking(nor)) {
 		spi_nor_rww_end_io(nor);
 		wake_up(&nor->rww.wait);
@@ -1336,6 +1354,9 @@ int spi_nor_prep_and_lock(struct spi_nor *nor)
 {
 	int ret;
 
+	if (nor->mtd.oops_panic_write)
+		return 0;
+
 	ret = spi_nor_prep(nor);
 	if (ret)
 		return ret;
@@ -1351,6 +1372,9 @@ int spi_nor_prep_and_lock(struct spi_nor *nor)
 
 void spi_nor_unlock_and_unprep(struct spi_nor *nor)
 {
+	if (nor->mtd.oops_panic_write)
+		return;
+
 	if (!spi_nor_use_parallel_locking(nor)) {
 		mutex_unlock(&nor->lock);
 	} else {
@@ -1407,6 +1431,9 @@ static int spi_nor_prep_and_lock_pe(struct spi_nor *nor, loff_t start, size_t le
 {
 	int ret;
 
+	if (nor->mtd.oops_panic_write)
+		return 0;
+
 	ret = spi_nor_prep(nor);
 	if (ret)
 		return ret;
@@ -1422,6 +1449,9 @@ static int spi_nor_prep_and_lock_pe(struct spi_nor *nor, loff_t start, size_t le
 
 static void spi_nor_unlock_and_unprep_pe(struct spi_nor *nor, loff_t start, size_t len)
 {
+	if (nor->mtd.oops_panic_write)
+		return;
+
 	if (!spi_nor_use_parallel_locking(nor)) {
 		mutex_unlock(&nor->lock);
 	} else {
@@ -1480,6 +1510,9 @@ static int spi_nor_prep_and_lock_rd(struct spi_nor *nor, loff_t start, size_t le
 {
 	int ret;
 
+	if (nor->mtd.oops_panic_write)
+		return 0;
+
 	ret = spi_nor_prep(nor);
 	if (ret)
 		return ret;
@@ -1495,6 +1528,9 @@ static int spi_nor_prep_and_lock_rd(struct spi_nor *nor, loff_t start, size_t le
 
 static void spi_nor_unlock_and_unprep_rd(struct spi_nor *nor, loff_t start, size_t len)
 {
+	if (nor->mtd.oops_panic_write)
+		return;
+
 	if (!spi_nor_use_parallel_locking(nor)) {
 		mutex_unlock(&nor->lock);
 	} else {
@@ -3393,6 +3429,26 @@ static void spi_nor_soft_reset(struct spi_nor *nor)
 	usleep_range(SPI_NOR_SRST_SLEEP_MIN, SPI_NOR_SRST_SLEEP_MAX);
 }
 
+static int spi_nor_panic_write(struct mtd_info *mtd, loff_t to, size_t len,
+			       size_t *retlen, const u_char *buf)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+
+	/*
+	 * At this point preemption and local interrupts are disabled, so we
+	 * can't get the lock if it's taken.
+	 */
+	if (mutex_is_locked(&nor->lock))
+		return -EPERM;
+
+	if (spi_nor_use_parallel_locking(nor) &&
+	    (nor->rww.ongoing_io || nor->rww.ongoing_rd)) {
+		return -EPERM;
+	}
+
+	return spi_nor_write(mtd, to, len, retlen, buf);
+}
+
 /* mtd suspend handler */
 static int spi_nor_suspend(struct mtd_info *mtd)
 {
@@ -3596,8 +3652,13 @@ static int spi_nor_set_mtd_info(struct spi_nor *nor)
 	mtd->size = nor->params->size;
 	mtd->_read = spi_nor_read;
 	/* Might be already set by some SST flashes. */
-	if (!mtd->_write)
+	if (!mtd->_write) {
 		mtd->_write = spi_nor_write;
+		if (nor->spimem &&
+		    spi_mem_controller_is_capable(nor->spimem->spi->controller, panic_write)) {
+			mtd->_panic_write = spi_nor_panic_write;
+		}
+	}
 	mtd->_suspend = spi_nor_suspend;
 	mtd->_resume = spi_nor_resume;
 	mtd->_get_device = spi_nor_get_device;
-- 
2.47.3

