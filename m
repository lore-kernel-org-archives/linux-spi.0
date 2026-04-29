Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6903BE65C;
	Wed, 29 Apr 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454043; cv=none; b=i4HpVsu4QeK15J5opBa6tCD5PIM2cG+VxhNX+bsehs9NCgv+NEmc1zCwsUboC1udd1L/sdjuzvCtNsKokjN73XleY6cIuUiGgrRAQML+mMr5SpX3+YJwxnKbwAKB3ByDm5wdmml4Zmq1W6T9MuLoQykT9UnN3ey0OfWfUVKVwuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454043; c=relaxed/simple;
	bh=GBOkNya7C3m93sUpoy4neluaSRzF08Eexlb6b3hJqQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bX6tpFyhvMLkHb2bLrBM1Dr3hl3M95i13WFVytWRFkfJAuIdM8HXQEnRISxLPTL5g6qj2jls3B3FPZT8JhJLoKQpFIvXgEpBsdzLRAymYfnOtXO7j4PXaSb6d6WLB0IGX7h0md4zCgBMu9D0DO/PyE41ki3Ksmvl9gKecxzQffw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDNCV+8A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDNCV+8A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09580C2BCF5;
	Wed, 29 Apr 2026 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777454043;
	bh=GBOkNya7C3m93sUpoy4neluaSRzF08Eexlb6b3hJqQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iDNCV+8Adb7/UciiHTrl5Q7PuObBC4sH30C0h87Hkxt3+nvmsG96cPJ0EOMMfC0hi
	 +3Dk0osODl4yveBCHu3YsFCf3h02xQ8PO3hf9suTPzm0945zUPwTjzMlVlACk7JDU7
	 LS8BiRbAkvdMWBrLKYvTh9Jn45XenGey7UO1IJX7BnwSQk0f1/8GMKEGHLqaOhOrem
	 i4lcJgAyUNr+7qAl4F0OgztcEnfb5lBhpl2e6hT8tLGBjx7GkUu++gjHOT+yeMpDOY
	 arzw4v+n3Xc1yLjQAKNN3kDVcEIi+qs+F0wI+rTNdLAORQDbIDrjyM/L9pLZKDAT0B
	 i0QtDz+aF1lbA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wI0zY-00000000h2d-2KOf;
	Wed, 29 Apr 2026 11:14:00 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Radu Pirea <radu_nicolae.pirea@upb.ro>,
	Ryan Wanner <ryan.wanner@microchip.com>,
	William Zhang <william.zhang@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 11/19] spi: fsl: switch to managed controller allocation
Date: Wed, 29 Apr 2026 11:13:25 +0200
Message-ID: <20260429091333.165363-12-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429091333.165363-1-johan@kernel.org>
References: <20260429091333.165363-1-johan@kernel.org>
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
 drivers/spi/spi-fsl-spi.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 1252c41c206f..e45816ef7b65 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -535,7 +535,7 @@ static struct spi_controller *fsl_spi_probe(struct device *dev,
 	u32 regval;
 	int ret = 0;
 
-	host = spi_alloc_host(dev, sizeof(struct mpc8xxx_spi));
+	host = devm_spi_alloc_host(dev, sizeof(struct mpc8xxx_spi));
 	if (host == NULL) {
 		ret = -ENOMEM;
 		goto err;
@@ -559,7 +559,7 @@ static struct spi_controller *fsl_spi_probe(struct device *dev,
 
 	ret = fsl_spi_cpm_init(mpc8xxx_spi);
 	if (ret)
-		goto err_cpm_init;
+		goto err;
 
 	mpc8xxx_spi->reg_base = devm_ioremap_resource(dev, mem);
 	if (IS_ERR(mpc8xxx_spi->reg_base)) {
@@ -625,8 +625,6 @@ static struct spi_controller *fsl_spi_probe(struct device *dev,
 
 err_probe:
 	fsl_spi_cpm_free(mpc8xxx_spi);
-err_cpm_init:
-	spi_controller_put(host);
 err:
 	return ERR_PTR(ret);
 }
@@ -705,13 +703,9 @@ static void of_fsl_spi_remove(struct platform_device *ofdev)
 	struct spi_controller *host = platform_get_drvdata(ofdev);
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_controller_get_devdata(host);
 
-	spi_controller_get(host);
-
 	spi_unregister_controller(host);
 
 	fsl_spi_cpm_free(mpc8xxx_spi);
-
-	spi_controller_put(host);
 }
 
 static struct platform_driver of_fsl_spi_driver = {
@@ -757,13 +751,9 @@ static void plat_mpc8xxx_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_controller_get_devdata(host);
 
-	spi_controller_get(host);
-
 	spi_unregister_controller(host);
 
 	fsl_spi_cpm_free(mpc8xxx_spi);
-
-	spi_controller_put(host);
 }
 
 MODULE_ALIAS("platform:mpc8xxx_spi");
-- 
2.53.0

