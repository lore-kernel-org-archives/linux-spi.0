From: Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 1/2] spi: Add call to spi_slave_abort() function when spidev driver is released
Date: Wed, 25 Sep 2019 11:11:42 +0200
Message-ID: <20190925091143.15468-2-lukma@denx.de>
References: <20190924110547.14770-1-lukma@denx.de>
 <20190925091143.15468-1-lukma@denx.de>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk@kernel.org, Lukasz Majewski <lukma@denx.de>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190925091143.15468-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This change is necessary for spidev devices (e.g. /dev/spidev3.0) working
in the slave mode (like NXP's dspi driver for Vybrid SoC).

When SPI HW works in this mode - the master is responsible for providing
CS and CLK signals. However, when some fault happens - like for example
distortion on SPI lines - the SPI Linux driver needs a chance to recover
from this abnormal situation and prepare itself for next (correct)
transmission.

This change doesn't pose any threat on drivers working in master mode as
spi_slave_abort() function checks if SPI slave mode is supported.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Link: https://lore.kernel.org/r/20190924110547.14770-2-lukma@denx.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Reported-by: kbuild test robot <lkp@intel.com>

---
Changes for v2:
- Add #ifdef CONFIG_SPI_SLAVE to not compile in spi_slave_abort() on systems
  which are only using master mode.
  (The spi_slave_abort() is 'protected' by this Kconfig define in drivers/spi.c
  file).
  This error was spotted by kbuild test robot from Intel.
---
 drivers/spi/spidev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 255786f2e844..3ea9d8a3e6e8 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -627,6 +627,9 @@ static int spidev_release(struct inode *inode, struct file *filp)
 		if (dofree)
 			kfree(spidev);
 	}
+#ifdef CONFIG_SPI_SLAVE
+	spi_slave_abort(spidev->spi);
+#endif
 	mutex_unlock(&device_list_lock);
 
 	return 0;
-- 
2.20.1
