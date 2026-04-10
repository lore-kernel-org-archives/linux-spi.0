Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D623ACF07;
	Fri, 10 Apr 2026 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775809137; cv=none; b=G5a+Un89geonew/O4be8uskFJGE0beEVkbxtBqXo2kEeDJKhGXZM5F8BSj3ey2n7QD5xy1Op4vYd67eY9s03t8BS8dmxgTwdgQKdg1ZAt96ZvdbqIErj+SYoH9g7qLRKuGdLepDcgsxm/pZgUNRaNC+4CX3gL3hTsXPAgd7c7Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775809137; c=relaxed/simple;
	bh=UYGlDi1cPoopc+/rV7EGEP17fwrJo+7fHh3T+dg3/bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VlD20Sh7rs0Y+MKC+Zb1sfZkUCE9ucJzl1y3+E0p4DPzkNjCoB1pRpTv3lU6hGI0T2e3OJprRteW0/tQOwj9OgUEYrJE0qdEfZFGxWPI29c7eD9Td+Z+LBmqcA7/Ptw2c1y4nOFhJVeP5SoCVcDWxh753HbovMng9M2wN3kipew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=az6fv2rf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="az6fv2rf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9863DC2BCC9;
	Fri, 10 Apr 2026 08:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775809136;
	bh=UYGlDi1cPoopc+/rV7EGEP17fwrJo+7fHh3T+dg3/bQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=az6fv2rf1uNhu+Zx/knqA2/WkMsBVre7Q510MlAegOtuelUJeMFz6cyFnZdcohtAr
	 wlQ8S/KW0XoYXe84FZ9TYHw9LRWAPvQ5hi25ucO0EQGucy3s5BfEucF05Ti54UTZoK
	 dCj/wH0wwhqlBAzuEiwdyPePs+XWOdeWuvNrNqS7p7o1yp6aNBEvmsO0TCSCj19ale
	 zXsfHdzVnVaWAzshrwS2w1pmD6UGBCnIpyAo9XBemTZJ4LP7p4CqauP0zNinJRWDCX
	 2WE3Xnq/8O+famIU9M0sAUJXDktTf2rtXnUhuynzOQWjeVcwjatmpg8I/PFkhKJpPP
	 1Yim7V2On3/0w==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wB74n-000000026uk-43fo;
	Fri, 10 Apr 2026 10:18:53 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH 15/26] spi: slave-mt27xx: fix controller deregistration
Date: Fri, 10 Apr 2026 10:17:45 +0200
Message-ID: <20260410081757.503099-16-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410081757.503099-1-johan@kernel.org>
References: <20260410081757.503099-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to deregister the controller before disabling underlying
resources like clocks (by disabling runtime PM) during driver unbind.

Fixes: 805be7ddf367 ("spi: mediatek: add spi slave for Mediatek MT2712")
Cc: stable@vger.kernel.org	# 4.20
Cc: Leilk Liu <leilk.liu@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-slave-mt27xx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-slave-mt27xx.c b/drivers/spi/spi-slave-mt27xx.c
index ce889cb33228..7aedeaa5889d 100644
--- a/drivers/spi/spi-slave-mt27xx.c
+++ b/drivers/spi/spi-slave-mt27xx.c
@@ -453,7 +453,7 @@ static int mtk_spi_slave_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	clk_disable_unprepare(mdata->spi_clk);
 	if (ret) {
 		dev_err(&pdev->dev,
@@ -473,7 +473,15 @@ static int mtk_spi_slave_probe(struct platform_device *pdev)
 
 static void mtk_spi_slave_remove(struct platform_device *pdev)
 {
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+
+	spi_controller_get(ctlr);
+
+	spi_unregister_controller(ctlr);
+
 	pm_runtime_disable(&pdev->dev);
+
+	spi_controller_put(ctlr);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.52.0

