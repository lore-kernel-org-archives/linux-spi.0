Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DDC4C6511;
	Mon,  5 Oct 2026 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214665; cv=none; b=dGbAL/ONphIJ93LStkvpxALyMfsFQviHymaI8Bn1JkSC4Uhyf07NHUcAt3hVESk9W4EY0dgdry8L82hhl7iiOuhuxaXWWk9tPWlTfwzeJ0RF3Uz8F44/qcrqzRDP+Q9/TeeQpzrcY2TjTMJvct2tAjProo4FOlM6ER/uc2HAJ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214665; c=relaxed/simple;
	bh=hgHjZ0MLTNNPp/wiI1L/LaSxEUhtkdOuoFQun4qcaGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqogNRi0HlvAXlIFaeKNT3dss5x0MZHBkY1RdZ/iLYc2JtRpU1PGk6wGPwiOT09pk3PU0MtzypQhRkO1aXlczf5d9tGAqZIkeH/wN5I9T5quNZUyrcRUpXSmAyl/BU/wTZUrplqzAccNdNP2+u6v6pqevO0N3c5dv+tSZ0BjByI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqQGdOrC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqQGdOrC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1951F00899;
	Mon,  5 Oct 2026 15:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791214661;
	bh=7JA8lfM6fZ4wCMdSflZNUKTIsR+EZrzQnkDisu0bGh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hqQGdOrCTvt+SoADXvL9rfGIUqHWxYcR8evy6/KsI4AjxSmTcHxYBoE7FhAVIroGT
	 YXwqLE+oLevWzrpev1ekdVKRc3XqgYlQRc/ug8JkSHJ1MnUKvJTLov1RAnLYsIkCAW
	 uMHE7p0qUyNCsJozTRS4c+P4kB2WixX+K+XP7oSnl4ba5w5bgFRBt0/4FN95I2EgzA
	 zAAiLpI6AgOWQE/uobbzeEcSmgo1o6KKDNRgWIUJIqdurecCeSKC5tuxK+g+MFHxDK
	 QUJwu31WwTPaaBHVOJQlXgZK3IAhgwk4Wt9wk+1gu12wiHsmXp3EA83kQHVFGW4XAO
	 neGxMo8v6OZwQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Joseph Steel <recv.jo@gmail.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v5 2/4] spi: dw: remove duplicated "!rx_len && !tx_len" handling from dw_spi_irq
Date: Mon,  5 Oct 2026 23:17:37 +0800
Message-ID: <20261005151739.25233-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261005151739.25233-1-jszhang@kernel.org>
References: <20261005151739.25233-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dw_spi_irq() need not handle enhanced-transfer's "!rx_len && !tx_len"
case as that state is already handled by dw_spi_enh_handler()

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index f5a80105ceeb..f82a632ca71c 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -284,12 +284,6 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 		dw_spi_mask_intr(dws, 0xff);
 		return IRQ_HANDLED;
 	}
-	if (dws->transfer_handler == dw_spi_enh_handler &&
-	    !dws->rx_len && !dws->tx_len) {
-		dw_spi_mask_intr(dws, 0xff);
-		spi_finalize_current_transfer(ctlr);
-		return IRQ_HANDLED;
-	}
 
 	return dws->transfer_handler(dws);
 }
-- 
2.53.0

