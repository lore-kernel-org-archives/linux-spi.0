Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCE837AA99;
	Fri, 10 Apr 2026 08:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775809136; cv=none; b=s7D2tKin5kZJTImasOl2Dbqc2cwd6HKZ7xGHuT3uAi4VC/ch2+LD2zzVSCjFXUm7AX6ta2yk362hKieTCSy1Qc3vEZBN2nOl+AsZz5KzKCqKAM0hxHf2ARQcx9khyw1edQEQ4wQ5RYW3/nQzBWBs67rvTzVATuTs/EMlcI4lh3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775809136; c=relaxed/simple;
	bh=ipPc3IvuR1QfaJumaXRxbml2av9cCHPHKfA4rCtGTnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4043U/jGjxVBPIe82M1D+Bz7/akDwNaxzEkLiUd87uPGJbG6tEnbr44ReEFXhwVZjG+PuRV4oPKM2TKsJ6hPtpOspUaSTd68BXbSnbKBUAnjZnwTKB2RE4wr5oJo7f2uJqlgkI25cyKIlr8/WTgMxkb+x4pZgLOZXzsrO7TP6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGJzR4LK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGJzR4LK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65461C19424;
	Fri, 10 Apr 2026 08:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775809136;
	bh=ipPc3IvuR1QfaJumaXRxbml2av9cCHPHKfA4rCtGTnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hGJzR4LKSmWd7tGI3L7RcUMyqdQ52xPo+RjYZfkOWLx79oMpQQgcc9lNIMMIGPYBX
	 yyGJWnA1ROvBKavokTcmYRDB05eYpR41SvLCFJfWYxvXGlYcoIFHUci/ywCPmQPMMe
	 Yhk5zVaG4Ba+vs7QoVzDZDntQUJooBdIxF4RodB1wTPUEcQSSNlHqPA1i1d91iCanJ
	 7efBGiXUy7MyCmnQ84ZbazTIjjJ0VliFRkrGzvH2btQlmusDUJtvReRErrq7P7avQ8
	 ydNR45oW/dwLlXGMfbJbDRQWHKtrijvH5kkDB64JulOIHfZwYnjPU+C+N5h+aVX91m
	 dtDTXBe7KE65g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wB74n-000000026uK-3VBa;
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
	Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH 02/26] spi: mtk-nor: fix controller deregistration
Date: Fri, 10 Apr 2026 10:17:32 +0200
Message-ID: <20260410081757.503099-3-johan@kernel.org>
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

Fixes: 881d1ee9fe81 ("spi: add support for mediatek spi-nor controller")
Cc: stable@vger.kernel.org	# 5.7
Cc: Chuanhong Guo <gch981213@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-mtk-nor.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 1e5ec0840174..74f34537b02c 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -913,7 +913,7 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_noresume(&pdev->dev);
 
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret < 0)
 		goto err_probe;
 
@@ -938,6 +938,8 @@ static void mtk_nor_remove(struct platform_device *pdev)
 	struct spi_controller *ctlr = dev_get_drvdata(&pdev->dev);
 	struct mtk_nor *sp = spi_controller_get_devdata(ctlr);
 
+	spi_unregister_controller(ctlr);
+
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
-- 
2.52.0

