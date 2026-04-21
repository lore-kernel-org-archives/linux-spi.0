Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239173D6477;
	Tue, 21 Apr 2026 13:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776538; cv=none; b=TytayxEH2P9+B8B3vVdYEeUEutCvdkySm78EttJ3DsynneKcsrpLr07Zgn8VV/na4d7oHQtuhn+MU5cz8QHauRtPk0YTRhGmupZglojkOZR6QRsWyd04+5opVaXCWw5tqPcDigXVosutnvVLIlH1bz/iWrfSgYEyszAXZF2QLTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776538; c=relaxed/simple;
	bh=v4LO/R9E8L+NQkiU87dhjklnNzNeABBuy62XXKFekjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCRx9pvselj6ZNzv8NKBW0KbqCrrCegSL7rGAUoXSxkrhO3NHpX6wHKysyHZ+NpJxNgwqcgAbnSbBMGmHmMXALqFJOa0ovSI1NPYUVcNRJFrWTrJsoOlTBg/EL6TW0ft53lFjIpoM2SwyFHIJfrX6cwE9+OazX3cHBsOVLh1WE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdjIbX4K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdjIbX4K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C568CC2BCB7;
	Tue, 21 Apr 2026 13:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776776537;
	bh=v4LO/R9E8L+NQkiU87dhjklnNzNeABBuy62XXKFekjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WdjIbX4Kq5bo0qkYTPbTBLxdF09Z4mAFrDBB0IJCyH3hayL90nPUTa1Bn19XcDKPP
	 tZ2CYtEypYXsKU7O0bgu4JJQq1tyFQA7s11sxJORfsvrvzfu8Ir7I+szhnYe1ezyTD
	 meAHF0CkZfXmMpuG+x0Z5HoI4vdNf2wbbXaoPtCkh9abMdvIRLmoIHDPhR2ck2Q6CH
	 zq6l3PbiL0sL5xQ3OyJLmbzWkId1yi9d35RxfI/Xd5JsgVDAmRLTGXzizIOgbP7Jo/
	 8M2rDDvduyMYusSV436XLp+0CG3W9A0TPHtG8XvXQubr5Viheef3Y0Rrq3obXIb+Vv
	 GYldZ5zuuCiOg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wFAk3-00000006S0v-2rQq;
	Tue, 21 Apr 2026 15:02:15 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/3] spi: orion: clean up probe return value
Date: Tue, 21 Apr 2026 15:02:11 +0200
Message-ID: <20260421130211.1537628-4-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421130211.1537628-1-johan@kernel.org>
References: <20260421130211.1537628-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the redundant initialisation and return explicit zero on successful
probe to make the code more readable.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-orion.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index a5ce970ff5a8..64bf215c1804 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -648,8 +648,8 @@ static int orion_spi_probe(struct platform_device *pdev)
 	struct orion_spi *spi;
 	struct resource *r;
 	unsigned long tclk_hz;
-	int status = 0;
 	struct device_node *np;
+	int status;
 
 	host = spi_alloc_host(&pdev->dev, sizeof(*spi));
 	if (host == NULL) {
@@ -787,7 +787,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 
 	pm_runtime_put_autosuspend(&pdev->dev);
 
-	return status;
+	return 0;
 
 out_rel_pm:
 	pm_runtime_disable(&pdev->dev);
-- 
2.52.0

