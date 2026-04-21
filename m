Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2900F3D16F9;
	Tue, 21 Apr 2026 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776774994; cv=none; b=LuTtrioO91mRQlsMcsNaHAdyXGIXjwIrXEemxoZf8czE0zPlnVmRHxoFJYIuNHqb7Pw8H38MKdlg55zjwNl4gJtHVNMjJyOz8V2ZJp0+8QZBil8PjuKZabpWECl/hImk8R4Gbn18QYxEYH4wxyZ3d+7lWb85P3QsXxjm3ysD/To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776774994; c=relaxed/simple;
	bh=5hLWyRBX5d6zZi74k8bRsxo55wmQFDVEYsYNZen8B0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvFO0ZTUTDNPQshEtyQEZLaA/lnWfZg1O35hKe81tVsdIjbITMoE0edNA3HrjqcHky8ZDNwRbdF8qEWABw/Ko/2gCfzAJqjuMIlbBYOxfSc+06uYETSztKZRb8oa7lLt4qr3YY/F41eC/7OlOycG0xd/XAuXHuEaLLLRleTKiJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWMeScRq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWMeScRq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F12C2BCB3;
	Tue, 21 Apr 2026 12:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776774993;
	bh=5hLWyRBX5d6zZi74k8bRsxo55wmQFDVEYsYNZen8B0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SWMeScRqvPoDqiMlG7yM8kSpzKHlGqpywFzgjhL6xvN0WB247rKw80En7VhVa/Pbd
	 7lFmX05RAc6L+V7OaHOTUjHXptbnnlLv3sPUawyl5MXlroSedmJQG2RYyvrcPvYGav
	 IRLHJ95Q39rtOIPj8U626NwfvRFNvG+dFjjVg86453yXQUJxzKKX9m0Lb0E9NBPp1C
	 DF4t63QcKgffMQQqjCk7y+97HI8pxkt4SGjGmhmR0B/7yXvZrGicVQYLvRZyjkUArw
	 aOdNZepMEQrGoOmwf+e14EZIDpABU6Pk97aVnO6dyL1XlgKQx02igTrfZCfJGZzFYT
	 SSUzFV5rxCgjQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wFAL9-00000006QyJ-2S9n;
	Tue, 21 Apr 2026 14:36:31 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/4] spi: cadence: clean up probe return value
Date: Tue, 21 Apr 2026 14:36:15 +0200
Message-ID: <20260421123615.1533617-5-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421123615.1533617-1-johan@kernel.org>
References: <20260421123615.1533617-1-johan@kernel.org>
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
 drivers/spi/spi-cadence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index f27586151ca9..d108e89fda22 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -635,7 +635,7 @@ static int cdns_target_abort(struct spi_controller *ctlr)
  */
 static int cdns_spi_probe(struct platform_device *pdev)
 {
-	int ret = 0, irq;
+	int ret, irq;
 	struct spi_controller *ctlr;
 	struct cdns_spi *xspi;
 	u32 num_cs;
@@ -754,7 +754,7 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	if (!spi_controller_is_target(ctlr))
 		pm_runtime_put_autosuspend(&pdev->dev);
 
-	return ret;
+	return 0;
 
 err_disable_rpm:
 	if (!spi_controller_is_target(ctlr)) {
-- 
2.52.0

