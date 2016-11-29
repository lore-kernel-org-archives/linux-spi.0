From: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6, 5/8] mtd: m25p80: Let m25p80_read() fallback to spi
 transfer
Date: Mon, 28 Nov 2016 17:32:47 -0800
Message-ID: <7697b2fa-4660-c791-e891-a22c8bc5390f@gmail.com>
References: <1472076269-4731-1-git-send-email-kdasu.kdev@gmail.com>
 <1472076269-4731-6-git-send-email-kdasu.kdev@gmail.com>
 <4b3b3d3e-b3f8-1d5b-65e3-0c37b6a29096@gmail.com>
 <8309370e-f99f-ed51-4789-c1d97d9d8191@atmel.com>
 <CAKekbesq1deU_0TCV4STAi=o8jZwoc_u+9zkdZuEhmd+BGwU2A@mail.gmail.com>
 <ae2c984e-2bcf-380e-a257-dbe786973af1@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, vigneshr-l0cyMroinI0@public.gmane.org,
        Yendapally Reddy Dhananjaya Reddy
        <yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
        Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
        Kamal Dasu <kamal.dasu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ae2c984e-2bcf-380e-a257-dbe786973af1-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 10/14/2016 06:17 AM, Cyrille Pitchen wrote:
> Le 13/10/2016 à 23:15, Kamal Dasu a écrit :
>> On Mon, Oct 10, 2016 at 4:29 AM, Cyrille Pitchen
>> <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> wrote:
>>> Hi all,
>>>
>>>
>>> Le 10/10/2016 à 10:04, Florian Fainelli a écrit :
>>>> On 08/24/2016 03:04 PM, Kamal Dasu wrote:
>>>>> In m25p80_read() even though spi_flash_read() is supported
>>>>> by some drivers, under certain circumstances like unaligned
>>>>> buffer, address or address range limitations on certain SoCs
>>>>> let it fallback to core spi reads. Such drivers are expected
>>>>> to return -EAGAIN so that the m25p80_read() uses standard
>>>>> spi transfer.
>>>>>
>>>>> Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>>
>>>> MTD folks, any comments on this?
>>>>
>>>>> ---
>>>>>  drivers/mtd/devices/m25p80.c | 11 +++++++++--
>>>>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
>>>>> index 9cf7fcd..77c2d2c 100644
>>>>> --- a/drivers/mtd/devices/m25p80.c
>>>>> +++ b/drivers/mtd/devices/m25p80.c
>>>>> @@ -155,9 +155,16 @@ static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
>>>>>              msg.data_nbits = m25p80_rx_nbits(nor);
>>>>>
>>>>>              ret = spi_flash_read(spi, &msg);
>>>>> -            if (ret < 0)
>>>>> +
>>>>> +            if (ret >= 0)
>>>>> +                    return msg.retlen;
>>>>> +
>>>>> +            /*
>>>>> +             * some spi master drivers might need to fallback to
>>>>> +             * normal spi transfer
>>>>> +             */
>>>>> +            if (ret != -EAGAIN)
>>> I just wonder whether EINVAL would be a better choice.
>>
>>  spi_flash_read calls the down stream controller driver with all
>> params addresses however  accelerated transfer is not possible by the
>> controller due to alignment issues, it needs to indicate to m25p call
>> to try the normal transfer, hence use of EAGAIN seemed appropriate.
>>
>>
> 
> Yes, I think I've understood the purpose of this patch. In the example you
> gave, the actual implementation of spi_flash_read() works fine with aligned
> addresses but doesn't support unaligned addresses. Hence, such unaligned
> addresses are invalid argument for spi_flash_read() and we should fall back
> to the legacy implementation of m25p80_read().
> 
> My point is just that EINVAL clearly tells that the SPI controller driver
> implementation of spi_flash_read() doesn't support the given input
> parameters, here an unaligned address, whereas EAGAIN suggests that some
> hardware resource is temporarily unavailable and we could call spi_flash_read()
> again later. However, in this case, spi_flash_read() would still fail even if
> called later.
> 
> That's why I've suggested EINVAL might have been a better choice than EAGAIN,
> but honestly it's not a big deal, only a detail. So if most people prefer to
> keep EAGAIN, I'm perfectly fine with it! :)
> 
> I don't want my comment to delay the integration of this patch.

So what are we going to do now, should Kamal resubmit and
s/EGAIN/EINVAL/ or is EAGAIN good enough? If EINVAL needs to be used,
which I agree with you seems like a valid error code to return, this
does imply changing the Broadcom QSPI driver though... so we have to
coordinate the two changes to be merged through the same cycle to avoid
regressions.
-- 
Florian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
