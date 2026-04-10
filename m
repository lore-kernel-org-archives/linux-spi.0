Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC5E31E853;
	Fri, 10 Apr 2026 08:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775809136; cv=none; b=iaj/za6+xYt1152k+TJ6L7XhyV2MsvWF030bAGCZXbHNITJJ8vtEhXY/SI0V4mP4WRtWhQ6Xol2xD+8XMqbZC4n9N23pCLSpW3wNSar6XDN6z3caJTb4KI65fKTv/uWhTP/qaFLKHl9bxshyY0eNWqKPJTmV4lirAY9qy0lDbW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775809136; c=relaxed/simple;
	bh=4sRIntkc37GGHVHGxdR2uM5Brr4SDLIbD8BZ/vDvMUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l1f3p8xGhac1Z4bakf85mL7RNCe7XC8AAqAQsn04soQY7wiP7Gmo8cztX33Og4uoahYSSC7sgXw/6MZM87DbgAysylDgCCDM9H5qADB2EPW0oDXlMJrODXPupLfBiNaZdK+SHN6hR9rAzuWx1fJf07U9NuKY/fxx1VLkiRfg4ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCFe1E46; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCFe1E46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61614C19421;
	Fri, 10 Apr 2026 08:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775809136;
	bh=4sRIntkc37GGHVHGxdR2uM5Brr4SDLIbD8BZ/vDvMUI=;
	h=From:To:Cc:Subject:Date:From;
	b=tCFe1E46gAEIqCHHo5PIg8EVPncWIdkiRXIrNcp6YCXQQ2Y0vP/nfYyD1YRQRZeJg
	 OjcZO/gMKMhhqb0b5zAub/05/2izE1nLhnl19EKehUmAtpUgsiEWg6KDAiOheUu7NU
	 U89bEEwUGXfokMN0AXfiU9TFBcRX+78plLKDMHDuiO1V1h0NqTGVmK6t0cSbWPzgDg
	 0tVw1Y4tqDzHPJsh8fX2JJVmCSsSCf77NB0Sw/u7bw03keh7CXdMicKQWZzj4vE5Pw
	 D/p+BKZuyDkIBecNB/l9w/XpjCXOyuJtUoymuHVbfRO0SDt4FYH8bfnXY3/bLQbGei
	 tKob4OSHm6BCA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wB74n-000000026uG-3MOV;
	Fri, 10 Apr 2026 10:18:53 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 00/26] spi: fix controller deregistration (part 2/2)
Date: Fri, 10 Apr 2026 10:17:30 +0200
Message-ID: <20260410081757.503099-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device managed registration generally only works if all involved
resources are managed as otherwise resources may be disabled or freed
while they are still in use.

This series fixes the SPI controller drivers that get this wrong by
disabling resources such as clocks, DMA and interrupts while the
controller (and its devices) are still registered, which can lead to
issues like system errors due to unclocked accesses, NULL-pointer
dereferences, hangs or just prevent SPI device drivers from doing I/O
during during deregistration (e.g. to power down devices).

I decided to split these fixes in two parts consisting of 20 and 26
patches respectively in order not to spam the lists too much.

I've also prepared a follow-on series to convert the drivers here that
do not yet use device managed controller allocation (which avoids taking
extra references during deregistration).

After that it should be possible to change the SPI API so that it no
longer drops a reference during deregistration without too much effort
(cf. [1]).

Note that this series is based on spi/for-next which specifically has
commit 1f8fd9490e31 ("spi: zynq-qspi: Simplify clock handling with
devm_clk_get_enabled()") (which is not in the for-7.1 branch).

Johan


[1]
https://lore.kernel.org/lkml/20260325145319.1132072-1-johan@kernel.org/


Johan Hovold (26):
  spi: mt65xx: fix controller deregistration
  spi: mtk-nor: fix controller deregistration
  spi: mxs: fix controller deregistration
  spi: npcm-pspi: fix controller deregistration
  spi: omap2-mcspi: fix controller deregistration
  spi: pic32: fix controller deregistration
  spi: pic32-sqi: fix controller deregistration
  spi: pl022: fix controller deregistration
  spi: qup: fix controller deregistration
  spi: rspi: fix controller deregistration
  spi: s3c64xx: fix controller deregistration
  spi: sh-hspi: fix controller deregistration
  spi: sh-msiof: fix controller deregistration
  spi: sifive: fix controller deregistration
  spi: slave-mt27xx: fix controller deregistration
  spi: sprd: fix controller deregistration
  spi: st-ssc4: fix controller deregistration
  spi: sun4i: fix controller deregistration
  spi: sun6i: fix controller deregistration
  spi: syncuacer: fix controller deregistration
  spi: tegra114: fix controller deregistration
  spi: tegra20-sflash: fix controller deregistration
  spi: ti-qspi: fix controller deregistration
  spi: uniphier: fix controller deregistration
  spi: zynqmp-gqspi: fix controller deregistration
  spi: zynq-qspi: fix controller deregistration

 drivers/spi/spi-mt65xx.c         |  4 +++-
 drivers/spi/spi-mtk-nor.c        |  4 +++-
 drivers/spi/spi-mxs.c            |  8 +++++++-
 drivers/spi/spi-npcm-pspi.c      |  8 +++++++-
 drivers/spi/spi-omap2-mcspi.c    |  8 +++++++-
 drivers/spi/spi-pic32-sqi.c      |  8 +++++++-
 drivers/spi/spi-pic32.c          | 11 ++++++++---
 drivers/spi/spi-pl022.c          |  8 +++++++-
 drivers/spi/spi-qup.c            |  8 +++++++-
 drivers/spi/spi-rspi.c           | 10 ++++++++--
 drivers/spi/spi-s3c64xx.c        |  4 +++-
 drivers/spi/spi-sh-hspi.c        | 10 ++++++++--
 drivers/spi/spi-sh-msiof.c       | 10 ++++++++--
 drivers/spi/spi-sifive.c         |  8 +++++++-
 drivers/spi/spi-slave-mt27xx.c   | 10 +++++++++-
 drivers/spi/spi-sprd.c           |  8 ++++++--
 drivers/spi/spi-st-ssc4.c        |  8 +++++++-
 drivers/spi/spi-sun4i.c          | 10 +++++++++-
 drivers/spi/spi-sun6i.c          |  8 +++++++-
 drivers/spi/spi-synquacer.c      |  8 +++++++-
 drivers/spi/spi-tegra114.c       |  8 +++++++-
 drivers/spi/spi-tegra20-sflash.c |  8 +++++++-
 drivers/spi/spi-ti-qspi.c        | 14 ++++++--------
 drivers/spi/spi-uniphier.c       |  8 +++++++-
 drivers/spi/spi-zynq-qspi.c      | 15 +++++++++++----
 drivers/spi/spi-zynqmp-gqspi.c   |  4 +++-
 26 files changed, 176 insertions(+), 42 deletions(-)

-- 
2.52.0

