From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v3 0/2] spi: sh-hspi: Do not specifically request shyway_clk clock
Date: Mon, 14 Apr 2014 10:41:35 +0900
Message-ID: <1397439698-30123-1-git-send-email-horms+renesas@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>,
	Simon Horman <horms+renesas@verge.net.au>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-sh@vger.kernel.org
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Rather than requesting the shyway_clk call clk_get with
the device and a NULL con_id.

This is in keeping with the way that clk_get() is called
on other drivers used by Renesas Gen 1 SoCs. And I believe
it is compatible with supplying clocks via DT, unlike the current code.


This series supplies a fix for the r8a7778, a consumer of the driver,
so that the hspi clocks it supplies have the correct source.

And a fix for the sh-hspi driver to address the problem
described above.


Mark, as the first mach-shmobile patch is a run-time dependency for the
second SPI driver patch could you consider taking both of them?

I have checked and I do not expect any conflicts anywhere between
v3.14-rc1 and what I have queued up in the devel branch of my renesas tree.


Simon Horman (2):
  ARM: shmobile: r8a7778: Use clks as MSTP007 parent
  spi: sh-hspi: Do not specifically request shyway_clk clock

 arch/arm/mach-shmobile/clock-r8a7778.c | 2 +-
 drivers/spi/spi-sh-hspi.c              | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.8.5.2

