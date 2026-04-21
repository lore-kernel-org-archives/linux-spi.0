Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD523BADA0;
	Tue, 21 Apr 2026 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776046; cv=none; b=D/7vbvSzEAKkrwOI7Cn18B87q6qjtmAjyHs6u+029f3uixpzYuNnGkYb8LQdKOzHmTQssCQGFBurRnyVFofwURsqTA3xFxVV74hDW9ACOYdHckagdwSQuG8UbWjYjRN9TZOUQG4JghlK05FKfEZbjZEEsR0IOZqRU+o4CQjaS40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776046; c=relaxed/simple;
	bh=wgArIPcZArnMQimQRP1QPvvKx7Z52l1PRVNiX2fzlhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHUPKz6njJAciw9f2VyZOIkdM2Ob2hcjyoC0oNkWGsOcKjNdjEF+0TPP4xcqMlHMEymwz55kpNliTlT89voT5eJ84CQsbNTFNE5Vacn9/ie5qWnyDAod9nrYLMlA8PIKflI7iUiZJUNyX0GiSBMpF9tZi9BGO55OLwRHlK5FIpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ql6vJJha; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ql6vJJha"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CADC2BCB7;
	Tue, 21 Apr 2026 12:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776776046;
	bh=wgArIPcZArnMQimQRP1QPvvKx7Z52l1PRVNiX2fzlhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ql6vJJhaLViTa4mDkgoRrfndl4ohHzwpiBJMaw5MAeBjGoTivQpWjT1G/F78G4mrQ
	 ih7YofOFFrW+B5eDrj//cCce15VfSxMAnkyFAvZQ89cESLMxY4nDwV0GbYgnNiiI8U
	 3CnTDkdR52pBWGE2N7Anpx+/qvj2PtwafmYiW3JbkNZI0Ix4T5k71dO3vR/ZbLs/8H
	 Cc8cuNMNdd/r+ae3hUoVH7EvIPfFslxCuAAyI2TGe1MA0dZp5vhnlrYPhpF/ZRzkVA
	 ATikb2fZ0Wt7OGsHFIMebY7uQrN77xVdFXk2UXMSEnzcogshD7/8TnJ7lRfIBks0c5
	 sWOvvFhGeFzNw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wFAc7-00000006RIQ-3tkR;
	Tue, 21 Apr 2026 14:54:03 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Anurag Dutta <a-dutta@ti.com>,
	Apurva Nandan <a-nandan@ti.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/6] spi: cadence-quadspi: fix clock imbalance on probe failure
Date: Tue, 21 Apr 2026 14:53:50 +0200
Message-ID: <20260421125354.1534871-3-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421125354.1534871-1-johan@kernel.org>
References: <20260421125354.1534871-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the bogus runtime PM get on probe failures that was never needed
and that leaks a usage count reference while preventing the clocks from
being disabled (as runtime PM has not yet been enabled).

Fixes: 1889dd208197 ("spi: cadence-quadspi: Fix clock disable on probe failure path")
Cc: stable@vger.kernel.org	# 6.19
Cc: Anurag Dutta <a-dutta@ti.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-cadence-quadspi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 5040e4e1cce0..b79f48f2420c 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2004,8 +2004,7 @@ static int cqspi_probe(struct platform_device *pdev)
 		pm_runtime_disable(dev);
 	cqspi_controller_enable(cqspi, 0);
 disable_clks:
-	if (pm_runtime_get_sync(&pdev->dev) >= 0)
-		clk_bulk_disable_unprepare(CLK_QSPI_NUM, cqspi->clks);
+	clk_bulk_disable_unprepare(CLK_QSPI_NUM, cqspi->clks);
 
 	return ret;
 }
-- 
2.52.0

