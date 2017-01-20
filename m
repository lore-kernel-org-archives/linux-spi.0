From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6, 5/8] mtd: m25p80: Let m25p80_read() fallback to spi transfer
Date: Fri, 20 Jan 2017 14:35:52 -0500
Message-ID: <CAC=U0a3sjckTOH4ASHDaqM4ZZu_Y3J=82BoFp=NM9qvEeEEdjQ@mail.gmail.com>
References: <1472076269-4731-1-git-send-email-kdasu.kdev@gmail.com>
 <1472076269-4731-6-git-send-email-kdasu.kdev@gmail.com> <4b3b3d3e-b3f8-1d5b-65e3-0c37b6a29096@gmail.com>
 <8309370e-f99f-ed51-4789-c1d97d9d8191@atmel.com> <CAKekbesq1deU_0TCV4STAi=o8jZwoc_u+9zkdZuEhmd+BGwU2A@mail.gmail.com>
 <ae2c984e-2bcf-380e-a257-dbe786973af1@atmel.com> <7697b2fa-4660-c791-e891-a22c8bc5390f@gmail.com>
 <a0179d25-71a5-b47f-4272-49aa2a346b54@atmel.com> <3260e7e5-fcf1-599a-e7b4-fd7aaef5be2e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
        Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Kamal Dasu <kamal.dasu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, vigneshr-l0cyMroinI0@public.gmane.org,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Yendapally Reddy Dhananjaya Reddy
        <yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list"
        <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
        Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3260e7e5-fcf1-599a-e7b4-fd7aaef5be2e-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Marek,

I will resend patch with s/EGAIN/EINVAL/ and also include the related
change in the broadcom controller driver as well.

Thnaks
Kamal

On Thu, Dec 1, 2016 at 10:45 AM, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On 11/29/2016 03:06 PM, Cyrille Pitchen wrote:
>> Hi all,
>>
>> +Marek
>>
>> Le 29/11/2016 =C3=A0 02:32, Florian Fainelli a =C3=A9crit :
>>> On 10/14/2016 06:17 AM, Cyrille Pitchen wrote:
>>>> Le 13/10/2016 =C3=A0 23:15, Kamal Dasu a =C3=A9crit :
>>>>> On Mon, Oct 10, 2016 at 4:29 AM, Cyrille Pitchen
>>>>> <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> wrote:
>>>>>> Hi all,
>>>>>>
>>>>>>
>>>>>> Le 10/10/2016 =C3=A0 10:04, Florian Fainelli a =C3=A9crit :
>>>>>>> On 08/24/2016 03:04 PM, Kamal Dasu wrote:
>>>>>>>> In m25p80_read() even though spi_flash_read() is supported
>>>>>>>> by some drivers, under certain circumstances like unaligned
>>>>>>>> buffer, address or address range limitations on certain SoCs
>>>>>>>> let it fallback to core spi reads. Such drivers are expected
>>>>>>>> to return -EAGAIN so that the m25p80_read() uses standard
>>>>>>>> spi transfer.
>>>>>>>>
>>>>>>>> Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>>>>>
>>>>>>> MTD folks, any comments on this?
>>>>>>>
>>>>>>>> ---
>>>>>>>>  drivers/mtd/devices/m25p80.c | 11 +++++++++--
>>>>>>>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m2=
5p80.c
>>>>>>>> index 9cf7fcd..77c2d2c 100644
>>>>>>>> --- a/drivers/mtd/devices/m25p80.c
>>>>>>>> +++ b/drivers/mtd/devices/m25p80.c
>>>>>>>> @@ -155,9 +155,16 @@ static ssize_t m25p80_read(struct spi_nor *no=
r, loff_t from, size_t len,
>>>>>>>>              msg.data_nbits =3D m25p80_rx_nbits(nor);
>>>>>>>>
>>>>>>>>              ret =3D spi_flash_read(spi, &msg);
>>>>>>>> -            if (ret < 0)
>>>>>>>> +
>>>>>>>> +            if (ret >=3D 0)
>>>>>>>> +                    return msg.retlen;
>>>>>>>> +
>>>>>>>> +            /*
>>>>>>>> +             * some spi master drivers might need to fallback to
>>>>>>>> +             * normal spi transfer
>>>>>>>> +             */
>>>>>>>> +            if (ret !=3D -EAGAIN)
>>>>>> I just wonder whether EINVAL would be a better choice.
>>>>>
>>>>>  spi_flash_read calls the down stream controller driver with all
>>>>> params addresses however  accelerated transfer is not possible by the
>>>>> controller due to alignment issues, it needs to indicate to m25p call
>>>>> to try the normal transfer, hence use of EAGAIN seemed appropriate.
>>>>>
>>>>>
>>>>
>>>> Yes, I think I've understood the purpose of this patch. In the example=
 you
>>>> gave, the actual implementation of spi_flash_read() works fine with al=
igned
>>>> addresses but doesn't support unaligned addresses. Hence, such unalign=
ed
>>>> addresses are invalid argument for spi_flash_read() and we should fall=
 back
>>>> to the legacy implementation of m25p80_read().
>>>>
>>>> My point is just that EINVAL clearly tells that the SPI controller dri=
ver
>>>> implementation of spi_flash_read() doesn't support the given input
>>>> parameters, here an unaligned address, whereas EAGAIN suggests that so=
me
>>>> hardware resource is temporarily unavailable and we could call spi_fla=
sh_read()
>>>> again later. However, in this case, spi_flash_read() would still fail =
even if
>>>> called later.
>>>>
>>>> That's why I've suggested EINVAL might have been a better choice than =
EAGAIN,
>>>> but honestly it's not a big deal, only a detail. So if most people pre=
fer to
>>>> keep EAGAIN, I'm perfectly fine with it! :)
>>>>
>>>> I don't want my comment to delay the integration of this patch.
>>>
>>> So what are we going to do now, should Kamal resubmit and
>>> s/EGAIN/EINVAL/ or is EAGAIN good enough? If EINVAL needs to be used,
>>> which I agree with you seems like a valid error code to return, this
>>> does imply changing the Broadcom QSPI driver though... so we have to
>>> coordinate the two changes to be merged through the same cycle to avoid
>>> regressions.
>>>
>>
>> Please replace the EAGAIN error code by EINVAL then I agree to merge thi=
s
>> patch in the github spi-nor tree.
>>
>> I know the EAGAIN error code has already been introduced in spi-bcm-qspi=
.c
>> through the spi tree but since currently m25p280.c handles neither EAGAI=
N
>> nor EINVAL as the returned code of spi_flash_read(), I guess no regressi=
on
>> will be introduced. The feature will work as expected once both the m25p=
80.c
>> and spi-bcm-qspi.c use the very same error code.
>>
>> Marek, any comment?
>
> I'm fine with this patch, but a patch for the broadcom controller would
> be great.
>
> --
> Best regards,
> Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
