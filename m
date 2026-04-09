Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAECF3B0AFC;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775736326; cv=none; b=WOY9v64BjOfrTKxckSOpf1AX/YmZzhwp5IyBOMs+L3BAwUSCZns8DlK2ixs6amJL8ZlNo0UwPs6HEWyV2lN9gqwSntGrrD8BK5MEVMptCotuhfWhc2NO+2aR4jjQ0V5iupfM02osfJPGgwLnLJwqA8ZuiNWJhUzi4HhwVZhKsxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775736326; c=relaxed/simple;
	bh=AzZOrde4AMVjVbEK+AIdwcR6ueHob3qjNZAqpCxP3c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUyEfCvZJabWJEXZ0nHPL45N+K/+Qap608YqO0AyYAEkBJYSXfcYn/diSpWJebSl11dyg9y+1uM/oJDBs/VfkqeFGpX2+kVK5CMt8nCWqx4pSROKezvx3qub7VhXw8/x3sYjQ5mwcQ+9OeBbgWPo9s4wfU8FD4W78tOofyR//+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzt5oRbx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzt5oRbx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A3BC2BCB2;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775736326;
	bh=AzZOrde4AMVjVbEK+AIdwcR6ueHob3qjNZAqpCxP3c4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gzt5oRbxamgpC+wzSeku4I4jGIn9D2mL0bDkhDLVeheMUVDg3fvAuJNIeBJijzxwl
	 pgZ24x8MZDmqaViIrLQ9lPjYtu+vt59XGdD4SABCuKq1pxFnoKpB1qxFNLAlU95kaB
	 vArALHtCrjoHAt4knON4Jr09M9YJwOzrTasiW6NintBalC296MXNaUfJ9akmUjR63h
	 LdxPA6i+awfMoJN4aEuWMrV45DSv8gZj8ZVH/VGIqkKQgGfNrgO/YUv6oLIq9sn7wS
	 Pja/MiNkfB1h3BTlMavX44Uy3TgP7GqgnsF5cvm0lJoHZlTCmTBWCE6rIReqZsx63C
	 p/oXbcOt4Y09Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wAo8R-00000001d6n-4AZR;
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
Subject: [PATCH 04/20] spi: atmel: fix controller deregistration
Date: Thu,  9 Apr 2026 14:04:03 +0200
Message-ID: <20260409120419.388546-5-johan@kernel.org>
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

Fixes: 754ce4f29937 ("[PATCH] SPI: atmel_spi driver")
Cc: stable@vger.kernel.org	# 2.6.21
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-atmel.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 445d645585bf..42db85d7ff8e 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1654,7 +1654,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret)
 		goto out_free_dma;
 
@@ -1688,8 +1688,12 @@ static void atmel_spi_remove(struct platform_device *pdev)
 	struct spi_controller	*host = platform_get_drvdata(pdev);
 	struct atmel_spi	*as = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
 	pm_runtime_get_sync(&pdev->dev);
 
+	spi_unregister_controller(host);
+
 	/* reset the hardware and block queue progress */
 	if (as->use_dma) {
 		atmel_spi_stop_dma(host);
@@ -1716,6 +1720,8 @@ static void atmel_spi_remove(struct platform_device *pdev)
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+
+	spi_controller_put(host);
 }
 
 static int atmel_spi_runtime_suspend(struct device *dev)
-- 
2.52.0

