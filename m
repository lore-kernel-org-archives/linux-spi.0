Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805843E6DD0;
	Tue, 14 Apr 2026 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776174341; cv=none; b=TZbZzPCh+RKUFdOnPujCYNvIlxbuXZow+yGkbpxSqiHdGega5kUP6QBJnK407KCStqnQnWLm7XFbQQ3jW9KXCX40gXaTUKRLS2988KsfWpORjPX8Cy4KGzxR6xopCC9FEQsMwO6UFtixaY1VHH9YtQc4NyBrWfyJgWrBZmls4bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776174341; c=relaxed/simple;
	bh=CD9c1yWD3HCd4mW1xhHDZHS+XcvTESm7Ozt3zqDLBlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gK+xDc5N1HN5YVWo2YnycLdQs816QGH4nygRPdOSUF0C5bAKYMh7MVHcct2RPctdfA1RUSx83y2vcQxCvfON8ZUftxHTC0N+OilxPuUXC4lCcDDRAPw4z69iNZvfSjh8HYgD0x4OFfzK6xPQFfXAJmnJz2oBLEfGGIx1Xi/A6O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fItK5kUJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fItK5kUJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105B9C2BCC6;
	Tue, 14 Apr 2026 13:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776174341;
	bh=CD9c1yWD3HCd4mW1xhHDZHS+XcvTESm7Ozt3zqDLBlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fItK5kUJW2UySYt+TOpsFUrHH2L82bGLvpgb6LxS5MpqFWIrs4rRyhMlEk0zgCWdJ
	 R/btMsJ1gL5i7R8riB2yq3yis0RolBm3ERH5FP85kuUfIFwS91nvaF1yrirM35DGCr
	 gUwmTT9JY+Mpq600KQU5JBiM5Yxv690TJvDmet+xnZm6Zq/P1XYxd5SZkCk/QqATb0
	 idAsFrZNvpwSH8n16oSCNnQnTlttguR/G6GigV1BdFs7/iP6pjfSJXrsXaU9hcrrGn
	 mDOmAb10j/zoTkT05c1LJqlT/quM2yuO1mpsFX/SnRAiQYlLbzYBfWubaM+rg0kUJx
	 8H7SoW+beV8/g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wCe5C-000000046W2-37Fo;
	Tue, 14 Apr 2026 15:45:38 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 6/8] spi: orion: fix controller deregistration
Date: Tue, 14 Apr 2026 15:43:17 +0200
Message-ID: <20260414134319.978196-7-johan@kernel.org>
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

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Fixes: 60cadec9da7b ("spi: new orion_spi driver")
Cc: stable@vger.kernel.org	# 2.6.27
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-orion.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 7a2186b51b4c..c54cd4ef09bd 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -801,10 +801,15 @@ static void orion_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct orion_spi *spi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	pm_runtime_get_sync(&pdev->dev);
 	clk_disable_unprepare(spi->axi_clk);
 
-	spi_unregister_controller(host);
+	spi_controller_put(host);
+
 	pm_runtime_disable(&pdev->dev);
 }
 
-- 
2.52.0

