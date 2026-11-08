Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794140222;
	b=DTBFC3crb3cHABhBGZ3qsAtuZ/eoYOBvxlbAn5a9uDe/KiB6SrIpWdrWdc6UibPtcta6
	 YKDtJ7SpaKcVI/gBncVxzfnCfAjPVz2OTO1kgk1EzAfhu4xy2TOtKlPzR8APazfKy6nF7
	 6DgXqyhkMbmvtYISl1qwxGPtOUA2Z7LsG29T4EFeglCZV9igl4ecX0PudvItJ7dokAZCF
	 CO1jzJZHHaNHpmGFUc4/6+EY6zXAmzPFncnunljT12NMEcOlS9IL2aATYheNZf5388tIm
	 CghXoZJvqIkqWbR0bGUwPjTI/gfTyaX0DFe/1OSFTGx1eCzrOw/29Sb//9Rn7j63VBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794140222;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=+QnPHIBmwdoJ1mg7wG97R78F4P6cWdZ4faiCfZ2d3bY=;
	b=wHsssGbOWnouQsUO177Iuf4oByf7iYfpwJhLktBz/yVu6GtCULA5zt3EM+2ElkcfuOiR
	 zRg4zIYfHXmpukjNXNK3WHck4Ua9IkIjfNtyaJdG3QXiooYWiU2ptOkdJC35n9KSffCkQ
	 L4e4vrikidKNM+DbuaA2TaL94NfGq0ky3JXVIKAbLC+tZGCXhrCTfXu3QIWfY/DmKTlbJ
	 fX+yyKnHfDOBu1rogu9HfV+uosLBP9S7MQxY9gjxO5HRnm8eDb3TfCkaPe/BKY9iMbbw8
	 s7YNetFlUwNGLZpw9yjZnS9vMTbOVNqrbzyOfHBYOa3jel/3YaUoJxdNmG05fMQIiZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JZgmf/U4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE27606A31C;
	Sun,  8 Nov 2026 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZgmf/U4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9394D1F0089F;
	Sun,  8 Nov 2026 12:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794140221;
	bh=+QnPHIBmwdoJ1mg7wG97R78F4P6cWdZ4faiCfZ2d3bY=;
	h=From:Subject:Date:To:Cc;
	b=JZgmf/U4Z9wyKVlkorX0WlwOTO91gix93zMroEa6FXjVqmvIdO0rSRZr0fxVWcr1/
	 MrKA2pu6TO7yhtHE9RxOdRTO5AL1OX0jZ2sKmj2jqVpNbVv1b43aOM06Y/DNSVBtO8
	 Dm5xvAlS+YtWcI/EGhzzqlzzXpO5KjvwF//yolW87dMlkX903ueJqEUA4m3wHY6mNf
	 vyTHlWOenWovV5E/sdhHUYGnOw+wCYC1SE6vaA5lIH8Ii70MBlacyyExYd3YfBeATX
	 DRr07PUi7fAhGO8T+Yg3y4ggMSM60v2Vw4EEM5/dmzPywFmhoVGxr16F9bPQg2NBZv
	 XmlK4BUNGNo6w==
From: Joshua Crofts <crofts@kernel.org>
Subject: [PATCH 00/11] spi: remove redundant
 pm_runtime_dont_use_autosuspend() calls
Date: Sun, 08 Nov 2026 13:16:47 +0100
Message-Id: <20261108-spi-dont-use-autosuspend-v1-0-3587b0183cbe@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQ6DMAxA0asgz7VEEE0JV6k6hNopXpIoJhUS4
 u5EjG/4/wDlIqwwdwcU/otKig3m0cF39fHHKNQMQz9YY/oJNQtSihtWZfR1S1o1cyR0zr2WMdg
 nE0HLc+Eg+71+f87zAl3CFTZqAAAA
X-Change-ID: 20261108-spi-dont-use-autosuspend-9997b4f65edd
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794140215; l=2214;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=LE9JAEK3uf/fTYpkCMzFmTQWpH/6qGCGHtNgMH5qPu0=;
 b=RPcJRMVGnrnJGMB1ZAmeSk2QRKr5GrfThl48m4h9ie56yEG6K6SvblDR3kPi5lJuxYr5MY0k6
 eaAn83VEbErAaMkMcr6mKQsFWEP7GT0wIpUCogUOVfocctLvl6Rhq2D
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function calls.

NOTE: Some drivers in drivers/spi/ (fsl-lpspi, imx, nxp-fspi, omap2-mcspi,
rpc-if) still keep their calls because they either rely on
pm_runtime_dont_use_autosuspend() before pm_runtime_disable() to flush
pending autosuspend delays and trigger synchronous runtime suspension,
or operate on a parent device rather than the platform device itself.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
Joshua Crofts (11):
      spi: axiado: remove redundant pm_runtime_dont_use_autosuspend() calls
      spi: cadence-quadspi: remove redundant pm_runtime_dont_use_autosuspend() calls
      spi: cadence: remove redundant pm_runtime_dont_use_autosuspend() calls
      spi: stm32: remove redundant pm_runtime_dont_use_autosuspend() calls
      spi: stm32-qspi: remove redundant pm_runtime_dont_use_autosuspend() calls
      spi: zynqmp-gqspi: remove redundant pm_runtime_dont_use_autosuspend() calls
      spi: mtk-nor: remove redundant pm_runtime_dont_use_autosuspend() calls
      spi: orion: remove redundant pm_runtime_dont_use_autosuspend() calls
      spi: rockchip-sfc: remove redundant pm_runtime_dont_use_autosuspend() calls
      spi: rtk-nor: remove redundant pm_runtime_dont_use_autosuspend() calls
      spi: tegra210-quad: remove redundant pm_runtime_dont_use_autosuspend() calls

 drivers/spi/spi-axiado.c          | 2 --
 drivers/spi/spi-cadence-quadspi.c | 2 --
 drivers/spi/spi-cadence.c         | 2 --
 drivers/spi/spi-mtk-nor.c         | 2 --
 drivers/spi/spi-orion.c           | 2 --
 drivers/spi/spi-rockchip-sfc.c    | 2 --
 drivers/spi/spi-rtk-nor.c         | 2 --
 drivers/spi/spi-stm32-qspi.c      | 2 --
 drivers/spi/spi-stm32.c           | 2 --
 drivers/spi/spi-tegra210-quad.c   | 2 --
 drivers/spi/spi-zynqmp-gqspi.c    | 2 --
 11 files changed, 22 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261108-spi-dont-use-autosuspend-9997b4f65edd

Best regards,
-- 
Joshua Crofts

