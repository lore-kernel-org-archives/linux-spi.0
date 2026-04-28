Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570B146AEF0;
	Tue, 28 Apr 2026 18:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777399888; cv=none; b=MMu/Wc6Brf77DF+l8PXl5lrbU4sCOVyVFzv56V6pFSBlEu4xlTiG5znrBv0McBqBw/eoLq1Hxo48+kWg90VJDlY2R4AUzE2hDmFlWayx3d8weMBZbS+Pe96XGt2udgrESVTTR3c9IHYLVrgdUSKJ/Jc6XpRONbBAHKO9fBizywA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777399888; c=relaxed/simple;
	bh=hcu3cIxbJISHC0gNcOJ/3vzK9uK9FIeZl/utZ+BQJeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6spo5hcszI765HfdqXL/wLlXMXmWjju3e5HPqijgHumrFtaNvwoCQ+ehSW7iW/jE2WtGGSzUSdL90eVtg8frOGU3qso2WVe1gDY34ME8n8kXKM2CmBl67nCvxdmkzJNNKxlEUk0eWrWSaHs9rM9MrjaC9nhueaQFCuGkuxqr3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcL3n8Xp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcL3n8Xp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EFBC2BCB8;
	Tue, 28 Apr 2026 18:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777399888;
	bh=hcu3cIxbJISHC0gNcOJ/3vzK9uK9FIeZl/utZ+BQJeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jcL3n8XpAx7icKFDvBsClKf6Gw5KcG554tH6tVzSIWStgDSy95i/134tB1jZWw4kI
	 np47TKkujTrR7kjslzhSEQU8uF9qpKM9uT9JbwJG80PP0BGHrWmZHgewCz/pktJhrb
	 TdCMBFqgpbIDTki8UMdZ/32I+X7UCUBAKVGCI0npeOBZiVWaCOlPD2q3PBmVB2hm6O
	 suXRV4PPvRanb2FcrKOzVJNYkMMjbBMz777HtI83ccIl3z8El0t9YBbrOXJrttARPk
	 dkdXs6ESwfA4T5gpVzuXKWVM/bNLWblKOyaONnv0Su/lJDcuGFA0QzAiIWw/Gx8l1/
	 50pXwmrmLCEog==
From: Conor Dooley <conor@kernel.org>
To: broonie@kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Cyril Jean <cyril.jean@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	linux-riscv@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] spi: microchip-core-qspi: report device on which timeout occured instead of which controller
Date: Tue, 28 Apr 2026 19:11:11 +0100
Message-ID: <20260428-porcupine-ninetieth-af00cb11b990@spud>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428-surfboard-unhearing-96776be0495d@spud>
References: <20260428-surfboard-unhearing-96776be0495d@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1017; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=b+S0ABQzEEVZUT2TBB5xfoa+31SnTtUvSbdC2jeWohY=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJkffth71DNHf3BRv7pNkEc/6NuBF893zV/tHbxt/5Y55 jEbtqzQ6ShlYRDjYpAVU2RJvN3XIrX+j8sO5563MHNYmUCGMHBxCsBE2t8wMnwP081UD0z+dGxb zuoN7n4eBXeLVnWsPSCUnXwg8oIK6ytGhiVV6TP8Jz7aJH3lo4LsNpltEXlnChiyn/Lv+SLId8D DhxEA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

When prepare_message callbacks fail, the SPI core already reports which
controller the failure happened on. The corresponding code in the mem_ops
portion of the driver already reports the device a timeout occurred on,
so make the regular part of the driver do the same.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/spi/spi-microchip-core-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index eab059fb0bc2c..c8b053c7c857b 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -604,7 +604,7 @@ static int mchp_coreqspi_prepare_message(struct spi_controller *ctlr, struct spi
 	ret = mchp_coreqspi_wait_for_ready(qspi);
 	if (ret) {
 		mutex_unlock(&qspi->op_lock);
-		dev_err(&ctlr->dev, "Timeout waiting on QSPI ready.\n");
+		dev_err(&m->spi->dev, "Timeout waiting on QSPI ready.\n");
 		return ret;
 	}
 
-- 
2.53.0

