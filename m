From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 4/5] mtd: m25p80: Check if the spi flash device has pm support
Date: Mon, 6 Feb 2017 14:35:46 -0500
Message-ID: <CAC=U0a3V9fPnee6yYPw6CarFiKnwFw1aA-tm=+K4RQSm_bgVSg@mail.gmail.com>
References: <1486164676-12912-1-git-send-email-kdasu.kdev@gmail.com>
 <1486164676-12912-5-git-send-email-kdasu.kdev@gmail.com> <9108d13d-0f06-172f-5e8d-91ff80fdd510@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list"
        <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9108d13d-0f06-172f-5e8d-91ff80fdd510-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Feb 6, 2017 at 6:01 AM, Cyrille Pitchen
<cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> wrote:
> Hi Kamal,
>
> Le 04/02/2017 =C3=A0 00:31, Kamal Dasu a =C3=A9crit :
>> Call the spi_nor_rescan() only if the controller driver needs this
>> support. This way SoCs that need this feature can use it.
>>
>> Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/mtd/devices/m25p80.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
>> index 4528e33..ffdec60 100644
>> --- a/drivers/mtd/devices/m25p80.c
>> +++ b/drivers/mtd/devices/m25p80.c
>> @@ -328,8 +328,13 @@ static int m25p_suspend(struct device *dev)
>>  static int m25p_resume(struct device *dev)
>>  {
>>       struct m25p *flash =3D dev_get_drvdata(dev);
>> +     struct spi_device *spi =3D flash->spi;
>> +     int ret =3D 0;
>> +
>> +     if (spi_flash_pm_supported(spi))
>> +             ret =3D spi_nor_pm_rescan(&flash->spi_nor, NULL);
>>
>
> Why don't you squash patch 2 into this one? Patch 2 suggests that
> spi_nor_pm_rescan() could safely be called in any case but now this patch
> suggests that calling that function is not so safe.
>
> I see two cases:
>
> 1/ either calling spi_nor_pm_rescan() is safe in any case, then patches 3=
,
> 4 and 5 are needless.
>

I agree it should be safe to call resume after implementing your
suggestions for patch 1 itself.

> 2/ or calling spi_nor_pm_rescan() has unwanted side effects in some cases=
,
> then patch 2 should be squashed into this patch: patch 2 will never be
> taken alone in the spi-nor tree if it may introduce bugs or regressions.
>
> If something has to be done in the SPI sub-system, I guess it should be
> done first: for sure applying patches 3 and 5 would not create any issue.
> Then patches 2 and 4 squashed into a single patch may be safely applied a=
fter.
>
> However, patches 3 and 5 still need to be discussed first.
>

I agree that these are not needed.

> Best regards,
>
> Cyrille
>
>> -     return spi_nor_pm_rescan(&flash->spi-nor, NULL);
>> +     return ret;
>>  }
>>  #endif
>>  static SIMPLE_DEV_PM_OPS(m25p_pm_ops, m25p_suspend, m25p_resume);
>>
>

Thanks
Kamal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
