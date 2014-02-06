From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: [PATCH 0/2] spi: Add Qualcomm QUP SPI controller support
Date: Thu,  6 Feb 2014 18:57:46 +0200
Message-ID: <1391705868-20091-1-git-send-email-iivanov@mm-sol.com>
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
up to 3 CS's and from 4 to 32 bits per word. SPI_LOOP mode is limited 
to input FIFO buffer size.

Currently driver support only PIO mode, I am hopping to add also DMA
mode support with dmaengine patches developed by Andy.

Regards,
Ivan

Ivan T. Ivanov (2):
  spi: qup: Add device tree bindings information
  spi: Add Qualcomm QUP SPI controller support

 .../devicetree/bindings/spi/qcom,spi-qup.txt       |   86 ++
 drivers/spi/Kconfig                                |   14 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-qup.c                              |  898 ++++++++++++++++++++
 4 files changed, 999 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
 create mode 100644 drivers/spi/spi-qup.c

-- 
1.7.9.5
