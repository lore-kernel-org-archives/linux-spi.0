Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1EA18A93F;
	Wed, 11 Feb 2026 07:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770795261; cv=none; b=jo6tAqewor5B33/LfzpjS4lO6utW5zH33/Z0dBX32Fmc3gkenIfILx9Fo5U+/sdaxsPbq96sVbs5kHiTrY0pB9C4Iz1zo1pZ4Lr+MuIt2u5obcUMMA3xFh9jo3o13vmMxw7kThlGdWDOOWhJpxsEIdEVuEvtH78rwPOjjATvCbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770795261; c=relaxed/simple;
	bh=X6XVIMtQo2WdOCqfyhm6WCR7WWugDRIOHR7mMPo6V/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tTmvOitXfEG56Lxb7tX4RRh051DaG+jXbdkArJNN+C5qrTMqKuLICbarjf9RuH0E0V2IFvk8mL/NOV4LmpQ1JHfP2JL61cUY9QYkXetgEKe2ZBIDtcYiioYUNXNb3ZiT9HiBW3jmpmLQHZRZcyYFhRTa37S/KEucM2isrgBBXwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; dkim=pass (2048-bit key) header.d=emlix.com header.i=@emlix.com header.b=epG5hkgw; dkim=pass (2048-bit key) header.d=emlix.com header.i=@emlix.com header.b=epG5hkgw; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emlix.com header.i=@emlix.com header.b="epG5hkgw";
	dkim=pass (2048-bit key) header.d=emlix.com header.i=@emlix.com header.b="epG5hkgw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
	s=20250930; t=1770794791;
	bh=HHHwyvToc2BIfyegaFl971NTjGHXZwmUNa2CBIYYkds=;
	h=From:To:Cc:Subject:Date:From;
	b=epG5hkgw9EDuXIekZ0i1zl9GO6S2b+D7TnYJhNHmgcdINnCyVAyg45RsWNxOtXx/V
	 VLDgL7yPeDP+G84SF2Cv03Gk2IhHKyD+zuhof4XVpcmh0SVtAB9RAK1x2Q9BlUvXsA
	 nC/NKSFoyl3Nr+pLeXXmVeQSb6OSOjeV97pvSp77NV0ZzfVUMaecUJqPEr37HWD9wc
	 QphbZ0UDYL+DyMHBAGhE/l/K3zvEyr4kPhptPo2DYC4kL4NigX5TEejdHX3r3YQu5v
	 Lx0IvIocQtqwPPZq88P9224ra+T3vwGajXlx6SIWq1G+1H6IOesdUrSLgkKwv+dmOD
	 WvIoA5ncFU0tQ==
Received: from mx1.emlix.com (localhost [127.0.0.1])
	by mx1.emlix.com (Postfix) with ESMTP id 3BAF85FAE9;
	Wed, 11 Feb 2026 08:26:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
	s=20250930; t=1770794791;
	bh=HHHwyvToc2BIfyegaFl971NTjGHXZwmUNa2CBIYYkds=;
	h=From:To:Cc:Subject:Date:From;
	b=epG5hkgw9EDuXIekZ0i1zl9GO6S2b+D7TnYJhNHmgcdINnCyVAyg45RsWNxOtXx/V
	 VLDgL7yPeDP+G84SF2Cv03Gk2IhHKyD+zuhof4XVpcmh0SVtAB9RAK1x2Q9BlUvXsA
	 nC/NKSFoyl3Nr+pLeXXmVeQSb6OSOjeV97pvSp77NV0ZzfVUMaecUJqPEr37HWD9wc
	 QphbZ0UDYL+DyMHBAGhE/l/K3zvEyr4kPhptPo2DYC4kL4NigX5TEejdHX3r3YQu5v
	 Lx0IvIocQtqwPPZq88P9224ra+T3vwGajXlx6SIWq1G+1H6IOesdUrSLgkKwv+dmOD
	 WvIoA5ncFU0tQ==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id 174B45F8B7;
	Wed, 11 Feb 2026 08:26:31 +0100 (CET)
From: Fabian Godehardt <fg@emlix.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fabian Godehardt <fg@emlix.com>
Subject: [PATCH] spi: spidev: fix lock inversion between spi_lock and buf_lock
Date: Wed, 11 Feb 2026 08:26:16 +0100
Message-ID: <20260211072616.489522-1-fg@emlix.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

The spidev driver previously used two mutexes, spi_lock and buf_lock,
but acquired them in different orders depending on the code path:

  write()/read(): buf_lock -> spi_lock
  ioctl():       spi_lock -> buf_lock

This AB-BA locking pattern triggers lockdep warnings and can
cause real deadlocks:

  WARNING: possible circular locking dependency detected
  spidev_ioctl() -> mutex_lock(&spidev->buf_lock)
  spidev_sync_write() -> mutex_lock(&spidev->spi_lock)
  *** DEADLOCK ***

The issue is reproducible with a simple userspace program that
performs write() and SPI_IOC_WR_MAX_SPEED_HZ ioctl() calls from
separate threads on the same spidev file descriptor.

Fix this by simplifying the locking model and removing the lock
inversion entirely. spidev_sync() no longer performs any locking,
and all callers serialize access using spi_lock.

buf_lock is removed since its functionality is fully covered by
spi_lock, eliminating the possibility of lock ordering issues.

This removes the lock inversion and prevents deadlocks without
changing userspace ABI or behaviour.

Signed-off-by: Fabian Godehardt <fg@emlix.com>
---
 drivers/spi/spidev.c | 63 ++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 41 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 9a0160f6dc3d..f28528ed1c24 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -74,7 +74,6 @@ struct spidev_data {
 	struct list_head	device_entry;
 
 	/* TX/RX buffers are NULL unless this device is open (users > 0) */
-	struct mutex		buf_lock;
 	unsigned		users;
 	u8			*tx_buffer;
 	u8			*rx_buffer;
@@ -102,24 +101,6 @@ spidev_sync_unlocked(struct spi_device *spi, struct spi_message *message)
 	return status;
 }
 
-static ssize_t
-spidev_sync(struct spidev_data *spidev, struct spi_message *message)
-{
-	ssize_t status;
-	struct spi_device *spi;
-
-	mutex_lock(&spidev->spi_lock);
-	spi = spidev->spi;
-
-	if (spi == NULL)
-		status = -ESHUTDOWN;
-	else
-		status = spidev_sync_unlocked(spi, message);
-
-	mutex_unlock(&spidev->spi_lock);
-	return status;
-}
-
 static inline ssize_t
 spidev_sync_write(struct spidev_data *spidev, size_t len)
 {
@@ -132,7 +113,8 @@ spidev_sync_write(struct spidev_data *spidev, size_t len)
 
 	spi_message_init(&m);
 	spi_message_add_tail(&t, &m);
-	return spidev_sync(spidev, &m);
+
+	return spidev_sync_unlocked(spidev->spi, &m);
 }
 
 static inline ssize_t
@@ -147,7 +129,8 @@ spidev_sync_read(struct spidev_data *spidev, size_t len)
 
 	spi_message_init(&m);
 	spi_message_add_tail(&t, &m);
-	return spidev_sync(spidev, &m);
+
+	return spidev_sync_unlocked(spidev->spi, &m);
 }
 
 /*-------------------------------------------------------------------------*/
@@ -157,7 +140,7 @@ static ssize_t
 spidev_read(struct file *filp, char __user *buf, size_t count, loff_t *f_pos)
 {
 	struct spidev_data	*spidev;
-	ssize_t			status;
+	ssize_t			status = -ESHUTDOWN;
 
 	/* chipselect only toggles at start or end of operation */
 	if (count > bufsiz)
@@ -165,7 +148,11 @@ spidev_read(struct file *filp, char __user *buf, size_t count, loff_t *f_pos)
 
 	spidev = filp->private_data;
 
-	mutex_lock(&spidev->buf_lock);
+	mutex_lock(&spidev->spi_lock);
+
+	if (spidev->spi == NULL)
+		goto err_spi_removed;
+
 	status = spidev_sync_read(spidev, count);
 	if (status > 0) {
 		unsigned long	missing;
@@ -176,7 +163,9 @@ spidev_read(struct file *filp, char __user *buf, size_t count, loff_t *f_pos)
 		else
 			status = status - missing;
 	}
-	mutex_unlock(&spidev->buf_lock);
+
+err_spi_removed:
+	mutex_unlock(&spidev->spi_lock);
 
 	return status;
 }
@@ -187,7 +176,7 @@ spidev_write(struct file *filp, const char __user *buf,
 		size_t count, loff_t *f_pos)
 {
 	struct spidev_data	*spidev;
-	ssize_t			status;
+	ssize_t			status = -ESHUTDOWN;
 	unsigned long		missing;
 
 	/* chipselect only toggles at start or end of operation */
@@ -196,13 +185,19 @@ spidev_write(struct file *filp, const char __user *buf,
 
 	spidev = filp->private_data;
 
-	mutex_lock(&spidev->buf_lock);
+	mutex_lock(&spidev->spi_lock);
+
+	if (spidev->spi == NULL)
+		goto err_spi_removed;
+
 	missing = copy_from_user(spidev->tx_buffer, buf, count);
 	if (missing == 0)
 		status = spidev_sync_write(spidev, count);
 	else
 		status = -EFAULT;
-	mutex_unlock(&spidev->buf_lock);
+
+err_spi_removed:
+	mutex_unlock(&spidev->spi_lock);
 
 	return status;
 }
@@ -379,14 +374,6 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 	ctlr = spi->controller;
 
-	/* use the buffer lock here for triple duty:
-	 *  - prevent I/O (from us) so calling spi_setup() is safe;
-	 *  - prevent concurrent SPI_IOC_WR_* from morphing
-	 *    data fields while SPI_IOC_RD_* reads them;
-	 *  - SPI_IOC_MESSAGE needs the buffer locked "normally".
-	 */
-	mutex_lock(&spidev->buf_lock);
-
 	switch (cmd) {
 	/* read requests */
 	case SPI_IOC_RD_MODE:
@@ -510,7 +497,6 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		break;
 	}
 
-	mutex_unlock(&spidev->buf_lock);
 	spi_dev_put(spi);
 	mutex_unlock(&spidev->spi_lock);
 	return retval;
@@ -541,9 +527,6 @@ spidev_compat_ioc_message(struct file *filp, unsigned int cmd,
 		return -ESHUTDOWN;
 	}
 
-	/* SPI_IOC_MESSAGE needs the buffer locked "normally" */
-	mutex_lock(&spidev->buf_lock);
-
 	/* Check message and copy into scratch area */
 	ioc = spidev_get_ioc_message(cmd, u_ioc, &n_ioc);
 	if (IS_ERR(ioc)) {
@@ -564,7 +547,6 @@ spidev_compat_ioc_message(struct file *filp, unsigned int cmd,
 	kfree(ioc);
 
 done:
-	mutex_unlock(&spidev->buf_lock);
 	spi_dev_put(spi);
 	mutex_unlock(&spidev->spi_lock);
 	return retval;
@@ -802,7 +784,6 @@ static int spidev_probe(struct spi_device *spi)
 	/* Initialize the driver data */
 	spidev->spi = spi;
 	mutex_init(&spidev->spi_lock);
-	mutex_init(&spidev->buf_lock);
 
 	INIT_LIST_HEAD(&spidev->device_entry);
 
-- 
2.47.3

