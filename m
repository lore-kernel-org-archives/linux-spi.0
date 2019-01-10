From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: dw: fix warning unused variable 'ret'" to the spi tree
Date: Thu, 10 Jan 2019 11:54:35 +0000 (GMT)
Message-ID: <20190110115435.6EE0F1127052@debutante.sirena.org.uk>
References: <20190110101407.7583-1-anders.roxell@linaro.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Anders Roxell <anders.roxell@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190110101407.7583-1-anders.roxell@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: dw: fix warning unused variable 'ret'

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 4f0a0cd52d6c812fbf737e436b18f04eac2e312e Mon Sep 17 00:00:00 2001
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 10 Jan 2019 11:14:07 +0100
Subject: [PATCH] spi: dw: fix warning unused variable 'ret'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1
