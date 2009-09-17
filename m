From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [spi-devel-general] [PATCH 1/2] spi: new SPI bus
	lock/unlockfunctions
Date: Thu, 17 Sep 2009 18:53:58 -0400
Message-ID: <8bd0f97a0909171553s1b7ee725x728bbca2f49511a9@mail.gmail.com>
References: <1253224997-7422-1-git-send-email-vapier@gentoo.org>
	<BD79186B4FD85F4B8E60E381CAEE190901D41E44@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	Yi Li <yi.li@analog.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753548AbZIQWyR@vger.kernel.org>
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901D41E44@mi8nycmail19.Mi8.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Sep 17, 2009 at 18:45, H Hartley Sweeten wrote:
> On Thursday, September 17, 2009 3:03 PM, Mike Frysinger wrote:
>> From: Yi Li <yi.li@analog.com>
>>
>> For some MMC cards over SPI bus, it needs to lock the SPI bus for it=
s own
>> use. =C2=A0The SPI transfer must not be interrupted by other SPI dev=
ices that
>> share the SPI bus with SPI MMC card.
>>
>> This patch introduces 2 APIs for SPI bus locking operation.
>>
>> =C2=A0/**
>> + * spi_lock_bus - lock SPI bus for exclusive access
>> + * @spi: device which want to lock the bus
>> + * Context: any
>> + *
>> + * Once the caller owns exclusive access to the SPI bus,
>> + * only messages for this device will be transferred.
>> + * Messages for other devices are queued but not transferred until
>> + * the bus owner unlock the bus.
>> + *
>> + * The caller may call spi_lock_bus() before spi_sync() or spi_asyn=
c().
>> + * So this call may be used in irq and other contexts which can't s=
leep,
>> + * as well as from task contexts which can sleep.
>> + *
>> + * It returns zero on success, else a negative error code.
>> + */
>> +int spi_lock_bus(struct spi_device *spi)
>> +{
>> + =C2=A0 =C2=A0 if (spi->master->lock_bus)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return spi->master->lock=
_bus(spi);
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(spi_lock_bus);
>> +
>> +/**
>> + * spi_unlock_bus - unlock SPI bus
>> + * @spi: device which want to unlock the bus
>> + * Context: any
>> + *
>> + * The caller has called spi_lock_bus() to lock the bus. It calls
>> + * spi_unlock_bus() to release the bus so messages for other device=
s
>> + * can be transferred.
>> + *
>> + * If the caller did not call spi_lock_bus() before, spi_unlock_bus=
()
>> + * should have no effect.
>> + *
>> + * It returns zero on success, else a negative error code.
>> + */
>> +int spi_unlock_bus(struct spi_device *spi)
>> +{
>> + =C2=A0 =C2=A0 if (spi->master->unlock_bus)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return spi->master->unlo=
ck_bus(spi);
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(spi_unlock_bus);
>> +
>> +/**
>
> I assume the spi master driver must supply the {lock/unlock}_bus meth=
ods
> to properly support the locking.

currently, yes.  a common solution would be nice.  ideas/patches welcom=
e ;).

>=C2=A0But, by returning 0 when the methods
> are not supplied you are basically saying all the current master driv=
ers
> in mainline support bus locking. =C2=A0I think this is really only "t=
rue" if
> spi->master->num_chipselect =3D=3D 1.

right, but that is no different from what we have today.  there is no
way for a client to guarantee exclusive access, so you cant write code
assuming it in the first place.  the only consumer thus far (mmc_spi)
actually errors out if such conditions exist.

in other words, we arent breaking anything.

> Also, do you have a master driver that does have the {lock/unlock}_bu=
s
> methods? =C2=A0I would like to see how you handled it.

http://git.kernel.org/?p=3Dlinux/kernel/git/vapier/blackfin.git;a=3Dcom=
mitdiff;h=3Dcc54fa8ed63e11a000031bc650d41d57b441803d
-mike
