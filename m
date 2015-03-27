From: Aaron Brice <aaron.brice@datasoft.com>
Subject: [PATCH 0/2] spi: fsl-dspi (vf610) clock fixes
Date: Fri, 27 Mar 2015 14:51:41 -0700
Message-ID: <1427493103-7354-1-git-send-email-aaron.brice@datasoft.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stefan@agner.ch
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

We were having intermittent problems writing to SRAM chip on SPI bus on vf610
SoM.  Added support for CS setup and hold times to meet the SRAM spec.  In the
process noticed that the baud rate was a little high.

Aaron Brice (2):
  spi: fsl-dspi: Fix clock rate scale values
  spi: fsl-dspi: Add ~50ns delay between cs and sck

 drivers/spi/spi-fsl-dspi.c | 84 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 70 insertions(+), 14 deletions(-)

-- 
2.1.0
