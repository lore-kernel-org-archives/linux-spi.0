Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD86A3161AD
	for <linux-spi@vger.kernel.org>; Thu,  5 Feb 2026 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770318440; cv=none; b=kS0+F3gm9hxbrgC2Nsrk1j6krl4h5Hv1MEnPhWRPi56jVGidWz2p6vNrnp6HWL0D5e1kxVFn5cO2ZjJxGcFHx+0EJqEsZxys56w4H8etLyi96fV4h6l5SU8fMnNd81aoB7NIoC1I5xpbMvWpcVRnDLjlgtGOGF3pCdAuZ2hm0dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770318440; c=relaxed/simple;
	bh=0ZtYMNIrVVrkdSY3M3AQ9WB/wN01k0rFv3mR889UOsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=snY/M9Dt1w2JoNZDveGSAap4l2PZt/L11fgX2ikOs97dNhE/enWTXwT6b/VO6Uks6Cwjq/AWCIM1b7R3fkAl7dyuzhGJfyOasyBAg6QwJWOeE90nzemZxnBm4O3UvbTYIDNggOfCg0lRa9wXGr3sMjVstvseB8gK4hYImbNUyh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ciHAmq+n; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ciHAmq+n"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9134E1A2C34;
	Thu,  5 Feb 2026 19:07:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 64BFF6074D;
	Thu,  5 Feb 2026 19:07:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E2208119D178B;
	Thu,  5 Feb 2026 20:07:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770318437; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dYYkOMmkvYm09ui+5e6ZadWbVo/SG1FMXVi2GURuVG8=;
	b=ciHAmq+nFySpzxqrOxnRMm491XzCE3ClAKpYW74F8w8q08takX5II9/7Nk/xgQyhIByA3b
	vD4f+Git2Nrq5ypf7ZFmDJF6i+48n8KG89drsVwtyu7bDdA5QBFreqZ1c8feMYvA8I4b8O
	ytC7XhvkgtsEEfK567U6lWksCetzINMiyyKcWt0VWM95EcK8kMQcPuIqFjlNKZUDnM/URq
	k0XyoK/ls801GlMSGAmMMmxdXhg1gyb4RGb68mp/bXkAOJ5FVLF2YcXzgRtmrpIQEgJkOP
	OyaeKqe3+3tF7N19oRwuU1B81REHxTU8un9CFOK3wdj9mIEZ38u/y7EUyowy7A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 05 Feb 2026 20:07:01 +0100
Subject: [PATCH DO NOT MERGE RFC 4/4] spi: cadence-qspi: Retrieve DQS
 capability using the core helper
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-winbond-nand-next-phy-tuning-v1-4-5e7d3976f0f1@bootlin.com>
References: <20260205-winbond-nand-next-phy-tuning-v1-0-5e7d3976f0f1@bootlin.com>
In-Reply-To: <20260205-winbond-nand-next-phy-tuning-v1-0-5e7d3976f0f1@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, praneeth@ti.com, 
 u-kumar1@ti.com, p-mantena@ti.com, a-dutta@ti.com, s-k6@ti.com, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

This is just a suggestion for Santhosh on how to get the DQS capability
information without the DT property, to introduce in his Cadence QSPI
PHY tuning series:
https://lore.kernel.org/linux-spi/87v7gbdwdh.fsf@bootlin.com/T/#t

This patch shall not be applied as-is and is just given as an FYI.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 4f799f747346..0809846a6ef0 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -3476,6 +3476,12 @@ static int cqspi_mem_op_execute_tuning(struct spi_mem *mem,
 	if (!cqspi->ddata->execute_tuning)
 		return -EOPNOTSUPP;
 
+	/*
+	 * FIXME: maybe this boolean could be queried when needed by
+	 * saving a pointer to the spi memory somewhere?
+	 */
+	cqspi->f_pdata->has_dqs = spi_mem_has_dqs(mem);
+
 	return cqspi->ddata->execute_tuning(mem, read_op, write_op);
 }
 
@@ -3517,8 +3523,6 @@ static int cqspi_of_get_flash_pdata(struct platform_device *pdev,
 		f_pdata->non_phy_clk_rate =
 			f_pdata->cqspi->ddata->get_non_phy_clk_rate(f_pdata->cqspi);
 
-	f_pdata->has_dqs = of_property_read_bool(np, "spi-has-dqs");
-
 	return 0;
 }
 

-- 
2.51.1

