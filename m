From: <Tudor.Ambarus@microchip.com>
Subject: [PATCH v5 07/13] spi: atmel-quadspi: switch to SPDX license
 identifiers
Date: Tue, 5 Feb 2019 15:43:41 +0000
Message-ID: <20190205154257.29529-8-tudor.ambarus@microchip.com>
References: <20190205154257.29529-1-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190205154257.29529-1-tudor.ambarus@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Adopt the SPDX license identifiers to ease license compliance
management.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v5: no change
v4: no change
v3: no change
v2: collect R-b

 drivers/spi/atmel-quadspi.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 06c31830d07b..ce4f8a648f45 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for Atmel QSPI Controller
  *
@@ -7,18 +8,6 @@
  * Author: Cyrille Pitchen <cyrille.pitchen@atmel.com>
  * Author: Piotr Bugalski <bugalski.piotr@gmail.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WIT=
HOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
- * more details.
- *
- * You should have received a copy of the GNU General Public License along=
 with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
- *
  * This driver is based on drivers/mtd/spi-nor/fsl-quadspi.c from Freescal=
e.
  */
=20
--=20
2.9.5
