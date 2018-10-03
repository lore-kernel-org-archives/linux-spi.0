From: Alok Chauhan <alokc@codeaurora.org>
Subject: [PATCH V5 0/3] spi-geni-qcom: QUP SPI GENI driver and SPI device tree bindings
Date: Wed,  3 Oct 2018 19:14:22 +0530
Message-ID: <1538574265-30235-1-git-send-email-alokc@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>
To: swboyd@chromium.org, dianders@chromium.org, broonie@kernel.org,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch series adds the driver for GENI based Qualcomm Universal
Peripheral (QUP) Serial Peripheral Interface (SPI) and SPI device tree
bindings.

An overview of the GENI SE SPI controller device tree components are in
patch 2 and 1. Patch 3 adds the SPI driver for GENI QUP HW.

changes from v4:
- Patch 1/3 and 2/3 are unchanged
- squashed patch 4/4 into 3/4 as suggested
- Patch 3/3 changes are follows:
        * Add SPI M_COMMAND OPCODE to handle different geni command
	  handling
        * Remove forward declaration of ISR
        * Remove unused variable rx_fifo_depth in spi_master structure
        * Declare cur_speed_hz as unsigned long to match clock framework
        * Declare cur_xfer as const pointer
        * Newline in error print
        * Correct consecutive spelling
        * Rename trans_len to len and restructure the lines in
	  setup_fifo_xfer()
        * Rename timeout to time_left and restructure the
	  handle_fifo_timeout()
        * Add check for '0' bytes transfer as part of
	  spi_geni_transfer_one()
        * Correct if-else check in geni_byte_per_fifo_word()
        * Remove NULL current transfer check in
	  geni_spi_handle_tx()/geni_spi_handle_rx() and make these
	  functions as void.
        * Hoist rx_last_byte_valid variable into function scope
        * Remove RT check in ISR and add cur_mcmd handling
        * Correct the error prints in ISR
        * In spi_alloc_master() pass 2nd arg as sizeof(*mas) for code
	  clarity
        * Use ret = PTR_ERR(se->base) for devm_ioremap_resource() err
	  return
        * Move request irq code to probe() and used request_irq() in place
	  of devm_request_irq()
        * Rewrite suspend/resume function
        * Add MODULE_DEVICE_TABLE(of, spi_geni_dt_match);
        * Remove include/linux/spi/spi-geni-qcom.h file
	

Dilip Kota (2):
  dt-bindings: soc: qcom: Remove SPI controller maximum frequency
    binding
  dt-bindings: soc: qcom: GENI SE SPI controller device tree binding

Girish Mahadevan (1):
  spi: spi-geni-qcom: Add SPI driver support for GENI based QUP

 .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  |  29 +-
 .../devicetree/bindings/spi/qcom,spi-geni-qcom.txt |  39 ++
 drivers/spi/Kconfig                                |  12 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-geni-qcom.c                        | 703 +++++++++++++++++++++
 5 files changed, 757 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt
 create mode 100644 drivers/spi/spi-geni-qcom.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
