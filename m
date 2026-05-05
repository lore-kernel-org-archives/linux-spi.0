Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7513E3DE429;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966182; cv=none; b=IgdAbLERhJNhLnykLApdGbBI9VgFolatRNxnLL60N/p3JYnoqoBImi84XplA3EkRQ1gAuAXBwJ+q1oCkF+sj8JA3rHh6HraAIwE1YRALjHSNp+dLuczfkGnIRJE8mg870uY7SClXgY3vGjeHihjiLzDDNHIxDHeykFpbnpnXi+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966182; c=relaxed/simple;
	bh=pEXQoRuunLgaMXmXLufauACKIHZkbDmN+d6y6Ut3KmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DaqvbX1mjC+5f5nzGIaQBsfZ1YqnwTvLjgRucsS28kt8IgwzlmHAUQBWJ89cUBFNCtomn6OsidwD2KxR6t2meJuhM/q0AxL11PUv+VfS0SDhomoUi2pR7MYG1hCMWDkNrwpdWfRXj8GGvY/RaB5F9AXjO6yLl1QUOfFfKvw3zgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjnYYtQ2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjnYYtQ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17485C2BCFF;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966182;
	bh=pEXQoRuunLgaMXmXLufauACKIHZkbDmN+d6y6Ut3KmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IjnYYtQ2c76SvGuiQ2V2v0rurX68zUFXCLXGijdVhXT3bZ2GxloJrfddN3+3Eu5Jm
	 d5UpQOkDuvUbNuSOAN8ON/PpJlRFOxymVOcF9DeyIwPkEhOwfb8brBGhI7CkIQIFnu
	 k7UYwzju/Ed0sDWo/QHFIMVI0IWGzVFsmt+2ggG+l5poc8B8sjl2urU2ZKuUJ3pPbk
	 KrZ32BZKkLWvVkgahs29ucvWCnKoHMYqj+KiC3qpbBB07x5JcWF6pLF5Uu1AuRbYqP
	 9roqOFbdcnfaH8frKy/rcZsEfabqi8LXJg5FyLOFJYoSwe7rl7rvTM8FHs8LNowfFA
	 WUEd7Upr1Jzcg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKADr-00000002atA-30Kp;
	Tue, 05 May 2026 09:29:39 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 11/20] spi: st-ssc4: switch to managed controller allocation
Date: Tue,  5 May 2026 09:29:00 +0200
Message-ID: <20260505072909.618363-12-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505072909.618363-1-johan@kernel.org>
References: <20260505072909.618363-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to device managed controller allocation to simplify error
handling and to avoid having to take another reference during
deregistration.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-st-ssc4.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index 9c8099fe6e19..df61094fc444 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -279,7 +279,7 @@ static int spi_st_probe(struct platform_device *pdev)
 	int irq, ret = 0;
 	u32 var;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(*spi_st));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*spi_st));
 	if (!host)
 		return -ENOMEM;
 
@@ -296,13 +296,12 @@ static int spi_st_probe(struct platform_device *pdev)
 	spi_st->clk = devm_clk_get(&pdev->dev, "ssc");
 	if (IS_ERR(spi_st->clk)) {
 		dev_err(&pdev->dev, "Unable to request clock\n");
-		ret = PTR_ERR(spi_st->clk);
-		goto put_host;
+		return PTR_ERR(spi_st->clk);
 	}
 
 	ret = clk_prepare_enable(spi_st->clk);
 	if (ret)
-		goto put_host;
+		return ret;
 
 	init_completion(&spi_st->done);
 
@@ -361,8 +360,7 @@ static int spi_st_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 clk_disable:
 	clk_disable_unprepare(spi_st->clk);
-put_host:
-	spi_controller_put(host);
+
 	return ret;
 }
 
@@ -371,16 +369,12 @@ static void spi_st_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct spi_st *spi_st = spi_controller_get_devdata(host);
 
-	spi_controller_get(host);
-
 	spi_unregister_controller(host);
 
 	pm_runtime_disable(&pdev->dev);
 
 	clk_disable_unprepare(spi_st->clk);
 
-	spi_controller_put(host);
-
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 }
 
-- 
2.53.0

