From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: Add addr_width field to struct spi_message
Date: Tue, 12 May 2015 10:57:03 +0200
Message-ID: <CAMuHMdXFY_W6Rd37rNeNUnztZ=8xUcZBS3=eLQwK52N6byGgBg@mail.gmail.com>
References: <1431269253-22890-1-git-send-email-B48286@freescale.com>
	<CAMuHMdUakeDgLZ4hXe0DBu97Xx4eiC9K_Qfc-imkDBrDBXNs6A@mail.gmail.com>
	<CY1PR0301MB0780A4057DBB4DEBC45A631F8BDA0@CY1PR0301MB0780.namprd03.prod.outlook.com>
	<CAMuHMdUzkr6_evPD5y-gaH=rtEgyZ+bHAddD+UmpTssQXZry1g@mail.gmail.com>
	<CY1PR0301MB078056CF0855A97334FD96458BDA0@CY1PR0301MB0780.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Hu Vincent <Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CY1PR0301MB078056CF0855A97334FD96458BDA0-YrwGdl+PljnwWZenWrSUgZwN6zqB+hSMnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Zhiqiang,

On Tue, May 12, 2015 at 10:27 AM, Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org> w=
rote:
>> -----Original Message-----
>> From: geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org [mailto:geert.uytterhoeven@gmail.=
com]
>> On Behalf Of Geert Uytterhoeven
>> Sent: 2015=E5=B9=B45=E6=9C=8812=E6=97=A5 16:12
>> To: Hou Zhiqiang-B48286
>> Cc: linux-spi; Mark Brown; Hu Mingkai-B21284
>> Subject: Re: [PATCH 1/3] spi: Add addr_width field to struct spi_mes=
sage
>>
>> On Tue, May 12, 2015 at 10:06 AM, Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org=
>
>> wrote:
>> >> From: geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>> >> [mailto:geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
>> >> On Behalf Of Geert Uytterhoeven
>> >> Sent: 2015=E5=B9=B45=E6=9C=8811=E6=97=A5 15:43
>> >> To: Hou Zhiqiang-B48286
>> >> Cc: linux-spi; Mark Brown; Hu Mingkai-B21284
>> >> Subject: Re: [PATCH 1/3] spi: Add addr_width field to struct
>> >> spi_message
>> >>
>> >> On Sun, May 10, 2015 at 4:47 PM, Zhiqiang Hou <B48286@freescale.c=
om>
>> >> wrote:
>> >> > From: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>> >> >
>> >> > Make SPI controller can get address width of the SPI device.
>> >>
>> >> What does "address wdith" mean? From your other patches, I infer =
it's
>> >> either
>> >> 24 or 32 bit addressing as used by nor-jedec ("m25p80").
>> >> Why does the generic spi_message needs to have nor-jedec-specific
>> fields?
>> >
>> > Yes, the address width is the address width of spi flash.
>> > The reason to add this nor-jedec-specific field to spi_message is =
the
>> > eSPI controller of Freescale limits the MAX transaction
>> > length(TRANLEN) to 0x10000 each transaction, so if the data size
>> > transferred exceed the TRANLEN, the eSPI controller can only trans=
fer
>> data for the first TRANLEN, and need to issue new write/read command=
s to
>> complete the remainders.
>> > So, eSPI controller need getting the address width of spi flash, a=
nd
>> > then calculate the new address to initialize the new write/read
>> commands.
>>
>> Shouldn't this be handled by the m25p80 driver instead?
>>
>> I see spi_master has a max_dma_len field.
>
> No, only the eSPI controller need to do this, it caused by the eSPI c=
ontroller's
> feature and other SPI controller have not this TRANLEN limit.
> And it has no relation with DMA.

IC.

Still, your doing m25p80-specific handling in your spi master driver.
Worse, you cannot connect any other type of spi device to your spi cont=
roller,
right?

So it looks like we need something like i2c_adapter_quirks, where spi m=
asters
can advertise their limitations?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
