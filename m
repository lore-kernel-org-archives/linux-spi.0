From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 00/17] SPI: Fine-tuning for several function implementations
Date: Fri, 13 Jan 2017 18:05:20 +0100
Message-ID: <1413e173-dbac-7a6e-09cb-2287300a335e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
To: linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 13 Jan 2017 17:50:23 +0100

Several update suggestions were taken into account
from static source code analysis.

Markus Elfring (17):
  Use kcalloc() in spi_register_board_info()
  Adjust checks for null pointers in two functions
  fsl: Use kcalloc() in of_fsl_spi_get_chipselects()
  fsl: Use kmalloc_array() in of_fsl_spi_get_chipselects()
  fsl: Combine substrings for two messages
  mpc52xx: Use kmalloc_array() in mpc52xx_spi_probe()
  mpc52xx: Combine substrings for two messages
  ppc4xx: Use kcalloc() in spi_ppc4xx_of_probe()
  ppc4xx: Combine substrings for a message in spi_ppc4xx_of_probe()
  ppc4xx: Adjust checks for null pointers in two functions
  topcliff-pch: Use kcalloc() in pch_spi_handle_dma()
  topcliff-pch: Improve size determinations in pch_spi_probe()
  topcliff-pch: Delete an unnecessary return statement in two functions
  topcliff-pch: Adjust six checks for null pointers
  topcliff-pch: Combine substrings for four messages
  topcliff-pch: Delete an error message for a failed memory allocation in pch_spi_set_tx()
  topcliff-pch: One check less in pch_spi_set_tx()

 drivers/spi/spi-fsl-spi.c      | 17 +++++-----
 drivers/spi/spi-mpc52xx.c      | 12 +++----
 drivers/spi/spi-ppc4xx.c       | 15 ++++-----
 drivers/spi/spi-topcliff-pch.c | 71 +++++++++++++++++++++---------------------
 drivers/spi/spi.c              | 10 +++---
 5 files changed, 63 insertions(+), 62 deletions(-)

-- 
2.11.0
