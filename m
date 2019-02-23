From: kernel@martin.sperl.org
Subject: [PATCH 2/5] spi: core: allow reporting the effectivly used speed_hz
 for a transfer
Date: Sat, 23 Feb 2019 08:49:49 +0000
Message-ID: <20190223084952.14758-3-kernel@martin.sperl.org>
References: <20190223084952.14758-1-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Martin Sperl <kernel@martin.sperl.org>
To: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>, linux-spi@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190223084952.14758-1-kernel@martin.sperl.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

From: Martin Sperl <kernel@martin.sperl.org>

Provide a means for the spi bus driver to report the effectively used
spi clock frequency used for each spi_transfer.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/spi/spi.c       | 1 +
 include/linux/spi/spi.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 90659eb29660..5a4616894d57 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3004,6 +3004,7 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 	 */
 	message->frame_length = 0;
 	list_for_each_entry(xfer, &message->transfers, transfer_list) {
+		xfer->effective_speed_hz = 0;
 		message->frame_length += xfer->len;
 		if (!xfer->bits_per_word)
 			xfer->bits_per_word = spi->bits_per_word;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index f2ce1fb403ef..f503a712423d 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -711,6 +711,9 @@ extern void spi_res_release(struct spi_controller *ctlr,
  *	the next transfer or completing this @spi_message.
  * @word_delay: clock cycles to inter word delay after each word size
  *	(set by bits_per_word) transmission.
+ * @effective_speed_hz: the effective SCK-speed that was used to
+ *      transfer this transfer. Set to 0 if the spi bus driver does
+ *      not support it.
  * @transfer_list: transfers are sequenced through @spi_message.transfers
  * @tx_sg: Scatterlist for transmit, currently not for client use
  * @rx_sg: Scatterlist for receive, currently not for client use
@@ -799,6 +802,8 @@ struct spi_transfer {
 	u32		speed_hz;
 	u16		word_delay;

+	u32		effective_speed_hz;
+
 	struct list_head transfer_list;
 };

--
2.11.0
