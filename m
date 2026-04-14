Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F93B3E63BE;
	Tue, 14 Apr 2026 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776174341; cv=none; b=h3OdJJoD5lQNTUDrVC046q634PdCN8MFohXCjuuUMv/7fRWVotQs/oxIAokRQL2Xv+goARue6UldHqIWOTGvgpOVq8TrNdHllXNZxTHxqAe/+czmEgf9V+PoqbCGjsdM9bz8/d25qsVErmv852Q/4l1rylCHajXJco9UUgpyEyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776174341; c=relaxed/simple;
	bh=6w8WzsRo3+kFLD5QPp3YB0Mln9P2TUnV/IBWCbt3Kss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLI2R/rLn6NMntNvD1YzcdHih9slzLHGIHrD/eHIGWUGhhwmBj0a822oR5xv/qJik0idoMkFUxeB4NeQeKT4x5TdaeMqWFJP2xt/W4Ply3A4h0DW0ekW2ijBt80RV6+E3/1nYySWrqS86Y4nx2BLBQGxk9KiWACDa0mY8hjI0/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaqXwdzl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaqXwdzl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC31C2BCC4;
	Tue, 14 Apr 2026 13:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776174341;
	bh=6w8WzsRo3+kFLD5QPp3YB0Mln9P2TUnV/IBWCbt3Kss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qaqXwdzloPbA61Ab6Co7ARFdp1HVm6jK5LsEcAWdRO9aq8tjQBpaGx2HPjCAcRv96
	 edxfK5Fd5ilkr8fr+vPkbbsSZlB2J88YOCrNiC4dsBqExK4jMEFOIje5pwGwnKzlbP
	 6fQ2hh0sMzXE+Fka8XNinoB6kWl+Yf0NzLVG0CswfkaWOkfIfcwf2vx0NG7Wb9hLNc
	 DDVbOtvAE+c/nhSzSPO0nvGtA8XBLCM8ijEx1XmmUVwmU9DiK0bRK9yZMxY3tmEkpC
	 s2a8qza0NnBT9RswlruMQLOLPOEoOzxN1I7IuO0N+rczAvLIFdsiP6qpMsJavku86a
	 x3elACTSWPrsw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wCe5C-000000046Vw-30KL;
	Tue, 14 Apr 2026 15:45:38 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Luotao Fu <l.fu@pengutronix.de>
Subject: [PATCH 3/8] spi: mpc52xx: fix controller deregistration
Date: Tue, 14 Apr 2026 15:43:14 +0200
Message-ID: <20260414134319.978196-4-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260414134319.978196-1-johan@kernel.org>
References: <20260414134319.978196-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to deregister the controller before disabling and releasing
underlying resources like interrupts and gpios during driver unbind.

Fixes: 42bbb70980f3 ("powerpc/5200: Add mpc5200-spi (non-PSC) device driver")
Fixes: b8d4e2ce60b6 ("mpc52xx_spi: add gpio chipselect")
Cc: stable@vger.kernel.org	# 2.6.33
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Luotao Fu <l.fu@pengutronix.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-mpc52xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index 05bbd3795e7d..823b49f8ece2 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -517,6 +517,8 @@ static void mpc52xx_spi_remove(struct platform_device *op)
 	struct mpc52xx_spi *ms = spi_controller_get_devdata(host);
 	int i;
 
+	spi_unregister_controller(host);
+
 	cancel_work_sync(&ms->work);
 	free_irq(ms->irq0, ms);
 	free_irq(ms->irq1, ms);
@@ -525,7 +527,6 @@ static void mpc52xx_spi_remove(struct platform_device *op)
 		gpiod_put(ms->gpio_cs[i]);
 
 	kfree(ms->gpio_cs);
-	spi_unregister_controller(host);
 	iounmap(ms->regs);
 	spi_controller_put(host);
 }
-- 
2.52.0

