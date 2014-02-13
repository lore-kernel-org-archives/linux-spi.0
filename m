From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: [PATH v2 0/2] spi: Add Qualcomm QUP SPI controller support
Date: Thu, 13 Feb 2014 18:21:12 +0200
Message-ID: <1392308472-30136-1-git-send-email-iivanov@mm-sol.com>
Cc: "Ivan T. Ivanov" <iivanov@mm-sol.com>, linux-spi@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
To: Mark Brown <broonie@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: "Ivan T. Ivanov" <iivanov@mm-sol.com>

Hi, 

Following two patches are adding initial support for SPI controller
available in Qualcomm SoC's.

Controller initialization is based on spi_qsd driver available in
CAF repository. 

Controller supports SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP modes, 
up to 4 CS's and from 4 to 32 bits per word. SPI_LOOP mode is limited 
to input FIFO buffer size.

Currently driver support only PIO mode, I am hopping to add also DMA
mode support with dmaengine patches developed by Andy.

Changes since first version:
 - Replace master::transfer_one_message with master::transfer_one and
   master::set_cs.   
 - Use full controller version for compatible string
   "qcom,spi-qup-v2.1.1" and "qcom,spi-qup-v2.2.1". 
 - Ensure that controller internal state is changed only if it is in
   valid state.  
 - Ensure that resources shared between interrupt and thread context
   are properly protected.
 - Use controller auto clock gating for run time power management, 
   instead full clock stop. This should have the same net result, right?
 - Simplify a bit read and write FIFO routines.
 - Several useless print messages removed.
 
Ivan T. Ivanov (2):
  spi: qup: Add device tree bindings information
  spi: Add Qualcomm QUP SPI controller support

 .../devicetree/bindings/spi/qcom,spi-qup.txt       |   85 ++
 drivers/spi/Kconfig                                |   13 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-qup.c                              |  837 ++++++++++++++++++++
 4 files changed, 936 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
 create mode 100644 drivers/spi/spi-qup.c

-- 
1.7.9.5
