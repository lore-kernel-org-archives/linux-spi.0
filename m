From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 11/11] spi: pxa2xx: Deal with the leftover garbage in TXFIFO
Date: Wed, 10 Oct 2018 19:09:36 +0200
Message-ID: <20181010170936.316862-12-lkundrak@v3.sk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Cc: James Cameron <quozl@laptop.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
To: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010170936.316862-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

There doesn't seem to be a way to empty TXFIFO on MMP2. The datasheet is
super-secret and the method described in Armada 16x manual won't work:

  "The TXFIFO and RXFIFO are cleared to 0b0 when the SSPx port is reset o=
r
  disabled (by writing a 0b0 to the <Synchronous Serial Port Enable> fiel=
d
  in the SSP Control Register 0)."

  # devmem 0xd4037008           # read SSSR
  0x0000F204
  # devmem 0xd4037000 32 0x80   # SSE off in SSCR0
  # devmem 0xd4037000 32 0x87   # SSE on
  # devmem 0xd4037008
  0x0000F204
         ^ TXFIFO level is still 2. Sigh.

The OLPC 1.75 boot firmware leaves two bytes in the TXFIFO. Those are
basically throwaway bytes used in response to the messages from the EC.
The OLPC kernel copes with this by power-cycling the hardware. Perhaps
the firmware should do this instead.

Other than that, there's not much we can do other than complain loudly
until the garbage gets drained and discard the actual data... For the
OLPC EC this will work just fine and pushing more data to TXFIFO would
break further transactions.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/spi/spi-pxa2xx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index a3b4b12c1077..2662b99d4439 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1076,6 +1076,20 @@ static int pxa2xx_spi_transfer_one(struct spi_cont=
roller *master,
 			pxa2xx_spi_write(drv_data, SSTO, chip->timeout);
 	}
=20
+	if (drv_data->ssp_type =3D=3D MMP2_SSP) {
+		u8 tx_level =3D (pxa2xx_spi_read(drv_data, SSSR)
+					& SSSR_TFL_MASK) >> 8;
+
+		if (tx_level) {
+			/* On MMP2, flipping SSE doesn't to empty TXFIFO. */
+			dev_warn(&spi->dev, "%d bytes of garbage in TXFIFO!\n",
+								tx_level);
+			if (tx_level > transfer->len)
+				tx_level =3D transfer->len;
+			drv_data->tx +=3D tx_level;
+		}
+	}
+
 	if (spi_controller_is_slave(master)) {
 		while (drv_data->write(drv_data))
 			;
--=20
2.19.0
