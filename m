From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH] SPI: DUAL and QUAD support
Date: Mon, 29 Jul 2013 12:43:57 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73E9EE267@DBDE04.ent.ti.com>
References: <20130729064234.GS9858@sirena.org.uk>
 <1375095194-7093-1-git-send-email-wangyuhang2014@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general@lists.sourceforge.net"
 <spi-devel-general@lists.sourceforge.net>, "Poddar,
 Sourav" <sourav.poddar@ti.com>, "tpiepho@gmail.com" <tpiepho@gmail.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "broonie@kernel.org" <broonie@kernel.org>
To: wangyuhang <wangyuhang2014@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1375095194-7093-1-git-send-email-wangyuhang2014@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hello,

> 
> Hi,
> 
> modify two things.
Hope you are tracking the Patch versions ?  Good to include it in mail-subject.

> 1:
> >> @@ -1316,6 +1324,12 @@ int spi_setup(struct spi_device *spi)
> >>         /* help drivers fail *cleanly* when they need options
> >>          * that aren't supported with their current master
> >>          */
> >> +       if (((spi->mode >> 8) & 0x03) == 0x03 ||
> >> +               ((spi->mode >> 10) & 0x03) == 0x03) {
> >> +               dev_err(&spi->dev,
> >> +               "setup: can not select dual and quad at the same time\n")
> >> +               return -EINVAL;
> >> +       }
> >> +               return -EINVAL;
> >> +       }
> 
> >This code won't work if the constants you added for mode flags change
> >value.  More importantly, anyone searching the code for SPI_TX_DUAL,
> >etc. won't find this code.
> 
> so use the certain macro to replace.
> 
> 2:
> >You need to make sure that existing userspace binaries can run
> >unmodified, changing the types will change the layout of the ioctl
> >arguments.  This may mean that you need to add new ioctls if you need to
> >change types.
> 
> I recovered the SPI_IOC_RD_LSB_FIRST ioctl.
> Add new ioctl to fit u16 mode.
> In addition,may SPI_IOC_RD_LSB_FIRST should be del in a better way.
> 
> Signed-off-by: wangyuhang <wangyuhang2014@gmail.com>
> ---
>  drivers/spi/spi.c               |   14 ++++++++++++++
>  drivers/spi/spidev.c            |   29 ++++++++++++++++++++++++++++-
>  include/linux/spi/spi.h         |   20 ++++++++++++++++++--
>  include/uapi/linux/spi/spidev.h |   17 ++++++++++++++++-
>  4 files changed, 76 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 004b10f..3f6dc93 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -868,6 +868,14 @@ static void of_register_spi_devices(struct spi_master
> *master)
>  			spi->mode |= SPI_CS_HIGH;
>  		if (of_find_property(nc, "spi-3wire", NULL))
>  			spi->mode |= SPI_3WIRE;
> +		if (of_find_property(nc, "spi-tx-dual", NULL))
> +			spi->mode |= SPI_TX_DUAL;
> +		if (of_find_property(nc, "spi-tx-quad", NULL))
> +			spi->mode |= SPI_TX_QUAD;
> +		if (of_find_property(nc, "spi-rx-dual", NULL))
> +			spi->mode |= SPI_RX_DUAL;
> +		if (of_find_property(nc, "spi-rx-quad", NULL))
> +			spi->mode |= SPI_RX_QUAD;
> 
 [Pekon] I think its cleaner to use similar parameters for channel-width
 info everywhere. Like you have added separate fields  'tx_nbits' and
 'rx_nbits' in spi_transfer, Why not do similar here for 'spi_master' ?
And also in 'spi_device'. This can be like below:

- SPI_3WIRE : tx_nbit = 0, rx_nbit = 0 (single wire for MISO & MOSI)
- SPI_4WIRE :  tx_nbit = 1, rx_nbit = 1 (separate wire for MISO & MOSI)
- DUAL_SPI :   tx_nbit = 2, rx_nbit = 2
- QUAD_SPI : tx_nbit = 2 or 4, rx_nbit = 4
This way 'mode' field can be explicitly left for other purposes like CPHA, CPOL.
OR custom modes (like modified SPI mode in Freescale controllers).

But if you are touching any existing configuration (like SPI_3WIRE as
proposed  above), Then please send it as independent patch/proposal,
which can be Acked by individual SPI driver maintainers.

[Pekon]: I think it is correct to assume all these SPI modes as mutually
exclusive from of_property() point of view? 
Instead of defining separate of_properties(), you can define a single
of_property() , something like 'max-tx-nbits' and 'max-rx-nbits'
which can represent various modes like (DUAL, QUAD, 3WIRE, 4WIRE).

>  		/* Device speed */
>  		prop = of_get_property(nc, "spi-max-frequency", &len);
> @@ -1316,6 +1324,12 @@ int spi_setup(struct spi_device *spi)
>  	/* help drivers fail *cleanly* when they need options
>  	 * that aren't supported with their current master
>  	 */
> +	if (((spi->mode & SPI_TX_DUAL) && (spi->mode & SPI_TX_QUAD))
> ||
> +		((spi->mode & SPI_RX_DUAL) && (spi->mode &
> SPI_RX_QUAD))) {
> +		dev_err(&spi->dev,
> +		"setup: can not select dual and quad at the same time\n");
> +		return -EINVAL;
> +	}
[Pekon]: this check would be not be required if you have single
 of_property() for all modes.


>  	bad_bits = spi->mode & ~spi->master->mode_bits;
>  	if (bad_bits) {
>  		dev_err(&spi->dev, "setup: unsupported mode bits %x\n",
> diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
> index 2e0655d..0b776de 100644
> --- a/drivers/spi/spidev.c
> +++ b/drivers/spi/spidev.c
> @@ -75,6 +75,9 @@ static DECLARE_BITMAP(minors, N_SPI_MINORS);
>  				| SPI_LSB_FIRST | SPI_3WIRE | SPI_LOOP \
>  				| SPI_NO_CS | SPI_READY)
> 
> +#define SPI_EXTMODE_MASK	(SPI_MODE_MASK | SPI_TX_DUAL \
> +				| SPI_TX_QUAD | SPI_RX_DUAL |
> SPI_RX_QUAD)
> +
>  struct spidev_data {
>  	dev_t			devt;
>  	spinlock_t		spi_lock;
> @@ -268,6 +271,8 @@ static int spidev_message(struct spidev_data *spidev,
>  		k_tmp->bits_per_word = u_tmp->bits_per_word;
>  		k_tmp->delay_usecs = u_tmp->delay_usecs;
>  		k_tmp->speed_hz = u_tmp->speed_hz;
> +		k_tmp->tx_nbits = u_tmp->tx_nbits;
> +		k_tmp->rx_nbits = u_tmp->rx_nbits;
>  #ifdef VERBOSE
>  		dev_dbg(&spidev->spi->dev,
>  			"  xfer len %zd %s%s%s%dbits %u usec %uHz\n",
> @@ -369,7 +374,10 @@ spidev_ioctl(struct file *filp, unsigned int cmd,
> unsigned long arg)
>  	case SPI_IOC_RD_MAX_SPEED_HZ:
>  		retval = __put_user(spi->max_speed_hz, (__u32 __user
> *)arg);
>  		break;
> -
> +	case SPI_IOC_EXTRD_MODE:
> +		retval = __put_user(spi->mode & SPI_EXTMODE_MASK,
> +					(__u16 __user *)arg);
> +		break;
>  	/* write requests */
>  	case SPI_IOC_WR_MODE:
>  		retval = __get_user(tmp, (u8 __user *)arg);
> @@ -433,6 +441,25 @@ spidev_ioctl(struct file *filp, unsigned int cmd,
> unsigned long arg)
>  				dev_dbg(&spi->dev, "%d Hz (max)\n", tmp);
>  		}
>  		break;
> +	case SPI_IOC_EXTWR_MODE:
> +		retval = __get_user(tmp, (u16 __user *)arg);
> +		if (retval == 0) {
> +			u16	save = spi->mode;
> +
> +			if (tmp & ~SPI_EXTMODE_MASK) {
> +				retval = -EINVAL;
> +				break;
> +			}
> +
> +			tmp |= spi->mode & ~SPI_EXTMODE_MASK;
> +			spi->mode = (u16)tmp;
> +			retval = spi_setup(spi);
> +			if (retval < 0)
> +				spi->mode = save;
> +			else
> +				dev_dbg(&spi->dev, "spi mode %02x\n",
> tmp);
> +		}
> +		break;
> 
>  	default:
>  		/* segmented and/or full-duplex I/O request */
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 38c2b92..222e49e 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -74,7 +74,7 @@ struct spi_device {
>  	struct spi_master	*master;
>  	u32			max_speed_hz;
>  	u8			chip_select;
> -	u8			mode;
> +	u16			mode;
>  #define	SPI_CPHA	0x01			/* clock phase */
>  #define	SPI_CPOL	0x02			/* clock polarity */
>  #define	SPI_MODE_0	(0|0)			/* (original
> MicroWire) */
> @@ -87,6 +87,10 @@ struct spi_device {
>  #define	SPI_LOOP	0x20			/* loopback mode */
>  #define	SPI_NO_CS	0x40			/* 1 dev/bus, no
> chipselect */
>  #define	SPI_READY	0x80			/* slave pulls low to
> pause */
> +#define	SPI_TX_DUAL	0x100			/* transmit with 2
> wires */
> +#define	SPI_TX_QUAD	0x200			/* transmit with 4
> wires */
> +#define	SPI_RX_DUAL	0x400			/* receive with 2
> wires */
> +#define	SPI_RX_QUAD	0x800			/* receive with 4
> wires */
>  	u8			bits_per_word;
>  	int			irq;
>  	void			*controller_state;
> @@ -437,6 +441,8 @@ extern struct spi_master
> *spi_busnum_to_master(u16 busnum);
>   * @rx_buf: data to be read (dma-safe memory), or NULL
>   * @tx_dma: DMA address of tx_buf, if @spi_message.is_dma_mapped
>   * @rx_dma: DMA address of rx_buf, if @spi_message.is_dma_mapped
> + * @tx_nbits: number of bits used for writting
> + * @rx_nbits: number of bits used for reading
>   * @len: size of rx and tx buffers (in bytes)
>   * @speed_hz: Select a speed other than the device default for this
>   *      transfer. If 0 the default (from @spi_device) is used.
> @@ -491,6 +497,11 @@ extern struct spi_master
> *spi_busnum_to_master(u16 busnum);
>   * by the results of previous messages and where the whole transaction
>   * ends when the chipselect goes intactive.
>   *
> + * When SPI can transfer in 1x,2x or 4x. It can get this tranfer information
> + * from device through @tx_nbits and @rx_nbits. In Bi-direction, these
> + * two should both be set. User can set transfer mode with
> SPI_NBITS_SINGLE(1x)
> + * SPI_NBITS_DUAL(2x) and SPI_NBITS_QUAD(4x) to support these three
> transfer.
> + *
>   * The code that submits an spi_message (and its spi_transfers)
>   * to the lower layers is responsible for managing its memory.
>   * Zero-initialize every field you don't set up explicitly, to
> @@ -511,6 +522,11 @@ struct spi_transfer {
>  	dma_addr_t	rx_dma;
> 
>  	unsigned	cs_change:1;
> +	u8		tx_nbits;
> +	u8		rx_nbits;
> +#define	SPI_NBITS_SINGLE	0x0; /* 1bit transfer */
> +#define	SPI_NBITS_DUAL		0x01; /* 2bits transfer */
> +#define	SPI_NBITS_QUAD		0x02; /* 4bits transfer */

[Pekon]: I don't think it's a good place for #defines.  Plz keep it out of struct body.

>  	u8		bits_per_word;
>  	u16		delay_usecs;
>  	u32		speed_hz;
> @@ -858,7 +874,7 @@ struct spi_board_info {
>  	/* mode becomes spi_device.mode, and is essential for chips
>  	 * where the default of SPI_CS_HIGH = 0 is wrong.
>  	 */
> -	u8		mode;
> +	u16		mode;
> 
>  	/* ... may need additional spi_device chip config data here.
>  	 * avoid stuff protocol drivers can set; but include stuff


With regards, pekon

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
