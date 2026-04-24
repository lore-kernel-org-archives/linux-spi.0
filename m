Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5490B3E024C;
	Fri, 24 Apr 2026 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777042783; cv=none; b=n9iis3kZW4cyoSI0jITEwDip8uqhGlEbhi9nmBLz2Q2/ZAKKVmVWrOLZ+LiEkhSc060fDbhEQMRtIpwejVx/HbeiO541F5gifYBkA7EjwI4T7CjF+Y2mKorFPeA53JiaGHTni1sqoFb7QkEKCFTqJA3wqOAZUq8K7j11fnfcnLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777042783; c=relaxed/simple;
	bh=zEH+jwk9ruNBgpMgbaWT4Ntt4+seT6nb5uYY2vl2nEM=;
	h=Message-ID:From:To:Cc:Subject:Date; b=K6mhj3WRma2ZO57n5fMNdKmYZdkkhhwsSADrq+LA2EiAesNfvZMiIRIxWgBctCc52eNX5Ls+nWHEAJHrbQhTJl9feWe5DbJkNsd1IxnYg6elp2+ByP3YN3XFR75UVJLcQ/v3g5uqSqtowYW5SBFgnt/ZivFErxg7RfHgsH7rdIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Er9FUf8I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Er9FUf8I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987D1C19425;
	Fri, 24 Apr 2026 14:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777042782;
	bh=zEH+jwk9ruNBgpMgbaWT4Ntt4+seT6nb5uYY2vl2nEM=;
	h=From:To:Cc:Subject:Date:From;
	b=Er9FUf8InepWLyNy/bVOF4uCNvn3zNtAbVCAiBuIAh3RNNP3rEr2EIYilxR0RYNZq
	 IVzTD5cjPyvgfGuFsUI7B8Xv7bdjbficZvPLjLB0U3NL7VNkYAOSTt99jZBedgkkij
	 MCVw4LsXpOT2yoSUwrAMeQt+/luR1LcOw7OkUkZ8lLK+tXZIRi8uAG5yN6lr1e7IjM
	 9uK2SH7WBNI5k5wLKsMYCRrkbVaiQFhqloYgh0K7rjXufEWm5xc2xuDSF9KHWx9OPP
	 wJzIOhViLVPhWx+/wTtrAxqSLDK+EnNG9kw9caDWXsuwCCtxUqi84D9TKJV8ab5X5j
	 KIpdZqbWxOEXw==
Message-ID: <b1a629e07ae2ecbbd869f15441a95e06@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.1-merge-window
Date: Fri, 24 Apr 2026 15:59:30 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 028ef9c96e96197026887c0f092424679298aae8:

  Linux 7.0 (2026-04-12 13:48:06 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.1-merge-window

for you to fetch changes up to 16ab65df5d867961a79cef366cdb33f09ebda603:

  spi: fix resource leaks on device setup failure (2026-04-22 15:10:22 +0100)

----------------------------------------------------------------
spi: Fixes for v7.1

This is quite a big set of fixes, almost all from Johan Hovold who is on
an ongoing quest to clean up issues with probe and removal handling in
drivers.  There isn't anything too concerning here especially with the
deregistration stuff which will very rarely get run in production
systems since this is all platform devices in the SoC on embedded
hardware, but it's all real issues which should be fixed.  There's more
in flight here.

We also have a few other minor fixes, one from Felix Gu along the same
lines as Johan's work and a couple of documentation things.

----------------------------------------------------------------
Dewei Meng (1):
      spi: Fix the error description in the `ptp_sts_word_post` comment

Felix Gu (1):
      spi: mtk-snfi: fix memory leak in probe

Johan Hovold (20):
      MAINTAINERS: update Socionext SPI maintainer address
      MAINTAINERS: update second Socionext SPI maintainer address
      spi: cadence: fix controller deregistration
      spi: cadence-quadspi: fix controller deregistration
      spi: mpc52xx: fix controller deregistration
      spi: mpc52xx: fix use-after-free on unbind
      spi: mxic: fix controller deregistration
      spi: orion: fix controller deregistration
      spi: topcliff-pch: fix controller deregistration
      spi: topcliff-pch: fix use-after-free on unbind
      spi: mpc52xx: fix use-after-free on registration failure
      spi: imx: fix runtime pm leak on probe deferral
      spi: orion: fix runtime pm leak on unbind
      spi: orion: fix clock imbalance on registration failure
      spi: orion: clean up probe return value
      spi: axiado: fix runtime pm imbalance on probe failure
      spi: axiado: rename probe error labels
      spi: axiado: clean up probe return value
      spi: fix resource leaks on device setup failure
      spi: fix controller cleanup() documentation

Krzysztof Kozlowski (1):
      spi: dt-bindings: fsl: Correct GPIO flags in the example

Mark Brown (4):
      spi: fix explicit controller deregistration
      spi: orion: runtime PM fixes
      spi: axiado: spi: axiado: fix runtime pm imbalance on probe failure
      spi: fix resource leaks on device setup failure

 Documentation/devicetree/bindings/spi/fsl,spi.yaml |   6 +-
 .../bindings/spi/microchip,mpfs-spi.yaml           |   4 +-
 .../bindings/spi/renesas,rzv2h-rspi.yaml           |  52 +++++-
 MAINTAINERS                                        |   4 +-
 drivers/spi/Kconfig                                |   4 +-
 drivers/spi/spi-amlogic-spisg.c                    |  10 +-
 drivers/spi/spi-aspeed-smc.c                       |   9 +-
 drivers/spi/spi-at91-usart.c                       |   8 +-
 drivers/spi/spi-atcspi200.c                        |  29 ++--
 drivers/spi/spi-atmel.c                            |   8 +-
 drivers/spi/spi-axiado.c                           |  32 ++--
 drivers/spi/spi-bcm63xx-hsspi.c                    |  54 +++----
 drivers/spi/spi-bcm63xx.c                          |   8 +-
 drivers/spi/spi-bcmbca-hsspi.c                     |  53 +++----
 drivers/spi/spi-cadence-quadspi.c                  |   8 +-
 drivers/spi/spi-cadence.c                          |   6 +-
 drivers/spi/spi-cavium-octeon.c                    |   8 +-
 drivers/spi/spi-cavium-thunderx.c                  |   8 +-
 drivers/spi/spi-ch341.c                            |  43 +++--
 drivers/spi/spi-coldfire-qspi.c                    |  10 +-
 drivers/spi/spi-cs42l43.c                          |   4 +-
 drivers/spi/spi-dln2.c                             |   8 +-
 drivers/spi/spi-ep93xx.c                           |   8 +-
 drivers/spi/spi-fsl-espi.c                         |  10 +-
 drivers/spi/spi-fsl-lpspi.c                        |  68 ++++----
 drivers/spi/spi-fsl-qspi.c                         |   3 +-
 drivers/spi/spi-fsl-spi.c                          |  14 +-
 drivers/spi/spi-hisi-kunpeng.c                     |  17 +-
 drivers/spi/spi-img-spfi.c                         |   8 +-
 drivers/spi/spi-imx.c                              |  42 ++---
 drivers/spi/spi-lantiq-ssc.c                       |   8 +-
 drivers/spi/spi-meson-spicc.c                      |   8 +-
 drivers/spi/spi-microchip-core-qspi.c              |  12 +-
 drivers/spi/spi-microchip-core-spi.c               |   4 +-
 drivers/spi/spi-mpc52xx.c                          |   9 +-
 drivers/spi/spi-mpfs.c                             |   4 +-
 drivers/spi/spi-mt65xx.c                           |   4 +-
 drivers/spi/spi-mtk-nor.c                          |   4 +-
 drivers/spi/spi-mtk-snfi.c                         |  20 ++-
 drivers/spi/spi-mxic.c                             |   3 +-
 drivers/spi/spi-mxs.c                              |   8 +-
 drivers/spi/spi-npcm-fiu.c                         |   8 -
 drivers/spi/spi-npcm-pspi.c                        |   8 +-
 drivers/spi/spi-nxp-fspi.c                         |   3 +-
 drivers/spi/spi-nxp-xspi.c                         |   3 +-
 drivers/spi/spi-omap2-mcspi.c                      |  25 ++-
 drivers/spi/spi-orion.c                            |  20 ++-
 drivers/spi/spi-pic32-sqi.c                        |   8 +-
 drivers/spi/spi-pic32.c                            |  11 +-
 drivers/spi/spi-pl022.c                            |  18 ++-
 drivers/spi/spi-pxa2xx-dma.c                       |   6 +-
 drivers/spi/spi-pxa2xx.c                           |  11 +-
 drivers/spi/spi-qup.c                              |   8 +-
 drivers/spi/spi-rockchip.c                         |  40 ++---
 drivers/spi/spi-rspi.c                             |  10 +-
 drivers/spi/spi-rzv2h-rspi.c                       |  60 +++----
 drivers/spi/spi-s3c64xx.c                          |   9 +-
 drivers/spi/spi-sh-hspi.c                          |  10 +-
 drivers/spi/spi-sh-msiof.c                         |  10 +-
 drivers/spi/spi-sifive.c                           |  29 ++--
 drivers/spi/spi-slave-mt27xx.c                     |  10 +-
 drivers/spi/spi-sn-f-ospi.c                        |   2 +-
 drivers/spi/spi-sprd.c                             |   8 +-
 drivers/spi/spi-st-ssc4.c                          |   8 +-
 drivers/spi/spi-stm32-ospi.c                       |   5 -
 drivers/spi/spi-stm32.c                            |  72 +++------
 drivers/spi/spi-sun4i.c                            |  10 +-
 drivers/spi/spi-sun6i.c                            |   8 +-
 drivers/spi/spi-sunplus-sp7021.c                   |  15 +-
 drivers/spi/spi-synquacer.c                        |   8 +-
 drivers/spi/spi-tegra114.c                         |   8 +-
 drivers/spi/spi-tegra20-sflash.c                   |   8 +-
 drivers/spi/spi-tegra20-slink.c                    |  26 ++-
 drivers/spi/spi-tegra210-quad.c                    |  22 ++-
 drivers/spi/spi-ti-qspi.c                          |  14 +-
 drivers/spi/spi-topcliff-pch.c                     |  11 +-
 drivers/spi/spi-uniphier.c                         |  24 ++-
 drivers/spi/spi-zynq-qspi.c                        |  15 +-
 drivers/spi/spi-zynqmp-gqspi.c                     |   4 +-
 drivers/spi/spi.c                                  | 174 ++++++++++++++-------
 include/linux/spi/spi-mem.h                        |  16 +-
 include/linux/spi/spi.h                            |   5 +-
 82 files changed, 850 insertions(+), 550 deletions(-)
