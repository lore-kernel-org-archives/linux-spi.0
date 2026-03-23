Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AA139185C;
	Mon, 23 Mar 2026 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263001; cv=none; b=IiSbtK92XfV8WWnf3pvIPMpGzsgJJv6UXJgswvmDssS6riO8HznrNCB+CgOED1T7DFAd3qbPG1HYWVSIysH3u1RE7r/EJEilc2+iYOzTBnb1KkVlcH7xkNLLss/TDJw+5qIiyRSrOlfBD4POEfAfTXiBXLyafV5fA7cmrhQqzIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263001; c=relaxed/simple;
	bh=64eGly1DBdIY4wQ+lw/es7xm3jGmQgoJsTMHjjplrB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LMrzN8GNr6UwDTpwpv306eflVwBN7703FywP/bTSGcwKsI2QUL4IKcGbpoNrkH2/JDkC5l4emsOO518/shiq40BvCtf2sXmC4BwhJDHmV5hYngcizTIjjHRKdMWMt8SXvxgb+Apn9Shct2rQT5nF/L38902b6S4/akScq+GIgPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdtAkPGC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdtAkPGC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8ACAC2BCB4;
	Mon, 23 Mar 2026 10:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774263000;
	bh=64eGly1DBdIY4wQ+lw/es7xm3jGmQgoJsTMHjjplrB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IdtAkPGC6x41DpxCgQPUGfbNEc42m140drpyuCj2R9CcSZYhJltdo/2ExuyxScTcd
	 mCDgk1B6VfxJgBt3L3Wo2wJRsvF0f9XcnQq3S7U+lZS4+c2P09MKPZrw4D8A681Ig2
	 +wLRP2dPzAfhxUDVVzoYPAWJvTL+wkhW2SOqf2IbHI1mNJSVPWCooNIIhEl6N+rgc8
	 gg/1eeAMn6SELJIpPPCFqWLszubBWR/CgTDH9yGXCt2w7xtCBBe/sQ1qS4160uYx7d
	 sNaL/4m2dt0im2o0gvDYoLvD8TpoVvGWR0o0HNhordV69fc+zTcGJNKBBuLVxiowTw
	 NkSobkiwC79JQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w4cr8-00000003Xim-1WsK;
	Mon, 23 Mar 2026 11:49:58 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/5] spi: imx: fix use-after-free on unbind
Date: Mon, 23 Mar 2026 11:49:44 +0100
Message-ID: <20260323104948.844583-2-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260323104948.844583-1-johan@kernel.org>
References: <20260323104948.844583-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SPI subsystem frees the controller and any subsystem allocated
driver data as part of deregistration (unless the allocation is device
managed).

Take another reference before deregistering the controller so that the
driver data is not freed until the driver is done with it.

Fixes: 307c897db762 ("spi: spi-imx: replace struct spi_imx_data::bitbang by pointer to struct spi_controller")
Cc: stable@vger.kernel.org	# 5.19
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-imx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 64c6c09e1e7b..a8d90c86a8a1 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -2401,6 +2401,8 @@ static void spi_imx_remove(struct platform_device *pdev)
 	struct spi_imx_data *spi_imx = spi_controller_get_devdata(controller);
 	int ret;
 
+	spi_controller_get(controller);
+
 	spi_unregister_controller(controller);
 
 	ret = pm_runtime_get_sync(spi_imx->dev);
@@ -2414,6 +2416,8 @@ static void spi_imx_remove(struct platform_device *pdev)
 	pm_runtime_disable(spi_imx->dev);
 
 	spi_imx_sdma_exit(spi_imx);
+
+	spi_controller_put(controller);
 }
 
 static int spi_imx_runtime_resume(struct device *dev)
-- 
2.52.0

