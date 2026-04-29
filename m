Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB9D3BED18;
	Wed, 29 Apr 2026 09:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454471; cv=none; b=iCm8mkPjpwfNFJxnSftJXHAFMEBR2xFtCVHojWJi505df8q2IwZ+j02KxXe+RDkHhpIv4M893GTHmlL6JJHELnYT/5kA5mnzm2dV70D7DGO5soiRkjthIACC+H7Q7KIRg5SMbK/9RLe6lPCQc2jEZYVGlkCvzhOd7LIKIJbgop0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454471; c=relaxed/simple;
	bh=UZoIuQtiP7uojx35wmjj8kbuysnIWA5mMNqxjvryBHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vx/iNwcBVpNgmYgC+N97mmdYEWUvmvQ2rwUyrjCpQPAPzEBZJU4TVhX8jTpowshlHBEwIZVQyVYQpfIumN/FI9MYpsAxmpaU6vhULJb9OQDk0vZf6AQHa7wLD4Kgl39zXde6yQul1QS4M8mkgbe2I9xLc5++bh1iK9INhYG85Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXRi8fdE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXRi8fdE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6333C19425;
	Wed, 29 Apr 2026 09:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777454470;
	bh=UZoIuQtiP7uojx35wmjj8kbuysnIWA5mMNqxjvryBHw=;
	h=From:To:Cc:Subject:Date:From;
	b=sXRi8fdEqHKtrbSwAIc7GSNUJFUQLaMYLIHs09bR35dxwAmOmCwUxN7tV8ORa/ZUo
	 wXIkxUyJRObY38QuVvyaJx+K/EUQGKuAIGt3Ewvtb5X1OhO0X2a6PASwSc7ZN4S4wm
	 X0OA1DVLVH9hPMrbhLd2sE666dpvKUTnAQD36yE88FPAZJUNkxdPK05yG0vWlGOfXn
	 0jJan9je52OmOq3f5hQfLbuvsYpSY2jTzXxusqg/fQAsltrdwRPYHTiWfC4dvOmiQv
	 FnrUc4G0nNi7RZLcgZLF/t8Rf/9NHKwfFL9uIkEubV/MwQfNYydgp4aS65VDxUhNwZ
	 X4/pR7fM1NfOg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wI16S-00000000hEW-25sx;
	Wed, 29 Apr 2026 11:21:08 +0200
From: Johan Hovold <johan@kernel.org>
To: Radu Pirea <radu_nicolae.pirea@upb.ro>,
	Mark Brown <broonie@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] spi: at91-usart: drop dead runtime pm support
Date: Wed, 29 Apr 2026 11:20:05 +0200
Message-ID: <20260429092005.166128-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the dead runtime PM support which has never been enabled.

Fixes: 96ed3ecde2c0 ("spi: at91-usart: add power management support")
Cc: Radu Pirea <radu_nicolae.pirea@upb.ro>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-at91-usart.c | 39 ++++++++----------------------------
 1 file changed, 8 insertions(+), 31 deletions(-)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index 32fee5a7ffdf..77cad4118202 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -16,7 +16,6 @@
 #include <linux/gpio/consumer.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
 
 #include <linux/spi/spi.h>
 
@@ -572,38 +571,18 @@ static int at91_usart_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-__maybe_unused static int at91_usart_spi_runtime_suspend(struct device *dev)
-{
-	struct spi_controller *ctlr = dev_get_drvdata(dev);
-	struct at91_usart_spi *aus = spi_controller_get_devdata(ctlr);
-
-	clk_disable_unprepare(aus->clk);
-	pinctrl_pm_select_sleep_state(dev);
-
-	return 0;
-}
-
-__maybe_unused static int at91_usart_spi_runtime_resume(struct device *dev)
-{
-	struct spi_controller *ctrl = dev_get_drvdata(dev);
-	struct at91_usart_spi *aus = spi_controller_get_devdata(ctrl);
-
-	pinctrl_pm_select_default_state(dev);
-
-	return clk_prepare_enable(aus->clk);
-}
-
 __maybe_unused static int at91_usart_spi_suspend(struct device *dev)
 {
 	struct spi_controller *ctrl = dev_get_drvdata(dev);
+	struct at91_usart_spi *aus = spi_controller_get_devdata(ctrl);
 	int ret;
 
 	ret = spi_controller_suspend(ctrl);
 	if (ret)
 		return ret;
 
-	if (!pm_runtime_suspended(dev))
-		at91_usart_spi_runtime_suspend(dev);
+	clk_disable_unprepare(aus->clk);
+	pinctrl_pm_select_sleep_state(dev);
 
 	return 0;
 }
@@ -614,11 +593,11 @@ __maybe_unused static int at91_usart_spi_resume(struct device *dev)
 	struct at91_usart_spi *aus = spi_controller_get_devdata(ctrl);
 	int ret;
 
-	if (!pm_runtime_suspended(dev)) {
-		ret = at91_usart_spi_runtime_resume(dev);
-		if (ret)
-			return ret;
-	}
+	pinctrl_pm_select_default_state(dev);
+
+	ret = clk_prepare_enable(aus->clk);
+	if (ret)
+		return ret;
 
 	at91_usart_spi_init(aus);
 
@@ -638,8 +617,6 @@ static void at91_usart_spi_remove(struct platform_device *pdev)
 
 static const struct dev_pm_ops at91_usart_spi_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(at91_usart_spi_suspend, at91_usart_spi_resume)
-	SET_RUNTIME_PM_OPS(at91_usart_spi_runtime_suspend,
-			   at91_usart_spi_runtime_resume, NULL)
 };
 
 static struct platform_driver at91_usart_spi_driver = {
-- 
2.53.0

