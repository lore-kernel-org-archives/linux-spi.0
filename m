From: Kamal Dasu <kamal.dasu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v6 2/3] mtd: spi-nor: Add spi-nor flash device
 synchronization between flash states
Date: Thu, 9 Mar 2017 15:03:09 -0500
Message-ID: <CAKekbeuH5TZCwz-i-2ayQHEFvZCQy-Oq3ZXY5Zut-ub_odPS=A@mail.gmail.com>
References: <1487967399-28967-1-git-send-email-kdasu.kdev@gmail.com>
 <1487967399-28967-3-git-send-email-kdasu.kdev@gmail.com> <79e81e11-3073-7078-05ca-3201f6dac15f@wedev4u.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
        Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
        Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Cyrille Pitchen <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <79e81e11-3073-7078-05ca-3201f6dac15f-yU5RGvR974pGWvitb5QawA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Mar 7, 2017 at 6:08 PM, Cyrille Pitchen
<cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org> wrote:
> Hi Kamal,
>
> +Boris for his knowledge on power management.
>
> Le 24/02/2017 =C3=A0 21:16, Kamal Dasu a =C3=A9crit :
>> Added flash access synchronization methods spi_nor_get/release_device().=
 This
>> change allows spi-nor driver to maintain flash states in spi-nor stuctur=
e for
>> read, write, erase, lock, unlock nor ops. Only when the flash state is F=
L_READY
>> a new state is set and spi-nor flash op is initiated. The state change i=
s done
>> with a spin_lock held and released as soon as the state is changed. Else=
 the
>> current process for spi-nor transfer is queued till the flash is in FL_R=
EADY
>> state. This change allows us to add mtd layer synchronization when the m=
td
>> resume suspend handlers are added.
>>
>
> This version goes the wrong way, IMHO. This is not what I meant when I
> was talking about synchronizing MTD and SPI devices: when accessing the
> MTD device we should wake the SPI device up instead of blocking the MTD
> handlers when the SPI device enters its suspended mode.
>
> However, the good news is that looking closer at how the runtime pm
> works, this synchronization should already be managed:
>
> in drivers/mtd/devices/m25p80.c:
>
>         nor->dev =3D &spi->dev;
>
> and in drivers/mtd/spi-nor/spi-nor.c:
>
>         struct device *dev =3D nor->dev;
>         [...]
>         mtd->dev.parent =3D dev;
>
> Hence the SPI device is the parent of the MTD device.
> Then by default, when resuming a device, the runtime pm framework wakes
> the device parent up too: see rmp_resume() from drivers/base/power/runtim=
e.c
>
> About the SPI controller, by default SPI masters ignore their children,
> so the SPI controller won't be resumed by the m25p80 SPI device. However
> spi_sync() can resume the controller when master->auto_runtime_pm is true=
.
>
> Then back to the MTD subsystem, maybe you should patch the mtdcore.c
> file rather than m25p80.c so the whole MTD subsystem could take
> advantage of your work on power management:
> you could update the .pm member of 'struct class' mtd_class to add
> runtime pm support to the already existing system-wide power management
> support. I guess you will have to add new hooks such mtd->_pm_suspend
> and mtd->_pm_resume. Finally spi-nor.c will implement those 2 hooks (and
> the NAND subsystem may also implement them as needed).
>
> Boris, does it make sense?
>
> Also, one last comment: I guess a call to pm_runtime_enable() is missing
> somewhere is this series, otherwise I don't think this could work.
> Besides, depending on where it will be added, we should not call
> pm_runtime_enable() unconditionally thinking of users who don't want to
> use this feature sending unneeded SPI commands to the memory.
>

To be clear I was implementing  for system sleep and S2/S3 pm modes,
so mtd_resume() and mtd_suspend() or the m25p80 suspend/resume is what
I need. I am not not having a run_time_pm  requirement.


> Best regards,
>
> Cyrille
>

Kamal
>
>> Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/mtd/spi-nor/spi-nor.c | 69 ++++++++++++++++++++++++++++++++++++=
+++++++
>>  include/linux/mtd/spi-nor.h   |  4 +++
>>  2 files changed, 73 insertions(+)
>>
>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor=
.c
>> index 8b71c11..5363807 100644
>> --- a/drivers/mtd/spi-nor/spi-nor.c
>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>> @@ -89,6 +89,15 @@ struct flash_info {
>>
>>  #define JEDEC_MFR(info)      ((info)->id[0])
>>
>> +/* map table for spi_nor op to flashchip state  */
>> +static int spi_nor_state[] =3D {
>> +     [SPI_NOR_OPS_READ]      =3D FL_READING,
>> +     [SPI_NOR_OPS_WRITE]     =3D FL_WRITING,
>> +     [SPI_NOR_OPS_ERASE]     =3D FL_ERASING,
>> +     [SPI_NOR_OPS_LOCK]      =3D FL_LOCKING,
>> +     [SPI_NOR_OPS_UNLOCK]    =3D FL_UNLOCKING,
>> +};
>> +
>>  static const struct flash_info *spi_nor_match_id(const char *name);
>>
>>  /*
>> @@ -396,10 +405,64 @@ static int erase_chip(struct spi_nor *nor)
>>       return nor->write_reg(nor, SPINOR_OP_CHIP_ERASE, NULL, 0);
>>  }
>>
>> +/**
>> + * spi_nor_get_device - [GENERIC] Get chip for selected access
>> + * @param mtd                MTD device structure
>> + * @param new_state  the state which is requested
>> + *
>> + * Get the nor flash device and lock it for exclusive access
>> + */
>> +static int spi_nor_get_device(struct mtd_info *mtd, int new_state)
>> +{
>> +     struct spi_nor *nor =3D mtd_to_spi_nor(mtd);
>> +     DECLARE_WAITQUEUE(wait, current);
>> +
>> +     /*
>> +      * Grab the lock and see if the device is available
>> +      */
>> +     while (1) {
>> +             spin_lock(&nor->chip_lock);
>> +             if (nor->state =3D=3D FL_READY) {
>> +                     nor->state =3D new_state;
>> +                     spin_unlock(&nor->chip_lock);
>> +                     break;
>> +             }
>> +             if (new_state =3D=3D FL_PM_SUSPENDED) {
>> +                     spin_unlock(&nor->chip_lock);
>> +                     return (nor->state =3D=3D FL_PM_SUSPENDED) ? 0 : -=
EAGAIN;
>> +             }
>> +             set_current_state(TASK_UNINTERRUPTIBLE);
>> +             add_wait_queue(&nor->wq, &wait);
>> +             spin_unlock(&nor->chip_lock);
>> +             schedule();
>> +             remove_wait_queue(&nor->wq, &wait);
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +/**
>> + * spi_nor_release_device - [GENERIC] release chip
>> + * @mtd: MTD device structure
>> + *
>> + * Release nor flash chip lock and wake up anyone waiting on the device=
.
>> + */
>> +static void spi_nor_release_device(struct mtd_info *mtd)
>> +{
>> +     struct spi_nor *nor =3D mtd_to_spi_nor(mtd);
>> +
>> +     /* Release the controller and the chip */
>> +     spin_lock(&nor->chip_lock);
>> +     nor->state =3D FL_READY;
>> +     wake_up(&nor->wq);
>> +     spin_unlock(&nor->chip_lock);
>> +}
>> +
>>  static int spi_nor_lock_and_prep(struct spi_nor *nor, enum spi_nor_ops =
ops)
>>  {
>>       int ret =3D 0;
>>
>> +     spi_nor_get_device(&nor->mtd, spi_nor_state[ops]);
>>       mutex_lock(&nor->lock);
>>
>>       if (nor->prepare) {
>> @@ -407,6 +470,7 @@ static int spi_nor_lock_and_prep(struct spi_nor *nor=
, enum spi_nor_ops ops)
>>               if (ret) {
>>                       dev_err(nor->dev, "failed in the preparation.\n");
>>                       mutex_unlock(&nor->lock);
>> +                     spi_nor_release_device(&nor->mtd);
>>                       return ret;
>>               }
>>       }
>> @@ -418,6 +482,7 @@ static void spi_nor_unlock_and_unprep(struct spi_nor=
 *nor, enum spi_nor_ops ops)
>>       if (nor->unprepare)
>>               nor->unprepare(nor, ops);
>>       mutex_unlock(&nor->lock);
>> +     spi_nor_release_device(&nor->mtd);
>>  }
>>
>>  /*
>> @@ -1743,6 +1808,10 @@ int spi_nor_scan(struct spi_nor *nor, const char =
*name, enum read_mode mode)
>>                       return ret;
>>       }
>>
>> +     nor->state =3D FL_READY;
>> +     init_waitqueue_head(&nor->wq);
>> +     spin_lock_init(&nor->chip_lock);
>> +
>>       /*
>>        * call init function to send necessary spi-nor read/write config
>>        * commands to nor flash based on above nor settings
>> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
>> index 29a8283..244d98d 100644
>> --- a/include/linux/mtd/spi-nor.h
>> +++ b/include/linux/mtd/spi-nor.h
>> @@ -13,6 +13,7 @@
>>  #include <linux/bitops.h>
>>  #include <linux/mtd/cfi.h>
>>  #include <linux/mtd/mtd.h>
>> +#include <linux/mtd/flashchip.h>
>>
>>  /*
>>   * Manufacturer IDs
>> @@ -210,6 +211,9 @@ struct spi_nor {
>>
>>       void *priv;
>>       const struct flash_info *info;
>> +     spinlock_t              chip_lock;
>> +     wait_queue_head_t       wq;
>> +     flstate_t               state;
>>  };
>>
>>  static inline void spi_nor_set_flash_node(struct spi_nor *nor,
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
