From: <Tudor.Ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: [PATCH] spi: spi-mem: Compute length only when needed
Date: Fri, 28 Feb 2020 16:07:44 +0000
Message-ID: <20200228160735.1565047-1-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: <Tudor.Ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>

When adjust_op_size is defined, len is never used. Move the len
computation where it's actually used.

Signed-off-by: Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
---
 drivers/spi/spi-mem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 3c46747bacb1..adaa0c49f966 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -418,12 +418,13 @@ int spi_mem_adjust_op_size(struct spi_mem *mem, struc=
t spi_mem_op *op)
 	struct spi_controller *ctlr =3D mem->spi->controller;
 	size_t len;
=20
-	len =3D sizeof(op->cmd.opcode) + op->addr.nbytes + op->dummy.nbytes;
-
 	if (ctlr->mem_ops && ctlr->mem_ops->adjust_op_size)
 		return ctlr->mem_ops->adjust_op_size(mem, op);
=20
 	if (!ctlr->mem_ops || !ctlr->mem_ops->exec_op) {
+		len =3D sizeof(op->cmd.opcode) + op->addr.nbytes +
+		      op->dummy.nbytes;
+
 		if (len > spi_max_transfer_size(mem->spi))
 			return -EINVAL;
=20
--=20
2.23.0
