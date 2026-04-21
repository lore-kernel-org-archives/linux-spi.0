Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2807F3BD653;
	Tue, 21 Apr 2026 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776208; cv=none; b=SrflIlJ3wbYKnqDKL0KITJjGYahy2pauXG7NOpDpnU+MqIAWuc1YliREdASVBbyAad4yXjfjusu8CSqzYk6Iwx5HX2o7+OJvfsHwQ1a7ufZLK/NZ5wK1WzXXwv08rBjd527SohmGtNiBpHkH6o0Hhv13SQU3dEni38f4xmsYUiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776208; c=relaxed/simple;
	bh=NdRxYl/Lw28QZ+YmuAY12uroQ7H2A+Oz8gEvYUbQAiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJXU5W6skB7zviryeO/T+qZiDIZYFo/SJwllSQBlo4VxKe4WAFd/5ZwiO6Kmz0bNNso/HTiCTgIgRWEQ9Tkuh6g4IFYLIr2bJFK7nedeE6R80iSkQODtnFQt3Uf/3DEUkEtlOnEn9km3dQXme0JBSikftb85xvfK31Q5ePVq28I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNdnNnfV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNdnNnfV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EC3C2BCB3;
	Tue, 21 Apr 2026 12:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776776207;
	bh=NdRxYl/Lw28QZ+YmuAY12uroQ7H2A+Oz8gEvYUbQAiI=;
	h=From:To:Cc:Subject:Date:From;
	b=vNdnNnfVuxCs1oy6pbhPvnV55bUVpSTKoCnqVtMsj3OLw6Qh/vCJkH6nUI9NEA9uE
	 Y3jUsIUfXt49tJy+ZpGTvm0DMFVU+sSbOoHvu6STcxdR7NxjsaA5ovAZw7WidcHy3U
	 At4/PEhI5wyIli7e+QgyeAoz5v737Bua1VDMBfxoVHnCXbCWqZY54YM7GWr6TAJgfh
	 lYnh8zUYJwTSBa2xuFfHvE6LPPwrAO87CEBGLFPXISKu1mPZmCws0aWbIXtEk/E/aH
	 pCcJeQrG/EIqCQT6qzrZHz4V2/TNVBYm4znFkDZJnkqhoqcC4qEJznSTCyK34k/ziQ
	 Tk9D9Zr/VpSKg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wFAej-00000006RuU-1hua;
	Tue, 21 Apr 2026 14:56:45 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] spi: imx: fix runtime pm leak on probe deferral
Date: Tue, 21 Apr 2026 14:56:32 +0200
Message-ID: <20260421125632.1537235-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to balance the runtime PM usage count before returning on
probe failure (e.g. probe deferral) so that the controller can be
suspended when a driver is later bound.

Fixes: 43b6bf406cd0 ("spi: imx: fix runtime pm support for !CONFIG_PM")
Cc: stable@vger.kernel.org	# 5.10
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 4747899e0646..e5c907c45b87 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -2373,6 +2373,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 out_runtime_pm_put:
 	pm_runtime_dont_use_autosuspend(spi_imx->dev);
 	pm_runtime_disable(spi_imx->dev);
+	pm_runtime_put_noidle(spi_imx->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 
 	clk_disable_unprepare(spi_imx->clk_ipg);
-- 
2.52.0

