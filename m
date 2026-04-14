Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FCE3E5ED3;
	Tue, 14 Apr 2026 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776174341; cv=none; b=iX1CP9ENFTkCzAy69wbH18H6rJoLfCJw/UWncf5p9bQPFnX4kloNe+il9mUh0iSr1s31Q3e/OOB7z2dQkpeawdT8GB+B0u4OfMF4DTqb0WXtl0eKHBF2eegrTwtnfuGmNRk0eJKoU5mVopEJWXOPgReK1Ft1sHmUjaCJcrTeT8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776174341; c=relaxed/simple;
	bh=sBCFg1wFmrRnH1u1Jj2UAJ+YPSqx35GnK209IW14Zng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oe1i3LajzjoFPSb7lv2f2gHcWog0qCDIqC5pKNtFLuJ7wn5u/jQHm6YF6nuT9ebykSxqYiQ4t00NR9insKWphl/cCMucPaGT1/x5s9sgcZJnAcMQHL2Mm8pZqWVM+XDgU3/pdiQi5MIctb5IosPn0SuOSiGPChe0zqx6mGDfjqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nC81lyCv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nC81lyCv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002E2C2BCB6;
	Tue, 14 Apr 2026 13:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776174341;
	bh=sBCFg1wFmrRnH1u1Jj2UAJ+YPSqx35GnK209IW14Zng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nC81lyCv278LkAH0ritLY3L/CQM01pncsAphwyH73u5sjA1Q+I1fEnPRgE0mo6r1I
	 BfMEpnsaPWdu0jsFE8wqm53XErZwItolMpnGpL8jlRYErzGy7GHEI9ie+CxgARuIqk
	 MsKuokeGPIvIYKLAvCtl+O2ONPApdBt24J/tyYNOqMp86UV69Zd4klBOibXD8PiSwI
	 RnWxu6E7H0QDsSFfjkrDhk+js43efuj/izuBlFG01PZuW0QqSkI7jqYfoGj8HK0mPD
	 I3a7BM/PaX1aRbU6h6qgBTH1zSXm9Qt13PLQsxZ/bWIOYIrIuABW/eUBnQ8oe9/ZUs
	 4YXNWKQKHWLHQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wCe5C-000000046W0-34x0;
	Tue, 14 Apr 2026 15:45:38 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH 5/8] spi: mxic: fix controller deregistration
Date: Tue, 14 Apr 2026 15:43:16 +0200
Message-ID: <20260414134319.978196-6-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260414134319.978196-1-johan@kernel.org>
References: <20260414134319.978196-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to deregister the controller before disabling underlying
resources like clocks (via runtime pm) during driver unbind.

Fixes: b942d80b0a39 ("spi: Add MXIC controller driver")
Cc: stable@vger.kernel.org	# 5.0: cc53711b2191
Cc: stable@vger.kernel.org	# 5.0
Cc: Mason Yang <masonccyang@mxic.com.tw>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-mxic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index f9369c69911c..b0e7fc828a50 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -832,9 +832,10 @@ static void mxic_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct mxic_spi *mxic = spi_controller_get_devdata(host);
 
+	spi_unregister_controller(host);
+
 	pm_runtime_disable(&pdev->dev);
 	mxic_spi_mem_ecc_remove(mxic);
-	spi_unregister_controller(host);
 }
 
 static const struct of_device_id mxic_spi_of_ids[] = {
-- 
2.52.0

