Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794140229;
	b=aLuoovRqLwZI+OFFcVQszva2esN0lq7WzbEOJnOnQ0bHlgmbX2rRzONb8PzxsQGl4w2U
	 LFSMbAcpAC72W68cAJWiXmNcBcLu7rFZiRiePyzSkSpnyvoEyEWnXFUdvLMkx4i189Bkz
	 O5V6hsGzpQJXTWmBTt6eQFogOTu3sAETRsv+o5cWj6CsZ89mDxvf98OHkA0bKvzEDdvUV
	 ja+nVgNmyB18rWhK0AtVKZYqSHrcb7EZxcl6D2cZP/1EVC39jRn3+ReYiUPp+QJ+k148K
	 6pCc0JR+lweawsgk4e+caSXOZ8kghRYdBdP8nrq/iBaY9gXg69aw7D+XdM1DKc/6M0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794140229;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=qxsTqo+JQMtCd9rmTo6lEo3pQJzhEtQmwRC4ed7agqc=;
	b=yBoPZFM5n2VE5in6lyFN6GB5qDFt2ruo3Cxs/9BX4gIbha0DJ8f3ycO0OnqgZfFzaG1L
	 ExDoAYkWlJ9Ea5lVQJsRbpTJj66vuDtGBo6tQvo8zzxirf3JN+FBMjuyWxLY+0yHHOMpN
	 WxHTtkzI5ekqg0PImppxH1XSPiJ2zdhPf6EjWVj1k34Gr/g93Rzk8Hhhb10peHmef0eSR
	 JYQJhN3TwhOy3odNQyX8FNVzdA4XhSh3FScbvIJaj1oMD/QvxBHzXLMpXsnz4kTrLo+VR
	 4Yrj5UW9WBObE+yGytlitY0uEi3YS3FrG3N0ccXtCfAxdJA++NcaLHTW5CrP7BlyiWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iIcoRQSE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72618606A31C;
	Sun,  8 Nov 2026 12:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iIcoRQSE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F09B1F008A1;
	Sun,  8 Nov 2026 12:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794140228;
	bh=qxsTqo+JQMtCd9rmTo6lEo3pQJzhEtQmwRC4ed7agqc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iIcoRQSEW4XrwKV+nN9Nb4Qa5qsQEH19jT0amut0xQctRCFfAEqzNq+Bs5Z9F9IWk
	 sQoYtXE7HJlRwkWJ8I1w2Ku2LPxakUauNIgRNx1YVQlh6cny3kvR1CI0VvkkAbF8Ql
	 pCq+bY+iwgS/27EMr6tjjreoaBXpQePYSnIo8khNK7G2tbxRiYiactQbQp0UgQRtP1
	 1k3E3ofNCdMdai1BrvqnHtKT3GbP1d8d+PEaaxqjOsYDKb6F2+VEbXQ5CpODx/kV33
	 bEyPyBdPxdBjpcwM584RGrzjQ76Y2g5zOkkJ4zxCDYseE8qT4exVR9Y+iMByK0h1zE
	 SM4pZo4C+0ydw==
From: Joshua Crofts <crofts@kernel.org>
Date: Sun, 08 Nov 2026 13:16:48 +0100
Subject: [PATCH 01/11] spi: axiado: remove redundant
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
Message-Id: <20261108-spi-dont-use-autosuspend-v1-1-3587b0183cbe@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794140215; l=1169;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=NRoyppHKukC1q/jS9eBWJZZhaKnTa7BWmakPxRHlU6c=;
 b=D2kmfHd3JpxqRP8yObPxfrCGD9MxMVhHhVSsWUhJruHhGwmb1aC8ca9RPWngeIISejU2cS6Z0
 pz4IH4C/CilCuSJTP0Hynq4XrRD4ZO2GveTD1qC25VNd7UjfK+5rtoO
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function calls.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/spi/spi-axiado.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-axiado.c b/drivers/spi/spi-axiado.c
index 4a781b53f372..983fa657f00a 100644
--- a/drivers/spi/spi-axiado.c
+++ b/drivers/spi/spi-axiado.c
@@ -858,7 +858,6 @@ static int ax_spi_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 
 	clk_disable_unprepare(xspi->ref_clk);
 err_disable_apb:
@@ -887,7 +886,6 @@ static void ax_spi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 
 	clk_disable_unprepare(xspi->ref_clk);
 	clk_disable_unprepare(xspi->pclk);

-- 
2.56.0

