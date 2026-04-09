Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD703939DD;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775736326; cv=none; b=T0n69OJ/BaBdwcnsmH1RsgYQ3LsEisF4vomfJrHmVEKgWiGht8pQmDjpQLJ4EhpregeVHITy8irUtfVp1acYvSmqeKUt0UQXtZ/0jA6ZN3WpEUhHoO5OJjROBHjbHGaXrz73ej9+eX/RWK+y5YVex1GUITKYoFQ38GXlnMJqbqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775736326; c=relaxed/simple;
	bh=3DbsYkN4pf5ND1z8L30fphcMVgrd1sOFsBKrJWKj7TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXbMa7GuAT2jsod0TWGLqTVvhvkacu8Ml5CI8CEVGZwp3UnuaA7t2ACfEISqDmv+giSzsSbdk8W80Gzr5VPvhQaaaoKy9viiGd5FAdl0H7XxUv+77XZ5/1rr7qsMRBj1ThqkVoygLfWfP3RYqmhrBsR4iNpX2/i22wBlOSi/38M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYXLZuoQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYXLZuoQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9B9C2BCB0;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775736326;
	bh=3DbsYkN4pf5ND1z8L30fphcMVgrd1sOFsBKrJWKj7TY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WYXLZuoQ8oFwwg7QCVCsTgjZ+oF7k4znxYvh4mcT3ituf4jUt6lOBmrtFIwxBMVHV
	 +S4d4bkYsE8nK9KkaN7KV2Bzunj3zsgDkyRK50RkaNG9EAGdrVF1X6Vea02xxPaMmq
	 ZWbI1aE3JWof1OmZAGy0BX0RB1PzIxNSUGx2O0TLuTobOAftUxE0S4pBQqGXlhli0u
	 ddF9jdySAeKu8i749/x8Y88QzAuzfWGjn8vMeRX+e4YnrYDHr0/KjDsHbCEbKkyWLc
	 Lp4ZMGXDzbpvH77kts6wta6cmJTcrjQL4HD77J8ugRZ0+p/vlCqVqBL4wSyiRr6k4X
	 TDib8HQ5kS1RQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wAo8R-00000001d6h-43PZ;
	Thu, 09 Apr 2026 14:05:23 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Sunny Luo <sunny.luo@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Radu Pirea <radu_nicolae.pirea@upb.ro>,
	William Zhang <william.zhang@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 01/20] spi: amlogic-spisg: fix controller deregistration
Date: Thu,  9 Apr 2026 14:04:00 +0200
Message-ID: <20260409120419.388546-2-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260409120419.388546-1-johan@kernel.org>
References: <20260409120419.388546-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Fixes: cef9991e04ae ("spi: Add Amlogic SPISG driver")
Cc: stable@vger.kernel.org	# 6.17: b8db95529979
Cc: stable@vger.kernel.org	# 6.17
Cc: Sunny Luo <sunny.luo@amlogic.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-amlogic-spisg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amlogic-spisg.c b/drivers/spi/spi-amlogic-spisg.c
index da8ec35115da..19c5eba412ef 100644
--- a/drivers/spi/spi-amlogic-spisg.c
+++ b/drivers/spi/spi-amlogic-spisg.c
@@ -800,7 +800,7 @@ static int aml_spisg_probe(struct platform_device *pdev)
 		goto out_clk;
 	}
 
-	ret = devm_spi_register_controller(dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret) {
 		dev_err(&pdev->dev, "spi controller registration failed\n");
 		goto out_clk;
@@ -823,6 +823,8 @@ static void aml_spisg_remove(struct platform_device *pdev)
 {
 	struct spisg_device *spisg = platform_get_drvdata(pdev);
 
+	spi_unregister_controller(spisg->controller);
+
 	if (!pm_runtime_suspended(&pdev->dev)) {
 		pinctrl_pm_select_sleep_state(&spisg->pdev->dev);
 		clk_disable_unprepare(spisg->core);
-- 
2.52.0

