Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA5B4052DC;
	Mon,  3 Aug 2026 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767992; cv=none; b=p7lFQffN0KWoiG6MqSpXaZxLuE1tTWEPGXlfa/Eui90btQgnNduNqdDMHRpYd2b/N35h+w/cbhHoam4KtRLAhCS9MQsjVbtdtr4sb4TOPm5Z4iyRWNJAFhKUz2n4MIk9XiWqEqAC0vY15PjKT3m+l9uuXUXJFZ83tbf0F3pZrU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767992; c=relaxed/simple;
	bh=HUVeVkSUXH3iu5qXIK/n2WdnDY/c6GWVgER4POFFIso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fGQtUWDe7Q0jY8972G3Z3n88rNcgfPrUNy6YLRtZP2rIl/Ge3rN+FwfjrHpRe+/78RnyLmX0fUTDncTMD0D2Sm4VAWQwkTiAxmtKSMR0cu27BygXmJHK9T92/p8xeuQp92LfNaD5TlGtjsRgFxdDw/E/+iYAJf4Kd9KlUdaTTYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jci4Zq/I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jci4Zq/I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B098E1F000E9;
	Mon,  3 Aug 2026 14:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785767990;
	bh=53BGIFyKdu/7aCeDraUPm6T1Lxp2D2cxRgdZdEBPRw0=;
	h=From:To:Cc:Subject:Date;
	b=Jci4Zq/INVQtnjBdMB6wBjafGLZQuwBXROFk2hRwNEw77HGe8uIViwMb/tmh3B+NB
	 WvpWJomospD+zWd6GpuHGfQsFWX6t1ljPQaQWrzjnnvW7Iz2ws1nMU2qj4UuwQVBC3
	 PC3w2Wt4PxODRxmidoD8AOOXpf0dXiQdhK+eS8g5yI9RSx5MpYWm4QBPtfVzHUMVgE
	 TsmodqMSRD6gWSydmJUDXq2tU1DUJyRCcT9c6lerI0BNljPPqHVI9TOHeMtmptdyp+
	 vbH8rNuJWfbKCvUaDsBKDobKqB+1g1hocUIce0psTDcGP5L7RfM3aiTn0VhBpOc41L
	 1PzTSOcAvrdzw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Radu Pirea <radu_nicolae.pirea@upb.ro>,
	Vladimir Moravcevic <vmoravcevic@axiado.com>,
	Tzu-Hao Wei <twei@axiado.com>,
	Swark Yang <syang@axiado.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	William Zhang <william.zhang@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Vladimir Oltean <olteanv@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linusw@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Li-hao Kuo <lhjeff911@gmail.com>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Michal Simek <michal.simek@amd.com>
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/39] spi: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:24 +0800
Message-ID: <20260803142003.12857-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the modern PM macros for the suspend and resume functions to be
automatically dropped by the compiler when CONFIG_PM or
CONFIG_PM_SLEEP are disabled, without having to use #ifdef guards or
__maybe_unused.

Compiled testd for arm, arm64, riscv and riscv64 with below
combinations:
!PM && !PM_SLEEP
PM && !PM_SLEEP
PM && PM_SLEEP

Jisheng Zhang (39):
  spi: atmel-quadspi: use modern PM macros
  spi: amlogic-spifc-a1: use modern PM macros
  spi: at91-usart: use modern PM macros
  spi: axiado: use modern PM macros
  spi: bcm-qspi: use modern PM macros
  spi: bcm63xx-hsspi: use modern PM macros
  spi: bcmbca-hsspi: use modern PM macros
  spi: cadence: use modern PM macros
  spi: coldfire-qspi: use modern PM macros
  spi: dln2: use modern PM macros
  spi: dw-pci: use modern PM macros
  spi: spi-fsl-dspi: use modern PM macros
  spi: fsl-espi: use modern PM macros
  spi: fsl-lpspi: use modern PM macros
  spi: qcom-geni: use modern PM macros
  spi: img-spfi: use modern PM macros
  spi: loongson: use modern PM macros
  spi: meson-spifc: use modern PM macros
  spi: mt65xx: use modern PM macros
  spi: mtk-nor: use modern PM macros
  spi: mxic: use modern PM macros
  spi: omap2-mcspi: use modern PM macros
  spi: orion: use modern PM macros
  spi: pl022: use modern PM macros
  spi: spi-qcom-qspi: use modern PM macros
  spi: qup: use modern PM macros
  spi: rockchip-sfc: use modern PM macros
  spi: rockchip: use modern PM macros
  spi: s3c64xx: use modern PM macros
  spi: slave-mt27xx: use modern PM macros
  spi: sprd: use modern PM macros
  spi: sunplus-sp7021: use modern PM macros
  spi: syncuacer: use modern PM macros
  spi: tegra114: use modern PM macros
  spi: tegra20-sflash: use modern PM macros
  spi: tegra20-slink: use modern PM macros
  spi: tegra210-quad: use modern PM macros
  spi: topcliff-pch: use modern PM macros
  spi: zynqmp-gqspi: use modern PM macros

 drivers/spi/atmel-quadspi.c        | 16 +++++-----
 drivers/spi/spi-amlogic-spifc-a1.c | 15 ++++------
 drivers/spi/spi-at91-usart.c       |  8 ++---
 drivers/spi/spi-axiado.c           | 15 +++++-----
 drivers/spi/spi-bcm-qspi.c         |  6 ++--
 drivers/spi/spi-bcm63xx-hsspi.c    |  8 ++---
 drivers/spi/spi-bcmbca-hsspi.c     |  8 ++---
 drivers/spi/spi-brcmstb-qspi.c     |  2 +-
 drivers/spi/spi-cadence.c          | 15 +++++-----
 drivers/spi/spi-coldfire-qspi.c    | 12 +++-----
 drivers/spi/spi-dln2.c             | 11 ++-----
 drivers/spi/spi-dw-pci.c           |  6 ++--
 drivers/spi/spi-fsl-dspi.c         |  6 ++--
 drivers/spi/spi-fsl-espi.c         | 11 ++-----
 drivers/spi/spi-fsl-lpspi.c        |  6 ++--
 drivers/spi/spi-geni-qcom.c        | 15 +++++-----
 drivers/spi/spi-img-spfi.c         | 11 ++-----
 drivers/spi/spi-iproc-qspi.c       |  2 +-
 drivers/spi/spi-loongson-core.c    |  4 +--
 drivers/spi/spi-loongson-pci.c     |  2 +-
 drivers/spi/spi-loongson-plat.c    |  2 +-
 drivers/spi/spi-meson-spifc.c      | 14 ++++-----
 drivers/spi/spi-mt65xx.c           | 11 ++-----
 drivers/spi/spi-mtk-nor.c          | 15 +++++-----
 drivers/spi/spi-mxic.c             |  9 +++---
 drivers/spi/spi-omap2-mcspi.c      |  9 +++---
 drivers/spi/spi-orion.c            | 12 +++-----
 drivers/spi/spi-pl022.c            | 10 ++-----
 drivers/spi/spi-qcom-qspi.c        | 16 +++++-----
 drivers/spi/spi-qup.c              | 14 ++++-----
 drivers/spi/spi-rockchip-sfc.c     | 12 +++-----
 drivers/spi/spi-rockchip.c         | 12 +++-----
 drivers/spi/spi-s3c64xx.c          | 12 +++-----
 drivers/spi/spi-slave-mt27xx.c     | 12 +++-----
 drivers/spi/spi-sprd.c             |  9 +++---
 drivers/spi/spi-sunplus-sp7021.c   | 16 +++++-----
 drivers/spi/spi-synquacer.c        | 10 +++----
 drivers/spi/spi-tegra114.c         | 10 +++----
 drivers/spi/spi-tegra20-sflash.c   | 10 +++----
 drivers/spi/spi-tegra20-slink.c    | 14 ++++-----
 drivers/spi/spi-tegra210-quad.c    | 14 ++++-----
 drivers/spi/spi-topcliff-pch.c     | 47 +++++++++++++-----------------
 drivers/spi/spi-zynqmp-gqspi.c     | 15 +++++-----
 43 files changed, 195 insertions(+), 289 deletions(-)

-- 
2.53.0

