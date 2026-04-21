Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A1E3D090F;
	Tue, 21 Apr 2026 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776774994; cv=none; b=deUrl9L+L3Ucog4gNkznDjOzpIHBXoxZGa38GlLsa7y0az+i/JyhnzzVcfgeY3kMWMhJVd4pGOLF0Y62dQ9P1RIiZlYf6mY9jp7kajufwxl9cdTAQfiY954QG1o9bsdz2XHL4JZ1vRGX44QtdVFeiQVkB0tWUYhCtfw7/1KesJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776774994; c=relaxed/simple;
	bh=wBk+O+ghtBtCmOFC6LjLHlTBkNea+9jcEd2jANWY4E0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fycvcb97xFxCGxDnhiORim10Sgd2an+/I+9Qzj732qmZelge8eNhldsphg2GcBDP9EEDhS8mNgbAdxr/fMLpg8v5Qiwqm0iXfQoqQ00VWMeCms5lsWDiVLS32V9icVbJ42cNsdEwWzCWPQFnRea9eJ8rG208drr7vR2BI0XJtw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nR5oTOCc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nR5oTOCc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB7CC2BCB9;
	Tue, 21 Apr 2026 12:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776774993;
	bh=wBk+O+ghtBtCmOFC6LjLHlTBkNea+9jcEd2jANWY4E0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nR5oTOCcqIxh1HJxhQ+I/GX/GtHAudnucA+Dt83/ppuva38fI6xh+Mgc2miaYVHrd
	 8VursFV/0SQRdwe5iacMfwv278l6heh6FlgCZseWmXN9FdaCQtcdpZHz2ZWyrN/2W3
	 t9X0V/8VCOL/Kk6+YV82zPE+XWcBgHX87wU4LYDm+X7zHTZ7PLoBvURmoDJ5WYRnm0
	 pJTaDpQ/g2DnsMPXJU+65MsOL8D2WqQj4IxeSM3JmeiB4RQ6FKNo1vSrbzAsXaYA3Q
	 IUs1Hi27V12aHyO3eBHRJ7HW/+1e262LdQeD9EGjhebYj690J+No5jkdNuhTemY8jH
	 rfDPbxbkA1hUA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wFAL9-00000006QyD-2LE7;
	Tue, 21 Apr 2026 14:36:31 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 1/4] spi: cadence: fix unclocked access on unbind
Date: Tue, 21 Apr 2026 14:36:12 +0200
Message-ID: <20260421123615.1533617-2-johan@kernel.org>
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

Make sure that the controller is runtime resumed before disabling it
during driver unbind to avoid unclocked register access and unbalanced
clock disable.

Also restore the autosuspend setting.

This issue was flagged by Sashiko when reviewing a controller
deregistration fix.

Fixes: d36ccd9f7ea4 ("spi: cadence: Runtime pm adaptation")
Cc: stable@vger.kernel.org	# 4.7
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Link: https://sashiko.dev/#/patchset/20260414134319.978196-1-johan%40kernel.org?part=1
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-cadence.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 08d7dabe818d..bf4a7cf6b142 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -776,16 +776,23 @@ static void cdns_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr = platform_get_drvdata(pdev);
 	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
+	int ret = 0;
+
+	if (!spi_controller_is_target(ctlr))
+		ret = pm_runtime_get_sync(&pdev->dev);
 
 	spi_controller_get(ctlr);
 
 	spi_unregister_controller(ctlr);
 
-	cdns_spi_write(xspi, CDNS_SPI_ER, CDNS_SPI_ER_DISABLE);
+	if (ret >= 0)
+		cdns_spi_write(xspi, CDNS_SPI_ER, CDNS_SPI_ER_DISABLE);
 
 	if (!spi_controller_is_target(ctlr)) {
 		pm_runtime_disable(&pdev->dev);
 		pm_runtime_set_suspended(&pdev->dev);
+		pm_runtime_put_noidle(&pdev->dev);
+		pm_runtime_dont_use_autosuspend(&pdev->dev);
 	}
 
 	spi_controller_put(ctlr);
-- 
2.52.0

