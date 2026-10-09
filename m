Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7160F4CA279;
	Fri,  9 Oct 2026 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544587; cv=pass; b=ow5vd5ib+WL5Djy7cXgzQ3qFTA1gP55mk/P5QxNcKCM0gXQ8Xb1Iobhu//AR1wnk+rgPHLdMwReAAMgppYWb9DYcx3MAMmXqaVvU5GL1z+XX2BVE1MDN5lblv6TLqqfKOfkgePRCtot3yF4OcfTrEJkyFchT375InQJINkqhv5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544587; c=relaxed/simple;
	bh=nr3WgYA3wEgw6T9d5UG+JnB8YU98wXc8clf5NFECUiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pjw+zXSCfIaxI8Qg6UFfAF5qD0eKkO9GIRyd/mQLeJyBHrlc+i65feVRE9lUX+MjUJXh0CE/S8q2OCZAtqWWs3y5lrPZoWIj8jkujniyAcOxZJJ2Rj878GLsSksPfnZmmnb2fnXm4soS3Q3rA3FqDrlnMnZE0GDnnOmlu18ZYRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=XPw205Yx; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="XPw205Yx"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E8FAB202601;
	Fri, 09 Oct 2026 13:16:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791544562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wb5AURV6OQnJ+6bsCo4q3udRoo0e+/xbs0dDLLrfLKU=;
	b=XPw205YxcwsEwodUkKtRmLRLIn/IfJDYTnaZk3Aien0znFTU5GnjGLzR2xaSkkb7p0LXFd
	6fCaxudVR+W+Wt2o3wZBFtXRwGsGQ7pP3WwbI3umEiGI/vncX1JAwvH8BPSu2k1/T8my+w
	xEKlmoJf/XElMMruT//KeZ206uBfpoegyCATqiIX0nbW+1JYcda4WDM/51eoh7EyRScGLv
	ESyW63IWMcRJebhainlRm8bdw1P/LVOY6i2qxbWFdYmMKMetXsWZtJp2+kxqHI0Nz20EfG
	CT/exPLvnqjR/IAniGVKu8vgm0kFAKqNYzxVeON7Oh1AlLWDeoApjycZjwk32g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791544562; a=rsa-sha256;
	cv=none;
	b=DnAYcl1HhztTQ/DaorxFH5n2UbXVQtNoOj+1ENwlriHiYrtFWqQoeUYif2q1pJvia6VIYC
	qKLF6CBAY3MLAv8sOoAXDH5dgE4MIs890bBpbpEXlfyNwPPiJzArS+xHWr30/EUSYAUwWK
	6+qEsqcrcksQnUel7nIILaxZ/XKY9X2SMizOm8egBj42EJJf+Z9WJHJsWcqN3DBPzrP0Y2
	emFcqCqAi/s0ljGe/Opf1ZVm/dcvZkONX7a708FAzeWv51sVrMihOw5ng5W5dKfagse6v8
	OJ5rxyHwq+7fyfZPbJxntI9sRHKugSv8s8T8YLcDJRCOBrCnVsYEhko9ynAArA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791544562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wb5AURV6OQnJ+6bsCo4q3udRoo0e+/xbs0dDLLrfLKU=;
	b=MIcmz5HWNehzSTmkNr0VlsjiFObbZ7uKIqgG8fMYaSi5heJoB7mgyMEU+uGC2YpNsEFOFM
	I1xIovXX57o6pp5GUN+ou5cCwkMtCTierNO29XA6AAYmpy7pMs/iOLffXMR8QEDxN/S5Ns
	QEclslYG5RpkRomIL7dc4+t6Z/j6r4hWd6c3OJHliqSz1DiZ+EA5y7bjfIayTI8dwSD//q
	GBvP/KVPrz/VQK43fyII/ETbSa0rtxbrZopMTkmA34Q1bQOs+ECSPpTo2tLCzLIP9jJNhK
	SGtEGRca5Sz1/3tviI4kRxEr8yy+aSLc5eS43P94CGgHSVktGg4ksQSUVS98lw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xF8a2-0052MG-2g;
	Fri, 09 Oct 2026 13:16:02 +0200
Received: from hardanger.blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B58C15BD5DD;
	Fri, 09 Oct 2026 10:16:42 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 09 Oct 2026 12:16:37 +0200
Subject: [PATCH spi-next 3/3] spi: spi-fsl-lpspi: cache content of
 Interrupt Enable Register (IER)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-spi-fsl-lpspi-more-cleanups-v1-3-2d4549d5205e@pengutronix.de>
References: <20261009-spi-fsl-lpspi-more-cleanups-v1-0-2d4549d5205e@pengutronix.de>
In-Reply-To: <20261009-spi-fsl-lpspi-more-cleanups-v1-0-2d4549d5205e@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de, linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1927; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=nr3WgYA3wEgw6T9d5UG+JnB8YU98wXc8clf5NFECUiM=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsg6sZ9D54XMYqc5seUPk/x9Vz+tXbP0xFe/GZv8JdN6T
 pnkLUup6ChlYRDjYpAVU2RZ+uOEokCgQ2nvy4RJMHNYmUCGMHBxCsBEZoYy/PfYcFimuuql/rEc
 /Rl6asG/ed59LuCv3cjK/K0zerre4ghGhrufHm2xXnVv+aIZN79/CpeZ8blB3lNWfCLDqmMtB04
 xXuEHAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

To improve performance avoid reading the Interrupt Enable Register (IER)
from the hardware, cache in struct fsl_lpspi_data::reg_ier.

Introduce struct fsl_lpspi_data::reg_ier, to cache the current value.
Extend fsl_lpspi_intctrl() to update the cache and replace the open coded
writing of the IRQ register in fsl_lpspi_prepare_message() with
fsl_lpspi_intctrl().

In fsl_lpspi_isr() don't read the IER from the hardware, but use the cached
value from struct fsl_lpspi_data::reg_ier.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-fsl-lpspi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index b25f94b2ef73..5b158b0cb5af 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -122,6 +122,7 @@ struct fsl_lpspi_data {
 	void (*rx)(struct fsl_lpspi_data *fsl_lpspi);
 
 	u32 remain;
+	u32 reg_ier;
 	u8 watermark;
 	u8 txfifosize;
 	u8 rxfifosize;
@@ -199,6 +200,7 @@ LPSPI_BUF_TX(u32)
 static void fsl_lpspi_intctrl(struct fsl_lpspi_data *fsl_lpspi,
 			      unsigned int enable)
 {
+	fsl_lpspi->reg_ier = enable;
 	writel(enable, fsl_lpspi->base + IMX7ULP_IER);
 }
 
@@ -525,7 +527,7 @@ static int fsl_lpspi_prepare_message(struct spi_controller *controller,
 	fsl_lpspi_set_cmd(fsl_lpspi);
 
 	/* No IRQs */
-	writel(0, fsl_lpspi->base + IMX7ULP_IER);
+	fsl_lpspi_intctrl(fsl_lpspi, 0);
 
 	/* Controller disable, clear FIFOs, clear status */
 	writel(CR_RRF | CR_RTF, fsl_lpspi->base + IMX7ULP_CR);
@@ -808,7 +810,7 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
 	u32 temp_SR, temp_IER;
 	struct fsl_lpspi_data *fsl_lpspi = dev_id;
 
-	temp_IER = readl(fsl_lpspi->base + IMX7ULP_IER);
+	temp_IER = fsl_lpspi->reg_ier;
 	fsl_lpspi_intctrl(fsl_lpspi, 0);
 	temp_SR = readl(fsl_lpspi->base + IMX7ULP_SR);
 

-- 
2.53.0

