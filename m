Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2028A55C1D1;
	Wed, 14 Oct 2026 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992660; cv=none; b=KMK8AtjpNpdMyfFkUkwdWxThtGFELzrN/DXNbrG1LgUJtus9MhENugW+SaTacvlHrs5n+nNtrhsnK1ORk+U7HRsoMzOthsh03P1VKWp92hjt5SvALQSiI/t5xStwWfK8eW6NhSztyVTLR0AHoMfOKxa01F5bOFPjMQASziF+TSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992660; c=relaxed/simple;
	bh=MpI8cVINFk8sKQl2GVuP4cMWS6VYVImIAtfIp1Xdn6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnugNbxx+nxXRMMyOJFvwRjk7TYCfDdn8MEWkZnPXDGSMHNIIX/yf9aaDr6EHY+IYAYShsEVb7ABofIBfGHRwL4GPOaNhTzuUmVnzeeblpju27cRL2db4hUmCpj8sFfOxaDCtvTL0eBIcUzJL1aiov3MMGiS7YwOwFtHxOj9D9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P307xOW/; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P307xOW/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 839EB4E411FA;
	Wed, 14 Oct 2026 15:44:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 57D6660368;
	Wed, 14 Oct 2026 15:44:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0E3021032806C;
	Wed, 14 Oct 2026 17:44:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791992655; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=f7vNixx4mKIVQLOjHEuwK6vkCQ2Iq2EaTsl5ZHvnbLk=;
	b=P307xOW/tOd9UdKQE/cuxD76pmc61gSS2bUtdE8Z8Rj7nK2i26/RYvGsHfMj9ZnXJn/ixg
	FhJlTGsS0YeLqCpNz2sqfm8SBSIQCtcXbyF6Nvdqm4pjVCkz6lmkbnqV/Dv/yF8PiFP2L5
	O1QFx35nJIdHvUSXsgQw5PaNeekSwMDjPpVylTFy+OW3/pXrvgT0jHmL3IuKtXBxxiUtte
	YL5fdqKwI/A/8t6JsWP8KAZRugyUHj921M8mJfG43J7CFs0d+4/UOscZ11lNLRPmdeecyP
	CeLqEQ+309ncndz6JR+1SbTWfQ8vJGxGzsFT0GAUbM69wYQXIBVH5D3vjwfJHA==
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
Subject: [PATCH v3 3/7] mtd: spi-nor: Add support for panic writes
Date: Wed, 14 Oct 2026 17:42:57 +0200
Message-ID: <20261014154301.157755-4-paul.cercueil@bootlin.com>
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

 drivers/mtd/spi-nor/core.c | 75 +++++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 58257cc21c68..d5e572287bb7 100644
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
@@ -2203,7 +2242,8 @@ static int spi_nor_octal_dtr_write(struct spi_nor *nor, loff_t to, size_t len,
 	if (IS_ALIGNED(to, 2) && IS_ALIGNED(len, 2))
 		return spi_nor_write_data(nor, to, len, buf);
 
-	tmp_buf = kmalloc(nor->params->page_size, GFP_KERNEL);
+	tmp_buf = kmalloc(nor->params->page_size,
+			  nor->mtd.oops_panic_write ? GFP_ATOMIC : GFP_KERNEL);
 	if (!tmp_buf)
 		return -ENOMEM;
 
@@ -3385,6 +3425,26 @@ static void spi_nor_soft_reset(struct spi_nor *nor)
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
@@ -3588,8 +3648,13 @@ static int spi_nor_set_mtd_info(struct spi_nor *nor)
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

