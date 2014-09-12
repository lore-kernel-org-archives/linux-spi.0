From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 2/6] spi: dw: remove FSF address
Date: Fri, 12 Sep 2014 15:11:57 +0300
Message-ID: <1410523921-16732-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1410523921-16732-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1410523921-16732-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

There is no need to keep FSF address in the head of the file. While here, fix
few typos in the header.

There is no functional change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw.c | 4 ----
 drivers/spi/spi-dw.h | 6 +++---
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 6fb36f1..0960cc7 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -11,10 +11,6 @@
  * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
  * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #include <linux/dma-mapping.h>
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 6d2acad..fcd12b6 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -217,11 +217,11 @@ static inline void spi_umask_intr(struct dw_spi *dws, u32 mask)
  * Each SPI slave device to work with dw_api controller should
  * has such a structure claiming its working mode (PIO/DMA etc),
  * which can be save in the "controller_data" member of the
- * struct spi_device
+ * struct spi_device.
  */
 struct dw_spi_chip {
-	u8 poll_mode;	/* 0 for contoller polling mode */
-	u8 type;	/* SPI/SSP/Micrwire */
+	u8 poll_mode;	/* 1 for controller polling mode */
+	u8 type;	/* SPI/SSP/MicroWire */
 	u8 enable_dma;
 	void (*cs_control)(u32 command);
 };
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
