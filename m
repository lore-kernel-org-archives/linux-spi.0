From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] spi: zynq: missing break statement
Date: Wed, 24 Jun 2015 17:31:33 +0300
Message-ID: <20150624143133.GE1702@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Simek <michal.simek@xilinx.com>,
	=?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
	linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org
To: Mark Brown <broonie@kernel.org>,
	Ranjit Waghmode <ranjit.waghmode@xilinx.com>
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

There is a missing break statement here so selecting both only selects
upper.

Fixes: dfe11a11d523 ('spi: Add support for Zynq Ultrascale+ MPSoC GQSPI controller')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 87b20a5..f23f36e 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -214,6 +214,7 @@ static void zynqmp_gqspi_selectslave(struct zynqmp_qspi *instanceptr,
 	case GQSPI_SELECT_FLASH_CS_BOTH:
 		instanceptr->genfifocs = GQSPI_GENFIFO_CS_LOWER |
 			GQSPI_GENFIFO_CS_UPPER;
+		break;
 	case GQSPI_SELECT_FLASH_CS_UPPER:
 		instanceptr->genfifocs = GQSPI_GENFIFO_CS_UPPER;
 		break;
