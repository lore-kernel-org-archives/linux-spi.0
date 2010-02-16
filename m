From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/5] spi: spi_lock_bus and
	spi_unlock_bus
Date: Tue, 16 Feb 2010 13:43:59 -0700
Message-ID: <fa686aa41002161243y6e24e439yff54a28cbe295de3@mail.gmail.com>
References: <20100216204450.e043eed8.eschwab@online.de>
	<20100216205720.ebe949a1.eschwab@online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
To: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100216205720.ebe949a1.eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Feb 16, 2010 at 12:57 PM, Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org> wrote:
> From: Yi Li <yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>
> For some MMC cards over SPI bus, it needs to lock the SPI bus for its own
> use. =A0The SPI transfer must not be interrupted by other SPI devices that
> share the SPI bus with SPI MMC card.
>
> This patch introduces 2 APIs for SPI bus locking operation.
>
> Signed-off-by: Yi Li <yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
> ---
> Andrew: we've posted these in the past with no response. =A0could you pick
> =A0 =A0 =A0 =A0them up please ?
> =A0drivers/spi/spi.c =A0 =A0 =A0 | =A0 48 +++++++++++++++++++++++++++++++=
++++++++++++++++
> =A0include/linux/spi/spi.h | =A0 =A07 ++++++
> =A02 files changed, 55 insertions(+), 0 deletions(-)
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 70845cc..b82b8ad 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -653,6 +653,54 @@ static void spi_complete(void *arg)
> =A0}
>
> =A0/**
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
> + =A0 =A0 =A0 if (spi->master->lock_bus)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return spi->master->lock_bus(spi);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL_GPL(spi_lock_bus);

This series seems to try and solve the problem the hard way, and by
creating a new locking scheme (and as history shows, new locking
schemes are *alwasy* broken).

Why is the locking getting pushed down to the bus driver level?  It
seems to me that the whole thing could be handled with common code and
a mutex in the spi_master structure.  spi_sync would be easy to handle
by putting a mutex around the spi_message submission.  spi_async would
be a little harder since it needs to be atomic, but that could also be
handled with a flag protected by a spinlock.

Basically, the idea is that existing drivers continue to use the API as-is

Drivers that want to lock the bus for exclusive access must call
spi_lock_bus() which should take the mutex and then sleep until all
in-flight spi_messages are processed.  After that, anyone calling
spi_async() will simply sleep until the locker unlocks the bus again.

To handle spi_sync() would probably require a flag protected by a
spinlock.  If the flag is set, then spi_sync() would simply fail.

Finally, the locking driver would need locked versions of spi_sync()
and spi_async() that sidestep the lock checks.  It would only be valid
to call these versions when holding the SPI bus lock.

There is no need to specify the spi_device in the lock request.  Since
the lock is exclusive, it is known that the only driver calling the
locked API version must already hold the lock.

Have I got this wrong?

g.

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
> + =A0 =A0 =A0 if (spi->master->unlock_bus)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return spi->master->unlock_bus(spi);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL_GPL(spi_unlock_bus);
> +
> +/**
> =A0* spi_sync - blocking/synchronous SPI data transfers
> =A0* @spi: device with which data will be exchanged
> =A0* @message: describes the data transfers
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index c47c4b4..c53292c 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -214,6 +214,8 @@ static inline void spi_unregister_driver(struct spi_d=
river *sdrv)
> =A0* =A0 =A0 the device whose settings are being modified.
> =A0* @transfer: adds a message to the controller's transfer queue.
> =A0* @cleanup: frees controller-specific state
> + * @lock_bus: lock SPI bus for exclusive access
> + * @unlock_bus: unlock SPI bus so other devices can access
> =A0*
> =A0* Each SPI master controller can communicate with one or more @spi_dev=
ice
> =A0* children. =A0These make a small bus, sharing MOSI, MISO and SCK sign=
als
> @@ -286,6 +288,9 @@ struct spi_master {
>
> =A0 =A0 =A0 =A0/* called on release() to free memory provided by spi_mast=
er */
> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*cleanup)(str=
uct spi_device *spi);
> +
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*lock_bus)(str=
uct spi_device *spi);
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*unlock_bus)(s=
truct spi_device *spi);
> =A0};
>
> =A0static inline void *spi_master_get_devdata(struct spi_master *master)
> @@ -578,6 +583,8 @@ spi_async(struct spi_device *spi, struct spi_message =
*message)
> =A0*/
>
> =A0extern int spi_sync(struct spi_device *spi, struct spi_message *messag=
e);
> +extern int spi_lock_bus(struct spi_device *spi);
> +extern int spi_unlock_bus(struct spi_device *spi);
>
> =A0/**
> =A0* spi_write - SPI synchronous write
>
>
>
>
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
