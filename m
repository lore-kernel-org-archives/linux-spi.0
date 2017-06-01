From: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH linux-next v3 1/1] spi: imx: dynamic burst length adjust
 for PIO mode
Date: Thu, 1 Jun 2017 04:58:47 -0700
Message-ID: <59300177.5030908@mentor.com>
References: <1495774962-2981-1-git-send-email-jiada_wang@mentor.com> <20170529095043.mytrgtyfne4dfmae@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170529095043.mytrgtyfne4dfmae-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Sascha

On 05/29/2017 02:50 AM, Sascha Hauer wrote:
> Hi,
>
> On Thu, May 25, 2017 at 10:02:42PM -0700, jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org wrote:
>> From: Jiada Wang<jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
>>
>> previously burst length (BURST_LENGTH) is always set to equal
>> to bits_per_word, causes a 10us gap between each word in
>> transfer, which significantly affects performance.
>>
>> This patch uses 32 bits transfer to simulate lower bits transfer,
>> and adjusts burst length runtimely to use biggeest burst length
>> as possible to reduce the gaps in transfer for PIO mode.
>>
> First let me say that I'm not really looking forward to have this patch
> in the driver. It adds quite some code to already hairy code pathes in
> the imx-spi driver and I saw you have the same patch for DMA mode
> aswell.
>
> The driver has different function hooks for the different controllers.
> This patch breaks that. In some places it assumes that dynamic burst
> is only possible on i.MX51 type controllers and also that in case
> dynamic burst is enabled it must be an i.MX51 type controller.
>
> We should really see how this patch can be better integrated into the
> driver, or, how the driver can be changed to better support the dynamic
> burst usecase.
  Yes, I can understand your concern, as this patch brings in a bunch of 
change,
and changes the behaviour of data transfer.
how about introduce a new DTS property like "fsl,spi-dynamic-burst",
and only enables dynamic burst when this property is added.
>> Signed-off-by: Jiada Wang<jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
>> ---
>>
>> Changes in v2:
>> * used cpu_to_* functions to ensure this patch works for both
>>    little&  big endian kernel.
>>
>> Changes in v3:
>> * Only allow dynamic burst in PIO mode
>> * Avoid direct manipulation of tx_buf&  rx_buf
>>
>>   drivers/spi/spi-imx.c | 156 +++++++++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 148 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
>> index b402530..54f7c31 100644
>> --- a/drivers/spi/spi-imx.c
>> +++ b/drivers/spi/spi-imx.c
>> @@ -56,9 +56,11 @@
>>
>>   /* The maximum  bytes that a sdma BD can transfer.*/
>>   #define MAX_SDMA_BD_BYTES  (1<<  15)
>> +#define MX51_ECSPI_CTRL_MAX_BURST	512
>>   struct spi_imx_config {
>>   	unsigned int speed_hz;
>>   	unsigned int bpw;
>> +	unsigned int len;
>>   };
>>
>>   enum spi_imx_devtype {
>> @@ -97,12 +99,14 @@ struct spi_imx_data {
>>   	unsigned int bytes_per_word;
>>   	unsigned int spi_drctl;
>>
>> -	unsigned int count;
>> +	unsigned int count, count_index;
> count_index is poorly named. It holds the remaining number of bytes that
> doesn't fit into the current burst length setting. Something like
> 'remainder' would be clearer.
Will update to use "remainder" in next update
>
>>   	void (*tx)(struct spi_imx_data *);
>>   	void (*rx)(struct spi_imx_data *);
>>   	void *rx_buf;
>>   	const void *tx_buf;
>>   	unsigned int txfifo; /* number of words pushed in tx FIFO */
>> +	unsigned int dynamic_burst, bpw_rx;
> bpw_rx is also poorly named. The name suggests something like b[it|yte]s_per_word
> for receive, but really it is some boolean flag.
>
>> +	unsigned int bpw_w;
> This holds the number of bytes per word, so what's the _w suffix? Why
> not bpw or even better bytes_per_word?
will use bytes_per_word
>>
>>   	/* DMA */
>>   	bool usedma;
>> @@ -238,6 +242,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
>>   		return false;
>>
>>   	spi_imx->wml = i;
>> +	spi_imx->dynamic_burst = 0;
>>
>>   	return true;
>>   }
>> @@ -252,6 +257,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
>>   #define MX51_ECSPI_CTRL_PREDIV_OFFSET	12
>>   #define MX51_ECSPI_CTRL_CS(cs)		((cs)<<  18)
>>   #define MX51_ECSPI_CTRL_BL_OFFSET	20
>> +#define MX51_ECSPI_CTRL_BL_MASK		(0xfff<<  20)
>>
>>   #define MX51_ECSPI_CONFIG	0x0c
>>   #define MX51_ECSPI_CONFIG_SCLKPHA(cs)	(1<<  ((cs) +  0))
>> @@ -279,6 +285,95 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
>>   #define MX51_ECSPI_TESTREG	0x20
>>   #define MX51_ECSPI_TESTREG_LBC	BIT(31)
>>
>> +static u32 spi_imx_u32_swap_u16(u32 val)
>> +{
>> +	u32 data = val;
>> +	u16 *temp = (u16 *)&data;
>> +
>> +	*temp = cpu_to_be16(*temp);
>> +	*(temp + 1) = cpu_to_be16(*(temp + 1));
>> +
>> +	data = cpu_to_be32(data);
>> +
>> +	return data;
>> +}
> This function swaps the two 16bit words when in little endian mode,
> right?
>
> Something like
>
> #ifdef __LITTLE_ENDIAN
> 	return (val<<  16) | (val>>  16);
> #endif
>
> would be much more readable.
will update with this.
>> +
>> +static void spi_imx_buf_rx_swap_u32(struct spi_imx_data *spi_imx)
>> +{
>> +	unsigned int val = readl(spi_imx->base + MXC_CSPIRXDATA);
>> +
>> +	if (spi_imx->rx_buf) {
>> +		if (spi_imx->bpw_w == 1)
>> +			val = cpu_to_be32(val);
>> +		else if (spi_imx->bpw_w == 2)
>> +			val = spi_imx_u32_swap_u16(val);
>> +
>> +		*(u32 *)spi_imx->rx_buf = val;
>> +		spi_imx->rx_buf += sizeof(u32);
>> +	}
>> +}
>> +
>> +static void spi_imx_buf_rx_swap(struct spi_imx_data *spi_imx)
>> +{
>> +	if (!spi_imx->bpw_rx) {
>> +		spi_imx_buf_rx_swap_u32(spi_imx);
>> +		return;
>> +	}
>> +
>> +	if (spi_imx->bpw_w == 1)
>> +		spi_imx_buf_rx_u8(spi_imx);
>> +	else if (spi_imx->bpw_w == 2)
>> +		spi_imx_buf_rx_u16(spi_imx);
>> +}
>> +
>> +static void spi_imx_buf_tx_swap_u32(struct spi_imx_data *spi_imx)
>> +{
>> +	u32 val = 0;
>> +
>> +	if (spi_imx->tx_buf) {
>> +		val = *(u32 *)spi_imx->tx_buf;
>> +		spi_imx->tx_buf += sizeof(u32);
>> +	}
>> +
>> +	spi_imx->count -= sizeof(u32);
>> +	if (spi_imx->bpw_w == 1)
>> +		val = cpu_to_be32(val);
>> +	else if (spi_imx->bpw_w == 2)
>> +		val = spi_imx_u32_swap_u16(val);
>> +
>> +	writel(val, spi_imx->base + MXC_CSPITXDATA);
>> +}
>> +
>> +static void spi_imx_buf_tx_swap(struct spi_imx_data *spi_imx)
>> +{
>> +	u32 ctrl, val;
>> +
>> +	if (spi_imx->count == spi_imx->count_index) {
>> +		spi_imx->count_index = spi_imx->count>  sizeof(u32) ?
>> +					spi_imx->count % sizeof(u32) : 0;
>> +		ctrl = readl(spi_imx->base + MX51_ECSPI_CTRL);
>> +		ctrl&= ~MX51_ECSPI_CTRL_BL_MASK;
>> +		if (spi_imx->count>= sizeof(u32)) {
>> +			val = spi_imx->count - spi_imx->count_index;
>> +		} else {
>> +			val = spi_imx->bpw_w;
>> +			spi_imx->bpw_rx = 1;
>> +		}
>> +		ctrl |= ((val * 8 - 1)<<  MX51_ECSPI_CTRL_BL_OFFSET);
>> +		writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
>> +	}
> Do we need to reconfigure the burst len at all? Can't we configure it to
> the max burst len and keep it that value?
yes, based on my experiment, the burst len need to be re-configured, 
otherwise when transfer the
'remainder' part data, with either burst len = 8 or 16, there will be issue.
>> +
>> +	if (spi_imx->count>= sizeof(u32)) {
>> +		spi_imx_buf_tx_swap_u32(spi_imx);
>> +		return;
>> +	}
>> +
>> +	if (spi_imx->bpw_w == 1)
>> +		spi_imx_buf_tx_u8(spi_imx);
>> +	else if (spi_imx->bpw_w == 2)
>> +		spi_imx_buf_tx_u16(spi_imx);
>> +}
>> +
>>   /* MX51 eCSPI */
>>   static unsigned int mx51_ecspi_clkdiv(struct spi_imx_data *spi_imx,
>>   				      unsigned int fspi, unsigned int *fres)
>> @@ -370,7 +465,15 @@ static int mx51_ecspi_config(struct spi_device *spi,
>>   	/* set chip select to use */
>>   	ctrl |= MX51_ECSPI_CTRL_CS(spi->chip_select);
>>
>> -	ctrl |= (config->bpw - 1)<<  MX51_ECSPI_CTRL_BL_OFFSET;
>> +	if (spi_imx->dynamic_burst) {
>> +		if (config->len>  MX51_ECSPI_CTRL_MAX_BURST)
>> +			ctrl |= MX51_ECSPI_CTRL_BL_MASK;
>> +		else
>> +			ctrl |= (((config->len - config->len % 4) * 8 - 1)<<
>> +				MX51_ECSPI_CTRL_BL_OFFSET);
>> +	} else {
>> +		ctrl |= (config->bpw - 1)<<  MX51_ECSPI_CTRL_BL_OFFSET;
>> +	}
>>
>>   	cfg |= MX51_ECSPI_CONFIG_SBBCTRL(spi->chip_select);
>>
>> @@ -805,6 +908,8 @@ static void spi_imx_push(struct spi_imx_data *spi_imx)
>>   	while (spi_imx->txfifo<  spi_imx_get_fifosize(spi_imx)) {
>>   		if (!spi_imx->count)
>>   			break;
>> +		if (spi_imx->txfifo&&  (spi_imx->count == spi_imx->count_index))
>> +			break;
>>   		spi_imx->tx(spi_imx);
>>   		spi_imx->txfifo++;
>>   	}
>> @@ -895,8 +1000,12 @@ static int spi_imx_setupxfer(struct spi_device *spi,
>>   	struct spi_imx_config config;
>>   	int ret;
>>
>> +	spi_imx->dynamic_burst = 0;
>> +	spi_imx->bpw_rx = 0;
>> +
>>   	config.bpw = t ? t->bits_per_word : spi->bits_per_word;
>>   	config.speed_hz  = t ? t->speed_hz : spi->max_speed_hz;
>> +	config.len = t->len;
>>
>>   	if (!config.speed_hz)
>>   		config.speed_hz = spi->max_speed_hz;
>> @@ -905,14 +1014,32 @@ static int spi_imx_setupxfer(struct spi_device *spi,
>>
>>   	/* Initialize the functions for transfer */
>>   	if (config.bpw<= 8) {
>> -		spi_imx->rx = spi_imx_buf_rx_u8;
>> -		spi_imx->tx = spi_imx_buf_tx_u8;
>> +		if (t->len>= sizeof(u32)&&  is_imx51_ecspi(spi_imx)) {
>> +			spi_imx->dynamic_burst = 1;
>> +			spi_imx->rx = spi_imx_buf_rx_swap;
>> +			spi_imx->tx = spi_imx_buf_tx_swap;
>> +		} else {
>> +			spi_imx->rx = spi_imx_buf_rx_u8;
>> +			spi_imx->tx = spi_imx_buf_tx_u8;
>> +		}
>>   	} else if (config.bpw<= 16) {
>> -		spi_imx->rx = spi_imx_buf_rx_u16;
>> -		spi_imx->tx = spi_imx_buf_tx_u16;
>> +		if (t->len>= sizeof(u32)&&  is_imx51_ecspi(spi_imx)) {
>> +			spi_imx->dynamic_burst = 1;
>> +			spi_imx->rx = spi_imx_buf_rx_swap;
>> +			spi_imx->tx = spi_imx_buf_tx_swap;
>> +		} else {
>> +			spi_imx->rx = spi_imx_buf_rx_u16;
>> +			spi_imx->tx = spi_imx_buf_tx_u16;
>> +		}
>>   	} else {
>> -		spi_imx->rx = spi_imx_buf_rx_u32;
>> -		spi_imx->tx = spi_imx_buf_tx_u32;
>> +		if (is_imx51_ecspi(spi_imx)) {
>> +			spi_imx->dynamic_burst = 1;
>> +			spi_imx->rx = spi_imx_buf_rx_swap;
>> +			spi_imx->tx = spi_imx_buf_tx_swap;
>> +		} else {
>> +			spi_imx->rx = spi_imx_buf_rx_u32;
>> +			spi_imx->tx = spi_imx_buf_tx_u32;
>> +		}
>>   	}
> You seem to assume that bpw is either 8, 16 or 32, but this is not true.
> It can be any other value in between aswell in which case you can't do
> dynamic_burst.
Yes, dynamic burst can only support bpw of 8, 16 or 32, other values 
can't be supported,
in case other bpw is requested, driver need to return error here.
and the limitation need to be added in change log.

>>
>>   	if (spi_imx_can_dma(spi_imx->bitbang.master, spi, t))
>> @@ -920,6 +1047,8 @@ static int spi_imx_setupxfer(struct spi_device *spi,
>>   	else
>>   		spi_imx->usedma = 0;
>>
>> +	spi_imx->bpw_w = DIV_ROUND_UP(config.bpw, 8);
> You are duplicating spi_imx_bytes_per_word() here. Why not call it
> instead? Also, when you are adding the bytes_per_word value to the
> driver private struct, then other places where this value is needed
> should use this variable directly rather than calling
> spi_imx_bytes_per_word() again.
will replace spi_imx_bytes_per_word() with directly use bytes_per_word 
variable

>
>> +
>>   	if (spi_imx->usedma) {
>>   		ret = spi_imx_dma_configure(spi->master,
>>   					    spi_imx_bytes_per_word(config.bpw));
>> @@ -1094,6 +1223,14 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
>>   	spi_imx->count = transfer->len;
>>   	spi_imx->txfifo = 0;
>>
>> +	if (spi_imx->dynamic_burst) {
>> +		if (spi_imx->count>  MX51_ECSPI_CTRL_MAX_BURST)
>> +			spi_imx->count_index = spi_imx->count %
>> +					       MX51_ECSPI_CTRL_MAX_BURST;
>> +		else
>> +			spi_imx->count_index = spi_imx->count % sizeof(u32);
>> +	}
>> +
>>   	reinit_completion(&spi_imx->xfer_done);
>>
>>   	spi_imx_push(spi_imx);
>> @@ -1110,6 +1247,9 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
>>   		return -ETIMEDOUT;
>>   	}
>>
>> +	if (spi_imx->dynamic_burst)
>> +		spi_imx->dynamic_burst = 0;
> The if() is unnecessary. Besides, spi_imx->dynamic_burst is initialized
> in spi_imx_setupxfer() when needed, so this is not needed at all here.
will remove if() in next update.

Thanks,
Jiada
> Sascha
>

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
