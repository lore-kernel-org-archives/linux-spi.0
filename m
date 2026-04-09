Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B4C3B4E9D;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775736326; cv=none; b=YEXQtOkoZ4m20lbVKQMxoaN0wK3VcG8F/Af/8n7QfLTq4SsWbdZJDaZ36ZaWjZA3exqMSHGWqIiN/UhrA5KT09VFtmjmopeIN9N7joWJx46NQKvahY5zS9cW7hvTwas5iTz5PqnhTQfUmhKqq9S1nbu/YJeDhaEDRDWTiDQKejY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775736326; c=relaxed/simple;
	bh=TsKrseCE8mLUIQsrECcitJ2L+nu38MyChipfMhoSMOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pv5JSlYCBmBf+hAwSaAPEEQ5yR0Agp0znSvvaZ1KSSdSwZreaMjo3c/j1YFUS4/ni8ejAKTky+JlyR5cTZt4c1jj4pkh5K147EKUkXOaZT4SMeycubnr3CQZHibAhpV9BODBgD8YiOPOcZGWfGtOPQbrLMesRcjyw1Voi5AyW+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGaN0CQQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGaN0CQQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D19C2BCB3;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775736326;
	bh=TsKrseCE8mLUIQsrECcitJ2L+nu38MyChipfMhoSMOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QGaN0CQQXNwmdSD1KyQkWUponEIJFNeBZJUmhVp+bCLSNGyqna1yPS5c2NgzkgRid
	 P+eOqk3iUt6pbo8zpltuvuqSXJvmP/bredOXvkWXztdUeZI3WpWolHpCYXf84f37E2
	 +hWg+7Gjlq9nBBDsTZyRAWfUkK1WPjD/tVupI6rzR5TZ0syY9CAGY2gQhQgt8I+MqV
	 p9k5f/1qGz2E6HUgFTEsMjig2tgeNsEUQHpeMouaefdQUB3kEDJAeBuaNhApUciYPC
	 PMRkSLvyWC4fGweKUIv/8dtbALKJ2fvR83tQUzsro+DfTuSjOI7eWnda0PgwydQVHU
	 xrVEf28n+ppJw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wAo8S-00000001d6r-03Hy;
	Thu, 09 Apr 2026 14:05:24 +0200
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
Subject: [PATCH 06/20] spi: bcm63xx-hsspi: fix controller deregistration
Date: Thu,  9 Apr 2026 14:04:05 +0200
Message-ID: <20260409120419.388546-7-johan@kernel.org>
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
resources like interrupts during driver unbind to allow SPI drivers to
do I/O during deregistration.

Note that clocks were also disabled before the recent commit
e532e21a246d ("spi: bcm63xx-hsspi: Simplify clock handling with
devm_clk_get_enabled()").

Fixes: 7d255695804f ("spi/bcm63xx-hsspi: use devm_register_master()")
Cc: stable@vger.kernel.org	# 3.14
Cc: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 266eabd3715b..e935e8ab9cfd 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -857,7 +857,7 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	}
 
 	/* register and we are done */
-	ret = devm_spi_register_controller(dev, host);
+	ret = spi_register_controller(host);
 	if (ret)
 		goto out_sysgroup_disable;
 
@@ -880,9 +880,15 @@ static void bcm63xx_hsspi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	/* reset the hardware and block queue progress */
 	__raw_writel(0, bs->regs + HSSPI_INT_MASK_REG);
 	sysfs_remove_group(&pdev->dev.kobj, &bcm63xx_hsspi_group);
+
+	spi_controller_put(host);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.52.0

