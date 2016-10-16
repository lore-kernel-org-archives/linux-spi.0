From: Ralf Ramsauer <ralf-ex4EvEgDZR1o7HI0AxOeTKwczVv4G7md@public.gmane.org>
Subject: Re: [PATCH] spi: mark device nodes only in case of successful
 instantiation
Date: Sun, 16 Oct 2016 11:55:22 +0200
Message-ID: <39e8d53a-a93d-feeb-044f-9b1b239dff21@ramses-pyramidenbau.de>
References: <20161014193113.29275-1-ralf@ramses-pyramidenbau.de>
 <CAMuHMdUMvjZvwBMUrWTk+obbUYsfRJxPTmdnv7Fz6uzkQ8nbbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
        Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdUMvjZvwBMUrWTk+obbUYsfRJxPTmdnv7Fz6uzkQ8nbbQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Geert,

On 10/16/2016 10:49 AM, Geert Uytterhoeven wrote:
> Hi Ralf,
> 
> (Cc i2c)
> 
> On Fri, Oct 14, 2016 at 9:31 PM, Ralf Ramsauer
> <ralf-ex4EvEgDZR1o7HI0AxOeTKwczVv4G7md@public.gmane.org> wrote:
>> Instantiated SPI device nodes are marked with OF_POPULATE. This was
>> introduced in bd6c164. On unloading, loaded device nodes will of course
>> be unmarked. The problem are nodes the fail during initialisation: If a
>> node failed during registration, it won't be unloaded and hence never be
>> unmarked again.
>>
>> So if a SPI driver module is unloaded and reloaded, it will skip nodes
>> that failed before.
>>
>> Skip device nodes that are already populated and mark them only in case
>> of success.
>>
>> Fixes: bd6c164 ("spi: Mark instantiated device nodes with OF_POPULATE")
>> Signed-off-by: Ralf Ramsauer <ralf-ex4EvEgDZR1o7HI0AxOeTKwczVv4G7md@public.gmane.org>
>> Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
>> ---
>> Hi,
>>
>> imagine the following situation: you loaded a spi driver as module, but
>> it fails to instantiate, because of some reasons (e.g. some resources,
>> like gpios, might be in use in userspace).
>>
>> When reloading the driver, _all_ nodes, including previously failed
>> ones, should be probed again. This is not the case at the moment.
>> Current behaviour only re-registers nodes that were previously
>> successfully loaded.
>>
>> This small patches fixes this behaviour. I stumbled over this while
>> working on a spi driver.
> 
> Thanks for your patch!
> 
>>  drivers/spi/spi.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
>> index 200ca22..f96a04e 100644
>> --- a/drivers/spi/spi.c
>> +++ b/drivers/spi/spi.c
>> @@ -1604,12 +1604,15 @@ static void of_register_spi_devices(struct spi_master *master)
>>                 return;
>>
>>         for_each_available_child_of_node(master->dev.of_node, nc) {
>> -               if (of_node_test_and_set_flag(nc, OF_POPULATED))
>> +               if (of_node_check_flag(nc, OF_POPULATED))
>>                         continue;
>>                 spi = of_register_spi_device(master, nc);
>> -               if (IS_ERR(spi))
>> +               if (IS_ERR(spi)) {
>>                         dev_warn(&master->dev, "Failed to create SPI device for %s\n",
>>                                 nc->full_name);
>> +                       continue;
>> +               }
>> +               of_node_set_flag(nc, OF_POPULATED);
> 
> I think it's safer to keep the atomic test-and-set, but clear the flag on
> failure, cfr. of_platform_device_create_pdata() and of_amba_device_create().
Ack, no prob. Let me change this in the next version.
> 
> Shouldn't of_spi_notify() be fixed, too?
Right, that's almost the same path.
> 
> The same issue exists for i2c in of_i2c_register_devices() and of_i2c_notify(),
> which is what I had used as an example.
Good old c&p ;-)
I'll fix and test that tomorrow and come back with two patches, as it
touches different subsystems.

Best
  Ralf
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 


-- 
Ralf Ramsauer
GPG: 0x8F10049B
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
