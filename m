From: Lukasz Majewski <lukma@denx.de>
Subject: [RFC/RFT PATCH v1 0/9] mtd: fsl: quadspi: Fixes for fsl-quadspi.c driver (vybrid HW)
Date: Thu, 27 Sep 2018 00:07:30 +0200
Message-ID: <20180926220739.620-1-lukma@denx.de>
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, yogeshnarayan.gaur@nxp.com,
        richard@nod.at, Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        prabhakar.kushwaha@nxp.com, han.xu@nxp.com, broonie@kernel.org,
        david.wolfe@nxp.com, computersforpeace@gmail.com,
        dwmw2@infradead.org, albert.aribaud@3adev.fr,
        Lukasz Majewski <lukma@denx.de>
To: Frieder Schrempf <frieder.schrempf@exceet.de>,
        boris.brezillon@bootlin.com, Mark Rutland <mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Please find following set of patches, which provide improved behaviour
of the fsl-quadspi.c driver on Vybrid vf610 HW.

Below code is based on previous work done by Albert ARIBAUD:
https://patchwork.ozlabs.org/patch/675401/

I've cleaned up the code a bit, make separate patches, exclude not
needed parts and port it to v4.19-rc3.

After applying those patches, the quadspi controller on vf610 works
with UBI/UBIFS.
The problem is with some corner case writes to raw MTD device
(like writing 1023B with single byte writes). Those fail sometimes.

Regression tests can be found in the following repository:
https://github.com/lmajewski/tests-spi/tree/master/tests

(Please read README.txt).

The NXP's community thread regarding HW issues in this block on
the vf610:
https://community.nxp.com/thread/485139

Maybe those patches will be helpful with the new, work in progress
driver for spi-fsl-qspi.c

Lukasz Majewski (9):
  Revert "mtd: fsl-quadspi: Rename SEQID_QUAD_READ to SEQID_READ"
  mtd: qspi: Provide quirk to read only half of RX buffer (NXP's vybrid)
  mtd: spi: Do not setup the default seqid as we got it set for DUAL and
    QUAD
  mtd: spi: Modify the HW capability mask according to supported RX
    lanes
  mtd: spi: Provide LUT entry to perform DUAL read
  mtd: spi: Enhance the fsl_qspi_read() method to support DUAL and QUAD
  mtd: spi: Add SPI_NOR_DUAL_READ property for the 'n25q128a13' Micron
    memory
  mtd: spi: Allocate memory corresponding to maximal fsl-quadspi.c
    controller area
  mtd: spi: Skip reading the Serial Flash Discoverable Parameters

 drivers/mtd/spi-nor/fsl-quadspi.c | 103 +++++++++++++++++++++++++++++---------
 drivers/mtd/spi-nor/spi-nor.c     |   2 +-
 2 files changed, 79 insertions(+), 26 deletions(-)

-- 
2.11.0
