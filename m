Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5F53E63BB;
	Tue, 14 Apr 2026 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776174341; cv=none; b=er9brAbxP/+5P/+k2qYe7YYiOLW4X0wUU/Tn7a2hQrQCyP6fdHtlMVf5NE9hiPkcM82r/ROSnBXpFmlxnHEO6o40u9nOJtr8kIR8MhtYib/jGSnzz0rHS0vJ8XJ7d4A16V2qIbgxSzZYOPeTTvyc0o4LPQp+EOfFkqekdAv0H/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776174341; c=relaxed/simple;
	bh=UtOj4j3/A/CiozTGbEOHTVtFSRrKzLJQIHHCs2pbwTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egieM72aB3j/GvrqJPPwz02eNYWjFs0COaz3xV4qeHet4f/th7NglKznHOMEHhtFFcOY0Anu8Y5ou+Nozd7IhUVuM3xZhMI69Z4EaSz69P8kf7ucpyjAotdYFGc8wyTvbZaWvyihLHCYxJHWty47JbxN1rv8oB/2mvLe99r5zdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2xBDosP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2xBDosP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1F3C2BCC7;
	Tue, 14 Apr 2026 13:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776174341;
	bh=UtOj4j3/A/CiozTGbEOHTVtFSRrKzLJQIHHCs2pbwTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h2xBDosPgyhJW/SH/UsOa0ug2Wt7aMi4SogWEpYvHwDnCY00mDNaGZGXHIPanIYoY
	 hGLFKJsIIkH3r23B8LZ6W5O9rWhEILx8PAJNwKTZMdpSiQJsGY5AUrXk0rfUO++rgS
	 N6jso5sqVrDyR0YtJToauEgxLk/GMbbFdHuPHZof+A8ztsXRQETgruZQ6p6Bkg6Ncf
	 syrU9p0R8hkBBLbavc8RaFamiYiSGTE+JqAxTbXsEOTVSe1GbV0eDHcvaEt0LhSrO7
	 vD1A34ynu9jG2jgcpTAc7Lz8c10UawvCCNa/i1zbacFda0JiCe+JGhGVT9LLTdA5wY
	 T/bI4qZK5f+JQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wCe5C-000000046W4-39YT;
	Tue, 14 Apr 2026 15:45:38 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Masayuki Ohtake <masa-korg@dsn.okisemi.com>
Subject: [PATCH 7/8] spi: topcliff-pch: fix controller deregistration
Date: Tue, 14 Apr 2026 15:43:18 +0200
Message-ID: <20260414134319.978196-8-johan@kernel.org>
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
underlying resources like interrupts and DMA during driver unbind.

Fixes: e8b17b5b3f30 ("spi/topcliff: Add topcliff platform controller hub (PCH) spi bus driver")
Cc: stable@vger.kernel.org	# 2.6.37
Cc: Masayuki Ohtake <masa-korg@dsn.okisemi.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-topcliff-pch.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index cae2dcefabea..c120436434d0 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1406,6 +1406,10 @@ static void pch_spi_pd_remove(struct platform_device *plat_dev)
 	dev_dbg(&plat_dev->dev, "%s:[ch%d] irq=%d\n",
 		__func__, plat_dev->id, board_dat->pdev->irq);
 
+	spi_controller_get(data->host);
+
+	spi_unregister_controller(data->host);
+
 	if (use_dma)
 		pch_free_dma_buf(board_dat, data);
 
@@ -1433,7 +1437,8 @@ static void pch_spi_pd_remove(struct platform_device *plat_dev)
 	}
 
 	pci_iounmap(board_dat->pdev, data->io_remap_addr);
-	spi_unregister_controller(data->host);
+
+	spi_controller_put(data->host);
 }
 #ifdef CONFIG_PM
 static int pch_spi_pd_suspend(struct platform_device *pd_dev,
-- 
2.52.0

