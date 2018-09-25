From: Hieu Tran Dang <dangtranhieu2012@gmail.com>
Subject: [PATCH 0/2] spi: fsl-lpspi: Option to prevent FIFO under/overrun
Date: Wed, 26 Sep 2018 03:36:59 +0700
Message-ID: <20180925203701.13605-1-dangtranhieu2012@gmail.com>
Cc: Hieu Tran Dang <dangtranhieu2012@gmail.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Gao Pan <pandy.gao@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Certain devices don't work well when a transmit FIFO underrun or
receive FIFO overrun occurs. Example is the SAF400x radio chip when
running at high speed which leads to garbage being sent to/received from
the chip. In which case, it should stall waiting for further data to be
available before proceeding. This patch add option to configure the SPI
controller to allow stalling (unset NOSTALL bit in CFGR1).

Hieu Tran Dang (2):
  dt-bindings: spi: fsl-lpspi: Option to allow stalling
  spi: fsl-lpspi: Option to prevent FIFO under/overrun

 .../devicetree/bindings/spi/spi-fsl-lpspi.txt          |  2 ++
 drivers/spi/spi-fsl-lpspi.c                            | 10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.17.1
