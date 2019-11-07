From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 2/2] spi: spi-mem: fallback to using transfers when CS gpios are used
Date: Thu,  7 Nov 2019 17:42:35 +1300
Message-ID: <20191107044235.4864-3-chris.packham@alliedtelesis.co.nz>
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

Devices with chip selects driven via GPIO are not compatible with the
spi-mem operations. Fallback to using standard spi transfers when the
device is connected with a gpio CS.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/spi/spi-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 9f0fa9f3116d..e5a46f0eb93b 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -286,7 +286,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct=
 spi_mem_op *op)
 	if (!spi_mem_internal_supports_op(mem, op))
 		return -ENOTSUPP;
=20
-	if (ctlr->mem_ops) {
+	if (ctlr->mem_ops && !mem->spi->cs_gpiod) {
 		ret =3D spi_mem_access_start(mem);
 		if (ret)
 			return ret;
--=20
2.24.0
