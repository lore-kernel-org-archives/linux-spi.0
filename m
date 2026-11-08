Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794140296;
	b=w/lYR6uCUBFqT9jTR2Za8qU+JHzCyNII0SzC/MFVTvHv73c+QRo/U7nVfYpP1fAACK2A
	 203kymAB0GBtMxVl6yj14sDC5CxbRNL1vXda6zlTCQaT1luFWhCDIwYM6LpjLRdFXixtR
	 3hVlblsCTJKrJ5WdME8F1cPu3QivGwe+5Tsla/IRA1kyULO0sjjsQK2q16Bf1xAzBGbmY
	 oelySyFknzP9heDVO5td1EtbEqYjDHnSjDzKKMITLcpQoRMUM/vzJDKNoYBa0C4oQrbCm
	 VDOATuNa5Sl8yAXJGdZuohASIvD9fTbe8223OIqtLvEZvFz0k9ZYq/xgH7OK9uMb8uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794140296;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=SckiUnu1S01rYyVBaocWKaUFwyjWG4UsjJW3tv/+z/0=;
	b=pqHl8CYbluvRouRSB/ElDyxZj4ep2wRHx4EDspLFWJbTYf8jBGLWQmYHT5PU24vPz+uX
	 MsGJXXk0VMYcEmopwv6/+mguplvsjDoXMy2VnPXwX66nzDK6DgeIPdatw/27neiuKpIL8
	 q6HppLl8NLeUIXEATkH0Kk5dwq6ihgLz+6t4oaAHtdoT5lOkkoLoqS92D/eliPgw7w5Xa
	 kVU3RqV/q7LotRFKioDNVSOs90jOqzu5sli+VYUDNfr/GV4IQ15E4XVHxD0zf7L35Ac6X
	 ULcMEEW0eBcIzrafSTBGc9a/dqXWH7QEOw+QiiHOWYsvzE7jO8/wdPjZQNSF6cUNtMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2doajhm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DA1606A31C;
	Sun,  8 Nov 2026 12:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2doajhm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E961F008A2;
	Sun,  8 Nov 2026 12:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794140295;
	bh=SckiUnu1S01rYyVBaocWKaUFwyjWG4UsjJW3tv/+z/0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=K2doajhm7XDLnukMsitOSySzn74EXWrVk4AXgpXZxA6pD34xRObyuefxmA16/VM/i
	 BHrQR9ZTvyOoTEEjxx9/9vGjgWcOwUnU9l+EzLE0/wejLqSP+qABrqkDwWjdbFwqDc
	 QisspIbLRPc/TvxHUugJnZhl4UyDwynLIVr5j6A890uG8v3X+ria/xKcd/AQ5FExL3
	 gRIsYuZbutKaiV3MF7ytEZHgbfhQ4idm6CC4uDNNIFdmyXd4BuYGw1OfgWNwjZulOs
	 dTQaU0VsOa147go8rEZ9wHGiCns6N58J4bw6tvCeuq0XEElAkom0AnHx7bQ3cSvR2N
	 +1Jy5qukSzC2g==
From: Joshua Crofts <crofts@kernel.org>
Date: Sun, 08 Nov 2026 13:16:58 +0100
Subject: [PATCH 11/11] spi: tegra210-quad: remove redundant
 pm_runtime_dont_use_autosuspend() calls
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-spi-dont-use-autosuspend-v1-11-3587b0183cbe@kernel.org>
References: <20261108-spi-dont-use-autosuspend-v1-0-3587b0183cbe@kernel.org>
In-Reply-To: <20261108-spi-dont-use-autosuspend-v1-0-3587b0183cbe@kernel.org>
To: Vladimir Moravcevic <vmoravcevic@axiado.com>, 
 Tzu-Hao Wei <twei@axiado.com>, Swark Yang <syang@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, Mark Brown <broonie@kernel.org>, 
 Karthikeyan Mitran <kmitran@axiado.com>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, Jyan Chou <jyanchou@realtek.com>, 
 Yu-Chun Lin <eleanor.lin@realtek.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-tegra@vger.kernel.org, Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794140215; l=1182;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=8JBQ4IcPEGwBD1QITLActHWZFpnabtrNZR/DykpAoss=;
 b=DwG+Igz5rwcKr2H2vQkzimZS8cgXmgDiMkHh4/f5yqxsMm/phmaTniGQH06bGPP7QMM/kq/WT
 BJKXCJ8NUw7DH0kns8hsHuGZwDqFvU0GN7mU+1NSSDUJ/14/p33mCf1
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function calls.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/spi/spi-tegra210-quad.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index d8cca3aa276b..5178cf7eca68 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -2185,7 +2185,6 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 exit_destroy_wq:
 	destroy_workqueue(tqspi->wq);
 exit_pm_disable:
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_force_suspend(&pdev->dev);
 	tegra_qspi_deinit_dma(tqspi);
 	return ret;
@@ -2205,7 +2204,6 @@ static void tegra_qspi_remove(struct platform_device *pdev)
 	spi_unregister_controller(host);
 	free_irq(tqspi->irq, tqspi);
 	destroy_workqueue(tqspi->wq);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_force_suspend(&pdev->dev);
 	tegra_qspi_deinit_dma(tqspi);
 }

-- 
2.56.0

