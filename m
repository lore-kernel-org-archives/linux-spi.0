From: Quentin YANG <quentinyang05-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Suggested Patch for 'amba-pl022.c' to solve
 the problem of running 'spidev_test' on Phytec LPC3250 board.
Date: Fri, 20 Aug 2010 09:50:51 +1000
Message-ID: <AANLkTinowRt+9H749STKP3wEJ6x0s5EHss=-p8x=eQDb@mail.gmail.com>
References: <AANLkTinQFQMXXBh7bq5ce_iwOzGvYCZxud6QWb-S71yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTinQFQMXXBh7bq5ce_iwOzGvYCZxud6QWb-S71yQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi,

Forgot to say that I am running Linux Kernel 2.6.34 with LPC32xx patch from
NXP.

Regards,
Quentin



On Fri, Aug 20, 2010 at 9:38 AM, Quentin YANG <quentinyang05-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>wrote:

> Hi,
>
> I was having trouble to run 'spidev_test' on Phytec LPC3250 board when I
> tried to change the SPI mode.
>
> [root@GsnCommsModule debug]# ./spidev_test -O
> can't set spi mode: Invalid argument
> Aborted
>
> 'dmesg' shows:
> ......
> spidev spi1.0: setup: unsupported mode bits 2
> ......
>
>
> According to source code: driver/spi/spi.c
> ............................
>     bad_bits = spi->mode & ~spi->master->mode_bits;
>     if (bad_bits) {
>         dev_dbg(&spi->dev, "setup: unsupported mode bits %x\n",
>             bad_bits);
>         return -EINVAL;
>     }
> ..............................
>
>
> Therefore, I did following change on amba-pl022.c, which is used as SPI
> master controller driver
> -------------------------------------------------------------------
>
> pl022_probe(struct amba_device *adev, struct amba_id *id)
> {
>        ...................................
>
>     /* Allocate master with space for data */
>     master = spi_alloc_master(dev, sizeof(struct pl022));
>     if (master == NULL) {
>         dev_err(&adev->dev, "probe - cannot alloc SPI master\n");
>         status = -ENOMEM;
>         goto err_no_master;
>
>     }
>
>         /* Quentin Added 2010-AUG-19 */
>         master->mode_bits=MODEBITS;
>      .........................
>
> }
>
> Now I can successfully set 'SPI mode' to mode 3.
>
> [root@GsnCommsModule debug]# ./spidev_test -OH
> spi mode: 3
> bits per word: 8
> max speed: 500000 Hz (500 KHz)
> 00 00 00 00 00 00
> 00 00 00 00 00 00
> 00 00 00 00 00 00
> 00 00 00 00 00 00
> 00 00 00 00 00 00
> 00 00 00 00 00 00
> 00 00
>
>
> Hope this patch can be added to amba-pl022.c in the next Linux kernel
> release.
>
>
> Regards,
>
> *Quentin YANG***
>
> *Firmware Engineer***
>
> *Tel: +61-2-88787724***
>
> *CHK GridSense Pty Ltd*
>
> Unit 3, 20-36 Nancarrow Ave
>
> Meadowbank, NSW, 2114, Australia
>
> Web Site:  http://www.gridsense.com
>
>
>
>
------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
