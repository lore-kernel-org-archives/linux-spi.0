Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794140276;
	b=JDGl7MPuKcRUeADLPaYBWzn6VroERSKdJ+qaOOYKLVxQ629ELKYOuM89ju/lMWLHhtUS
	 qQRs+A6JAWDq/tS1B1KD9ofXUQDnw4qAy1toTYfmxGkDrLwE2E03PmOz2iiRt5B8j7DTt
	 e8soRrdl0iAp1BwNEaT0pLfUDActbXfq/3Lih6GSKcWjQDNPSZo5PAsI/TmScrEdCB4AM
	 WXb0QYCDDWkk5wvlv40Kmucqbd4VKb/7WlF2Mu80c5GYxE+M1Y3fbg+vmy7r7h6HYVvbL
	 vTWALNtJFybQcoIM+gG+Ers11C/qpvHqcv/jt2WRfWRHwaMGunZIpABkOLl9A2Zdc0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794140276;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=MT69fl7958f35mgL+cf3gwuQcSNrSgQ2F5xRyYMscKI=;
	b=y6bXTMUf88dC2iVVHkiHRyn7EeYCmJLweW7e1O2OxNwR5jILFEWJ1waU4cz8gFysneP/
	 Gk4Vns93r7P5GhTHBDsZNVbiHtu8+jo0VeADo9TCYp2co/yOdOQz3QqCGMlJaVDpWCWFS
	 C2uLjjVDjbJ0JqrvbNKkeoIKFqnMHp3LYdmgFqXAdv2M4K5c8unJtBSviRYzKQQBIIZnF
	 5FXCB2gIy4Strz9nYUauqy5HNmovJZQJxpxOXM3HpKdpSNqe3I4Sx7gzyCT6gWVkJXSTP
	 vHeyFpV8Lc1BLa732jPYzvDCSh+NiqzgpJrbA1i82Ii4h0bLgt6xyLS3ZijaP03Q1jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hvC3k2YU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1099606A332;
	Sun,  8 Nov 2026 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hvC3k2YU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2941F008A2;
	Sun,  8 Nov 2026 12:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794140275;
	bh=MT69fl7958f35mgL+cf3gwuQcSNrSgQ2F5xRyYMscKI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hvC3k2YUECUU4R16MmHmvuFEu6nG275q0OfsyLIRsJMZjlz8oY1Nw9JXCHzb5sDTi
	 K9JKK2V/2l+hSyd6iDrr371znsb/71ywpEkAZg3BGLVZG+TRPDz0WMYhZYZf0na8EG
	 KQqWQ6P/l2z+57wcJuuJ0qP4V+1vBUKYRfl49M6cUTwkYfuxwB0banjXgLTILN8uGn
	 77dD+TMznQKEfV/Sjcif68kpvl75UNBvAmh6kTQ8T2Dm+DrXhK+K5twePUCjT4aaPN
	 NDRYw8tuuyKXDUF7y9KImE0PCY9ivYSfJt+8UW53L0HX5PgUtfH9cZTeyIWYyT81Ve
	 aKcivKxhQMPeQ==
From: Joshua Crofts <crofts@kernel.org>
Date: Sun, 08 Nov 2026 13:16:55 +0100
Subject: [PATCH 08/11] spi: orion: remove redundant
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
Message-Id: <20261108-spi-dont-use-autosuspend-v1-8-3587b0183cbe@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794140215; l=1098;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=yh6M+dZbdbrK1vkY6Im9lR8DhinANaCbpgoKrriXeYg=;
 b=hGOXI0JIhFdu6cYxFmVFQgIvvBHkhsXS9qY0uy75k4xiaGp6FzXQCSG/r/NhglQfhuAD7uoQ6
 stJFrhfo/yUBkRyg7FGD7TMshe3FCxDfyB4WhnScvXmHMuMmOASMB5d
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function calls.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/spi/spi-orion.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index b8882229c054..190842f710c3 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -789,7 +789,6 @@ static int orion_spi_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 
 	return status;
 }
@@ -806,7 +805,6 @@ static void orion_spi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 }
 
 MODULE_ALIAS("platform:" DRIVER_NAME);

-- 
2.56.0

