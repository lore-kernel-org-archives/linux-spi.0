From: Volker Haspel <volker.haspel@linutronix.de>
Subject: [PATCH v2 0/1] spi: spi-fsl-qspi: call spi_unregister_controller
Date: Tue, 12 Mar 2019 11:12:02 +0100
Message-ID: <20190312101203.14207-1-volker.haspel@linutronix.de>
Cc: linux-spi@vger.kernel.org, han.xu@nxp.com,
        volker.haspel@linutronix.de, john.ogness@linutronix.de
To: broonie@kernel.org, linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Changes since v1:
 * use devm_spi_register_controller() instead of calling
   spi_unregister_controller() in the remove function

Thanks
Volker

Volker Haspel (1):
  spi: spi-fsl-qspi: use devm_spi_register_controller

 drivers/spi/spi-fsl-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.11.0
