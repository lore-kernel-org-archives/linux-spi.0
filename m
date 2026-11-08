Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794140263;
	b=JFjnUtJVpYxEFZueIZdfr3DOhFQjzWHkwwSeK6fP4A4lBZPQ0MwJ+X422rAzbOPBwSCB
	 8zi4CgaL2OAxS5OTXjKIMIYcDKfr4/1oF4dmeoUu1jAsXBzRAbx3yeqX2NUIAtVuyxon+
	 HGoVvPvxFbdJmuxdwTv97710+V+hYIHPTgLNs66PWFHv6agXbmo6bLltW/3kMCTj0aZ4V
	 MYY5S7rRpsxlsm/nBbnVPWA4DZbceYcmzE5V/7CX6ljT1dlOQzdqY2Fajth9CgWhq9Cbj
	 Tkw1kTfh9jAT4eGpvLFfAywhJ1hDO7+jHC1314Law5aAW1aSQi1kBcSloOIRbfPEO6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794140263;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=jSqLJqEenfPUEv5x/5YgjJzs+wC3FTZEJ+DOA07BxFY=;
	b=V/pE3wiwhXdVJJ03ozj3JD6hxc5T/fL6PdsFSJ6c/2v+i+I6WrTGyujFTuJgq1bfgtwT
	 Lp4GlZoPI+e/YucSN1iBGvQR4les0shFvn3ALioNg6u4RR9UcC4zC78luEWi0tsAAtv9W
	 XVF4vsvdzNULQFmlkSoDTCGheoxWYD6cZivWhGmA5XudMvLS25Ag5cetzzDTPwV/zN0ba
	 4Hd921fnHY3ZxbVzjvjmYD/FfPIMWP2g2d7LibE3UegHgA8SPQMb7Z69pIzvWoNzG8Jaj
	 504rFIU51EesvSOASvXCSBNn+JASs5RdNiJZLal+xNVc+kFLOIL9NvQcY0hg9mHwYRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dmt9kufG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D36606A336;
	Sun,  8 Nov 2026 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dmt9kufG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BA81F008A7;
	Sun,  8 Nov 2026 12:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794140262;
	bh=jSqLJqEenfPUEv5x/5YgjJzs+wC3FTZEJ+DOA07BxFY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dmt9kufGDneBG905YjJR5VWep5ht13IbZwf6qUhlBN1fvTz6sxqhTWJCtcmePiEE5
	 GTDIzmOPIZ/GcF21+kyOCu1KOV0taF+7JoCSkDqbo0kntrTOG5SE6OGbAdOX79v0FQ
	 XUMHqUxqspnNIjvSAFmgK94EncAnF66ijoWetGcxFT9qQB60be2a/ruhUITscrKZwc
	 8tatgDUWvWkBbx5wNCmynSjMUB6fGuwhJzuXE5LJRobkW33VC/vkE4L0aa0J0O2ylN
	 tZvgBJ1/aLLL7FJ3/dMOxuaJ8tIx9EYLD5MqMaktUw+/edUP/n9AvkFS+8ulePRg9x
	 qFhCTJrlTySSQ==
From: Joshua Crofts <crofts@kernel.org>
Date: Sun, 08 Nov 2026 13:16:53 +0100
Subject: [PATCH 06/11] spi: zynqmp-gqspi: remove redundant
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
Message-Id: <20261108-spi-dont-use-autosuspend-v1-6-3587b0183cbe@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794140215; l=1221;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=4MTe2XoG6bL0dA+imKBTeRSlKR09cV9ZpdyKSI+tTcw=;
 b=fanzJyCM5acC3ttwnRzP6W6fGrhFx+Ivfoi9NOhstm1NqiPZTzn4CiOagoigAc1CAcLhdeuTE
 pKO0P7ZEjP2A9/cRhpjGnGJDwupU6fmrbjeeoCTgiDxfE6gHb6HlKrL
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function calls.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/spi/spi-zynqmp-gqspi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 15e9d3ef8839..2511d71e1423 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1335,7 +1335,6 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 
 clk_dis_all:
 	pm_runtime_disable(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);
@@ -1366,7 +1365,6 @@ static void zynqmp_qspi_remove(struct platform_device *pdev)
 	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
 
 	pm_runtime_disable(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);

-- 
2.56.0

