Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794140283;
	b=uyii4cpcGFBpuNVtQMzE+/zTx/zTLaSTwfcwQrtUDlf/ZyN/1J1CJS19wO0DAr85JVPB
	 dwPTWkGwmbk3WI+GTRSDV2Y3b4pvgLZEu422zSbjxOtV/DheqU3bdPZCleCFiJR4U3UQc
	 VR4f8kjlyljIp3Y2oLM9e7PDNWMuQMcE0mOAmZKFVlIdZTP8SBOKkZxE7xX/WW7kXGx6F
	 0HIlfIb9vPQinIBjAWlh1SEoitc6iozv3RCT4rk3fs7AJnuH19RhjTlaGUfS/zLb2xc7K
	 uDFgv4Ugy6cP7pi8TvuFvWSanGI+O+zwwpYWp6JLPz0bcTKyqrY9dwrG+FfV0EX57ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794140283;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ivHf0Pc3p6eAqWr0NJ+TWsKwIGrisFj3IhQMlgFUcRs=;
	b=tiBJdIgdsIpEgVnr2bAmKPJXpMzsKUfVBh7ibZOVkyI1ynQW1mZCBEZDrf5FQQivg7Nc
	 vrlDIWeJizPzsDaNHJ5FJ8j0i/HfTNxk+S56wofCN6FlAQ+XFhmShv6Z/o7knssSEqij4
	 xt4cgWsnIa0WlDB5Cul1qEgdC0kYlLUTv5JLV+hl2pLeiTWwk4LrvDRs0tuWK0VM4ynGY
	 U2I+rs9nh2Iar55405JsDPqqxyuuzOlws82C8RiU1sFG9Slfab1ObPPihubBBj/AXl5QQ
	 oG9XYCnPKqpy0/XtGUol4s1SswtcDguurSH5cYyGc5SzwzCqoEs+66NqvmjkxSpHZcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=brbvRanz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAC8606A337;
	Sun,  8 Nov 2026 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=brbvRanz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDC31F0089F;
	Sun,  8 Nov 2026 12:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794140282;
	bh=ivHf0Pc3p6eAqWr0NJ+TWsKwIGrisFj3IhQMlgFUcRs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=brbvRanznwpm1elRlhsunNMW2MwSaxrbh6gXspid20cmy6oaZLHcd0upqM1xd87EG
	 QAt776bNgeLXudxA209oBJDquMjbQ3fXkgWVgGCwHRIuPn2iau2lkxxDRfaOoJJMNl
	 SuBZi8I4NQMzkz4/UrGn5AkTcELYYSTcpY6DQQ34Te8ohkI1dZFr7Y6OBYV0B+z4tR
	 RKkN633ZRb/txLmMWZg75po3BstSiammcZO7m4Ttfcd/Vls8cKLFtUcmImLgLE12OH
	 Q90/dE/dlZO/YoWHZRYVgQg+7l1X+eQD791ImeAD/W5I1jq/5M/DxKBbq5lZDdn4J1
	 SxPwwOVVK+6Cg==
From: Joshua Crofts <crofts@kernel.org>
Date: Sun, 08 Nov 2026 13:16:56 +0100
Subject: [PATCH 09/11] spi: rockchip-sfc: remove redundant
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
Message-Id: <20261108-spi-dont-use-autosuspend-v1-9-3587b0183cbe@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794140215; l=1213;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=wPeL2I+QI3Df2BxdnDa7pNerVfRXP8M/5qu6ZdMC2YA=;
 b=QfRsr7iFtOGktsDSyJiCngMR0Or7BK4oIsOoaF3SOsZrwq8Pw92AyW8OFIYMFVVKXsVfVt2RV
 jzHDfBbXkvaABN8v1G8Azj1PTHUYWB5lNOMfQjjymPpKGPbtMhZ7hzs
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function calls.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/spi/spi-rockchip-sfc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index a85a260ba95f..2d24765afd3f 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -730,7 +730,6 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
-	pm_runtime_dont_use_autosuspend(dev);
 err_irq:
 	clk_disable_unprepare(sfc->clk);
 err_clk:
@@ -749,7 +748,6 @@ static void rockchip_sfc_remove(struct platform_device *pdev)
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	if (sfc->use_dma) {
 		dma_unmap_single(&pdev->dev, sfc->dma_buffer, sfc->max_iosize,
 				 DMA_BIDIRECTIONAL);

-- 
2.56.0

