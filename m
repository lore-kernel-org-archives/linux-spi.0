Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270862ED84C
	for <linux-spi@vger.kernel.org>; Sun, 12 Apr 2026 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776011542; cv=none; b=ArCpmCPjqhi3J4+4bHIssdBHajW3olzt8+AR+rG5A7qBCGwoPEpg57PBYcSiQSqtTVOG2eZBjC40Mkuln0gCfrCtwK6AiLixYyAcIBiqx2kXnFTtIeap/WglNQaiQiwKHVx1nvPM4l0bq9FMisoWifoihUdMkzQYKNYtdg9DE8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776011542; c=relaxed/simple;
	bh=A9NrOmrGg9D5qQPIJd3OHlgLpJRhg3BN4oaCn3ZDTsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUJcXJ1A12Lako+lJc8OWT+gFQcUgywKWil4lahBvmtkz8vQXtmPSNezgGmenrfXjooCG1gHSrG2D6I7gb81P5BPT5rBOvD6nxYt0pOzds5AI0F2uiipjam58AchxrQ1GGnLoyN5tupKvcVzFozZdxTbYRZs68NmVSZ46EbDxxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWdieLq3; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWdieLq3"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b97f9587e6eso476041166b.3
        for <linux-spi@vger.kernel.org>; Sun, 12 Apr 2026 09:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776011539; x=1776616339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bb0Cl07VkZM2TjR90yXu/+DWSboJw3nu1/V+vc9DpAw=;
        b=HWdieLq3FjGDVhne0yX7HcGi5NK+CKOtbSKa/lG5AU/ee0fYf7sdRBA/hW1t22mQBw
         ryr9dv9+YbhN2q7qMZHVv1tgaebLfPgnppXpMOs9M1evZ12TG1F9OOOebzqNumAlvasL
         cosJzquotaCabhO3rAnv/NFNpFS+JhmPbOhFz+2ftFrXjf4cyfWpKDMj1h7rTi+W6iX8
         enOrBH/pOighuPt9VKHU1Joce4nhFZH1du//oeTZRdjGtrwvJ4yDlLryGBxAUfPvd32g
         5irjQiYETany6eforh9+XUNnutaA5/q3+SqzuVa8O+XidEm5RD1/+/ku3lVdL3wZzl6G
         VsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776011539; x=1776616339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bb0Cl07VkZM2TjR90yXu/+DWSboJw3nu1/V+vc9DpAw=;
        b=h41CshDreRl8vWZvoupegEg7TI/15nr2GM5hseqRJsSgca1612WzFC6jfYLc0aFJ/V
         C+HjGWEYziDK69ue2hXYmUlUQ/nFOt1GOnl+ZwAmug+AY4PlG0dyw8BSn+oKgcIn1Ger
         73C1pbKy6dvkUbxgUeLedbiimjlUKrHddKG9BfHti/ARQp2xEaWVv3/Yvgz4V93j9o0b
         sS63KnRjN1cCNbjRjUQVMgoIAzZSRO2CpobdZAMImJepd72oDVnxV1rc+19M1LY/VUiA
         j7L8bIPIr2o8QDY5LJtkMYWkf/XVl2MydqSHxXR71+ThoSaFO6zuwX5UXYGGIZGS6c2f
         46yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzEb7g2Io+CRwrKJxnJTOl/8co3vPe3u5YFZAu22xFaaYYEv+7o96i9C381/adsRWtt71M+jespQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzXANwd7/GhLy95APTu07LqpCPbIMKGxe8EgcrMKEENYXFN5Qy
	GBMgxRe9ZeQwAf15+fi3ST4eH1a0zBcHdeLxZTODAOxDsrihEtHEwQoX
X-Gm-Gg: AeBDievwwGvqLnLBwLFPlI1Q1MbuDaJIGAOqCyUeikf6AlfVlj2/QOt6Vd2MCV6dyaI
	QmGvurePd3Kq8B/KegUaTNari4UlAUqA6gj8dQsq7OAZlQgP7vFzHJtbK3DaxQBBPF86SfPGis7
	qO7lq/kulSY+z7SPxb7/7zlpcXBeRZ9p06u+o0CaxTzddnmFPt1gHta8ymbY7klteWbef3Ry7/n
	CGNkKPW9AQWmwxqCrN4/Mrj4p5dLrhcFz8pn972C5g2PJQx4OWsyEoD8mfGcC6tVcX2S3s4Hd7D
	hhchcshp4L0rv6k0jS9apwFUQ2LSThJR4DmnDl6lNdy/sG/PSap15ARlLht/wWSlfdIyHSaVES9
	szFBCViqdfwPDbI62gV+lN1AoZDdZe2UZvWJKaHd6AidDbuoqSQmmgjIhKfE2iB+1TraUb2RXzm
	YV3NomLIYtrKImqMdAAnyGHJ20dx2ZmSUr
X-Received: by 2002:a17:907:a646:b0:b9b:e5d:71de with SMTP id a640c23a62f3a-b9d72833620mr561255566b.49.1776011539215;
        Sun, 12 Apr 2026 09:32:19 -0700 (PDT)
Received: from khalil-hp.home ([62.250.67.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e7f1a3bsm236468666b.62.2026.04.12.09.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 09:32:18 -0700 (PDT)
From: Khalil <khalilst@gmail.com>
X-Google-Original-From: Khalil <khalil@rentman.nl>
To: broonie@kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: rf@opensource.cirrus.com,
	linux-spi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khalil <khalil@rentman.nl>,
	Khalil <khalilst@gmail.com>
Subject: [PATCH 3/3] spi: pxa2xx: Handle clock gating for GPIO chip select devices
Date: Sun, 12 Apr 2026 18:31:51 +0200
Message-ID: <20260412163151.506282-4-khalil@rentman.nl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412163151.506282-1-khalil@rentman.nl>
References: <20260215135524.1171065-2-khalil@rentman.nl>
 <20260412163151.506282-1-khalil@rentman.nl>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Intel LPSS SPI controllers (Cannon Lake and later) with dynamic
clock gating (cs_clk_stays_gated=true), the SPI clock is gated when
no native chip select is asserted. When using a GPIO chip select
(via SPI_CONTROLLER_GPIO_SS), the SPI framework toggles the GPIO
and also calls the controller's set_cs callback.

Handle this in the pxa2xx cs_assert/cs_deassert functions: when the
device uses a GPIO chip select on an LPSS controller, assert native
CS in the control register to enable the clock, and force the clock
gate on. On deassert, restore both.

This is needed on platforms where serial-multi-instantiate installs
a GPIO chip select from the peripheral's ACPI GpioIo resource to
work around an incomplete cs-gpios property on the SPI controller.

Signed-off-by: Khalil <khalilst@gmail.com>
---
 drivers/spi/spi-pxa2xx.c | 45 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 6291d7c2e..fe5762063 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -419,20 +419,43 @@ static void cs_assert(struct spi_device *spi)
 {
 	struct driver_data *drv_data =
 		spi_controller_get_devdata(spi->controller);
+	const struct lpss_config *config;
 
 	if (drv_data->ssp_type == CE4100_SSP) {
 		pxa2xx_spi_write(drv_data, SSSR, spi_get_chipselect(spi, 0));
 		return;
 	}
 
-	if (is_lpss_ssp(drv_data))
-		lpss_ssp_cs_control(spi, true);
+	if (is_lpss_ssp(drv_data)) {
+		config = lpss_get_config(drv_data);
+
+		if (spi_is_csgpiod(spi)) {
+			/*
+			 * GPIO handles the actual chip select to the device.
+			 * On LPSS controllers with dynamic clock gating, the
+			 * SPI clock won't run unless the native CS state says
+			 * "asserted" in the CS control register. Assert native
+			 * CS in the register to enable the clock, and force
+			 * the clock gate on.
+			 */
+			lpss_ssp_cs_control(spi, true);
+			if (config->cs_clk_stays_gated) {
+				__lpss_ssp_update_priv(drv_data,
+					LPSS_PRIV_CLOCK_GATE,
+					LPSS_PRIV_CLOCK_GATE_CLK_CTL_MASK,
+					LPSS_PRIV_CLOCK_GATE_CLK_CTL_FORCE_ON);
+			}
+		} else {
+			lpss_ssp_cs_control(spi, true);
+		}
+	}
 }
 
 static void cs_deassert(struct spi_device *spi)
 {
 	struct driver_data *drv_data =
 		spi_controller_get_devdata(spi->controller);
+	const struct lpss_config *config;
 	unsigned long timeout;
 
 	if (drv_data->ssp_type == CE4100_SSP)
@@ -444,8 +467,22 @@ static void cs_deassert(struct spi_device *spi)
 	       !time_after(jiffies, timeout))
 		cpu_relax();
 
-	if (is_lpss_ssp(drv_data))
-		lpss_ssp_cs_control(spi, false);
+	if (is_lpss_ssp(drv_data)) {
+		config = lpss_get_config(drv_data);
+
+		if (spi_is_csgpiod(spi)) {
+			/* Deassert native CS and restore clock gating */
+			lpss_ssp_cs_control(spi, false);
+			if (config->cs_clk_stays_gated) {
+				__lpss_ssp_update_priv(drv_data,
+					LPSS_PRIV_CLOCK_GATE,
+					LPSS_PRIV_CLOCK_GATE_CLK_CTL_MASK,
+					LPSS_PRIV_CLOCK_GATE_CLK_CTL_FORCE_OFF);
+			}
+		} else {
+			lpss_ssp_cs_control(spi, false);
+		}
+	}
 }
 
 static void pxa2xx_spi_set_cs(struct spi_device *spi, bool level)
-- 
2.43.0

