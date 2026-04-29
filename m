Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998D4286430;
	Wed, 29 Apr 2026 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454593; cv=none; b=jigB0THU0tdXWIym8GPSUJF1FKwN2cz7bgvGAxHPi/EpBp1JoAWX+7klG0Lzgz3HmyEfGP6dLT5clPUdq9YKn9/gZemDxM9fW14GmSzKOGvbFCnvrGAmHOSedeNfoG90ADJtNVx6Ku0izuLLm5hJI1BSR/Sq+A0TVLxesZkbs/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454593; c=relaxed/simple;
	bh=eQs80Ma+lCeziXNpUTjAztgwET9gezLiUmAYWEHD028=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hBr1x39/GPunXXq8rUwIClO84EPQiQagUwix2PJWbkSeOzRZGMiGzb3IGoRjWd67iueZxaG5lZAgPTHYjc/Emi3ebYuibDzlN20/8vn5zck0thxbrXsWTQI3IpdsBHa3vgGP9lyw8GoGN9H373rzkY184T0Nkb59pHTXPx92MY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewfndRih; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewfndRih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A5DC19425;
	Wed, 29 Apr 2026 09:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777454593;
	bh=eQs80Ma+lCeziXNpUTjAztgwET9gezLiUmAYWEHD028=;
	h=From:To:Cc:Subject:Date:From;
	b=ewfndRihpfKfhGNEUuPpLQKUagFwPq/x1aNT5ANDnO6rP5CG0sbYGybfYydmuwQ/G
	 KvkMv+u37CpHg4D0gwxKkI4auzjxoNNMN9MBDXuPVHGRJeZr4PpU7UmI4/5mng9M0F
	 PRqbdKOAPx/nbjiTIzsX66SgduhTzylbAXhZohKsu/XnKUTI4l33PJq0kTfENEREsF
	 JtiTiRJGqVNJsgY2+Vpoku+YUp6ecewC3reV/39mq2mdAZT88GevpsMI6DT44BQ2Tb
	 vLZTlzslLK9ExtkmwTTCjW8bI/gaZ8i8UbD3Wzz1cG9lLAwZUGojDPP1v/nmnA489T
	 r/CbFd0pyZhew==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wI18Q-00000000hHk-3kov;
	Wed, 29 Apr 2026 11:23:10 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] spi: clean up controller registration return value
Date: Wed, 29 Apr 2026 11:23:01 +0200
Message-ID: <20260429092301.166375-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return explicit zero on successful controller registration to make the
code more readable.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 104279858f56..5f57de24b9f7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3552,7 +3552,8 @@ int spi_register_controller(struct spi_controller *ctlr)
 	/* Register devices from the device tree and ACPI */
 	of_register_spi_devices(ctlr);
 	acpi_register_spi_devices(ctlr);
-	return status;
+
+	return 0;
 
 del_ctrl:
 	device_del(&ctlr->dev);
@@ -3560,6 +3561,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 	mutex_lock(&board_lock);
 	idr_remove(&spi_controller_idr, ctlr->bus_num);
 	mutex_unlock(&board_lock);
+
 	return status;
 }
 EXPORT_SYMBOL_GPL(spi_register_controller);
-- 
2.53.0

