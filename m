Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17813BE487;
	Thu, 22 Jan 2026 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098149; cv=none; b=HRK86nOfMFCx2FsaF2I3qruXSGOFWPNwUpIuTpG91/ZfbuWK1uWHExex+ogEvfu1EoH1hJJvVx2dr4hn1SoIoJaniWzpHFxlD/MkXVMQi6vh9hE+igyktygGIQvNliPduEUqDg6bbIuDfwrv/xzbStVIMuOkTstnnLIXA3Ntw+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098149; c=relaxed/simple;
	bh=1oFV/VTuEmXKj9VfbsDu/B9vL9XgmwfbNs7cuVNQNWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LTtOaPed3AJ/ApfJelKrhrLv//xyaHluC9GRjzqz1GoJ7kQSUhip1XH0XktHXUQpgm2sm5VP19yCbSzpltPcCy64B08fGgdurmfg7wnsBnGtD8aOetCqKybEBHBCeMQT8spbUTIbpiGchNXKiQVrTPnY1P36/ZQgoRcZdFbVGCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEbhmzCz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEbhmzCz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7531C116C6;
	Thu, 22 Jan 2026 16:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769098148;
	bh=1oFV/VTuEmXKj9VfbsDu/B9vL9XgmwfbNs7cuVNQNWI=;
	h=From:To:Cc:Subject:Date:From;
	b=ZEbhmzCz7y30gq+2KF1+lr5+37rEd89J5jCWhZ9zbhR+nnqmvRdiCXfkkXckJLELk
	 NBbreT5mEws0Naj1IykbMcsPlyfFfdgA7brhVRWh6D0WaB5n2cBlg0SrzoZ9xYfMxd
	 CsvQhZvtjDSLS7KXp3/Xz1HUpxiVqi0CZkN9GaPuFdrOQXvwNz9yjWcESuHJnCNSwi
	 GzsLA2/+2wQ2NIul+7Jd/AfRMvIUI4rynGr8BZdN27+IWVc9ErxjX6GHrmcpzRy1Q3
	 k3ypoC/0uT6pCDhzgdQPn2wPlbsClohGjpxUO7TdF4wijG9VYl/GHxDYwETSYScQVb
	 5rFjObbnP1DKg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: dw-mmio: support suspend/resume
Date: Thu, 22 Jan 2026 23:50:46 +0800
Message-ID: <20260122155046.12848-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add system wide suspend and resume support, the implementation is
straightforward, just call spi_controller_suspend() then assert the
reset and disable clks for suspend, enable clks and deassert reset
then call spi_controller_resume() for resume.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/spi/spi-dw-mmio.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 33239b4778cb..b8123db4ad55 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -392,6 +392,38 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int dw_spi_mmio_suspend(struct device *dev)
+{
+	struct dw_spi_mmio *dwsmmio = dev_get_drvdata(dev);
+	int ret;
+
+	ret = dw_spi_suspend_controller(&dwsmmio->dws);
+	if (ret)
+		return ret;
+
+	reset_control_assert(dwsmmio->rstc);
+
+	clk_disable_unprepare(dwsmmio->pclk);
+	clk_disable_unprepare(dwsmmio->clk);
+
+	return 0;
+}
+
+static int dw_spi_mmio_resume(struct device *dev)
+{
+	struct dw_spi_mmio *dwsmmio = dev_get_drvdata(dev);
+
+	clk_prepare_enable(dwsmmio->clk);
+	clk_prepare_enable(dwsmmio->pclk);
+
+	reset_control_deassert(dwsmmio->rstc);
+
+	return dw_spi_resume_controller(&dwsmmio->dws);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(dw_spi_mmio_pm_ops,
+				dw_spi_mmio_suspend, dw_spi_mmio_resume);
+
 static void dw_spi_mmio_remove(struct platform_device *pdev)
 {
 	struct dw_spi_mmio *dwsmmio = platform_get_drvdata(pdev);
@@ -435,6 +467,7 @@ static struct platform_driver dw_spi_mmio_driver = {
 		.name	= DRIVER_NAME,
 		.of_match_table = dw_spi_mmio_of_match,
 		.acpi_match_table = ACPI_PTR(dw_spi_mmio_acpi_match),
+		.pm	= pm_sleep_ptr(&dw_spi_mmio_pm_ops),
 	},
 };
 module_platform_driver(dw_spi_mmio_driver);
-- 
2.51.0

