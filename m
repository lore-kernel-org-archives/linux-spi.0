From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: rspi: Remove obsolete qspi platform_device_id entry
Date: Wed, 24 Jun 2015 11:21:16 +0200
Message-ID: <CAMuHMdUpn-fs7b5QpQNyheYDLSqZxp_GmAsaOsRKTRdNw8Qsfw@mail.gmail.com>
References: <1435064527-11786-1-git-send-email-geert+renesas@glider.be>
	<1435064527-11786-2-git-send-email-geert+renesas@glider.be>
	<CAMuHMdUEWmNKreYcMOyJZjBiL_raG37BdSTAnFGg_W-jqOuV1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdUEWmNKreYcMOyJZjBiL_raG37BdSTAnFGg_W-jqOuV1Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Jun 24, 2015 at 10:01 AM, Geert Uytterhoeven
<geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> On Tue, Jun 23, 2015 at 3:02 PM, Geert Uytterhoeven
> <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org> wrote:
>> Since commit a483dcbfa21f919c ("ARM: shmobile: lager: Remove legacy
>> board support"), R-Car Gen2 SoCs are only supported in generic DT-only
>> ARM multi-platform builds.  The driver doesn't need to match platform
>> devices by name anymore, hence remove the corresponding
>> platform_device_id entry.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
>> ---
>>  drivers/spi/spi-rspi.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
>> index 56216b205e0f2c34..3e82b84c9ed48b2f 100644
>> --- a/drivers/spi/spi-rspi.c
>> +++ b/drivers/spi/spi-rspi.c
>> @@ -1295,7 +1295,6 @@ error1:
>>
>>  static const struct platform_device_id spi_driver_ids[] = {
>>         { "rspi",       (kernel_ulong_t)&rspi_ops },
>> -       { "qspi",       (kernel_ulong_t)&qspi_ops },
>>         {},
>>  };
>
> qspi_ops is still used for DT matching, but rspi_of_match[] is protected
> by #ifdef CONFIG_OF, so this may lead to compiler warnings.

(same as rspi_rz_ops)

Unlike the sh_eth case, I don't get a warning if CONFIG_OF=n, because
qspi_ops is const. Not even with a picky gcc 4.1.2.

> Please drop this one, will fix.

And unlike the sh_eth case, this cannot be fixed with one #ifdef without
restructuring the whole driver.

Hence I'm inclined to withdraw my drop requst.
Mark, what do you think? Is this patch OK as-is?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
