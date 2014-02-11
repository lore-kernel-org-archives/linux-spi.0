From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: Remove explictly set bus_num and num_chipselect to
 default setting
Date: Tue, 11 Feb 2014 22:10:19 +0800
Message-ID: <1392127819.9833.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Boot <bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org>,
	Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Thomas Langer <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>,
	David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The purpose of commit 1e8a52e18cfb
"spi: By default setup spi_masters with 1 chipselect and dynamics bus n=
umber"
is to avoid setting default value for bus_num and num_chipselect in spi=
 master
drivers. So let's remove the duplicate code.

Cc: Chris Boot <bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org>
Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Thomas Langer <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>
Cc: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c        | 1 -
 drivers/spi/spi-efm32.c          | 4 ----
 drivers/spi/spi-falcon.c         | 2 --
 drivers/spi/spi-octeon.c         | 2 --
 drivers/spi/spi-sh-hspi.c        | 1 -
 drivers/spi/spi-tegra114.c       | 1 -
 drivers/spi/spi-tegra20-sflash.c | 1 -
 drivers/spi/spi-tegra20-slink.c  | 1 -
 drivers/spi/spi-ti-qspi.c        | 1 -
 9 files changed, 14 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 8a89dd1..6916745 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -315,7 +315,6 @@ static int bcm2835_spi_probe(struct platform_device=
 *pdev)
=20
 	master->mode_bits =3D BCM2835_SPI_MODE_BITS;
 	master->bits_per_word_mask =3D SPI_BPW_MASK(8);
-	master->bus_num =3D -1;
 	master->num_chipselect =3D 3;
 	master->transfer_one_message =3D bcm2835_spi_transfer_one;
 	master->dev.of_node =3D pdev->dev.of_node;
diff --git a/drivers/spi/spi-efm32.c b/drivers/spi/spi-efm32.c
index 03cbb5e..f53bbea 100644
--- a/drivers/spi/spi-efm32.c
+++ b/drivers/spi/spi-efm32.c
@@ -308,10 +308,6 @@ static int efm32_spi_probe_dt(struct platform_devi=
ce *pdev,
 	}
=20
 	ddata->pdata.location =3D location;
-
-	/* spi core takes care about the bus number using an alias */
-	master->bus_num =3D -1;
-
 	return 0;
 }
=20
diff --git a/drivers/spi/spi-falcon.c b/drivers/spi/spi-falcon.c
index 0ae7f45..09965f0 100644
--- a/drivers/spi/spi-falcon.c
+++ b/drivers/spi/spi-falcon.c
@@ -419,9 +419,7 @@ static int falcon_sflash_probe(struct platform_devi=
ce *pdev)
 	priv->master =3D master;
=20
 	master->mode_bits =3D SPI_MODE_3;
-	master->num_chipselect =3D 1;
 	master->flags =3D SPI_MASTER_HALF_DUPLEX;
-	master->bus_num =3D -1;
 	master->setup =3D falcon_sflash_setup;
 	master->prepare_transfer_hardware =3D falcon_sflash_prepare_xfer;
 	master->transfer_one_message =3D falcon_sflash_xfer_one;
diff --git a/drivers/spi/spi-octeon.c b/drivers/spi/spi-octeon.c
index cf88974..a4805f2 100644
--- a/drivers/spi/spi-octeon.c
+++ b/drivers/spi/spi-octeon.c
@@ -257,8 +257,6 @@ static int octeon_spi_probe(struct platform_device =
*pdev)
 	p->register_base =3D (u64)devm_ioremap(&pdev->dev, res_mem->start,
 					     resource_size(res_mem));
=20
-	/* Dynamic bus numbering */
-	master->bus_num =3D -1;
 	master->num_chipselect =3D 4;
 	master->mode_bits =3D SPI_CPHA |
 			    SPI_CPOL |
diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index 82d2f92..755d7cc 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -298,7 +298,6 @@ static int hspi_probe(struct platform_device *pdev)
=20
 	pm_runtime_enable(&pdev->dev);
=20
-	master->num_chipselect	=3D 1;
 	master->bus_num		=3D pdev->id;
 	master->setup		=3D hspi_setup;
 	master->cleanup		=3D hspi_cleanup;
diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 3d10ece..4006495 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1042,7 +1042,6 @@ static int tegra_spi_probe(struct platform_device=
 *pdev)
 	master->setup =3D tegra_spi_setup;
 	master->transfer_one_message =3D tegra_spi_transfer_one_message;
 	master->num_chipselect =3D MAX_CHIP_SELECT;
-	master->bus_num =3D -1;
 	master->auto_runtime_pm =3D true;
=20
 	tspi->master =3D master;
diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20=
-sflash.c
index 5db73c0..47869ea 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -450,7 +450,6 @@ static int tegra_sflash_probe(struct platform_devic=
e *pdev)
 	master->transfer_one_message =3D tegra_sflash_transfer_one_message;
 	master->auto_runtime_pm =3D true;
 	master->num_chipselect =3D MAX_CHIP_SELECT;
-	master->bus_num =3D -1;
=20
 	platform_set_drvdata(pdev, master);
 	tsd =3D spi_master_get_devdata(master);
diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-=
slink.c
index 8e21651..e3c1b93 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1038,7 +1038,6 @@ static int tegra_slink_probe(struct platform_devi=
ce *pdev)
 	master->unprepare_message =3D tegra_slink_unprepare_message;
 	master->auto_runtime_pm =3D true;
 	master->num_chipselect =3D MAX_CHIP_SELECT;
-	master->bus_num =3D -1;
=20
 	platform_set_drvdata(pdev, master);
 	tspi =3D spi_master_get_devdata(master);
diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 7eb2cef..49ddfc7 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -429,7 +429,6 @@ static int ti_qspi_probe(struct platform_device *pd=
ev)
=20
 	master->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD=
;
=20
-	master->bus_num =3D -1;
 	master->flags =3D SPI_MASTER_HALF_DUPLEX;
 	master->setup =3D ti_qspi_setup;
 	master->auto_runtime_pm =3D true;
--=20
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
