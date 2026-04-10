Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6384E3AE196;
	Fri, 10 Apr 2026 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775809137; cv=none; b=IQXvF5adsyKLVplX0qBKD3UZJK6C+mDnhUH2Yj4pp6dRJK7udYw7ZaKvJrZx71I4VVgwIJjigajIak1M8ihgnYNVhqz40duclnuO7FhIuhJfhBzzxtoVOa+xzR+EIMb8M3JeTrQalGvGDP+eUtaLt1rjPdc7K09VxwUSMpOXbhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775809137; c=relaxed/simple;
	bh=uOexjg/vLArFedhRI5E2v6SLQj6aJ4WVqhjN4mRf364=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6npjbP6ursUFGnjTT4lWErtL9zaVacYotgGnV4KhpB0unuA7lCR4n7MUiGziXwIoIK5Oe47lj33zUOYu5q8DnB5RgAj4UccJDG5+dVAMhEnzTGhoiYsnysBk0hywXUaN0fEzQKNHFO3EFMeS4OEF6QIx5W1GtkWLMraajfGJpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFMyzlvz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFMyzlvz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7966C4AF0B;
	Fri, 10 Apr 2026 08:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775809136;
	bh=uOexjg/vLArFedhRI5E2v6SLQj6aJ4WVqhjN4mRf364=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OFMyzlvzmFzFzw5JcponkWGLgFBSta98hNyqHfZtPmwzqRjsn15tiyP8v6pVQQDoE
	 Xeji4SxwmOmuFPcxqbi5NuO7JU4de5dy640cY3/e9It118biFfn7eLOjIxyytks+/c
	 xvFdEEDe3zVbPE3FOWuUobSwJul5k8dDvfBGK3gKOHoTiWLYUgHO0K9mXVysQYHIAu
	 wBKdY96fEIv4BbAOT8KQEYKG9cOjG5Of5TSg2zD8eUlhHCRHn0WT4v56FNy3yTX0Px
	 WfyizLv9rSKrIZ2PUceobeSKb1vQw9GW7on/tKUbbmtQQ7ttYu/NrUab2Tuqc7ieUQ
	 RdpcBk3q40iCA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wB74n-000000026uo-48wV;
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
	Lee Jones <lee@kernel.org>
Subject: [PATCH 17/26] spi: st-ssc4: fix controller deregistration
Date: Fri, 10 Apr 2026 10:17:47 +0200
Message-ID: <20260410081757.503099-18-johan@kernel.org>
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
resources like clocks during driver unbind.

Fixes: 9e862375c542 ("spi: Add new driver for STMicroelectronics' SPI Controller")
Cc: stable@vger.kernel.org	# 4.0
Cc: Lee Jones <lee@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-st-ssc4.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index b173ef70d77e..9c8099fe6e19 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -349,7 +349,7 @@ static int spi_st_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, host);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register host\n");
 		goto rpm_disable;
@@ -371,10 +371,16 @@ static void spi_st_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct spi_st *spi_st = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	pm_runtime_disable(&pdev->dev);
 
 	clk_disable_unprepare(spi_st->clk);
 
+	spi_controller_put(host);
+
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 }
 
-- 
2.52.0

