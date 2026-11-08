Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794140256;
	b=RAJGeuYUX3mh8i/Xoi8Vp8FspB8vwOmNnUBJFHWsCunMQ2gMKcOIljdGlw7Xokaadgym
	 oNix6Lr61gz5Otw4h7BtxMoaT3iJUgkYLb/HECNJ7Rfv20d+PYmccT3urzlhI8sFuEmxT
	 4LU28WcWcBMI5P6zbyV2HjUJlWxkPWJwn80TcFVAtiHPtk+uFT/P7H3JxYzjIfnxH5LwT
	 1CWJjtMeKvjx6hodYWtwVslIs7MVAFzvyIfAUEpKBd5up1VwgvtKSo8rm+1vjhAyqWVMa
	 8yTMGZq2WbYuwGBfUTgJzqfFldcHYfJfHalykEBhHLODeulcMMS+RtKY3cgy1kNJDOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794140256;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=6rdelwBDg+dMqAh9YJf04osZ8RwF/tmm4URL76mwa3w=;
	b=1AGdJ6rv0qzEwO/VqYItxG0n2dmz6Ojri4RvAwKt3LzvYFmCJ3JZ2YVQa2ftbR7P/+y3
	 9trZzAcmxfiZaFmmrk//I+v7nIXZmjOYDnFPN71hS6hNfeoU0rnJWR4ay6S++PWq341fy
	 CB5XulX5RdMF9d93gDmls878HdpDkKJOz3Uf1JRQQ2MuBjn0WaJWsApbEVSmriuewjAgK
	 yTo5hlLo/5c+wvxLPe1oQAPJWYMwK16rwLBQbcXhopXvI1hAoY1vEq7yuV7l4C+0jHEw5
	 YCo4Z8B1n9PS+Nv2MWeIy0SESvL0/I2yBSEWVcvNoHIQ/QdCUpxDbUXNWentajLuVWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGg0mmjA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED10606D80A;
	Sun,  8 Nov 2026 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGg0mmjA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB8B1F0089F;
	Sun,  8 Nov 2026 12:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794140255;
	bh=6rdelwBDg+dMqAh9YJf04osZ8RwF/tmm4URL76mwa3w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KGg0mmjAW4zSkZLAZrGgXi0iGZl3a+Dqk4jQjudYVLXDOaRCDsbjcKi0rRl9W3K4K
	 c0ESBltD+wYxPNOiKfDgaTNaVmcKFHgLM7bJUZAtri4sQ+xg+Ro5hBP/MOYAGRBWd2
	 YoGY//fu/okSHJpfYCxv6mUVatZLlI2WjP1Kl5bUgvuzR1CmalCicXrUf7PI+gOF9l
	 jYrdIfbiidEr3bMz5qKEkSZgFb3F+WwUcVPzJ74+cb1gJbAfPETPT1vvfIu8XtDY2y
	 977A+uR13VqBDVrz9bk/hDr/HPu9Mn4naufvivZDOLcKLz+2UeFy76Crk8u3mg2+98
	 NM6P7UQu7IoDQ==
From: Joshua Crofts <crofts@kernel.org>
Date: Sun, 08 Nov 2026 13:16:52 +0100
Subject: [PATCH 05/11] spi: stm32-qspi: remove redundant
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
Message-Id: <20261108-spi-dont-use-autosuspend-v1-5-3587b0183cbe@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794140215; l=1153;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=toqgrbHHm8bx0slhbz7guv4WcXlfLyxE8Ef7rFNNPDE=;
 b=Dl10lIimEbjxQcPFQglkgDiwyI8vueTbAfpV+yEqs25+R9eTBKhZeYyRRcLi4OONxS3Q+Pfk7
 4xkQAC/5NHJCRal7U5RkFXTaM6H6mkBdWgpVcGhbiLGlFRAMz/53bpN
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function calls.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/spi/spi-stm32-qspi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index b77daba6db83..4ca21a327a26 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -882,7 +882,6 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 	pm_runtime_put_noidle(qspi->dev);
 	pm_runtime_disable(qspi->dev);
 	pm_runtime_set_suspended(qspi->dev);
-	pm_runtime_dont_use_autosuspend(qspi->dev);
 err_dma_free:
 	stm32_qspi_dma_free(qspi);
 err_clk_disable:
@@ -904,7 +903,6 @@ static void stm32_qspi_remove(struct platform_device *pdev)
 	pm_runtime_put_noidle(qspi->dev);
 	pm_runtime_disable(qspi->dev);
 	pm_runtime_set_suspended(qspi->dev);
-	pm_runtime_dont_use_autosuspend(qspi->dev);
 	clk_disable_unprepare(qspi->clk);
 }
 

-- 
2.56.0

