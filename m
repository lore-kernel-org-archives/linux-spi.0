Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03CD551982
	for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992655; cv=none; b=hz1P/iCo4BX+fVev8XUbhTiYdQpIyJdRoBrbGZvOKrVyZKxEhDCMTcq+oA1fkzNCY4lfbgEmGFiOvh6gIo2vP+eF1dJ9rkJefFI6vsRTCIKhODQ0jPJTq3S4tuIuWGmCDdK3xk3m9s8l3N9o63Za4TDnOcnfAYo36zNPIWquBPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992655; c=relaxed/simple;
	bh=fg/qTT82sxZvI7NiMI5++vT/FYdMPITw36On0xFjk8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+DUhvkeL145otPVBe/TenDj/cTcN5Bnfv7b+dTzD95qJeZbz+mW0Hqq9e5eCrcZjFPLurMGG1+C8vIl0WW6r7ToO8FhGWBXqAnKqhHhr1vVHGj6UUGnrKexWjNKcaI1e/XBwCR3hlA2wiDLGLbnzvq9e2q3LUg0golgh/at/eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0cUawt3i; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0cUawt3i"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AC7C1C6344F;
	Wed, 14 Oct 2026 15:45:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AE05D60368;
	Wed, 14 Oct 2026 15:44:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 092A01032831F;
	Wed, 14 Oct 2026 17:44:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791992649; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=GcId23e25YWV3EkaB1LBizu2mjqjYuhu3m5VaPrgCe4=;
	b=0cUawt3iZB94ERJcV1Vcq0RhnLC91bvctwhwNptVZfctIksLxQgu6izYrdzeuZvVKdAxuY
	56I7trDUwKvR8BBFP8lH7eqDffjVEifoXV2yb8GOOKyCr7XbHJAicDg/Da4Fwebapw84Pj
	1p7r/AVjgnqtzPbAJAckcK+blIYQ9BzXr33aE2TICETXi38zpuoMVu59fvw7Jdyg3UCzGb
	VxmYQu0VO94Vip1IwNd6bIOOK058OL8zCrEbR8dUf3vBR8hkmtNfK56W4Vt0LJIynQ7ynb
	qe+Y6pmmQwkkxzytt0ML7XHmkv94NFttxOV+eFeX1mq1ebry73pv0c6FbTEscA==
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
Subject: [PATCH v3 1/7] spi: spi-mem: Add support for panic mem writes
Date: Wed, 14 Oct 2026 17:42:55 +0200
Message-ID: <20261014154301.157755-2-paul.cercueil@bootlin.com>
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

Add a 'panic_write' flag to the controller's capabilities struct.
When set, the SPI controller indicates that it will be able to send
commands to a connected NOR or NAND memory in the context of a kernel
panic, which means without sleeping and without relying on IRQs.

Whether or not a given memory operation is a panic mem write is given by
the spi_mem_op.panic_write flag.

Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>
---

Notes:
    v2: - Don't call spi_mem_access_start/end on panic. We don't need to
          flush the SPI queue at that point, and we don't need to lock the
          mutexes.
        - Check that the SPI controller's PM status is active, and bail out
          otherwise.
    
    v3: - Use pm_runtime_active() instead of pm_runtime_get_if_active(). The
          latter cannot be used in a panic context.
        - Forbid fallback to regular SPI on panic

 drivers/spi/spi-mem.c       | 42 +++++++++++++++++++++++++++++++++----
 include/linux/spi/spi-mem.h |  5 +++++
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index b94680b60af9..9ad42dd9de70 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -398,6 +398,31 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	u8 *tmpbuf;
 	int ret;
 
+	if (op->panic_write) {
+		if (!spi_mem_controller_is_capable(ctlr, panic_write))
+			return -EOPNOTSUPP;
+
+		/*
+		 * Only support panic writes if we'll go through .exec_op().
+		 * The regular SPI path (spi_sync(), etc.) explicitly mentions
+		 * that it can only be used from a context that may sleep, which
+		 * is not the case on a kernel panic.
+		 * If this changes in the future, this could be reworked, but
+		 * for now this will have to do.
+		 */
+		if (WARN_ON_ONCE(!ctlr->mem_ops || !ctlr->mem_ops->exec_op))
+			return -EOPNOTSUPP;
+
+		if (spi_get_csgpiod(mem->spi, 0))
+			return -EPERM;
+
+		/* On panic IRQs are disabled so we cannot wait on locks */
+		if (mutex_is_locked(&ctlr->bus_lock_mutex) ||
+		    mutex_is_locked(&ctlr->io_mutex)) {
+			return -EPERM;
+		}
+	}
+
 	/* Make sure the operation frequency is correct before going futher */
 	spi_mem_adjust_op_freq(mem, (struct spi_mem_op *)op);
 
@@ -420,15 +445,20 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		return -EOPNOTSUPP;
 
 	if (ctlr->mem_ops && ctlr->mem_ops->exec_op && !spi_get_csgpiod(mem->spi, 0)) {
-		ret = spi_mem_access_start(mem);
-		if (ret)
-			return ret;
+		if (!op->panic_write) {
+			ret = spi_mem_access_start(mem);
+			if (ret)
+				return ret;
+		} else if (!pm_runtime_active(ctlr->dev.parent)) {
+			return -EPERM;
+		}
 
 		trace_spi_mem_start_op(mem, op);
 		ret = ctlr->mem_ops->exec_op(mem, op);
 		trace_spi_mem_stop_op(mem, op);
 
-		spi_mem_access_end(mem);
+		if (!op->panic_write)
+			spi_mem_access_end(mem);
 
 		/*
 		 * Some controllers only optimize specific paths (typically the
@@ -441,6 +471,10 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 			return ret;
 		}
+
+		/* On panic write we can't fall back to the fallback SPI path */
+		if (op->panic_write)
+			return ret;
 	}
 
 	tmpbufsize = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 0cce6b57242a..2633307bfad5 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -169,6 +169,7 @@ enum spi_mem_data_dir {
  *		 operation does not involve transferring data
  * @data.buf.in: input buffer (must be DMA-able)
  * @data.buf.out: output buffer (must be DMA-able)
+ * @panic_write: The command is executed in the context of a kernel panic
  * @max_freq: frequency limitation wrt this operation. 0 means there is no
  *	      specific constraint and the highest achievable frequency can be
  *	      attempted.
@@ -211,6 +212,7 @@ struct spi_mem_op {
 		} buf;
 	} data;
 
+	bool panic_write;
 	unsigned int max_freq;
 };
 
@@ -392,6 +394,8 @@ struct spi_controller_mem_ops {
  *                   is a pause in the transfer (eg. internal bus contention or
  *                   DMA arbitration on an interconnect). Features such as NAND
  *                   continuous reads shall not be leveraged.
+ * @panic_write: Set to true if the controller driver supports writing to a
+ *               connected NAND/NOR memory in a kernel panic context
  */
 struct spi_controller_mem_caps {
 	bool dtr;
@@ -400,6 +404,7 @@ struct spi_controller_mem_caps {
 	bool per_op_freq;
 	bool secondary_op_tmpl;
 	bool no_cs_assertion;
+	bool panic_write;
 };
 
 #define spi_mem_controller_is_capable(ctlr, cap)	\
-- 
2.47.3

