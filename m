From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: [PATCH 1/2] spi: add an SPI-device flag for systems, preferring
	power-efficiency
Date: Thu, 15 Mar 2012 22:32:09 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1203152228430.2988@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

Currently the usual SPI driver behaviour is to keep chip select lines
active between messages, unless explicitly required by client drivers to
release it at the end of an SPI message. This is good for performance,
but not very good for power-efficiency, because it is generally not very
easy to suspend SPI-controllers, while a chip-select is active. If during
such a suspend the controller loses power, its IO lines may change
polarity, which can confuse activated clients. This patch adds a new
.flags field to struct spi_board_info and to struct spi_device and a
flag to let users specify in their SPI board-info, that they prefer to
deactivate this device's chip-select line between messages. Drivers can
be gradually extended to support this feature.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
---
 drivers/spi/spi.c       |    1 +
 include/linux/spi/spi.h |   12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index bce1a55..f82fa79 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -433,6 +433,7 @@ struct spi_device *spi_new_device(struct spi_master *master,
 	proxy->max_speed_hz = chip->max_speed_hz;
 	proxy->mode = chip->mode;
 	proxy->irq = chip->irq;
+	proxy->flags = chip->flags;
 	strlcpy(proxy->modalias, chip->modalias, sizeof(proxy->modalias));
 	proxy->dev.platform_data = (void *) chip->platform_data;
 	proxy->controller_data = chip->controller_data;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 176fce9..70cfa7f 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -29,6 +29,12 @@
  */
 extern struct bus_type spi_bus_type;
 
+/*
+ * Release Chip Select after each message to preserve power rather than
+ * optimising for performance by keeping it active.
+ */
+#define SPI_BOARD_FLAG_RELEASE_CS	(1 << 0)
+
 /**
  * struct spi_device - Master side proxy for an SPI slave device
  * @dev: Driver model representation of the device.
@@ -50,6 +56,7 @@ extern struct bus_type spi_bus_type;
  *	The spi_transfer.bits_per_word can override this for each transfer.
  * @irq: Negative, or the number passed to request_irq() to receive
  *	interrupts from this device.
+ * @flags: A mask of SPI_BOARD_FLAG_* flags, copied from spi_board_info
  * @controller_state: Controller's runtime state
  * @controller_data: Board-specific definitions for controller, such as
  *	FIFO initialization parameters; from board_info.controller_data
@@ -86,6 +93,7 @@ struct spi_device {
 #define	SPI_READY	0x80			/* slave pulls low to pause */
 	u8			bits_per_word;
 	int			irq;
+	unsigned long		flags;
 	void			*controller_state;
 	void			*controller_data;
 	char			modalias[SPI_NAME_SIZE];
@@ -703,6 +711,7 @@ static inline ssize_t spi_w8r16(struct spi_device *spi, u8 cmd)
  * @controller_data: Initializes spi_device.controller_data; some
  *	controllers need hints about hardware setup, e.g. for DMA.
  * @irq: Initializes spi_device.irq; depends on how the board is wired.
+ * @flags: A mask of SPI_BOARD_FLAG_* flags
  * @max_speed_hz: Initializes spi_device.max_speed_hz; based on limits
  *	from the chip datasheet and board-specific signal quality issues.
  * @bus_num: Identifies which spi_master parents the spi_device; unused
@@ -732,12 +741,13 @@ struct spi_board_info {
 	 *
 	 * platform_data goes to spi_device.dev.platform_data,
 	 * controller_data goes to spi_device.controller_data,
-	 * irq is copied too
+	 * irq and flags are copied too
 	 */
 	char		modalias[SPI_NAME_SIZE];
 	const void	*platform_data;
 	void		*controller_data;
 	int		irq;
+	unsigned long	flags;
 
 	/* slower signaling on noisy or low voltage boards */
 	u32		max_speed_hz;
-- 
1.7.2.5


------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
