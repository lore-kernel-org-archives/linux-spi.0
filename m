From: han.xu@nxp.com
Subject: [PATCH 0/3] dynamically alloc AHB memory
Date: Wed, 10 Jul 2019 10:31:25 +0800
Message-ID: <20190710023128.13115-1-han.xu@nxp.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
To: han.xu@nxp.com, broonie@kernel.org, ashish.kumar@nxp.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Han Xu <han.xu@nxp.com>

i.MX platforms reserved 256M memory area for FSPI/QSPI AHB memory, it
may failed to alloc all of them at once on some platforms. These patches
allow the controller alloc AHB as needed.

i.MX7D RX FIFO should be 128B rather than 512B.

Han Xu (3):
  spi: spi-nxp-fspi: dynamically alloc AHB memory for FSPI
  spi: spi-fsl-qspi: change i.MX7D RX FIFO size
  spi: spi-fsl-qspi: dynamically alloc AHB memory for QSPI

 drivers/spi/spi-fsl-qspi.c | 60 +++++++++++++++++++++++++++-----------
 drivers/spi/spi-nxp-fspi.c | 39 ++++++++++++++++++++-----
 2 files changed, 74 insertions(+), 25 deletions(-)

-- 
2.17.1
