From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: [PATCH 2/2] spi: spidev: fix a max speed setting
Date: Thu, 20 Feb 2020 14:11:51 +0000
Message-ID: <20200220141143.3902922-3-oleksandr.suvorov@toradex.com>
References: <20200220141143.3902922-1-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Oleksandr Suvorov <cryosay@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opanyuk <igor.opanyuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Mark Brown <broonie@kernel.org>
To: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200220141143.3902922-1-oleksandr.suvorov@toradex.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

SPI_IOC_WR_MAX_SPEED_HZ command always sets spi->max_speed_hz
to the initial value come from DT.
It leads to set a wrong max speed with IOCTL call.

Fix the logic of a max speed assignment.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

 drivers/spi/spidev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 1e217e3e9486..b9b3ac70eb18 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -449,11 +449,13 @@ spidev_ioctl(struct file *filp, unsigned int cmd, uns=
igned long arg)
=20
 			spi->max_speed_hz =3D tmp;
 			retval =3D spi_setup(spi);
-			if (retval >=3D 0)
+			if (retval) {
+				spi->max_speed_hz =3D save;
+			} else {
 				spidev->speed_hz =3D tmp;
-			else
-				dev_dbg(&spi->dev, "%d Hz (max)\n", tmp);
-			spi->max_speed_hz =3D save;
+				dev_dbg(&spi->dev, "%d Hz (max)\n",
+					spidev->speed_hz);
+			}
 		}
 		break;
=20
--=20
2.24.1
