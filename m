From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v6 2/3] mtd: spi-nor: Add spi-nor flash device
 synchronization between flash states
Date: Sun, 5 Mar 2017 02:11:59 +0100
Message-ID: <d0bfefa9-4a53-3ee9-fe92-c008dd4e9199@denx.de>
References: <1487967399-28967-1-git-send-email-kdasu.kdev@gmail.com>
 <1487967399-28967-3-git-send-email-kdasu.kdev@gmail.com>
 <7500eaf2-082d-2902-b6b5-768189d1aae9@denx.de>
 <CAC=U0a04jNhP1uWB6jMvDE-D7j7cgvdSG1DazQiU+mJmTwC7eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
To: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAC=U0a04jNhP1uWB6jMvDE-D7j7cgvdSG1DazQiU+mJmTwC7eQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 03/03/2017 10:38 PM, Kamal Dasu wrote:
> Marek,
>
> On Sun, Feb 26, 2017 at 7:18 AM, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
>> On 02/24/2017 09:16 PM, Kamal Dasu wrote:
>>> Added flash access synchronization methods spi_nor_get/release_device(). This
>>
>> Should be get/put to be consistent with the rest of the kernel ...
>>
>
> Can change that.
>
>>> change allows spi-nor driver to maintain flash states in spi-nor stucture for
>>> read, write, erase, lock, unlock nor ops. Only when the flash state is FL_READY
>>> a new state is set and spi-nor flash op is initiated. The state change is done
>>> with a spin_lock held and released as soon as the state is changed. Else the
>>> current process for spi-nor transfer is queued till the flash is in FL_READY
>>> state. This change allows us to add mtd layer synchronization when the mtd
>>> resume suspend handlers are added.
>>>
>>> Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> ---
>>>  drivers/mtd/spi-nor/spi-nor.c | 69 +++++++++++++++++++++++++++++++++++++++++++
>>>  include/linux/mtd/spi-nor.h   |  4 +++
>>>  2 files changed, 73 insertions(+)
>>>
>>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
>>> index 8b71c11..5363807 100644
>>> --- a/drivers/mtd/spi-nor/spi-nor.c
>>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>>> @@ -89,6 +89,15 @@ struct flash_info {
>>>
>>>  #define JEDEC_MFR(info)      ((info)->id[0])
>>>
>>> +/* map table for spi_nor op to flashchip state  */
>>> +static int spi_nor_state[] = {
>>> +     [SPI_NOR_OPS_READ]      = FL_READING,
>>> +     [SPI_NOR_OPS_WRITE]     = FL_WRITING,
>>> +     [SPI_NOR_OPS_ERASE]     = FL_ERASING,
>>> +     [SPI_NOR_OPS_LOCK]      = FL_LOCKING,
>>> +     [SPI_NOR_OPS_UNLOCK]    = FL_UNLOCKING,
>>> +};
>>
>> Can't you just retain which instruction is in progress instead of adding
>> yet another orthogonal FL_FOO ?
>>
>
> I just used what other mtd flash drivers use. I could use the ops, but
> will have to add the missing ops/states.

What is missing ?

>>>  static const struct flash_info *spi_nor_match_id(const char *name);
>>>
>>>  /*
>>> @@ -396,10 +405,64 @@ static int erase_chip(struct spi_nor *nor)
>>>       return nor->write_reg(nor, SPINOR_OP_CHIP_ERASE, NULL, 0);
>>>  }
>>>
>>> +/**
>>> + * spi_nor_get_device - [GENERIC] Get chip for selected access
>>> + * @param mtd                MTD device structure
>>> + * @param new_state  the state which is requested
>>> + *
>>> + * Get the nor flash device and lock it for exclusive access
>>> + */
>>> +static int spi_nor_get_device(struct mtd_info *mtd, int new_state)
>>> +{
>>> +     struct spi_nor *nor = mtd_to_spi_nor(mtd);
>>> +     DECLARE_WAITQUEUE(wait, current);
>>> +
>>> +     /*
>>> +      * Grab the lock and see if the device is available
>>> +      */
>>> +     while (1) {
>>> +             spin_lock(&nor->chip_lock);
>>> +             if (nor->state == FL_READY) {
>>> +                     nor->state = new_state;
>>> +                     spin_unlock(&nor->chip_lock);
>>> +                     break;
>>> +             }
>>> +             if (new_state == FL_PM_SUSPENDED) {
>>> +                     spin_unlock(&nor->chip_lock);
>>> +                     return (nor->state == FL_PM_SUSPENDED) ? 0 : -EAGAIN;
>>> +             }
>>> +             set_current_state(TASK_UNINTERRUPTIBLE);
>>> +             add_wait_queue(&nor->wq, &wait);
>>> +             spin_unlock(&nor->chip_lock);
>>> +             schedule();
>>> +             remove_wait_queue(&nor->wq, &wait);
>>
>> Somehow, I have to wonder, doesn't runtime PM implement this sort of
>> functionality already ?
>>
>
> I did not see any API I could apply here.

Does runtime_pm_get()/runtime_pm_put() help here ?

[...]

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
