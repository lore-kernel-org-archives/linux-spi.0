Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAA9411631;
	Thu, 26 Mar 2026 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542383; cv=none; b=jLqsdJpfJayj9MfzEWcC/lh+1oJieNOgo3kb13DUgAWZykgvfGhH9wpokIvN7c5HNUMgd5vvDv9iRmMKlceX5wF7zIyu1DzYuReLJUaPoadjoE91hm2+85Mo1Le9LrrwAc6i11hZ821w9ysojTNeeXh2IBP9axYr2IrIzK7pZiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542383; c=relaxed/simple;
	bh=SmX64hBc0VvAMQmLzdKqKpg2jUqj8tgh7ljKLZKQBMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M+yrCyLby6G0TJMsnGT3+tH3+Uh1Z/UaV6EqtzYYkHf6CaogHxwlEQlpOOJOj7D8XizV3uF20APB8NDDQfwML2ypo2H9W0+iVQlnSKrPlkCMB3MIfuySdN2pEoSbbBfw4E0gbYIshkrzHWEUk4z70Jg1sTUXwAZd3fwGTAkG0sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yNpQjZDO; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yNpQjZDO"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A818D1A3007;
	Thu, 26 Mar 2026 16:26:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 774A2601FA;
	Thu, 26 Mar 2026 16:26:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D215010450CA0;
	Thu, 26 Mar 2026 17:26:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774542379; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yGIuJpVwWLTfF36jwuLLhNiOA2wGXHIPXa0FAwaadKw=;
	b=yNpQjZDO1vFDiEPq3WhKYtssiq5FUYuxDMYyFlOkvjHTEEr3eVYwlFgQA90asN7MzpS7ca
	I5qTCr1d0YD3DYmEEwPlxlGLHD5VsZtRDQDTKux8LYVzlsWphM0i9LNe29B6b5uMg5JWsR
	6KUdnok2MS3Wgn5VQ/8QnHvKQOMxkldRFDEtXvT9oWIhMoNg7Q2C/ZLsVjBuGPhFFzruO5
	wmEsxdINcjKnYZn5OfppjKkMJOazVlL0JdNWnyH0en46LdnbDOi5fPqZr6SEG7mDwM1paf
	Z7Vcei3R36l7OzdWj8HVRVg+5DipF009szLRf9L2V+nXIT/Jaj3FhAYbxFU/5A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 26 Mar 2026 17:25:57 +0100
Subject: [PATCH v2 10/11] mtd: spinand: winbond: Create a helper to detect
 the need for the HS bit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-winbond-v6-18-rc1-cont-read-v2-10-643de97a68a3@bootlin.com>
References: <20260326-winbond-v6-18-rc1-cont-read-v2-0-643de97a68a3@bootlin.com>
In-Reply-To: <20260326-winbond-v6-18-rc1-cont-read-v2-0-643de97a68a3@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The logic is not complex but might be reused to cleanup a bit the
section by moving it to a dedicated helper.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index b30a343a6672..ffbcd25b0366 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -421,30 +421,33 @@ static int w25n0xjw_set_sr4_hs(struct spinand_device *spinand, bool enable)
 	return spinand_write_reg_op(spinand, W25N0XJW_SR4, sr4);
 }
 
+/*
+ * SDR dual and quad I/O operations over 104MHz require the HS bit to
+ * enable a few more dummy cycles.
+ */
+static bool w25n0xjw_op_needs_hs(const struct spi_mem_op *op)
+{
+	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
+		return false;
+	else if (op->cmd.buswidth != 1 || op->addr.buswidth == 1)
+		return false;
+	else if (op->max_freq && op->max_freq <= 104 * HZ_PER_MHZ)
+		return false;
+
+	return true;
+}
+
 static int w25n0xjw_hs_cfg(struct spinand_device *spinand,
 			   enum spinand_bus_interface iface)
 {
 	const struct spi_mem_op *op;
-	bool hs;
 
 	if (iface != SSDR)
 		return -EOPNOTSUPP;
 
-	/*
-	 * SDR dual and quad I/O operations over 104MHz require the HS bit to
-	 * enable a few more dummy cycles.
-	 */
 	op = spinand->op_templates->read_cache;
-	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
-		hs = false;
-	else if (op->cmd.buswidth != 1 || op->addr.buswidth == 1)
-		hs = false;
-	else if (op->max_freq && op->max_freq <= 104 * HZ_PER_MHZ)
-		hs = false;
-	else
-		hs = true;
 
-	return w25n0xjw_set_sr4_hs(spinand, hs);
+	return w25n0xjw_set_sr4_hs(spinand, w25n0xjw_op_needs_hs(op));
 }
 
 static int w35n0xjw_write_vcr(struct spinand_device *spinand, u8 reg, u8 val)

-- 
2.51.1

