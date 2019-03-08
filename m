From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH  0/2] spi: spi-mem: stm32-qspi: add suspend support and fix
Date: Fri, 8 Mar 2019 14:12:19 +0100
Message-ID: <1552050741-27739-1-git-send-email-ludovic.Barre@st.com>
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
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch series adds suspend support and fix a nor memory
corruption due to timeout counter issue.

Ludovic Barre (2):
  spi: spi-mem: stm32-qspi: avoid memory corruption at low frequency
  spi: spi-mem: stm32-qspi: add suspend/resume support

 drivers/spi/spi-stm32-qspi.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

-- 
2.7.4
