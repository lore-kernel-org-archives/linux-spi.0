From: Amelie DELAUNAY <amelie.delaunay-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH] spi: stm32: Fix comments compilation warnings
Date: Fri, 20 Mar 2020 14:53:15 +0100
Message-ID: <57ccd75c-1dbd-58d4-9f63-c72befe4c79e@st.com>
References: <1584711857-9162-1-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <alexandre.torgue-qxv4g6HH51o@public.gmane.org>,
        <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-stm32-XDFAJ8BFU24N7RejjzZ/Li2xQDfSxrLKVpNB7YpNyf8@public.gmane.org>,
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
To: Alain Volmat <alain.volmat-qxv4g6HH51o@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1584711857-9162-1-git-send-email-alain.volmat-qxv4g6HH51o@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Alain,

On 3/20/20 2:44 PM, Alain Volmat wrote:
> Fix all functions and structure descriptions to have the driver
> warning free when built with W=1.
> 
> Signed-off-by: Alain Volmat <alain.volmat-qxv4g6HH51o@public.gmane.org>


Thanks for the cleaning :)

Reviewed-by: Amelie Delaunay <amelie.delaunay-qxv4g6HH51o@public.gmane.org>

> ---
>   drivers/spi/spi-stm32.c | 62 +++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 45 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
> index e041f9c4ec47..44ac6eb3298d 100644
> --- a/drivers/spi/spi-stm32.c
> +++ b/drivers/spi/spi-stm32.c
> @@ -175,7 +175,7 @@
>   #define SPI_DMA_MIN_BYTES	16
>   
>   /**
> - * stm32_spi_reg - stm32 SPI register & bitfield desc
> + * struct stm32_spi_reg - stm32 SPI register & bitfield desc
>    * @reg:		register offset
>    * @mask:		bitfield mask
>    * @shift:		left shift
> @@ -187,16 +187,16 @@ struct stm32_spi_reg {
>   };
>   
>   /**
> - * stm32_spi_regspec - stm32 registers definition, compatible dependent data
> - * en: enable register and SPI enable bit
> - * dma_rx_en: SPI DMA RX enable register end SPI DMA RX enable bit
> - * dma_tx_en: SPI DMA TX enable register end SPI DMA TX enable bit
> - * cpol: clock polarity register and polarity bit
> - * cpha: clock phase register and phase bit
> - * lsb_first: LSB transmitted first register and bit
> - * br: baud rate register and bitfields
> - * rx: SPI RX data register
> - * tx: SPI TX data register
> + * struct stm32_spi_regspec - stm32 registers definition, compatible dependent data
> + * @en: enable register and SPI enable bit
> + * @dma_rx_en: SPI DMA RX enable register end SPI DMA RX enable bit
> + * @dma_tx_en: SPI DMA TX enable register end SPI DMA TX enable bit
> + * @cpol: clock polarity register and polarity bit
> + * @cpha: clock phase register and phase bit
> + * @lsb_first: LSB transmitted first register and bit
> + * @br: baud rate register and bitfields
> + * @rx: SPI RX data register
> + * @tx: SPI TX data register
>    */
>   struct stm32_spi_regspec {
>   	const struct stm32_spi_reg en;
> @@ -213,7 +213,7 @@ struct stm32_spi_regspec {
>   struct stm32_spi;
>   
>   /**
> - * stm32_spi_cfg - stm32 compatible configuration data
> + * struct stm32_spi_cfg - stm32 compatible configuration data
>    * @regs: registers descriptions
>    * @get_fifo_size: routine to get fifo size
>    * @get_bpw_mask: routine to get bits per word mask
> @@ -223,13 +223,13 @@ struct stm32_spi;
>    * @set_mode: routine to configure registers to desired mode
>    * @set_data_idleness: optional routine to configure registers to desired idle
>    * time between frames (if driver has this functionality)
> - * set_number_of_data: optional routine to configure registers to desired
> + * @set_number_of_data: optional routine to configure registers to desired
>    * number of data (if driver has this functionality)
>    * @can_dma: routine to determine if the transfer is eligible for DMA use
>    * @transfer_one_dma_start: routine to start transfer a single spi_transfer
>    * using DMA
> - * @dma_rx cb: routine to call after DMA RX channel operation is complete
> - * @dma_tx cb: routine to call after DMA TX channel operation is complete
> + * @dma_rx_cb: routine to call after DMA RX channel operation is complete
> + * @dma_tx_cb: routine to call after DMA TX channel operation is complete
>    * @transfer_one_irq: routine to configure interrupts for driver
>    * @irq_handler_event: Interrupt handler for SPI controller events
>    * @irq_handler_thread: thread of interrupt handler for SPI controller
> @@ -587,6 +587,7 @@ static void stm32f4_spi_read_rx(struct stm32_spi *spi)
>   /**
>    * stm32h7_spi_read_rxfifo - Read bytes in Receive Data Register
>    * @spi: pointer to the spi controller data structure
> + * @flush: boolean indicating that FIFO should be flushed
>    *
>    * Write in rx_buf depends on remaining bytes to avoid to write beyond
>    * rx_buf end.
> @@ -756,6 +757,9 @@ static void stm32h7_spi_disable(struct stm32_spi *spi)
>   
>   /**
>    * stm32_spi_can_dma - Determine if the transfer is eligible for DMA use
> + * @master: controller master interface
> + * @spi_dev: pointer to the spi device
> + * @transfer: pointer to spi transfer
>    *
>    * If driver has fifo and the current transfer size is greater than fifo size,
>    * use DMA. Otherwise use DMA for transfer longer than defined DMA min bytes.
> @@ -974,6 +978,8 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
>   
>   /**
>    * stm32_spi_prepare_msg - set up the controller to transfer a single message
> + * @master: controller master interface
> + * @msg: pointer to spi message
>    */
>   static int stm32_spi_prepare_msg(struct spi_master *master,
>   				 struct spi_message *msg)
> @@ -1026,6 +1032,7 @@ static int stm32_spi_prepare_msg(struct spi_master *master,
>   
>   /**
>    * stm32f4_spi_dma_tx_cb - dma callback
> + * @data: pointer to the spi controller data structure
>    *
>    * DMA callback is called when the transfer is complete for DMA TX channel.
>    */
> @@ -1041,6 +1048,7 @@ static void stm32f4_spi_dma_tx_cb(void *data)
>   
>   /**
>    * stm32f4_spi_dma_rx_cb - dma callback
> + * @data: pointer to the spi controller data structure
>    *
>    * DMA callback is called when the transfer is complete for DMA RX channel.
>    */
> @@ -1054,6 +1062,7 @@ static void stm32f4_spi_dma_rx_cb(void *data)
>   
>   /**
>    * stm32h7_spi_dma_cb - dma callback
> + * @data: pointer to the spi controller data structure
>    *
>    * DMA callback is called when the transfer is complete or when an error
>    * occurs. If the transfer is complete, EOT flag is raised.
> @@ -1079,6 +1088,9 @@ static void stm32h7_spi_dma_cb(void *data)
>   /**
>    * stm32_spi_dma_config - configure dma slave channel depending on current
>    *			  transfer bits_per_word.
> + * @spi: pointer to the spi controller data structure
> + * @dma_conf: pointer to the dma_slave_config structure
> + * @dir: direction of the dma transfer
>    */
>   static void stm32_spi_dma_config(struct stm32_spi *spi,
>   				 struct dma_slave_config *dma_conf,
> @@ -1126,6 +1138,7 @@ static void stm32_spi_dma_config(struct stm32_spi *spi,
>   /**
>    * stm32f4_spi_transfer_one_irq - transfer a single spi_transfer using
>    *				  interrupts
> + * @spi: pointer to the spi controller data structure
>    *
>    * It must returns 0 if the transfer is finished or 1 if the transfer is still
>    * in progress.
> @@ -1166,6 +1179,7 @@ static int stm32f4_spi_transfer_one_irq(struct stm32_spi *spi)
>   /**
>    * stm32h7_spi_transfer_one_irq - transfer a single spi_transfer using
>    *				  interrupts
> + * @spi: pointer to the spi controller data structure
>    *
>    * It must returns 0 if the transfer is finished or 1 if the transfer is still
>    * in progress.
> @@ -1207,6 +1221,7 @@ static int stm32h7_spi_transfer_one_irq(struct stm32_spi *spi)
>   /**
>    * stm32f4_spi_transfer_one_dma_start - Set SPI driver registers to start
>    *					transfer using DMA
> + * @spi: pointer to the spi controller data structure
>    */
>   static void stm32f4_spi_transfer_one_dma_start(struct stm32_spi *spi)
>   {
> @@ -1227,6 +1242,7 @@ static void stm32f4_spi_transfer_one_dma_start(struct stm32_spi *spi)
>   /**
>    * stm32h7_spi_transfer_one_dma_start - Set SPI driver registers to start
>    *					transfer using DMA
> + * @spi: pointer to the spi controller data structure
>    */
>   static void stm32h7_spi_transfer_one_dma_start(struct stm32_spi *spi)
>   {
> @@ -1243,6 +1259,8 @@ static void stm32h7_spi_transfer_one_dma_start(struct stm32_spi *spi)
>   
>   /**
>    * stm32_spi_transfer_one_dma - transfer a single spi_transfer using DMA
> + * @spi: pointer to the spi controller data structure
> + * @xfer: pointer to the spi_transfer structure
>    *
>    * It must returns 0 if the transfer is finished or 1 if the transfer is still
>    * in progress.
> @@ -1405,7 +1423,7 @@ static void stm32_spi_set_mbr(struct stm32_spi *spi, u32 mbrdiv)
>   /**
>    * stm32_spi_communication_type - return transfer communication type
>    * @spi_dev: pointer to the spi device
> - * transfer: pointer to spi transfer
> + * @transfer: pointer to spi transfer
>    */
>   static unsigned int stm32_spi_communication_type(struct spi_device *spi_dev,
>   						 struct spi_transfer *transfer)
> @@ -1522,7 +1540,7 @@ static void stm32h7_spi_data_idleness(struct stm32_spi *spi, u32 len)
>   /**
>    * stm32h7_spi_number_of_data - configure number of data at current transfer
>    * @spi: pointer to the spi controller data structure
> - * @len: transfer length
> + * @nb_words: transfer length (in words)
>    */
>   static int stm32h7_spi_number_of_data(struct stm32_spi *spi, u32 nb_words)
>   {
> @@ -1546,6 +1564,9 @@ static int stm32h7_spi_number_of_data(struct stm32_spi *spi, u32 nb_words)
>    * stm32_spi_transfer_one_setup - common setup to transfer a single
>    *				  spi_transfer either using DMA or
>    *				  interrupts.
> + * @spi: pointer to the spi controller data structure
> + * @spi_dev: pointer to the spi device
> + * @transfer: pointer to spi transfer
>    */
>   static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
>   					struct spi_device *spi_dev,
> @@ -1625,6 +1646,9 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
>   
>   /**
>    * stm32_spi_transfer_one - transfer a single spi_transfer
> + * @master: controller master interface
> + * @spi_dev: pointer to the spi device
> + * @transfer: pointer to spi transfer
>    *
>    * It must return 0 if the transfer is finished or 1 if the transfer is still
>    * in progress.
> @@ -1658,6 +1682,8 @@ static int stm32_spi_transfer_one(struct spi_master *master,
>   
>   /**
>    * stm32_spi_unprepare_msg - relax the hardware
> + * @master: controller master interface
> + * @msg: pointer to the spi message
>    */
>   static int stm32_spi_unprepare_msg(struct spi_master *master,
>   				   struct spi_message *msg)
> @@ -1671,6 +1697,7 @@ static int stm32_spi_unprepare_msg(struct spi_master *master,
>   
>   /**
>    * stm32f4_spi_config - Configure SPI controller as SPI master
> + * @spi: pointer to the spi controller data structure
>    */
>   static int stm32f4_spi_config(struct stm32_spi *spi)
>   {
> @@ -1701,6 +1728,7 @@ static int stm32f4_spi_config(struct stm32_spi *spi)
>   
>   /**
>    * stm32h7_spi_config - Configure SPI controller as SPI master
> + * @spi: pointer to the spi controller data structure
>    */
>   static int stm32h7_spi_config(struct stm32_spi *spi)
>   {
> 
