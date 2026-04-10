Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045DE33E368;
	Fri, 10 Apr 2026 06:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775803709; cv=none; b=QGBFtbMr/rwKTEuoNfIeItFLlNQDzlVbYzRn8aHOkHrcFp1FfH4lsi4xo1iuiuFMQIDzmenes03UWSFSc45Td/nJXa526E2l/OelJGwFIFPg5x2aXzjmfKb+Y+7pb3SSYuHhFZhCrT/cHCOsVy80AE8lP/1I708WjENFpyF+G0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775803709; c=relaxed/simple;
	bh=zI27ErMD3HrjmKrsQfoiTPAfZGa7KsVSFhAwDBbp+hU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iy9ULsUSZlqvBW4SNbrmDxe741HZp9ajym7qa84jSYBpbe6sCDuY/syDdub5JkidqSXicvh0+p0D0rtVcXksTgyVmhavKr414AJZadPvHbeMP9ozk0Di1XG6QDnp0+yE+fRd7LFoQcSOBf5edbxxkOWAdt43BXqcPspakvkEADg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzX2bA8k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzX2bA8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EBAC19421;
	Fri, 10 Apr 2026 06:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775803708;
	bh=zI27ErMD3HrjmKrsQfoiTPAfZGa7KsVSFhAwDBbp+hU=;
	h=From:To:Cc:Subject:Date:From;
	b=XzX2bA8kkRol+sHKs0ptATewHGtj6GonWKzHHvbzRxFpRhBEksKSzKiGatP4pTiWQ
	 aWE2y4D5DTYkEJclSjb6xeAepbtkdoxfn6JKI0UR/+sV420r9i8us8GXkG0SavCgYL
	 4NwD1YFMTY/7Y7h8iT6Md1qh+l8+OYsBiVUGDPKkwZE6SKmo5O5MYSR/k8OX1Ljxny
	 EBejjvJ76kLg1jYgCQTTfKesGHtx5QqAsPprwqQFxSwKfQXHmzQjRzKUewGwNxShBK
	 4HTKf7JSotJbJQJWtuiUrC/67x/u7APca1DugLtA8oHbsZQG064FgNspDhTgw6rZJJ
	 9nNKe+RA2lA3Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wB5fG-000000025H9-0Z5o;
	Fri, 10 Apr 2026 08:48:26 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2] spi: fsl: fix controller deregistration
Date: Fri, 10 Apr 2026 08:47:49 +0200
Message-ID: <20260410064749.496888-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to deregister the controller before releasing underlying
resources like DMA during driver unbind.

Fixes: 4178b6b1b595 ("spi: fsl-(e)spi: migrate to using devm_ functions to simplify cleanup")
Cc: stable@vger.kernel.org	# 4.3
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---

Changes in v2:
 - add missing deregistration in of_fsl_spi_remove()


 drivers/spi/spi-fsl-spi.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index bf3fc3ce0cc2..1252c41c206f 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -614,7 +614,7 @@ static struct spi_controller *fsl_spi_probe(struct device *dev,
 
 	mpc8xxx_spi_write_reg(&reg_base->mode, regval);
 
-	ret = devm_spi_register_controller(dev, host);
+	ret = spi_register_controller(host);
 	if (ret < 0)
 		goto err_probe;
 
@@ -705,7 +705,13 @@ static void of_fsl_spi_remove(struct platform_device *ofdev)
 	struct spi_controller *host = platform_get_drvdata(ofdev);
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	fsl_spi_cpm_free(mpc8xxx_spi);
+
+	spi_controller_put(host);
 }
 
 static struct platform_driver of_fsl_spi_driver = {
@@ -751,7 +757,13 @@ static void plat_mpc8xxx_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	fsl_spi_cpm_free(mpc8xxx_spi);
+
+	spi_controller_put(host);
 }
 
 MODULE_ALIAS("platform:mpc8xxx_spi");
-- 
2.52.0

