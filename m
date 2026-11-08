Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794140236;
	b=eX/0J3jceUmerjlmQ1JdtQLLmNKgVuauT9GSssMShz0QnPsnIUFnyJ+UJToFPba7qKvw
	 IoRO3vHJ7w3XczbaKPRxqxbPi477z4TgKWw7CWYbV9PYizVcFa5J9EJfOZdAV/OmJ2NQn
	 oH6JXfrCo13oXxzv55BB69/RINJ5tQS26Iug9qoY2UQeY2b+U/8hGVtd+9u3mb1lEBlIg
	 Cuhdz2ICha/s6p+c4dRFHQy//FBvu0dUTQkP5xRS9QaVAjrkIOsEzZod2euFBgKNJLLD7
	 JWsYN82zEpUNGq2JwcWtW2Zh6C4x3Olm/6Mlecj5/iIX+TN/4di6ucdtAKWowLRbpqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794140236;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=t0HhTPj4bzTBaikkJltYtx6Hu1FRWN4PirZ6ZWFxmvo=;
	b=AWKucsRvUS20auNtSa/YAtNxSyHnHH9wvkXqPLGoPeMVm6ySv/zohTxoy8p/qlb4hZ5R
	 cCaLKn9mW+fR6ZmYKmqZA1WZ8/XCsnX4uY2DmzCdvYg79Dk/5W483j19snuLQKprXNSAb
	 EpAEQprXW2tBztmmclDuN+JjJ2QsgP4QA0ZPRKD1G6lqP2WVytSiIkX6SokXXRWTmCfx7
	 rVZMgnqDO3UC0mfvYlVn6EnzaJ/77MrjRJEy+1CzWZBD1r1XuGa0omY7tIXsXZGmDvMml
	 YNW6FDO/yTTLPlrDwIsNjLE0kfy4onHfIKItO8Qbc1i3x82F9+4NfFqdZDzDA8BAmrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xt6D6o3w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF919606A334;
	Sun,  8 Nov 2026 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xt6D6o3w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6762E1F008A2;
	Sun,  8 Nov 2026 12:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794140235;
	bh=t0HhTPj4bzTBaikkJltYtx6Hu1FRWN4PirZ6ZWFxmvo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Xt6D6o3wwRmLzN1HgqrLJFG+iw7lbY42O4ANyK6/MQUzGsGtAMnfARTq9wTW8gmWx
	 rQ2EqDfMXU7i8S8Yddd3QBeEf3pN90lGN9W9PEUvfuWn0j3qB3qsSwwDatNjHLyPvz
	 HzB5cBousC4t6KlOklo4xmThMQOSPJg3sD91RLl94qwVBAyc8cxpxEfxEUx1pwwwsO
	 ysXUyuEe1XGfCTMGw2OoD1jMSDB6HlMp5NcCI5C198YzdAAik/gKYvIC3ADb2JYRiI
	 UzpvIDDI/Jtf0krhU7ItMYAN5FXib7fWfidwt45NB6LdLEg1Pnf/BPdwRBoYKkAE7P
	 vYudWIe4dDHVw==
From: Joshua Crofts <crofts@kernel.org>
Date: Sun, 08 Nov 2026 13:16:49 +0100
Subject: [PATCH 02/11] spi: cadence-quadspi: remove redundant
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
Message-Id: <20261108-spi-dont-use-autosuspend-v1-2-3587b0183cbe@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794140215; l=1162;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=uyKe4YBV0WQ4xjRxVeaEsXG0/WnAC3tiK57fwM2IAFg=;
 b=93g0ybMATTAxNpyewzVSnIR92o5FRQQxSwuay4wOjBW1FQjHkbqT39CYxeIHluV2ZLyEZNY2D
 SG1evYLXLYOD+B2LJyza+hd7pn1c0HFaiTfUHHvvDMNpDZ/Wc+rMECW
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function calls.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/spi/spi-cadence-quadspi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 73ea51c41f95..a276745095e4 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2001,7 +2001,6 @@ static int cqspi_probe(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
 	pm_runtime_put_noidle(dev);
-	pm_runtime_dont_use_autosuspend(dev);
 
 	cqspi_controller_enable(cqspi, 0);
 disable_clks:
@@ -2037,7 +2036,6 @@ static void cqspi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
 }
 
 static int cqspi_runtime_suspend(struct device *dev)

-- 
2.56.0

