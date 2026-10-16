Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3425947535E;
	Fri, 16 Oct 2026 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146607; cv=none; b=qbTOYKyzVDAh6oVYTCAz12qJ+sjAKh0MpzgUtRafEvgauIVMQXJxRx7EFyV4npxN8u+JfDoGDYwDsXLSa5I9VSzf5TzaldWbp8dqHOQ+wglT8CDYbPyhbFLNb1hCphG8WFrSIxuvJ770PDlO9BH+tMBf/bqLJDhPu5g4oQnOm6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146607; c=relaxed/simple;
	bh=77SlPFv1sIialX2CvYP5sY8haWbu9+eCYAgijrQkGhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJP2gIJDU3i8xDhSe+TPdal/LJHENvQDSZqPhQNNxzTci8hu/QUVgZJZC/3vaWLhGzAUm4IocSKFNroBkRdcqVSpceW4tOr6jk8nGDxwwA4IC2IdXVI6Mcv+SrVay5oF+ML+W6lGsgdiIaEm3mtgrmhQ9ZWcZvA5jYl4VzZKEw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rA4mX/K4; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rA4mX/K4"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 58E1FC6220F;
	Fri, 16 Oct 2026 10:31:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8CFF06075D;
	Fri, 16 Oct 2026 10:30:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E201D1032868C;
	Fri, 16 Oct 2026 12:29:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792146601; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=lAvTALq8/2QjR+XVZhKb89O8degogFcCW3Yx3v3Zn8Q=;
	b=rA4mX/K4Fi93ecjpKrPDMUq2XpFkMFgmFGPr6OHQAKVN8XiRqkfRJpNwXHj9xF60RtNtVb
	WGBE/XxfAiVsH20Qm+wSz0+3AdZ8UY5RKkDWGX7ZWBQlKxIXSSQqAV+dCMb4aVq8ttnwzl
	G4yVryDaXDZ932M8ETp3GDt6sl7CafSvrmNG7HE93RhfmH4/rggQ9sQ/98eUJ7RpoA3UBC
	bHUPJK55Y7GQjOVVYll1AUzbTFU/Jsa22fnpM08XnRi4smK+kGYxLIR2p7FmMNcenadutK
	lmifry5vHkAPJmCZNa1ADFcLU96iYi2yvZRH+F1xwmGIC85rhsx5krRRS0kIbg==
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
Subject: [PATCH v4 3/7] mtd: spi-nor: Add support for panic writes
Date: Fri, 16 Oct 2026 12:29:13 +0200
Message-ID: <20261016102917.171095-4-paul.cercueil@bootlin.com>
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

Notes:
    v2: - Update spi_nor_wait_till_ready_with_timeout() to use
          poll_timeout_us_atomic() on panic
        - Alloc temp buffer with GFP_ATOMIC in spi_nor_octal_dtr_write()
          on panic
        - Bail out if nor->rww.ongoing_pe is set in spi_nor_panic_write()
    
    v3: Use GFP_KERNEL xor GFP_ATOMIC
    
    v4: kmalloc() is not safe in panic context; reuse boucebuf instead

 drivers/mtd/spi-nor/core.c | 92 ++++++++++++++++++++++++++++++++++----
 1 file changed, 84 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 7f347141ea3f..10ec80c54504 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -97,6 +97,9 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
 	if (op->data.nbytes)
 		op->data.buswidth = spi_nor_get_protocol_data_nbits(proto);
 
+	if (nor->mtd.oops_panic_write)
+		op->panic_write = true;
+
 	if (spi_nor_protocol_is_dtr(proto)) {
 		/*
 		 * SPIMEM supports mixed DTR modes, but right now we can only
@@ -282,7 +285,7 @@ static ssize_t spi_nor_spimem_write_data(struct spi_nor *nor, loff_t to,
 	if (spi_nor_spimem_bounce(nor, &op))
 		memcpy(nor->bouncebuf, buf, op.data.nbytes);
 
-	if (nor->dirmap.wdesc) {
+	if (nor->dirmap.wdesc && !nor->mtd.oops_panic_write) {
 		nbytes = spi_mem_dirmap_write(nor->dirmap.wdesc, op.addr.val,
 					      op.data.nbytes, op.data.buf.out);
 	} else {
@@ -665,6 +668,9 @@ static void spi_nor_rww_end_rdst(struct spi_nor *nor)
 
 static int spi_nor_lock_rdst(struct spi_nor *nor)
 {
+	if (nor->mtd.oops_panic_write)
+		return 0;
+
 	if (spi_nor_use_parallel_locking(nor))
 		return spi_nor_rww_start_rdst(nor);
 
@@ -673,6 +679,9 @@ static int spi_nor_lock_rdst(struct spi_nor *nor)
 
 static void spi_nor_unlock_rdst(struct spi_nor *nor)
 {
+	if (nor->mtd.oops_panic_write)
+		return;
+
 	if (spi_nor_use_parallel_locking(nor)) {
 		spi_nor_rww_end_rdst(nor);
 		wake_up(&nor->rww.wait);
@@ -716,8 +725,14 @@ static int spi_nor_wait_till_ready_with_timeout(struct spi_nor *nor, u64 timeout
 {
 	int ret, status;
 
-	ret = poll_timeout_us(status = spi_nor_ready(nor), status,
-			      100, timeout_ms * 1000, false);
+	if (nor->mtd.oops_panic_write) {
+		ret = poll_timeout_us_atomic(status = spi_nor_ready(nor), status,
+					     100, timeout_ms * 1000, false);
+	} else {
+		ret = poll_timeout_us(status = spi_nor_ready(nor), status,
+				      100, timeout_ms * 1000, false);
+	}
+
 	if (ret < 0) {
 		dev_dbg(nor->dev, "flash operation timed out\n");
 		return ret;
@@ -1283,6 +1298,9 @@ static void spi_nor_rww_end_io(struct spi_nor *nor)
 
 static int spi_nor_lock_device(struct spi_nor *nor)
 {
+	if (nor->mtd.oops_panic_write)
+		return 0;
+
 	if (!spi_nor_use_parallel_locking(nor))
 		return 0;
 
@@ -1291,6 +1309,9 @@ static int spi_nor_lock_device(struct spi_nor *nor)
 
 static void spi_nor_unlock_device(struct spi_nor *nor)
 {
+	if (nor->mtd.oops_panic_write)
+		return;
+
 	if (spi_nor_use_parallel_locking(nor)) {
 		spi_nor_rww_end_io(nor);
 		wake_up(&nor->rww.wait);
@@ -1328,6 +1349,9 @@ int spi_nor_prep_and_lock(struct spi_nor *nor)
 {
 	int ret;
 
+	if (nor->mtd.oops_panic_write)
+		return 0;
+
 	ret = spi_nor_prep(nor);
 	if (ret)
 		return ret;
@@ -1343,6 +1367,9 @@ int spi_nor_prep_and_lock(struct spi_nor *nor)
 
 void spi_nor_unlock_and_unprep(struct spi_nor *nor)
 {
+	if (nor->mtd.oops_panic_write)
+		return;
+
 	if (!spi_nor_use_parallel_locking(nor)) {
 		mutex_unlock(&nor->lock);
 	} else {
@@ -1399,6 +1426,9 @@ static int spi_nor_prep_and_lock_pe(struct spi_nor *nor, loff_t start, size_t le
 {
 	int ret;
 
+	if (nor->mtd.oops_panic_write)
+		return 0;
+
 	ret = spi_nor_prep(nor);
 	if (ret)
 		return ret;
@@ -1414,6 +1444,9 @@ static int spi_nor_prep_and_lock_pe(struct spi_nor *nor, loff_t start, size_t le
 
 static void spi_nor_unlock_and_unprep_pe(struct spi_nor *nor, loff_t start, size_t len)
 {
+	if (nor->mtd.oops_panic_write)
+		return;
+
 	if (!spi_nor_use_parallel_locking(nor)) {
 		mutex_unlock(&nor->lock);
 	} else {
@@ -1472,6 +1505,9 @@ static int spi_nor_prep_and_lock_rd(struct spi_nor *nor, loff_t start, size_t le
 {
 	int ret;
 
+	if (nor->mtd.oops_panic_write)
+		return 0;
+
 	ret = spi_nor_prep(nor);
 	if (ret)
 		return ret;
@@ -1487,6 +1523,9 @@ static int spi_nor_prep_and_lock_rd(struct spi_nor *nor, loff_t start, size_t le
 
 static void spi_nor_unlock_and_unprep_rd(struct spi_nor *nor, loff_t start, size_t len)
 {
+	if (nor->mtd.oops_panic_write)
+		return;
+
 	if (!spi_nor_use_parallel_locking(nor)) {
 		mutex_unlock(&nor->lock);
 	} else {
@@ -2203,9 +2242,20 @@ static int spi_nor_octal_dtr_write(struct spi_nor *nor, loff_t to, size_t len,
 	if (IS_ALIGNED(to, 2) && IS_ALIGNED(len, 2))
 		return spi_nor_write_data(nor, to, len, buf);
 
-	tmp_buf = kmalloc(nor->params->page_size, GFP_KERNEL);
-	if (!tmp_buf)
-		return -ENOMEM;
+	if (nor->mtd.oops_panic_write) {
+		/*
+		 * The kernel is panicking; kmalloc() is not safe. Shamelessly
+		 * reuse the 'bouncebuf' buffer, which is the size we want, and
+		 * won't be reused anymore at this point (the first two bytes
+		 * might be overwritten, but only after we transferred them, so
+		 * it's safe).
+		 */
+		tmp_buf = nor->bouncebuf;
+	} else {
+		tmp_buf = kmalloc(nor->params->page_size, GFP_KERNEL);
+		if (!tmp_buf)
+			return -ENOMEM;
+	}
 
 	memset(tmp_buf, 0xff, nor->params->page_size);
 
@@ -2243,7 +2293,8 @@ static int spi_nor_octal_dtr_write(struct spi_nor *nor, loff_t to, size_t len,
 		ret -= end - (to + len);
 
 out:
-	kfree(tmp_buf);
+	if (!nor->mtd.oops_panic_write)
+		kfree(tmp_buf);
 	return ret;
 }
 
@@ -3385,6 +3436,26 @@ static void spi_nor_soft_reset(struct spi_nor *nor)
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
+	    (nor->rww.ongoing_io || nor->rww.ongoing_rd || nor->rww.ongoing_pe)) {
+		return -EPERM;
+	}
+
+	return spi_nor_write(mtd, to, len, retlen, buf);
+}
+
 /* mtd suspend handler */
 static int spi_nor_suspend(struct mtd_info *mtd)
 {
@@ -3588,8 +3659,13 @@ static int spi_nor_set_mtd_info(struct spi_nor *nor)
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

