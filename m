From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: bcm53xx: driver for SPI controller on Broadcom bcma SoC
Date: Sun, 17 Aug 2014 17:28:13 +0200
Message-ID: <CACna6ryqmkYhDFHHiLdE3b9TpypJAko=Z2xRsXCiMu2iQyvFDA@mail.gmail.com>
References: <1407933212-20530-1-git-send-email-zajec5@gmail.com>
	<1408228864-20313-1-git-send-email-zajec5@gmail.com>
	<20140817142117.GI14537@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140817142117.GI14537-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 17 August 2014 16:21, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Sun, Aug 17, 2014 at 12:41:04AM +0200, Rafa=C5=82 Mi=C5=82ecki wro=
te:
>
>> +static inline unsigned int bcm53xxspi_calc_timeout(size_t len)
>> +{
>> +     return (len * 9000 / 13500000 * 110 / 100) + 1;
>> +}
>
> Magic numbersr!

You just hit the reality of Broadcom world :( I'll try to improve it
at least a bit.

>> +static int bcm53xxspi_wait(struct bcm53xxspi *b53spi, unsigned int =
timeout_ms)
>> +{
>> +     unsigned long deadline;
>> +     u32 tmp;
>> +
>> +     /* SPE bit has to be 0 before we read MSPI STATUS */
>> +     while (1) {
>> +             tmp =3D bcm53xxspi_read(b53spi, B53SPI_MSPI_SPCR2);
>> +             if (!(tmp & B53SPI_MSPI_SPCR2_SPE))
>> +                     break;
>> +     }
>
> This could block for ever, there should be a timeout of some kind.  I=
'd
> also include a cpu_relax() in here since it's a busy wait.

Right, will fix that.

>> +static void bcm53xxspi_buf_write(struct bcm53xxspi *b53spi, u8 *w_b=
uf,
>> +                              size_t len, bool cont)
>> +{
>> +     u32 tmp;
>> +     int i;
>> +
>> +     for (i =3D 0; i < len; i++) {
>> +             /* Transmit Register File MSB */
>> +             bcm53xxspi_write(b53spi, B53SPI_MSPI_TXRAM + 4 * (i * =
2),
>> +                              (unsigned int)w_buf[i]);
>> +     }
>> +
>> +     for (i =3D 0; i < len; i++) {
>> +             tmp =3D B53SPI_CDRAM_CONT | B53SPI_CDRAM_PCS_DISABLE_A=
LL |
>> +                   B53SPI_CDRAM_PCS_DSCK;
>> +             if (!cont && i =3D=3D len - 1)
>> +                     tmp &=3D ~B53SPI_CDRAM_CONT;
>> +             tmp &=3D ~0x1;
>> +             /* Command Register File */
>> +             bcm53xxspi_write(b53spi, B53SPI_MSPI_CDRAM + 4 * i, tm=
p);
>> +     }
>> +
>> +     /* Set queue pointers */
>> +     bcm53xxspi_write(b53spi, B53SPI_MSPI_NEWQP, 0);
>> +     bcm53xxspi_write(b53spi, B53SPI_MSPI_ENDQP, len - 1);
>> +
>> +     if (cont)
>> +             bcm53xxspi_write(b53spi, B53SPI_MSPI_WRITE_LOCK, 1);
>> +
>> +     /* Start SPI transfer */
>> +     tmp =3D bcm53xxspi_read(b53spi, B53SPI_MSPI_SPCR2);
>> +     tmp |=3D B53SPI_MSPI_SPCR2_SPE;
>> +     if (cont)
>> +             tmp |=3D B53SPI_MSPI_SPCR2_CONT_AFTER_CMD;
>> +     bcm53xxspi_write(b53spi, B53SPI_MSPI_SPCR2, tmp);
>> +
>> +     /* Wait for SPI to finish */
>> +     bcm53xxspi_wait(b53spi, bcm53xxspi_calc_timeout(len));
>
> This means we can only do unidirectonal transfers from the look of it=
 -
> is that a limitation of the hardware (from a quick read it seems like=
 it
> might be)?

Yeah, these transfers are really tricky. It took me a while to figure
out how to correctly read and write data. I spent hours writing some
opcodes, reading data and comparing it with what I expected to be on
the flash. Finally I did all this magic with "read_offset" and managed
to read/write data in a stable way.
OFC I don't have access to any Broadcom SPI controller specification,
it's not the way you can work with Broadcom hardware. If this hw can
handle transfers in some sane way (bidirectionally) I can't implement
it right now :(

>> +     /* Wait for SPI to finish */
>> +     bcm53xxspi_wait(b53spi, bcm53xxspi_calc_timeout(len));
>
> No interrupts?  This will busy wait for the entire transfer which see=
ms
> a bit much.

I'm afraid so. I found no reference to SPI interrupts.
Hauke: do you have any info about that?

> I'm also not seeing a set_cs() operation here.

I found no info about that, none of the registers seem to be
responsible for that. Is that OK for the driver to work without set_cs
handler/callback?

>> +     err =3D spi_register_master(master);
>> +     if (err) {
>
> devm_spi_register_master().

Will change that.

--=20
Rafa=C5=82
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
