From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH 0/2] spi: spi-mem: add stm32 qspi controller
Date: Fri, 5 Oct 2018 09:43:01 +0200
Message-ID: <1538725383-19781-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, Ludovic Barre <ludovic.barre@st.com>
To: Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

The goal of this serie is to add support of qspi controller for stm32.
It is a specialized communication interface targeting single,
dual or quad SPI Flash memories (NOR/NAND).

Ludovic Barre (2):
  dt-bindings: spi: add stm32 qspi controller
  spi: spi-mem: add stm32 qspi controller

 .../devicetree/bindings/spi/spi-stm32-qspi.txt     |  44 ++
 drivers/spi/Kconfig                                |   9 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-stm32-qspi.c                       | 512 +++++++++++++++++++++
 4 files changed, 566 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt
 create mode 100644 drivers/spi/spi-stm32-qspi.c

-- 
2.7.4
