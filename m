Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FBD390C95;
	Tue, 24 Mar 2026 08:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774340631; cv=none; b=GNvTLU23BgQP2xxi7tsTN2raoTTcW+I3MLM18zGVK1ifR0Ui4rDsrteFdnxXDM2UNrmjnJg2lBFbT6k+75nU32Ebs0d4FzXgvUkmoqyy/znytU1jC3uDZHKWMNUT7KzFfV5LyEf336pUtrsVxZpy75unEHG48hizC3ZRNpEahxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774340631; c=relaxed/simple;
	bh=k3YtsUOZ02FudyzraP3IJRi+FC88W1D4DLa4KDfOTDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxwjLYkn0R1WmG7Ian+e6fifRQPnYw9HmXfCi+FrFYyNlLraB7iNiWm8eOXpY5xDvBZCxvRZQOKp6RP4tjcn0gxiLrL6lbMRqrmwYTvOhM/g2tPcpoJk0W6tOJtqBpw4y3dGbS93ePVnQywfYxvGtJhbJNToQJNoM6LFLD/IrSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3ft6Tf2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3ft6Tf2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F84C2BCB4;
	Tue, 24 Mar 2026 08:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774340630;
	bh=k3YtsUOZ02FudyzraP3IJRi+FC88W1D4DLa4KDfOTDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l3ft6Tf20pZaf/bAr/pt+6rq8cuNfY2CE7Q0miiUhYO8kKyYv76tgy/UvxbsVS8q5
	 HHcfCnnM90nGytDuQrQX0NErGLfPkEWk/EstbhrpnYGX8iVJLghN+nDoFqbc/BgSCW
	 zdE7S3iP4o8urBlJyE3EXg2GL28DGET0zBqlv1mSNH6DIesJlpLrIZqaQtv/XXP/bE
	 HMGnC29ublElFNAaY2ZgHcOtdk9R6P73Yp5Zr8TgEp5Ra5WC8Bby0TUhtn2EFXvmLQ
	 M0UzicKnYqWJuk3cs+xznSPrL+bTkRAowdb58/2dKs6b3tJMZzNy5hF23EhySTctcF
	 D4i1tsr9tzlBg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w4x3E-00000003mQE-1Kq7;
	Tue, 24 Mar 2026 09:23:48 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	addy ke <addy.ke@rock-chips.com>
Subject: [PATCH v2 2/5] spi: rockchip: fix controller deregistration
Date: Tue, 24 Mar 2026 09:23:23 +0100
Message-ID: <20260324082326.901043-3-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260324082326.901043-1-johan@kernel.org>
References: <20260324082326.901043-1-johan@kernel.org>
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
Cc: stable@vger.kernel.org	# 3.17
Cc: addy ke <addy.ke@rock-chips.com>
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

