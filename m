From: Pantelis Antoniou <pantelis.antoniou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: mark device nodes only in case of successful instantiation
Date: Mon, 17 Oct 2016 22:20:47 +0300
Message-ID: <33118B65-9BF4-45AF-AC55-B44BECB5BBD1@gmail.com>
References: <20161014193113.29275-1-ralf@ramses-pyramidenbau.de> <CAMuHMdUMvjZvwBMUrWTk+obbUYsfRJxPTmdnv7Fz6uzkQ8nbbQ@mail.gmail.com> <39e8d53a-a93d-feeb-044f-9b1b239dff21@ramses-pyramidenbau.de>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
        Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Ralf Ramsauer <ralf-ex4EvEgDZR1o7HI0AxOeTKwczVv4G7md@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <39e8d53a-a93d-feeb-044f-9b1b239dff21-ex4EvEgDZR1o7HI0AxOeTKwczVv4G7md@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Ralf,

> On Oct 16, 2016, at 12:55 , Ralf Ramsauer =
<ralf-ex4EvEgDZR1o7HI0AxOeTKwczVv4G7md@public.gmane.org> wrote:
>=20
> Hi Geert,
>=20
> On 10/16/2016 10:49 AM, Geert Uytterhoeven wrote:
>> Hi Ralf,
>>=20
>> (Cc i2c)
>>=20
>> On Fri, Oct 14, 2016 at 9:31 PM, Ralf Ramsauer
>> <ralf-ex4EvEgDZR1o7HI0AxOeTKwczVv4G7md@public.gmane.org> wrote:
>>> Instantiated SPI device nodes are marked with OF_POPULATE. This was
>>> introduced in bd6c164. On unloading, loaded device nodes will of =
course
>>> be unmarked. The problem are nodes the fail during initialisation: =
If a
>>> node failed during registration, it won't be unloaded and hence =
never be
>>> unmarked again.
>>>=20
>>> So if a SPI driver module is unloaded and reloaded, it will skip =
nodes
>>> that failed before.
>>>=20
>>> Skip device nodes that are already populated and mark them only in =
case
>>> of success.
>>>=20
>>> Fixes: bd6c164 ("spi: Mark instantiated device nodes with =
OF_POPULATE")
>>> Signed-off-by: Ralf Ramsauer <ralf-ex4EvEgDZR1o7HI0AxOeTKwczVv4G7md@public.gmane.org>
>>> Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
>>> ---
>>> Hi,
>>>=20
>>> imagine the following situation: you loaded a spi driver as module, =
but
>>> it fails to instantiate, because of some reasons (e.g. some =
resources,
>>> like gpios, might be in use in userspace).
>>>=20
>>> When reloading the driver, _all_ nodes, including previously failed
>>> ones, should be probed again. This is not the case at the moment.
>>> Current behaviour only re-registers nodes that were previously
>>> successfully loaded.
>>>=20
>>> This small patches fixes this behaviour. I stumbled over this while
>>> working on a spi driver.
>>=20
>> Thanks for your patch!
>>=20
>>> drivers/spi/spi.c | 7 +++++--
>>> 1 file changed, 5 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
>>> index 200ca22..f96a04e 100644
>>> --- a/drivers/spi/spi.c
>>> +++ b/drivers/spi/spi.c
>>> @@ -1604,12 +1604,15 @@ static void of_register_spi_devices(struct =
spi_master *master)
>>>                return;
>>>=20
>>>        for_each_available_child_of_node(master->dev.of_node, nc) {
>>> -               if (of_node_test_and_set_flag(nc, OF_POPULATED))
>>> +               if (of_node_check_flag(nc, OF_POPULATED))
>>>                        continue;
>>>                spi =3D of_register_spi_device(master, nc);
>>> -               if (IS_ERR(spi))
>>> +               if (IS_ERR(spi)) {
>>>                        dev_warn(&master->dev, "Failed to create SPI =
device for %s\n",
>>>                                nc->full_name);
>>> +                       continue;
>>> +               }
>>> +               of_node_set_flag(nc, OF_POPULATED);
>>=20
>> I think it's safer to keep the atomic test-and-set, but clear the =
flag on
>> failure, cfr. of_platform_device_create_pdata() and =
of_amba_device_create().
> Ack, no prob. Let me change this in the next version.
>>=20
>> Shouldn't of_spi_notify() be fixed, too?
> Right, that's almost the same path.
>>=20
>> The same issue exists for i2c in of_i2c_register_devices() and =
of_i2c_notify(),
>> which is what I had used as an example.
> Good old c&p ;-)
> I'll fix and test that tomorrow and come back with two patches, as it
> touches different subsystems.
>=20

Thanks for this. This is a very rare case that=E2=80=99s easy to slip =
through.
It is good to be consistent :)

> Best
>  Ralf
>>=20

Regards

=E2=80=94 Pantelis

>> Gr{oetje,eeting}s,
>>=20
>>                        Geert
>>=20
>> --
>> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- =
geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org
>>=20
>> In personal conversations with technical people, I call myself a =
hacker. But
>> when I'm talking to journalists I just say "programmer" or something =
like that.
>>                                -- Linus Torvalds
>>=20
>=20
>=20
> --=20
> Ralf Ramsauer
> GPG: 0x8F10049B

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
