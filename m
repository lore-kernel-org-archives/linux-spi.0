Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794140269;
	b=G0aYBE7wOaYz6n+cfklWan6oXOMFU7jZF+9o1/0/NMQs2r2FxXhYn8e7kSOwbEC8XVFt
	 esnioRWrCFrRunRifTYf5FAmZGhH3a/K3QJcp7gK4DbQHqeR9Qf8O8koea65yyoNcm/HV
	 l1qk6WR2Y0QL5S2Sdnk41/6CwBdjCmhe++/dpp+kwWs4P+CPBjCFq6/BTbrP3CV0Q5Gm5
	 2zctBo807gqYNuw/MCavSK22kMq3HB8FlPxz/OD0vB5fcpyYBQvv3OVFu+gJf0vICS4WR
	 sdd8e2m5Ki7epFvKgSWSIHOXj4/3puc2bmQ7FM/GtJ1rsxyaDyVmkmstnHsos/ibPwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794140269;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=R/Uj3OgmmW6UqMpinFCutb/gtRFMEJIKzUntN0uYzOM=;
	b=WXFY008+61Cy+Eirx7y/0xyiq2zBRabZLzuomhPqGiAcHSAVMJRt+L2aqKxvgWHDIoNW
	 PNCHecz1sTkDNAHzLc0QkivYOXzbRKSL7cqkYbHii1nsr5wLX1NRazRoAHkSTpnD0ja9+
	 vtRntT+5wM2GloT2pZQZI5YDzkIASlNUr4jzEWHZ2lWTfSpSw3sG1VnZxYRaBCcwvyg+J
	 toaKHs8KztFIff8EYalBwoWaD2fMkvZ6wSzJE/bNbdWJe/zNhb+htIJGO5epmbU4BRtmu
	 tFznaciq0wg24CfeVxkd1tjrT7Q91chg7MWhen2lkOpEYEAjTU9CV7BRHhCTP7aV4sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jh5BpzPg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A67A606D803;
	Sun,  8 Nov 2026 12:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jh5BpzPg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DACD1F008A5;
	Sun,  8 Nov 2026 12:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794140269;
	bh=R/Uj3OgmmW6UqMpinFCutb/gtRFMEJIKzUntN0uYzOM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jh5BpzPg/2WVzlkpRYuRbWsr7ye55Iy1aaHLpP0AijzDc3+F+RkpBJd8XfiyOcbu3
	 o4EnXEzgcbSZd1e8pnTIHinJCfTvG+hAHdV5Jmo5sb0OcK5VSRN2bWdlbjoG3zw8oz
	 l82J4VE3Xm+naXs1vxygzkco96bSCY7BsAH0KYtaU2mG7KQwv7zcr4lbTXY+xNJOVy
	 7PThtuWhUXA1qm5Ko1CoWEj30kGoaNf6s/EJoro8ATmmBG1rnHt1XcY3QZ8GcBkWVi
	 2m7rkKGxQVbUBPwTwYtMzotXQt+i1zDGVVpuZV1l3v8MAkZ1tn/nebh1/7YS5TjoQM
	 ZLJCENfD31aEQ==
From: Joshua Crofts <crofts@kernel.org>
Date: Sun, 08 Nov 2026 13:16:54 +0100
Subject: [PATCH 07/11] spi: mtk-nor: remove redundant
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
Message-Id: <20261108-spi-dont-use-autosuspend-v1-7-3587b0183cbe@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794140215; l=1081;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=AXed4VswP0TgN3GA7lXd2TOUSBx89qibzjtjhBwfZfo=;
 b=Tdb9cnfLsrnvFVWfgrGuJe4+ELv9rSxH2osXu/imxHyUX6P1dPnp5MzAl5fUem1DM6brYDOlz
 VOknjNnvB77DhreZYOpZguG85u/r8OaQmETw2n1SPEYcslDml+Ay7SG
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function calls.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/spi/spi-mtk-nor.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 6b6e55d68048..79e54ccf2a6a 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -932,7 +932,6 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 
 err_disable_clk:
 	mtk_nor_disable_clk(sp);
@@ -949,7 +948,6 @@ static void mtk_nor_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 
 	mtk_nor_disable_clk(sp);
 }

-- 
2.56.0

