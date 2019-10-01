From: Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] spi: Avoid calling spi_slave_abort() with kfreed spidev
Date: Tue,  1 Oct 2019 11:06:57 +0200
Message-ID: <20191001090657.25721-1-lukma@denx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Colin Ian King <colin.king@canonical.com>,
        linux-spi@vger.kernel.org, krzk@kernel.org,
        linux-kernel@vger.kernel.org, Lukasz Majewski <lukma@denx.de>,
        kbuild test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
To: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Call spi_slave_abort() only when the spidev->spi is !NULL and the
structure hasn't already been kfreed.

Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lukasz Majewski <lukma@denx.de>

---
This fix applies on:
repo: https://kernel.googlesource.com/pub/scm/linux/kernel/git/broonie/spi.git
branch: for-5.4
SHA1: 6b04e47b73f2a0d2c330cecca99f8e2cb8f85b34
---
 drivers/spi/spidev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 3ea9d8a3e6e8..2c6d4dbeebac 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -600,15 +600,16 @@ static int spidev_open(struct inode *inode, struct file *filp)
 static int spidev_release(struct inode *inode, struct file *filp)
 {
 	struct spidev_data	*spidev;
+	int dofree;
 
 	mutex_lock(&device_list_lock);
 	spidev = filp->private_data;
 	filp->private_data = NULL;
+	dofree = 0;
 
 	/* last close? */
 	spidev->users--;
 	if (!spidev->users) {
-		int		dofree;
 
 		kfree(spidev->tx_buffer);
 		spidev->tx_buffer = NULL;
@@ -628,7 +629,8 @@ static int spidev_release(struct inode *inode, struct file *filp)
 			kfree(spidev);
 	}
 #ifdef CONFIG_SPI_SLAVE
-	spi_slave_abort(spidev->spi);
+	if (!dofree)
+		spi_slave_abort(spidev->spi);
 #endif
 	mutex_unlock(&device_list_lock);
 
-- 
2.20.1
