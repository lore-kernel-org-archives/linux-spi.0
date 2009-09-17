From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: RE: [spi-devel-general] [PATCH 1/2] spi: new SPI bus lock/unlockfunctions
Date: Thu, 17 Sep 2009 18:45:54 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901D41E44@mi8nycmail19.Mi8.com>
References: <1253224997-7422-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Yi Li" <yi.li@analog.com>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>
To: "Mike Frysinger" <vapier@gentoo.org>,
	<spi-devel-general@lists.sourceforge.net>,
	"David Brownell" <dbrownell@users.sourceforge.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753378AbZIQWpy@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <1253224997-7422-1-git-send-email-vapier@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thursday, September 17, 2009 3:03 PM, Mike Frysinger wrote:
> From: Yi Li <yi.li@analog.com>
> 
> For some MMC cards over SPI bus, it needs to lock the SPI bus for its own
> use.  The SPI transfer must not be interrupted by other SPI devices that
> share the SPI bus with SPI MMC card.
> 
> This patch introduces 2 APIs for SPI bus locking operation.
> 
> Signed-off-by: Yi Li <yi.li@analog.com>
> Signed-off-by: Bryan Wu <cooloney@kernel.org>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
> Andrew: we've posted these in the past with no response.  could you pick
>         them up please ?

Hello Mike,

This is the first time I have seen this patch.  I might have missed it
previously.

I would like to test it on my ep93xx system but have some question below.
 
>  drivers/spi/spi.c       |   48 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/spi/spi.h |    7 ++++++
>  2 files changed, 55 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 70845cc..b82b8ad 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -653,6 +653,54 @@ static void spi_complete(void *arg)
>  }
>  
>  /**
> + * spi_lock_bus - lock SPI bus for exclusive access
> + * @spi: device which want to lock the bus
> + * Context: any
> + *
> + * Once the caller owns exclusive access to the SPI bus,
> + * only messages for this device will be transferred.
> + * Messages for other devices are queued but not transferred until
> + * the bus owner unlock the bus.
> + *
> + * The caller may call spi_lock_bus() before spi_sync() or spi_async().
> + * So this call may be used in irq and other contexts which can't sleep,
> + * as well as from task contexts which can sleep.
> + *
> + * It returns zero on success, else a negative error code.
> + */
> +int spi_lock_bus(struct spi_device *spi)
> +{
> +	if (spi->master->lock_bus)
> +		return spi->master->lock_bus(spi);
> +	else
> +		return 0;
> +}
> +EXPORT_SYMBOL_GPL(spi_lock_bus);
> +
> +/**
> + * spi_unlock_bus - unlock SPI bus
> + * @spi: device which want to unlock the bus
> + * Context: any
> + *
> + * The caller has called spi_lock_bus() to lock the bus. It calls
> + * spi_unlock_bus() to release the bus so messages for other devices
> + * can be transferred.
> + *
> + * If the caller did not call spi_lock_bus() before, spi_unlock_bus()
> + * should have no effect.
> + *
> + * It returns zero on success, else a negative error code.
> + */
> +int spi_unlock_bus(struct spi_device *spi)
> +{
> +	if (spi->master->unlock_bus)
> +		return spi->master->unlock_bus(spi);
> +	else
> +		return 0;
> +}
> +EXPORT_SYMBOL_GPL(spi_unlock_bus);
> +
> +/**

I assume the spi master driver must supply the {lock/unlock}_bus methods
to properly support the locking.  But, by returning 0 when the methods
are not supplied you are basically saying all the current master drivers
in mainline support bus locking.  I think this is really only "true" if
spi->master->num_chipselect == 1.

Also, do you have a master driver that does have the {lock/unlock}_bus
methods?  I would like to see how you handled it.

Regards,
Hartley
