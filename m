From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH 0/2] spi: stm32-qspi: add dma support
Date: Fri, 22 Mar 2019 15:35:52 +0100
Message-ID: <1553265354-16433-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, Ludovic Barre <ludovic.barre@st.com>
To: Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch series adds dma support for the stm32-qspi.
In read mode, the memory map is preferred vs dma
(due to better throughput). If the dma transfer fails the buffer is
sent by polling.

Ludovic Barre (2):
  spi: stm32-qspi: add spi_master_put in release function
  spi: stm32-qspi: add dma support

 drivers/spi/spi-stm32-qspi.c | 182 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 163 insertions(+), 19 deletions(-)

-- 
2.7.4
