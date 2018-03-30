From: Arkadiusz Kwiatkowski <arkadiusz.kwiatkowski@aptiv.com>
Subject: [PATCH v2 1/2] spi: spi-ti-qspi: Fix parameters order in regmap_update_bits calls
Date: Fri, 30 Mar 2018 11:41:23 +0200
Message-ID: <1522402884-26790-1-git-send-email-arkadiusz.kwiatkowski@aptiv.com>
References: <496c162d-5e3c-e008-a14b-6b990e253e64@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Arkadiusz Kwiatkowski" <arkadiusz.kwiatkowski@aptiv.com>
To: <vigneshr@ti.com>, <sourav.poddar@ti.com>, <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <496c162d-5e3c-e008-a14b-6b990e253e64@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This commit fixes the order of parameters passed to regmap_update_bits
function inside spi-ti-qspi driver. Accidentally the code worked
correctly when cs=3D0, but it is not the case for other values.

Signed-off-by: Arkadiusz Kwiatkowski <arkadiusz.kwiatkowski@aptiv.com>
---
 drivers/spi/spi-ti-qspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index c24d9b4..d0ea62d 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -490,8 +490,8 @@ static void ti_qspi_enable_memory_map(struct spi_device=
 *spi)
        ti_qspi_write(qspi, MM_SWITCH, QSPI_SPI_SWITCH_REG);
        if (qspi->ctrl_base) {
                regmap_update_bits(qspi->ctrl_base, qspi->ctrl_reg,
-                                  MEM_CS_EN(spi->chip_select),
-                                  MEM_CS_MASK);
+                                  MEM_CS_MASK,
+                                  MEM_CS_EN(spi->chip_select));
        }
        qspi->mmap_enabled =3D true;
 }
@@ -503,7 +503,7 @@ static void ti_qspi_disable_memory_map(struct spi_devic=
e *spi)
        ti_qspi_write(qspi, 0, QSPI_SPI_SWITCH_REG);
        if (qspi->ctrl_base)
                regmap_update_bits(qspi->ctrl_base, qspi->ctrl_reg,
-                                  0, MEM_CS_MASK);
+                                  MEM_CS_MASK, 0);
        qspi->mmap_enabled =3D false;
 }

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
