Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9AF40242D;
	Thu, 30 Apr 2026 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777550599; cv=none; b=OCzsY1EhtrSdj87F5lENlrnAVMpZWjUcCYxJvh+tdebl09VIHQdDZu/1KlLsYTXB/tFiSza7zPJ1+bc85pd3RzCpNS63rZ6NaE41NcmqR4QNd2eA6/JxyhI0f4Sz+AwS62igmgfVqnCgtIpG8LwkTeLMVTYLd97U/hu4m6e0FLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777550599; c=relaxed/simple;
	bh=Cb2ieVkoQgY7Y51P7otiSAutj9E10FQ/pO62xvb3MjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWGomizbtZPNtLaEdRRSMlJCrdeItUaNSXfL9YN0Jetn4TkLEcZoJccF/ejwQus/RKyFf+m4S+jZ9oTMIaC0xjDczH9fINCRcKiqvsmpvS/NAnCR5DQG+bg+idn+0N0o1zQ6447rS4RBC49o8lyuXBHVnGZIPHXdf65Z0dlVWJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpt3fE8a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpt3fE8a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6E2C2BCB3;
	Thu, 30 Apr 2026 12:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777550599;
	bh=Cb2ieVkoQgY7Y51P7otiSAutj9E10FQ/pO62xvb3MjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dpt3fE8a8vZvaOZSpSiB/X/WvyO6gZ1Fb6OmUHo8INBlxFqDi6Wu8gIZasVYp0zzw
	 oPMMxmxVR4Dut+OZWGymzqevcwnJkF6MxXB2zxeDx4PaHrCMJpaLVbbsqEASj3V25e
	 h4BTllqCv/NBas7nKfcoYn7ARsJbcvklBhMU4+v1QDsSFn006lKk1K4xJtKbMjCjVP
	 Ypo1e8MQNIqh/W72HS9Sk4G3A+noL4QKNHOoJ3hNha1v9gvULdJpV6mEwGB6vvMG8z
	 12ouqFL2i9Yf+aHgfDLQActtJTTu59PG7ZzZCaBNOu2Uxil1aL3QjWP88Gzw6nhlk5
	 cLj3+z1hMnF0A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wIQ6v-000000012sx-0lgF;
	Thu, 30 Apr 2026 14:03:17 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 2/3] spi: omap2-mcspi: clean up error labels
Date: Thu, 30 Apr 2026 14:01:59 +0200
Message-ID: <20260430120200.249323-3-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430120200.249323-1-johan@kernel.org>
References: <20260430120200.249323-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up the error labels by adding a common prefix and naming them
after what they do.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-omap2-mcspi.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 60c05eb91781..59ebdf7edbd2 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1553,26 +1553,27 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 		status = omap2_mcspi_request_dma(mcspi,
 						 &mcspi->dma_channels[i]);
 		if (status == -EPROBE_DEFER)
-			goto free_ctlr;
+			goto err_release_dma;
 	}
 
 	status = platform_get_irq(pdev, 0);
 	if (status < 0)
-		goto free_ctlr;
+		goto err_release_dma;
+
 	init_completion(&mcspi->txdone);
 	status = devm_request_irq(&pdev->dev, status,
 				  omap2_mcspi_irq_handler, 0, pdev->name,
 				  mcspi);
 	if (status) {
 		dev_err(&pdev->dev, "Cannot request IRQ");
-		goto free_ctlr;
+		goto err_release_dma;
 	}
 
 	mcspi->ref_clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
 	if (IS_ERR(mcspi->ref_clk)) {
 		status = PTR_ERR(mcspi->ref_clk);
 		dev_err_probe(&pdev->dev, status, "Failed to get ref_clk");
-		goto free_ctlr;
+		goto err_release_dma;
 	}
 	if (mcspi->ref_clk)
 		mcspi->ref_clk_hz = clk_get_rate(mcspi->ref_clk);
@@ -1587,19 +1588,19 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 
 	status = omap2_mcspi_controller_setup(mcspi);
 	if (status < 0)
-		goto disable_pm;
+		goto err_disable_rpm;
 
 	status = spi_register_controller(ctlr);
 	if (status < 0)
-		goto disable_pm;
+		goto err_disable_rpm;
 
 	return status;
 
-disable_pm:
+err_disable_rpm:
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-free_ctlr:
+err_release_dma:
 	omap2_mcspi_release_dma(ctlr);
 
 	return status;
-- 
2.53.0

