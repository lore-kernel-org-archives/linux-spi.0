From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/2]spi: DUAL and QUAD support
Date: Tue, 3 Sep 2013 20:24:08 -0700
Message-ID: <CA+7tXih4XkhZ8xGcaUdGU6O4ZN1ZLfqyjb2UEKsRxsZBA+=DZw@mail.gmail.com>
References: <1376216117-5864-1-git-send-email-wangyuhang2014@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Poddar,
	Sourav" <sourav.poddar-l0cyMroinI0@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>
To: wangyuhang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1376216117-5864-1-git-send-email-wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Aug 11, 2013 at 3:15 AM, wangyuhang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> fix the previous patch some mistake below:

This isn't a very good commit message.  "the previous patch" will have
no meaning in the kernel git repo.  The rest of the message only
describes changes since a previous version of the patch and not the
actual patch in full.

>
> +               /* Device DUAL/QUAD mode */
> +               prop = of_get_property(nc, "spi-tx-nbits", &len);

Why not use of_property_read_u32() here?

> +               if (!prop || len < sizeof(*prop)) {
> +                       dev_err(&master->dev, "%s has no 'spi-tx-nbits' property\n",
> +                               nc->full_name);
> +                       spi_dev_put(spi);
> +                       continue;

So if no spi-tx-nbits property is supplied, the device is rejected and
the loop continues to the next device entry?  This means ALL EXISTING
DEVICE TREES with SPI devices will be rejected, since none of them
have this new property!  Was this patch tested at all with any system
before being accepted?

> +       /* check mode to prevent that DUAL and QUAD set at the same time
> +        */
> +       if (((spi->mode & SPI_TX_DUAL) && (spi->mode & SPI_TX_QUAD)) ||
> +               ((spi->mode & SPI_RX_DUAL) && (spi->mode & SPI_RX_QUAD))) {
> +               dev_err(&spi->dev,
> +               "setup: can not select dual and quad at the same time\n");
> +               return -EINVAL;

This test can be done with fewer operations as:
if ((spi->mode & (SPI_TX_DUAL|SPI_TX_QUAD)) == (SPI_TX_DUAL|SPI_TX_QUAD) ||
    (spi->mode & (SPI_RX_DUAL|SPI_RX_QUAD)) == (SPI_RX_DUAL|SPI_RX_QUAD)) {


> +       }
> +       /* if it is SPI_3WIRE mode, DUAL and QUAD should be forbidden
> +        */
> +       if ((spi->mode & SPI_3WIRE) && (spi->mode &
> +               (SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD)))
> +               return -EINVAL;

No dev_err message for this possibility?  What's different than the
previous check that does produce a message?

>         /* help drivers fail *cleanly* when they need options
>          * that aren't supported with their current master
>          */
Following this comment is the code:
        bad_bits = spi->mode & ~spi->master->mode_bits;
        if (bad_bits) {
                dev_err(&spi->dev, "setup: unsupported mode bits %x\n",
                        bad_bits);
                return -EINVAL;
        }

Won't this always trigger for anything that sets one of the dual or quad bits?

> @@ -1370,12 +1428,50 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
>         /**
>          * Set transfer bits_per_word and max speed as spi device default if
>          * it is not set for this transfer.
> +        * Set transfer tx_nbits and rx_nbits as single transfer default
> +        * (SPI_NBITS_SINGLE) if it is not set for this transfer.
>          */
>         list_for_each_entry(xfer, &message->transfers, transfer_list) {
>                 if (!xfer->bits_per_word)
>                         xfer->bits_per_word = spi->bits_per_word;
>                 if (!xfer->speed_hz)
>                         xfer->speed_hz = spi->max_speed_hz;
> +               if (xfer->tx_buf && !xfer->tx_nbits)
> +                       xfer->tx_nbits = SPI_NBITS_SINGLE;
> +               if (xfer->rx_buf && !xfer->rx_nbits)
> +                       xfer->rx_nbits = SPI_NBITS_SINGLE;
> +               /* check transfer tx/rx_nbits:
> +                * 1. keep the value is not out of single, dual and quad
> +                * 2. keep tx/rx_nbits is contained by mode in spi_device
> +                * 3. if SPI_3WIRE, tx/rx_nbits should be in single
> +                */
> +               if (xfer->tx_nbits != SPI_NBITS_SINGLE &&
> +                       xfer->tx_nbits != SPI_NBITS_DUAL &&
> +                       xfer->tx_nbits != SPI_NBITS_QUAD)
> +                       return -EINVAL;
> +               if ((xfer->tx_nbits == SPI_NBITS_DUAL) &&
> +                       !(spi->mode & (SPI_TX_DUAL | SPI_TX_QUAD)))
> +                       return -EINVAL;
> +               if ((xfer->tx_nbits == SPI_NBITS_QUAD) &&
> +                       !(spi->mode & SPI_TX_QUAD))
> +                       return -EINVAL;
> +               if ((spi->mode & SPI_3WIRE) &&
> +                       (xfer->tx_nbits != SPI_NBITS_SINGLE))
> +                       return -EINVAL;
> +               /* check transfer rx_nbits */
> +               if (xfer->rx_nbits != SPI_NBITS_SINGLE &&
> +                       xfer->rx_nbits != SPI_NBITS_DUAL &&
> +                       xfer->rx_nbits != SPI_NBITS_QUAD)
> +                       return -EINVAL;
> +               if ((xfer->rx_nbits == SPI_NBITS_DUAL) &&
> +                       !(spi->mode & (SPI_RX_DUAL | SPI_RX_QUAD)))
> +                       return -EINVAL;
> +               if ((xfer->rx_nbits == SPI_NBITS_QUAD) &&
> +                       !(spi->mode & SPI_RX_QUAD))
> +                       return -EINVAL;
> +               if ((spi->mode & SPI_3WIRE) &&
> +                       (xfer->rx_nbits != SPI_NBITS_SINGLE))
> +                       return -EINVAL;
>         }

What a lot of code to check the transfer bits.  It really needs this much?

> @@ -511,6 +524,11 @@ struct spi_transfer {
>         dma_addr_t      rx_dma;
>
>         unsigned        cs_change:1;
> +       u8              tx_nbits;
> +       u8              rx_nbits;
> +#define        SPI_NBITS_SINGLE        0x01 /* 1bit transfer */
> +#define        SPI_NBITS_DUAL          0x02 /* 2bits transfer */
> +#define        SPI_NBITS_QUAD          0x04 /* 4bits transfer */

These fields increase the size of a spi_transfer by 4 bytes.  If you
used bitfields instead it wouldn't increase the size at all since
there are still 7 bits left after cs_change.

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
