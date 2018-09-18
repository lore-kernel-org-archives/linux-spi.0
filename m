From: Dilip Kota <dkota@codeaurora.org>
Subject: [PATCH V4 0/4] spi-geni-qcom: QUP SPI GENI driver and SPI device tree bindings
Date: Tue, 18 Sep 2018 23:37:22 +0530
Message-ID: <1537294047-12093-1-git-send-email-dkota@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, Dilip Kota <dkota@codeaurora.org>
To: swboyd@chromium.org, dianders@chromium.org, broonie@kernel.org,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

In this V4 series, submitted changes to remove SPI controller
max-frquency device tree binding as it is controller
specific property.

Move the GENI SE SPI controller device tree bindings
documentation to devicetree/bindings/spi/qcom,spi-geni-qcom.txt.

Address the reviewer comments to spi-geni-qcom.c in patch-V3.

Adds changes in spi-geni-qcom.c to plugin set_cs API to SPI framework.

Dilip Kota (3):
  dt-bindings: soc: qcom: Remove SPI controller maximum frequency entry
  dt-bindings: soc: qcom: GENI SE SPI controller device tree binding
  spi: spi-geni-qcom: Plugin API to assert and de-assert Chipselect

Girish Mahadevan (1):
  spi: spi-geni-qcom: Add SPI driver support for GENI based QUP

 .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  |  29 +-
 .../devicetree/bindings/spi/qcom,spi-geni-qcom.txt |  39 ++
 drivers/spi/Kconfig                                |  12 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-geni-qcom.c                        | 680 +++++++++++++++++++++
 include/linux/spi/spi-geni-qcom.h                  |  14 +
 6 files changed, 748 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt
 create mode 100644 drivers/spi/spi-geni-qcom.c
 create mode 100644 include/linux/spi/spi-geni-qcom.h

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
