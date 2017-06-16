From: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH 00/15] spi: qup: Fixes and add support for >64k transfers
Date: Fri, 16 Jun 2017 14:28:43 +0530
Message-ID: <1497603538-12750-1-git-send-email-varada@codeaurora.org>
Cc: Varadarajan Narayanan <varada@codeaurora.org>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

v2:
	Incorporate feedback from Andy Gross, Sricharan, Stanimir Varbanov

	Modified the QUP-v1 dma completion sequence to QUP-v2 as per feedback.

	Removed code that used controller->xfer to identify extra interrupts,
	since with the fixes done to handle i/o completion we don't see
	extra interrupts.

v1:
	This series fixes some existing issues in the code for both
	interrupt and dma mode. Patches 1 - 11 are the fixes.
	Random failures/timeout are observed without these fixes.
	Also, the current driver does not support block transfers > 64K
	and the driver quietly fails. Patches 12 - 18 add support for this
	in both interrupt and dma mode.

	The entire series has been tested on ipq4019 with
	SPI-NOR flash for block sizes > 64k.

Varadarajan Narayanan (15):
  spi: qup: Enable chip select support
  spi: qup: Setup DMA mode correctly
  spi: qup: Add completion timeout for dma mode
  spi: qup: Add completion timeout for fifo/block mode
  spi: qup: Place the QUP in run mode before DMA transactions
  spi: qup: Fix error handling in spi_qup_prep_sg
  spi: qup: Fix transaction done signaling
  spi: qup: Do block sized read/write in block mode
  spi: qup: refactor spi_qup_io_config into two functions
  spi: qup: call io_config in mode specific function
  spi: qup: allow block mode to generate multiple transactions
  spi: qup: refactor spi_qup_prep_sg
  spi: qup: allow multiple DMA transactions per spi xfer
  spi: qup: Ensure done detection
  spi: qup: support for qup v1 dma

 .../devicetree/bindings/spi/qcom,spi-qup.txt       |   6 +
 drivers/spi/spi-qup.c                              | 629 ++++++++++++++-------
 2 files changed, 440 insertions(+), 195 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
