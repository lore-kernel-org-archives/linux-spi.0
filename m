Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAA932B112
	for <linux-spi@vger.kernel.org>; Tue, 13 Oct 2026 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900892; cv=none; b=HQGzPd7jisxHACcM/9t59v2QTS2U0afhDv17H4BJmuJDMAdbqP2xR0JcaUK7LGoHuNumZ8FM8vTsD/dLSl6zHqHU0diGd4wCDPML8hwvOYAK0h3En1yESh6y9LcuApht15zEJsvQSlZTIgCF043K+xrDn9LFtOUP+nnd7nwQFVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900892; c=relaxed/simple;
	bh=gOlj5rVO97pFW146ZbYw8gZq8fqB8DCYM2b8fLsb44A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVAm5vKJkvkAnwWssAKlH3yQ4sUxX7CrhDHdtMB4nzTuusgXTJH8kdaQ4XQ8LjeQe2OJiVdHrqpI79vkmM6QN0uC43LMp12ZnbkNNjeAKmLhiegM4TCY2rCeqYD8prA5u7Ospbf4XfukLDPiB+zepmmQjSltsty/zeK+/LdOv+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1KBLxdWA; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1KBLxdWA"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5701D1A11FE;
	Tue, 13 Oct 2026 14:14:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 236FD60362;
	Tue, 13 Oct 2026 14:14:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7C36611D7168A;
	Tue, 13 Oct 2026 16:14:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791900883; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=g3feu5m1An2nWg4B/Kn0hMyPGyDxCRZ6peVoz21XP4I=;
	b=1KBLxdWAgHpDlBY4vbdXOofBBwt12Ydqk8pKKa8TcN1yibCmBrXABJ2FVt4Y/6S6EvH/Ir
	MJ8RznxSpb3oB2j8DOIR1qxFDSard2JUaHNkNiFzc+LHpEKb7n5unGhD577qYwdltBRK4N
	4U456vAyBx9MZRLUU2Ir4skJzH5yQIFDbpGnLcEmY09C+Ix6Qzw2JpfzwFqXmHswDJ3vLK
	o/tASMhYWrgBgejJ3Q+6mex37aahXQFViEoOeUr3J6Vn3nOYiOKc5L8N9F74z8TjE2aCS9
	UTt+nIXB65s3giM+xtaVLFv3F+89QII8WpA/awiiT+iG2rqhWfzbtqbuIPEcaQ==
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
Subject: [PATCH v2 3/7] mtd: spi-nor: Add support for panic writes
Date: Tue, 13 Oct 2026 16:13:46 +0200
Message-ID: <20261013141350.189996-4-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013141350.189996-1-paul.cercueil@bootlin.com>
References: <20261013141350.189996-1-paul.cercueil@bootlin.com>
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

 drivers/mtd/spi-nor/core.c | 78 +++++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 2509fb983d4f..281acc54b324 100644
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
@@ -717,8 +726,14 @@ static int spi_nor_wait_till_ready_with_timeout(struct spi_nor *nor,
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
@@ -1284,6 +1299,9 @@ static void spi_nor_rww_end_io(struct spi_nor *nor)
 
 static int spi_nor_lock_device(struct spi_nor *nor)
 {
+	if (nor->mtd.oops_panic_write)
+		return 0;
+
 	if (!spi_nor_use_parallel_locking(nor))
 		return 0;
 
@@ -1292,6 +1310,9 @@ static int spi_nor_lock_device(struct spi_nor *nor)
 
 static void spi_nor_unlock_device(struct spi_nor *nor)
 {
+	if (nor->mtd.oops_panic_write)
+		return;
+
 	if (spi_nor_use_parallel_locking(nor)) {
 		spi_nor_rww_end_io(nor);
 		wake_up(&nor->rww.wait);
@@ -1329,6 +1350,9 @@ int spi_nor_prep_and_lock(struct spi_nor *nor)
 {
 	int ret;
 
+	if (nor->mtd.oops_panic_write)
+		return 0;
+
 	ret = spi_nor_prep(nor);
 	if (ret)
 		return ret;
@@ -1344,6 +1368,9 @@ int spi_nor_prep_and_lock(struct spi_nor *nor)
 
 void spi_nor_unlock_and_unprep(struct spi_nor *nor)
 {
+	if (nor->mtd.oops_panic_write)
+		return;
+
 	if (!spi_nor_use_parallel_locking(nor)) {
 		mutex_unlock(&nor->lock);
 	} else {
@@ -1400,6 +1427,9 @@ static int spi_nor_prep_and_lock_pe(struct spi_nor *nor, loff_t start, size_t le
 {
 	int ret;
 
+	if (nor->mtd.oops_panic_write)
+		return 0;
+
 	ret = spi_nor_prep(nor);
 	if (ret)
 		return ret;
@@ -1415,6 +1445,9 @@ static int spi_nor_prep_and_lock_pe(struct spi_nor *nor, loff_t start, size_t le
 
 static void spi_nor_unlock_and_unprep_pe(struct spi_nor *nor, loff_t start, size_t len)
 {
+	if (nor->mtd.oops_panic_write)
+		return;
+
 	if (!spi_nor_use_parallel_locking(nor)) {
 		mutex_unlock(&nor->lock);
 	} else {
@@ -1473,6 +1506,9 @@ static int spi_nor_prep_and_lock_rd(struct spi_nor *nor, loff_t start, size_t le
 {
 	int ret;
 
+	if (nor->mtd.oops_panic_write)
+		return 0;
+
 	ret = spi_nor_prep(nor);
 	if (ret)
 		return ret;
@@ -1488,6 +1524,9 @@ static int spi_nor_prep_and_lock_rd(struct spi_nor *nor, loff_t start, size_t le
 
 static void spi_nor_unlock_and_unprep_rd(struct spi_nor *nor, loff_t start, size_t len)
 {
+	if (nor->mtd.oops_panic_write)
+		return;
+
 	if (!spi_nor_use_parallel_locking(nor)) {
 		mutex_unlock(&nor->lock);
 	} else {
@@ -2196,6 +2235,7 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 static int spi_nor_octal_dtr_write(struct spi_nor *nor, loff_t to, size_t len,
 				   const u8 *buf)
 {
+	gfp_t mm_flags = GFP_KERNEL;
 	u8 *tmp_buf;
 	size_t bytes_written;
 	loff_t start, end;
@@ -2204,7 +2244,10 @@ static int spi_nor_octal_dtr_write(struct spi_nor *nor, loff_t to, size_t len,
 	if (IS_ALIGNED(to, 2) && IS_ALIGNED(len, 2))
 		return spi_nor_write_data(nor, to, len, buf);
 
-	tmp_buf = kmalloc(nor->params->page_size, GFP_KERNEL);
+	if (nor->mtd.oops_panic_write)
+		mm_flags |= GFP_ATOMIC;
+
+	tmp_buf = kmalloc(nor->params->page_size, mm_flags);
 	if (!tmp_buf)
 		return -ENOMEM;
 
@@ -3386,6 +3429,26 @@ static void spi_nor_soft_reset(struct spi_nor *nor)
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
@@ -3589,8 +3652,13 @@ static int spi_nor_set_mtd_info(struct spi_nor *nor)
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

