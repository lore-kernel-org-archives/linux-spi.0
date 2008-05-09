From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH/RFC] spi: Change modalias from a pointer to a character array
Date: Fri, 09 May 2008 11:32:28 -0600
Message-ID: <20080509173146.2932.16141.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	dbrownell@users.sourceforge.net
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932775AbYEIRe1@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Grant Likely <grant.likely@secretlab.ca>

Currently, 'modalias' in the spi_device structure is a 'const char *'.
The spi_new_device() function fills in the modalias value from a passed
in spi_board_info data block.  Since it is a pointer copy, the new
spi_device remains dependent on the spi_board_info structure after the
new spi_device is registered (no other fields in spi_device directly
depend on the spi_board_info structure; all of the other data is copied).

This causes a problem when dynamically propulating the list of attached
SPI devices.  For example, in arch/powerpc, the list of SPI devices can
be populated from data in the device tree.  With the current code, the
device tree adapter must kmalloc() a new spi_board_info structure for
each new SPI device it finds in the device tree, and there is no simple
mechanism in place for keeping track of these allocations.

This patch changes modalias from a 'const char *' to a fixed char array.
By copying the modalias string instead of referencing it, the dependency
on the spi_board_info structure is eliminated and an outside caller does
not need to maintain a separate spi_board_info allocation for each device.

If searched through the code to the best of my ability for any references
to modalias which may be affected by this change and haven't found anything.
It has been tested with the lite5200b platform in arch/powerpc.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/spi/spi.c       |    2 +-
 include/linux/spi/spi.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 1ad12af..bdf1b70 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -229,7 +229,7 @@ struct spi_device *spi_new_device(struct spi_master *master,
 	proxy->max_speed_hz = chip->max_speed_hz;
 	proxy->mode = chip->mode;
 	proxy->irq = chip->irq;
-	proxy->modalias = chip->modalias;
+	strncpy(proxy->modalias, chip->modalias, KOBJ_NAME_LEN);
 
 	snprintf(proxy->dev.bus_id, sizeof proxy->dev.bus_id,
 			"%s.%u", master->dev.bus_id,
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 387e428..38a080b 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -82,7 +82,7 @@ struct spi_device {
 	int			irq;
 	void			*controller_state;
 	void			*controller_data;
-	const char		*modalias;
+	char			modalias[KOBJ_NAME_LEN];
 
 	/*
 	 * likely need more hooks for more protocol options affecting how
