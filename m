Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0741E391E59;
	Mon, 23 Mar 2026 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263001; cv=none; b=Wt8xhLo/pj7XKsCF00gMZky0dB/Fve2dfURv+lZGTfpGuYE22hZg1ABoWTqw3LPHyeO0tJe2GC3g6JTf9ED2nzg6pWKqonUYPQ2nWAfPJbLtR9elhPJEbfB/o0RbbXM//oHgEylejZz1Nhj9wAYHmKDtMUt9Th+zp5WHI1W3HPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263001; c=relaxed/simple;
	bh=9avy4ppcCMDrHoZeH18htD8v/8YlfQK+8sJuE3Atbi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=peNIfJGslIWZWaIHIPJ5q7bLpQKj+Eh0N6S7YHapit1alwAVHezBDVvlaKt/SRaGccSEiVtl2n7wxCm6gjnepKZsi4atKS5e3RByicrXexmineEVg20hqTrtk9Sj9fBpFypFty8tQxmhzE4k8UeLVHcphio24SlCG23Zzbc6urY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBD9doG8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBD9doG8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6611C2BCB1;
	Mon, 23 Mar 2026 10:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774263000;
	bh=9avy4ppcCMDrHoZeH18htD8v/8YlfQK+8sJuE3Atbi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vBD9doG8Leh8/XOcKN0Fs1G+v1URxOZ+AoEgTfedTBTqoTWEo8xR679NKG4vAomz/
	 +xoA92izB3krfn4G6xQItIzThkEUsGN66Rs3ii+MTmUUQ8lyBNLR7PcF353QzIhuHO
	 SQVhSxu+Y0mFD2RANyj9vbonSJZIJYdysRlcSNcBgNz0DsM0lSmGZRWWZ65nsRgzuP
	 jjzr8cCyBguVsyh5ryIwDWGVlnBF0WmB/dhnE1T474A7sXThmQKNUkqasdsFnpj1/6
	 MwNbqJL5UBN18+njL6pXocy71ZMlbRCHU35o9rDOi0YmP8oih1u4rmBFJ7n0oWrnLl
	 batCdJAVNocbw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w4cr8-00000003Xis-1dus;
	Mon, 23 Mar 2026 11:49:58 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/5] spi: rockchip: fix controller deregistration
Date: Mon, 23 Mar 2026 11:49:47 +0100
Message-ID: <20260323104948.844583-5-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260323104948.844583-1-johan@kernel.org>
References: <20260323104948.844583-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to deregister the controller before freeing underlying
resources like DMA channels during driver unbind.

Fixes: 64e36824b32b ("spi/rockchip: add driver for Rockchip RK3xxx SoCs integrated SPI")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-rockchip.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index fd2ebef4903f..eb1992b4178e 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -908,7 +908,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 		break;
 	}
 
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register controller\n");
 		goto err_free_dma_rx;
@@ -936,6 +936,8 @@ static void rockchip_spi_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(&pdev->dev);
 
+	spi_unregister_controller(ctlr);
+
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-- 
2.52.0

