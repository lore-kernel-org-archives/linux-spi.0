Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239B13D647B;
	Tue, 21 Apr 2026 13:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776538; cv=none; b=tDSup4lr6jgC2qnKKaDxaXpH3wXfUjDEZ4YEX4xKajt9RL9S0Mvhn1uiVr26cOMrmmDGmQvdnLp7rmAdc7AoaTk3H80QTc+auqN6z2sXWHtjcCx1i9Be2V+Dqf/3FsRHVwvKcv9kk80GyZmEGhyREDONSlbiihap1a1vTbbOryQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776538; c=relaxed/simple;
	bh=CkfDx8VuNVH8TbkuU+p989cQvobVMXMonGaGvMeEicw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJn6dvNLf6Bb21vr4a8yaQ8qTxni7HBGdM57setWRwDOkNRhIRvrkf/laNieNORiCXqnoNcxrAhodAedX+rqWZjLYNjs+YvBNsdkH+0Zlf2jwISzPCrkXvBqH5i04RJ9uj9zkW8nKvMj3ZZ/3Nzaap2Xetc4y186kUKxnqpxwx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjD9CAl2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjD9CAl2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDA2C2BCB6;
	Tue, 21 Apr 2026 13:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776776537;
	bh=CkfDx8VuNVH8TbkuU+p989cQvobVMXMonGaGvMeEicw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LjD9CAl21jtzi80KbT94A+a0cZihcpR2cDp4RmCzaq2mH5koDnhfDu3M0UHXZoKLn
	 pcUpoJSZEtzkPWn63oHHfvT4MLGwS4hwudh8Vi8xq+UXuYlvHEp73eLYXvjVAwQngz
	 2E0IZQ00Rde6RF7AcrN3dRX5eWUB+DbvfyPkFtp0unXHC9S8cJ2TVCagOKUjytDKZX
	 NNDAiPDP8JJz9wt10aJZjDTPsmL1FdXLvi4F1bIAxEn4N8ZTM9WMYNWpdHbN0mf1Wc
	 fbzEIR879aCHr36GOUu7FK7N4V89yRiw4g/tfQywdD3erNyRVB/9Djvxv3f1z44OTX
	 aBUd1dpYcHB3Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wFAk3-00000006S0r-2mUh;
	Tue, 21 Apr 2026 15:02:15 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] spi: orion: fix runtime pm leak on unbind
Date: Tue, 21 Apr 2026 15:02:09 +0200
Message-ID: <20260421130211.1537628-2-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421130211.1537628-1-johan@kernel.org>
References: <20260421130211.1537628-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to balance the runtime PM usage count on driver unbind so that
the controller can be suspended when a driver is rebound.

Also restore the autosuspend setting.

This issue was flagged by Sashiko when reviewing a controller
deregistration fix.

Fixes: 5c6786945b4e ("spi: spi-orion: add runtime PM support")
Cc: stable@vger.kernel.org	# 3.17
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Link: https://sashiko.dev/#/patchset/20260414134319.978196-1-johan%40kernel.org?part=6
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-orion.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index c54cd4ef09bd..c61ebfd1d18d 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -811,6 +811,9 @@ static void orion_spi_remove(struct platform_device *pdev)
 	spi_controller_put(host);
 
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 }
 
 MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
2.52.0

