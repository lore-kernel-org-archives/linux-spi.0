From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v1 0/3] Correct wml setting for spi-imx in dma mode
Date: Wed, 10 Oct 2018 10:32:39 +0000
Message-ID: <1539196453-8704-1-git-send-email-yibin.gong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
To: "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


Current dynamic burst length is based on the whole transfer length,
that's ok if there is only one sg, but is not right in case multi sgs
in one transfer,because the tail data should be based on the last sg
length instead of the whole transfer length. Othwise, the last dma
done interrupt will never be triggered. It could be caught in
mtd_stresstest case without this patchset as below:

insmod mtd_stresstest.ko dev=3D0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
mtd_stresstest: MTD device: 0
mtd_stresstest: not NAND flash, assume page size is 512 bytes.
mtd_stresstest: MTD device size 4194304, eraseblock size 65536, page size 5=
12, count of eraseblocks 64, pa0
mtd_stresstest: doing operations
mtd_stresstest: 0 operations done
mtd_test: mtd_read from 1ff532, size 880
mtd_test: mtd_read from 20c267, size 64998
spi_master spi0: I/O Error in DMA RX
m25p80 spi0.0: SPI transfer failed: -110
spi_master spi0: failed to transfer one message from queue
mtd_test: error: read failed at 0x20c267
mtd_stresstest: error -110 occurred
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
insmod: ERROR: could not insert module mtd_stresstest.ko: Connection timed =
out

Robin Gong (3):
  spi: imx: move wml setting to later than setup_transfer
  spi: imx: correct wml as the last sg length
  spi: imx: use PIO mode if size is small

 drivers/spi/spi-imx.c | 53 ++++++++++++++++++++++++++++++++++-------------=
----
 1 file changed, 35 insertions(+), 18 deletions(-)

--=20
2.7.4
