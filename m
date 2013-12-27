From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 2/5] spi: rspi: Remove casts
Date: Fri, 27 Dec 2013 15:33:55 +0100
Message-ID: <2810034.n2a8aHlIUW@avalon>
References: <1387878574-21445-1-git-send-email-geert+renesas@linux-m68k.org> <1387878574-21445-3-git-send-email-geert+renesas@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-sh@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1387878574-21445-3-git-send-email-geert+renesas@linux-m68k.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Geert,

Thank you for the patch.

On Tuesday 24 December 2013 10:49:31 Geert Uytterhoeven wrote:
> Remove useless casts, and do not cast away const.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> ---
>  drivers/spi/spi-rspi.c |   29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
> index 08861b5db893..a0038687a8fd 100644
> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -330,9 +330,7 @@ static int rspi_send_pio(struct rspi_data *rspi, struct
> spi_message *mesg, struct spi_transfer *t)
>  {
>  	int remain = t->len;
> -	u8 *data;
> -
> -	data = (u8 *)t->tx_buf;
> +	const u8 *data = t->tx_buf;
>  	while (remain > 0) {
>  		rspi_write8(rspi, rspi_read8(rspi, RSPI_SPCR) | SPCR_TXMD,
>  			    RSPI_SPCR);
> @@ -358,12 +356,11 @@ static int qspi_send_pio(struct rspi_data *rspi,
> struct spi_message *mesg, struct spi_transfer *t)
>  {
>  	int remain = t->len;
> -	u8 *data;
> +	const u8 *data = t->tx_buf;
> 
>  	rspi_write8(rspi, SPBFCR_TXRST, QSPI_SPBFCR);
>  	rspi_write8(rspi, 0x00, QSPI_SPBFCR);
> 
> -	data = (u8 *)t->tx_buf;
>  	while (remain > 0) {
> 
>  		if (rspi_wait_for_interrupt(rspi, SPSR_SPTEF, SPCR_SPTIE) < 0) {
> @@ -399,8 +396,8 @@ static void rspi_dma_complete(void *arg)
>  	wake_up_interruptible(&rspi->wait);
>  }
> 
> -static int rspi_dma_map_sg(struct scatterlist *sg, void *buf, unsigned len,
> -			   struct dma_chan *chan,
> +static int rspi_dma_map_sg(struct scatterlist *sg, const void *buf,
> +			   unsigned len, struct dma_chan *chan,
>  			   enum dma_transfer_direction dir)
>  {
>  	sg_init_table(sg, 1);
> @@ -440,12 +437,13 @@ static void rspi_memory_from_8bit(void *buf, const
> void *data, unsigned len) static int rspi_send_dma(struct rspi_data *rspi,
> struct spi_transfer *t) {
>  	struct scatterlist sg;
> -	void *buf = NULL;
> +	const void *buf = NULL;
>  	struct dma_async_tx_descriptor *desc;
>  	unsigned len;
>  	int ret = 0;
> 
>  	if (rspi->dma_width_16bit) {
> +		void *tmp;

I really dislike tmp as a variable name, as it can mean pretty much anything. 
What about calling it tx_buf instead ?

>  		/*
>  		 * If DMAC bus width is 16-bit, the driver allocates a dummy
>  		 * buffer. And, the driver converts original data into the
> @@ -454,13 +452,14 @@ static int rspi_send_dma(struct rspi_data *rspi,
> struct spi_transfer *t) *  DMAC data:     1st byte, dummy, 2nd byte, dummy
> ...
>  		 */
>  		len = t->len * 2;
> -		buf = kmalloc(len, GFP_KERNEL);
> -		if (!buf)
> +		tmp = kmalloc(len, GFP_KERNEL);
> +		if (!tmp)
>  			return -ENOMEM;
> -		rspi_memory_to_8bit(buf, t->tx_buf, t->len);
> +		rspi_memory_to_8bit(tmp, t->tx_buf, t->len);
> +		buf = tmp;
>  	} else {
>  		len = t->len;
> -		buf = (void *)t->tx_buf;
> +		buf = t->tx_buf;
>  	}
> 
>  	if (!rspi_dma_map_sg(&sg, buf, len, rspi->chan_tx, DMA_TO_DEVICE)) {
> @@ -528,7 +527,7 @@ static int rspi_receive_pio(struct rspi_data *rspi,
> struct spi_message *mesg,
> 
>  	rspi_receive_init(rspi);
> 
> -	data = (u8 *)t->rx_buf;
> +	data = t->rx_buf;
>  	while (remain > 0) {
>  		rspi_write8(rspi, rspi_read8(rspi, RSPI_SPCR) & ~SPCR_TXMD,
>  			    RSPI_SPCR);
> @@ -575,7 +574,7 @@ static int qspi_receive_pio(struct rspi_data *rspi,
> struct spi_message *mesg,
> 
>  	qspi_receive_init(rspi);
> 
> -	data = (u8 *)t->rx_buf;
> +	data = t->rx_buf;
>  	while (remain > 0) {
> 
>  		if (rspi_wait_for_interrupt(rspi, SPSR_SPTEF, SPCR_SPTIE) < 0) {
> @@ -802,7 +801,7 @@ static void rspi_cleanup(struct spi_device *spi)
> 
>  static irqreturn_t rspi_irq(int irq, void *_sr)
>  {
> -	struct rspi_data *rspi = (struct rspi_data *)_sr;
> +	struct rspi_data *rspi = _sr;
>  	unsigned long spsr;
>  	irqreturn_t ret = IRQ_NONE;
>  	unsigned char disable_irq = 0;
-- 
Regards,

Laurent Pinchart

