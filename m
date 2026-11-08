Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794140249;
	b=JSs6WHXpMMwlHpWBjNa/tSp2kLwX5VA8ieTNwbi0SNSHKDyVTzlStCpKfzF41fOCGXDZ
	 Q92ZBT/amzzNwC/zl4wyNsIaDXrf99T9dcVRa1yDs9H918m67uKgHaZjFOAWzMLeZ5Ih0
	 sQJgCWl7fIiJeCoLYTduXWAsLU1x0GfRBvdZ9K53jWHC0qjXoZ3zHL/ip6AqCJJiF031E
	 /drUHtb23EmQ0cG0JGJ85B+JnZPyLOu22DeRmA292tfI4ieIcgSm8IKUdX4BbmrygWb8/
	 CaMjvdWIG+iq5BnqF3dsFawFhoyulHHtqSzis4Q2/qRD0zTlIdrzYIYZjJG/dT5JjgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794140249;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Upd1f9Y7GeQlOyeiEE4CvPE/32oJWXBWoj8XnXZdDyU=;
	b=bs94uvzTYKYryrXYiuyTh7jJSHcBUcIzOgdOIfo9Qjj7TBrJPr2uJFgP/kZS91lc4tzS
	 ZNFjRbgptB5UGc0txLyKU1eiq9ilkmbwhjGls/zJplH9Y5jdSX+jhp0z9eGLRILw8TGw6
	 3mf5PssNnu80qflVmL1jlnRuukLQVr4aJsvWuNa15wr+28lYs9I43/TYNtxEzZLkeP82V
	 kUba35WUUct0YlZaIY+k1eOV47+WFb2LjYOymFextdVRufEuxbNTSgzOEgbu4lnnwZLe/
	 UF1kS8cD+PoGxy9KgGvcjhDLMdGpiSdxEdf98e1JLYo5dWBwhljUZ6en29sVVcsZElA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L0BeoZCx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A811606A335;
	Sun,  8 Nov 2026 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L0BeoZCx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9861F008A1;
	Sun,  8 Nov 2026 12:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794140249;
	bh=Upd1f9Y7GeQlOyeiEE4CvPE/32oJWXBWoj8XnXZdDyU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=L0BeoZCxlBN8EvWflf/Sn5VnIEBAyAwEoV3E25bqxAPBcVeIy6mFmsZJL2Ml9kLLT
	 l5ltrFQSLD70IQHPrPMw9QyeykL8nGsZbk5cjhddtBTAqUL0mwznXj1eMeXo3RaGBs
	 iVIVfAs8SCV3+yi+h9u71zMvq26XXs/LgGgbFAY9OKs3o9pnDfEbsyYmlQrXORlZ/2
	 Gl1rSf7yPNEisKboRVCgeT/2ChVLAZDzRZ8W/FaB5jORTL2ZO0+KAFNJzf0xtbEzU/
	 z/2UQv9VzalrWKRrFM1RDMPHE90WIofQTaqVWVXzCo5Xos56RjRXnr8+hYop+8pOEK
	 MHSxxwVeiYrjw==
From: Joshua Crofts <crofts@kernel.org>
Date: Sun, 08 Nov 2026 13:16:51 +0100
Subject: [PATCH 04/11] spi: stm32: remove redundant
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
Message-Id: <20261108-spi-dont-use-autosuspend-v1-4-3587b0183cbe@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794140215; l=1155;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=QvLywcRSSDKS5yUXJE6xHg7ZzXNpEk1qFSP2ldha5FY=;
 b=UTTkB8s0pLkl95WznVm4FajsxQmheX0X6774NiBDe/285YHOsX6ccbFnyzqX/95QBNjJhbtB/
 3/KkR7kUVHrBwqxUAEKCumgTN8RaYronv25TuXkKoqiSHoEuNJ8aUbV
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function calls.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/spi/spi-stm32.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 4c3ae546afc0..95994278cdaa 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -2544,7 +2544,6 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 
 	if (spi->mdma_rx)
 		dma_release_channel(spi->mdma_rx);
@@ -2574,7 +2573,6 @@ static void stm32_spi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 
 	if (ctrl->dma_tx)
 		dma_release_channel(ctrl->dma_tx);

-- 
2.56.0

