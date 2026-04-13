Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326153B6BE8
	for <linux-spi@vger.kernel.org>; Mon, 13 Apr 2026 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776074532; cv=none; b=OZF1nCbP3O9x3nSz0hwf4KTaiD6qMUTNRd1Ix+nX8bMZrN8VJzTWCBWPGD3kJkRV1/G12DVzoe4L8qy7YAND2tveIBcBiK/SQPwUgcBTw1VzQSlHIgzSfHUauCQvW/gVFYMahkGhI1RBlyOn2wAhgpDGmLZNVV7aPDHA9AVLVLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776074532; c=relaxed/simple;
	bh=A9NrOmrGg9D5qQPIJd3OHlgLpJRhg3BN4oaCn3ZDTsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIsKoDln4wb8+dAQhsMDo1DqYizTmcHKLMUj+OLI7LVinChf9YmCMvubx5EWRZqd9p4J79Md938wS8fnfsxAC0IgZaHqZDtC7u+c82EPOhnCA/YYvKwMnPumvl5mUU1LBGbN+sJJfApzxcY9dRAiD39PR00FjnOVgDKO+pJ7tYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3kX2vjP; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3kX2vjP"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-670f6ae9c7dso2012657a12.2
        for <linux-spi@vger.kernel.org>; Mon, 13 Apr 2026 03:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776074529; x=1776679329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bb0Cl07VkZM2TjR90yXu/+DWSboJw3nu1/V+vc9DpAw=;
        b=i3kX2vjPqb4dw2+yAD4LxUj6eqG1EuespiNOYx1WENBZZztTSacSLSiElfCOGODasX
         Lo91jrhYIY/skHDrURRZYcprRJwDyhOWSE233WjwuaauvQwfPCluWUfc3h0LBXW2C+rj
         El17rvvx5gzylZ5rb6g5mQami595mSqEgMhwlwojtN3b08uOS/A7NypXNLMAbGjGhk72
         nazmzQfuAIFm4UGTzakNXCk4sHIDUld3MtLZRQyf8ujCw5du2IKOpApmIX8dtRQN+BGh
         fINtCCnweDl9gcGxwGc3bZFXSLDUi6F8P/WLCeylP6AaaNty7HM6BZLUJm6s5H3Yo7fM
         4QVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776074529; x=1776679329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bb0Cl07VkZM2TjR90yXu/+DWSboJw3nu1/V+vc9DpAw=;
        b=F7GAL0tyJzSnNekPsgpK6DqIsPiqBsc90WhHZ6l5ydTHo2aHJyBGAgnmCVNRi2XdRV
         jKbtUN5s2eEsI/xOUjl14RXaWTdvwwGd2e0G8/KVjkE1IwuWxPHaxyLriiJxyz9w9ZMy
         JBC5YD6ppWuNqjY570S7d840ey0P3PadkYZWrZhwbnMFUu3z2ZGqBkGRtyuoHluXonHY
         ADO9BcTO1Q6h0A/BdqsmtE3pcJ79u7tOAWVYjHHyxmNYLptp8Fg20C119gA1tDCqpgqI
         J7OvWK2qOR+8rhOB8RZpvYrgnzSgL6PXxdCiqyuBb2hVGtvXTKoKYF2zq7Jwsf95V5bB
         kolA==
X-Forwarded-Encrypted: i=1; AFNElJ/yqAZAHBP08UQaLCuMcmd8TKva9SFCziZTZkyszjyNUO8jEvEP8+T6bRsYEK28/EtP6c7oeWNvD6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYQUca/Pt6KAG/G6AcVL8Rl43A8VaLMyrODcPgNNLXg3pQ00Ol
	BP4vNcV1NoDi5+MCynkOgYaMY545Myct09LpUPWSEjUC9aJPiCi0dSb4
X-Gm-Gg: AeBDiev+zwi26iyXyoQNNgkx/rzoS8dIp4+EmRYVUJBXiemiFTB5NB/4jFfK8dMJlz6
	V86uc0tcILYufNY2aF4ytHo0W8TDvlt7E/PUS/kMko+a70kpUjFdVQV8pkCv6V91rfNkONmjxeH
	rik7G1BxOHVPESE/symwb2TLTLidx8cjQGyTPke1thYu5b3Lh6160tLMFS1UBu3maF/XbxHpkBe
	Ge0OQlwyx1El/VvyGE0pZ9hT7GUEHHip62jHTcmY2dRxPz/2M/Qp9PCVOZ7H0kPseZDkFyIS3qG
	dDBQYYqcwi0D/kU+UCpATaW8UymKxc6sbOoBQvitjZG9JAkQ71/9p10Lbwlfii1Eu4G4zMTJqnp
	UwrPK5qQmXCvk7jWcom1LgwaxaOM5bdParcz2G5GaY2nncJDBgKKw6YgoQ768q1dqH4B8iECKe9
	w6YUiyW8fa/jNelioo9kh82g==
X-Received: by 2002:a17:907:a2c5:b0:b97:1009:7536 with SMTP id a640c23a62f3a-b9d72792d3amr700806166b.15.1776074529018;
        Mon, 13 Apr 2026 03:02:09 -0700 (PDT)
Received: from khalil-hp.home ([62.250.67.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e7f189esm291993566b.58.2026.04.13.03.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 03:02:06 -0700 (PDT)
From: Khalil <khalilst@gmail.com>
X-Google-Original-From: Khalil <khalil@rentman.nl>
To: broonie@kernel.org,
	hdegoede@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: rf@opensource.cirrus.com,
	linux-spi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khalil <khalil@rentman.nl>,
	Khalil <khalilst@gmail.com>
Subject: [PATCH v2 3/3] spi: pxa2xx: Handle clock gating for GPIO chip select devices
Date: Mon, 13 Apr 2026 12:01:40 +0200
Message-ID: <20260413100140.579845-4-khalil@rentman.nl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413100140.579845-1-khalil@rentman.nl>
References: <20260413100140.579845-1-khalil@rentman.nl>
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

