From: Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] spi: dw: fix warning unused variable 'ret'
Date: Thu, 10 Jan 2019 11:14:07 +0100
Message-ID: <20190110101407.7583-1-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

When CONFIG_SPI_DESIGNWARE are enabled we see the unused variable
warning in dw_spi_setup.

../drivers/spi/spi-dw.c: In function ‘dw_spi_setup’:
../drivers/spi/spi-dw.c:400:6: warning: unused variable ‘ret’ [-Wunused-variable]
  int ret;
      ^~~

Remove the unused varable.

Fixes: 9400c41e77b8 ("spi: dw: Convert to use CS GPIO descriptors")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/spi/spi-dw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index f54b498001a9..7092e58add2c 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -397,7 +397,6 @@ static int dw_spi_setup(struct spi_device *spi)
 {
 	struct dw_spi_chip *chip_info = NULL;
 	struct chip_data *chip;
-	int ret;
 
 	/* Only alloc on first setup */
 	chip = spi_get_ctldata(spi);
-- 
2.19.2
