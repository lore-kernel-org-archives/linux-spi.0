From: Arkadiusz Kwiatkowski <arkadiusz.kwiatkowski@aptiv.com>
Subject: [PATCH v2 2/2] spi: spi-ti-qspi: Add checking which flash chip has been mmap-ed
Date: Fri, 30 Mar 2018 11:41:24 +0200
Message-ID: <1522402884-26790-2-git-send-email-arkadiusz.kwiatkowski@aptiv.com>
References: <496c162d-5e3c-e008-a14b-6b990e253e64@ti.com>
 <1522402884-26790-1-git-send-email-arkadiusz.kwiatkowski@aptiv.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Arkadiusz Kwiatkowski" <arkadiusz.kwiatkowski@aptiv.com>
To: <vigneshr@ti.com>, <sourav.poddar@ti.com>, <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522402884-26790-1-git-send-email-arkadiusz.kwiatkowski@aptiv.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch allows placing more than one flash chip on the qspi bus
by checking which spi device has been memory-mapped and remapping
if necessary.

Signed-off-by: Arkadiusz Kwiatkowski <arkadiusz.kwiatkowski@aptiv.com>
---
 drivers/spi/spi-ti-qspi.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index d0ea62d..5b99a1e 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -66,7 +66,7 @@ struct ti_qspi {
        u32 cmd;
        u32 dc;

-       bool mmap_enabled;
+       struct spi_device       *mmap_spi_device;
 };

 #define QSPI_PID                       (0x0)
@@ -493,7 +493,7 @@ static void ti_qspi_enable_memory_map(struct spi_device=
 *spi)
                                   MEM_CS_MASK,
                                   MEM_CS_EN(spi->chip_select));
        }
-       qspi->mmap_enabled =3D true;
+       qspi->mmap_spi_device =3D spi;
 }

 static void ti_qspi_disable_memory_map(struct spi_device *spi)
@@ -504,7 +504,7 @@ static void ti_qspi_disable_memory_map(struct spi_devic=
e *spi)
        if (qspi->ctrl_base)
                regmap_update_bits(qspi->ctrl_base, qspi->ctrl_reg,
                                   MEM_CS_MASK, 0);
-       qspi->mmap_enabled =3D false;
+       qspi->mmap_spi_device =3D NULL;
 }

 static void ti_qspi_setup_mmap_read(struct spi_device *spi,
@@ -544,8 +544,12 @@ static int ti_qspi_spi_flash_read(struct spi_device *s=
pi,

        mutex_lock(&qspi->list_lock);

-       if (!qspi->mmap_enabled)
+       if (qspi->mmap_spi_device !=3D spi) {
+               if (qspi->mmap_spi_device)
+                       ti_qspi_disable_memory_map(qspi->mmap_spi_device);
                ti_qspi_enable_memory_map(spi);
+       }
+
        ti_qspi_setup_mmap_read(spi, msg);

        if (qspi->rx_chan) {
@@ -600,7 +604,7 @@ static int ti_qspi_start_transfer_one(struct spi_master=
 *master,

        mutex_lock(&qspi->list_lock);

-       if (qspi->mmap_enabled)
+       if (qspi->mmap_spi_device)
                ti_qspi_disable_memory_map(spi);

        list_for_each_entry(t, &m->transfers, transfer_list) {
@@ -787,7 +791,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
                        master->spi_flash_read =3D NULL;
                }
        }
-       qspi->mmap_enabled =3D false;
+       qspi->mmap_spi_device =3D NULL;

        ret =3D devm_spi_register_master(&pdev->dev, master);
        if (!ret)
--
2.7.4

***************************************************************************=
************* Note: If the reader of this message is not the intended recip=
ient, or an employee or agent responsible for delivering this message to th=
e intended recipient, you are hereby notified that any dissemination, distr=
ibution or copying of this communication is strictly prohibited. If you hav=
e received this communication in error, please notify us immediately by rep=
lying to the message and deleting it from your computer. Thank you. *******=
***************************************************************************=
******
