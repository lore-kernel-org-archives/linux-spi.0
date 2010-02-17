From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/2] spi/mmc_spi: SPI bus locking
	API, using mutex
Date: Wed, 17 Feb 2010 13:03:04 -0700
Message-ID: <fa686aa41002171203p552b75adqc219b7857301eca3@mail.gmail.com>
References: <20100217191513.52392dd6.eschwab@online.de>
	<20100217191709.2fd1028c.eschwab@online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
To: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100217191709.2fd1028c.eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Feb 17, 2010 at 11:17 AM, Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org> wrote:
> From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
>
> SPI bus locking API to allow exclusive access to the SPI bus, especially,=
 but
> not limited to, for the mmc_spi driver.
>
> Coded according to an outline from Grant Likely; here is his
> specification (accidentally swapped function names corrected):

Wow.  You're fast.  Thanks for turning this around so quickly.  Comments be=
low.

> It requires 3 things to be added to struct spi_master.
> - 1 Mutex
> - 1 spin lock
> - 1 flag.
>
> The mutex protects spi_sync, and provides sleeping "for free"
> The spinlock protects the atomic spi_async call.
> The flag is set when the lock is obtained, and checked while holding
> the spinlock in spi_async(). =A0If the flag is checked, then spi_async()
> must fail immediately.
>
> The current runtime API looks like this:
> spi_async(struct spi_device*, struct spi_message*);
> spi_sync(struct spi_device*, struct spi_message*);
>
> The API needs to be extended to this:
> spi_async(struct spi_device*, struct spi_message*)
> spi_sync(struct spi_device*, struct spi_message*)
> spi_bus_lock(struct spi_master*) =A0/* although struct spi_device* might
> be easier */
> spi_bus_unlock(struct spi_master*)
> spi_async_locked(struct spi_device*, struct spi_message*)
> spi_sync_locked(struct spi_device*, struct spi_message*)
>
> Drivers can only call the last two if they already hold the spi_master_lo=
ck().
>
> spi_bus_lock() obtains the mutex, obtains the spin lock, sets the
> flag, and releases the spin lock before returning. =A0It doesn't even
> need to sleep while waiting for "in-flight" spi_transactions to
> complete because its purpose is to guarantee no additional
> transactions are added. =A0It does not guarantee that the bus is idle.
>
> spi_bus_unlock() clears the flag and releases the mutex, which will
> wake up any waiters.
>
> The difference between spi_async() and spi_async_locked() is that the
> locked version bypasses the check of the lock flag. =A0Both versions
> need to obtain the spinlock.
>
> The difference between spi_sync() and spi_sync_locked() is that
> spi_sync() must hold the mutex while enqueuing a new transfer.
> spi_sync_locked() doesn't because the mutex is already held. =A0Note
> however that spi_sync must *not* continue to hold the mutex while
> waiting for the transfer to complete, otherwise only one transfer
> could be queued up at a time!
>
> Almost no code needs to be written. =A0The current spi_async() and
> spi_sync() can probably be renamed to __spi_async() and __spi_sync()
> so that spi_async(), spi_sync(), spi_async_locked() and
> spi_sync_locked() can just become wrappers around the common code.
>
> spi_sync() is protected by a mutex because it can sleep
> spi_async() needs to be protected with a flag and a spinlock because
> it can be called atomically and must not sleep

The usage model also needs to be documented in the .c files or
somewhere in Documentation/.  You can use the kernel doc format to
document the usage of each function in the .c file.

>
> Signed-off-by: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
> ---
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -524,6 +524,10 @@ int spi_register_master(struct spi_master *master)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dynamic =3D 1;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 spin_lock_init(&master->bus_lock_spinlock);
> + =A0 =A0 =A0 mutex_init(&master->bus_lock_mutex);
> + =A0 =A0 =A0 master->bus_lock_chipselect =3D SPI_MASTER_BUS_UNLOCKED;

The locking operations have no dependency on the spi_device.  Rename
bus_lock_chipselect to bus_lock_flag.

> @@ -692,7 +696,7 @@ EXPORT_SYMBOL_GPL(spi_setup);
> =A0* (This rule applies equally to all the synchronous transfer calls,
> =A0* which are wrappers around this core asynchronous primitive.)
> =A0*/
> -int spi_async(struct spi_device *spi, struct spi_message *message)
> +static int __spi_async(struct spi_device *spi, struct spi_message *messa=
ge)
> =A0{
> =A0 =A0 =A0 =A0struct spi_master *master =3D spi->master;
>
> @@ -720,7 +724,6 @@ int spi_async(struct spi_device *spi, struct spi_mess=
age *message)
> =A0 =A0 =A0 =A0message->status =3D -EINPROGRESS;
> =A0 =A0 =A0 =A0return master->transfer(spi, message);
> =A0}
> -EXPORT_SYMBOL_GPL(spi_async);

Move the definitions of spi_async() and spi_async_locked() to here,
right below the __spi_async() definition.

>
>
> =A0/*--------------------------------------------------------------------=
-----*/
> @@ -756,14 +759,50 @@ static void spi_complete(void *arg)
> =A0*
> =A0* It returns zero on success, else a negative error code.
> =A0*/
> +
> +int spi_sync_locked(struct spi_device *spi, struct spi_message *message)
> +{
> + =A0 =A0 =A0 DECLARE_COMPLETION_ONSTACK(done);
> + =A0 =A0 =A0 int status;
> + =A0 =A0 =A0 struct spi_master *master =3D spi->master;
> +
> + =A0 =A0 =A0 message->complete =3D spi_complete;
> + =A0 =A0 =A0 message->context =3D &done;
> +
> + =A0 =A0 =A0 spin_lock(&master->bus_lock_spinlock);
> +
> + =A0 =A0 =A0 status =3D __spi_async(spi, message);
> +
> + =A0 =A0 =A0 spin_unlock(&master->bus_lock_spinlock);

Instead of obtaining the spinlock here, both spi_sync() and
spi_sync_locked() can call spi_async_locked() directly (assuming the
chipselect # check is removed from spi_async_locked() as per my
comment below.

> +
> + =A0 =A0 =A0 if (status =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wait_for_completion(&done);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D message->status;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 message->context =3D NULL;
> +
> + =A0 =A0 =A0 return status;
> +}
> +EXPORT_SYMBOL_GPL(spi_sync_locked);
> +
> =A0int spi_sync(struct spi_device *spi, struct spi_message *message)
> =A0{
> =A0 =A0 =A0 =A0DECLARE_COMPLETION_ONSTACK(done);
> =A0 =A0 =A0 =A0int status;
> + =A0 =A0 =A0 struct spi_master *master =3D spi->master;
>
> =A0 =A0 =A0 =A0message->complete =3D spi_complete;
> =A0 =A0 =A0 =A0message->context =3D &done;
> - =A0 =A0 =A0 status =3D spi_async(spi, message);
> +
> + =A0 =A0 =A0 mutex_lock(&master->bus_lock_mutex);
> +
> + =A0 =A0 =A0 spin_lock(&master->bus_lock_spinlock);
> + =A0 =A0 =A0 status =3D __spi_async(spi, message);
> + =A0 =A0 =A0 spin_unlock(&master->bus_lock_spinlock);
> +
> + =A0 =A0 =A0 mutex_unlock(&master->bus_lock_mutex);
> +
> =A0 =A0 =A0 =A0if (status =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wait_for_completion(&done);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D message->status;

spi_sync() and spi_sync_locked() are largely idenical.  Only
difference is that spi_sync() needs to obtain the mutex.  Rename
spi_sync() to __spi_sync() and add a 'get_lock' flag parameter.  Then
make spi_sync() and spi_sync_locked() call __spi_sync() with the flag
set appropriately.

> @@ -773,6 +812,82 @@ int spi_sync(struct spi_device *spi, struct spi_mess=
age *message)
> =A0}
> =A0EXPORT_SYMBOL_GPL(spi_sync);
>
> +int spi_async(struct spi_device *spi, struct spi_message *message)
> +{
> + =A0 =A0 =A0 struct spi_master *master =3D spi->master;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&master->bus_lock_spinlock, flags);
> +
> + =A0 =A0 =A0 if (master->bus_lock_chipselect =3D=3D SPI_MASTER_BUS_UNLOC=
KED
> + =A0 =A0 =A0 =A0|| master->bus_lock_chipselect =3D=3D spi->chip_select) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __spi_async(spi, message);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* REVISIT:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* if the bus is locked to an other devic=
e, message transfer
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* fails. Maybe messages should be queued=
 in the SPI layer
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* and be transmitted after the lock is r=
eleased.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
> + =A0 =A0 =A0 }

Don't check the cs#.  There is no need for the cs to be associated
with the lock.  Make this simply:

if (master->bus_lock_flag)
        ret =3D -EBUSY;
else
        ret =3D __spi_async(spi, message);

You can drop the comment here too; or at the very least move it into
the header block for the function.

> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&master->bus_lock_spinlock, flags);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +EXPORT_SYMBOL_GPL(spi_async);
> +
> +int spi_async_locked(struct spi_device *spi, struct spi_message *message)
> +{
> + =A0 =A0 =A0 struct spi_master *master =3D spi->master;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&master->bus_lock_spinlock, flags);
> +
> + =A0 =A0 =A0 if (master->bus_lock_chipselect =3D=3D spi->chip_select) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __spi_async(spi, message);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* API error: the SPI bus lock is not held =
by the caller */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&master->bus_lock_spinlock, flags);

This version shouldn't check the flag at all.  Just call __spi_async()
unconditionally.  Taking the spin lock probably isn't necessary, but
it is probably wise to keep the locking model consistent.

> +
> + =A0 =A0 =A0 return ret;
> +
> +}
> +EXPORT_SYMBOL_GPL(spi_async_locked);
> +
> +int spi_bus_lock(struct spi_device *spi)

On further reflection, pass in the spi_master to this function.  The
lock is bus-wide, and doesn't care about what device is used, as long
as the caller is the one holding the lock.  ie. a caller could
potentially have more than one spi_device that it would want to use
while holding the bus lock.

> +{
> + =A0 =A0 =A0 struct spi_master *master =3D spi->master;
> +
> + =A0 =A0 =A0 spin_lock(&master->bus_lock_spinlock);
> + =A0 =A0 =A0 mutex_lock(&master->bus_lock_mutex);

Always grab the mutex first.  Otherwise you could get a deadlock.

> + =A0 =A0 =A0 master->bus_lock_chipselect =3D spi->chip_select;

make this simply master->bus_lock_flag =3D 1;

> + =A0 =A0 =A0 spin_unlock(&master->bus_lock_spinlock);
> +
> + =A0 =A0 =A0 /* mutex remains locked until spi_bus_unlock is called */
> +
> + =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL_GPL(spi_bus_lock);
> +
> +int spi_bus_unlock(struct spi_device *spi)

Ditto here, pass in spi_master*

> +{
> + =A0 =A0 =A0 struct spi_master =A0 =A0 =A0 *master =3D spi->master;
> +
> + =A0 =A0 =A0 spin_lock(&master->bus_lock_spinlock);
> + =A0 =A0 =A0 mutex_unlock(&master->bus_lock_mutex);
> + =A0 =A0 =A0 master->bus_lock_chipselect =3D SPI_MASTER_BUS_UNLOCKED;
> + =A0 =A0 =A0 spin_unlock(&master->bus_lock_spinlock);

Unlock doesn't need to grab the spinlock.  It can just clear the flag
and release the mutex.

> +
> + =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL_GPL(spi_bus_unlock);
> +
> =A0/* portable code must never pass more than 32 bytes */
> =A0#define =A0 =A0 =A0 =A0SPI_BUFSIZ =A0 =A0 =A0max(32,SMP_CACHE_BYTES)
>
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -261,6 +261,14 @@ struct spi_master {
> =A0#define SPI_MASTER_NO_RX =A0 =A0 =A0 BIT(1) =A0 =A0 =A0 =A0 =A0/* can'=
t do buffer read */
> =A0#define SPI_MASTER_NO_TX =A0 =A0 =A0 BIT(2) =A0 =A0 =A0 =A0 =A0/* can'=
t do buffer write */
>
> + =A0 =A0 =A0 /* lock and mutex for SPI bus locking */
> + =A0 =A0 =A0 spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0bus_lock_spinlock;
> + =A0 =A0 =A0 struct mutex =A0 =A0 =A0 =A0 =A0 =A0bus_lock_mutex;
> +
> + =A0 =A0 =A0 /* chipselect of the spi device that locked the bus for exc=
lusive use */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bus_lock_chip=
select;
> +#define SPI_MASTER_BUS_UNLOCKED 0xFF =A0 =A0 =A0 =A0 =A0 /* value to ind=
icate unlocked */
> +
> =A0 =A0 =A0 =A0/* Setup mode and clock, etc (spi driver may call many tim=
es).
> =A0 =A0 =A0 =A0 *
> =A0 =A0 =A0 =A0 * IMPORTANT: =A0this may be called when transfers to anot=
her
> @@ -541,6 +549,8 @@ static inline void spi_message_free(struct spi_messag=
e *m)
>
> =A0extern int spi_setup(struct spi_device *spi);
> =A0extern int spi_async(struct spi_device *spi, struct spi_message *messa=
ge);
> +extern int
> +spi_async_locked(struct spi_device *spi, struct spi_message *message);

Please keep return parameters and annotations on the same line as the
function name (makes grep results more useful).  You can break lines
between parameters.

>
> =A0/*--------------------------------------------------------------------=
-------*/
>
> @@ -550,6 +560,9 @@ extern int spi_async(struct spi_device *spi, struct s=
pi_message *message);
> =A0*/
>
> =A0extern int spi_sync(struct spi_device *spi, struct spi_message *messag=
e);
> +extern int spi_sync_locked(struct spi_device *spi, struct spi_message *m=
essage);
> +extern int spi_bus_lock(struct spi_device *spi);
> +extern int spi_bus_unlock(struct spi_device *spi);
>
> =A0/**
> =A0* spi_write - SPI synchronous write

Really good work.  Thanks!

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
