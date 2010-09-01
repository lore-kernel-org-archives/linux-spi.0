From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: add a bits_per_word to struct spi_board_info
Date: Wed,  1 Sep 2010 14:24:49 +0800
Message-ID: <1283322289-2545-1-git-send-email-feng.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Currently a spi device's bits_per_word can only be inited
inside protocol driver's probe func, this patch will enable
platform code to specify this info when registering the
spi_board_info

Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
---
 drivers/spi/spi.c       |    1 +
 include/linux/spi/spi.h |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a9e5c79..a8690e7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -350,6 +350,7 @@ struct spi_device *spi_new_device(struct spi_master *master,
 	proxy->chip_select = chip->chip_select;
 	proxy->max_speed_hz = chip->max_speed_hz;
 	proxy->mode = chip->mode;
+	proxy->bits_per_word = chip->bits_per_word;
 	proxy->irq = chip->irq;
 	strlcpy(proxy->modalias, chip->modalias, sizeof(proxy->modalias));
 	proxy->dev.platform_data = (void *) chip->platform_data;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 92e52a1..f36d0d5 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -698,6 +698,8 @@ static inline ssize_t spi_w8r16(struct spi_device *spi, u8 cmd)
  * @mode: Initializes spi_device.mode; based on the chip datasheet, board
  *	wiring (some devices support both 3WIRE and standard modes), and
  *	possibly presence of an inverter in the chipselect path.
+ * @bits_per_word: Initializes spi_device.bits_per_word, usually it will
+ * be from 8 to 32 bits
  *
  * When adding new SPI devices to the device tree, these structures serve
  * as a partial device template.  They hold information which can't always
@@ -742,6 +744,7 @@ struct spi_board_info {
 	 * where the default of SPI_CS_HIGH = 0 is wrong.
 	 */
 	u8		mode;
+	u8		bits_per_word;
 
 	/* ... may need additional spi_device chip config data here.
 	 * avoid stuff protocol drivers can set; but include stuff
-- 
1.7.0.4


------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
