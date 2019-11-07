From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 1/2] spi: bcm-qspi: Convert to use CS GPIO descriptors
Date: Thu,  7 Nov 2019 17:42:34 +1300
Message-ID: <20191107044235.4864-2-chris.packham@alliedtelesis.co.nz>
References: <20191107044235.4864-1-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
To: broonie@kernel.org, kdasu.kdev@gmail.com,
        bcm-kernel-feedback-list@broadcom.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191107044235.4864-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Set use_gpio_descriptors to true and avoid asserting the native chip
select if the spi core has done it for us.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/spi/spi-bcm-qspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 7a3531856491..85bad70f59e3 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -803,7 +803,8 @@ static int bcm_qspi_bspi_exec_mem_op(struct spi_devic=
e *spi,
 			return -EIO;
=20
 	from =3D op->addr.val;
-	bcm_qspi_chip_select(qspi, spi->chip_select);
+	if (!spi->cs_gpiod)
+		bcm_qspi_chip_select(qspi, spi->chip_select);
 	bcm_qspi_write(qspi, MSPI, MSPI_WRITE_LOCK, 0);
=20
 	/*
@@ -882,7 +883,8 @@ static int bcm_qspi_transfer_one(struct spi_master *m=
aster,
 	int slots;
 	unsigned long timeo =3D msecs_to_jiffies(100);
=20
-	bcm_qspi_chip_select(qspi, spi->chip_select);
+	if (!spi->cs_gpiod)
+		bcm_qspi_chip_select(qspi, spi->chip_select);
 	qspi->trans_pos.trans =3D trans;
 	qspi->trans_pos.byte =3D 0;
=20
@@ -1234,6 +1236,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
 	master->cleanup =3D bcm_qspi_cleanup;
 	master->dev.of_node =3D dev->of_node;
 	master->num_chipselect =3D NUM_CHIPSELECT;
+	master->use_gpio_descriptors =3D true;
=20
 	qspi->big_endian =3D of_device_is_big_endian(dev->of_node);
=20
--=20
2.24.0
