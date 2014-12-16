From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: right bit shift error in ad7314.c ?
Date: Tue, 16 Dec 2014 15:53:14 +0100
Message-ID: <CAMuHMdW2fxx7EvY2dn4ouacNwNGVZfTudsxEf9HYPQN3Wdxhwg@mail.gmail.com>
References: <1193269024.16018525.1418311626515.JavaMail.root@telenet.be>
	<1214473234.24918772.1418739665627.JavaMail.root@telenet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	thomas de schampheleire <thomas.de.schampheleire-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1214473234.24918772.1418739665627.JavaMail.root-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Jeroen,

On Tue, Dec 16, 2014 at 3:21 PM, Jeroen De Wachter
<jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org> wrote:
> That driver reads a status from the SPI bus that contains the temperature
> read by the sensor. There's some other information in that status too, so
> some bit manipulation is done to get the temperature data:
>
> s16 data;
> int ret;
> ...
> data = (ret & AD7314_TEMP_MASK) >> AD7314_TEMP_SHIFT;
> data = (data << 6) >> 6;
>
> Before that last line is executed, the temperature data is in the lowest
> 10 bits of the data variable. To be able to handle negative temperatures,
> those 10 bits get shifted to the left (discarding higher bits) and then
> shifted back to the right, with what is assumed to be an Arithmetic Shift
> Right, which takes into account the 2's complement content of the lowest
> 10 bits.
>
> However, the implementation of right shift on a signed integer is not
> defined in the C standard and is implementation-dependent [1].

Have you tried using a signed division instead?

The following seems to work for me:

        data = (s16)(data << 6) / 64;

Without the cast, "data << 6" seems to be promoted to an unsigned type.

Alternatively, you can split it in two parts, to force a signed intermediate
result:

        data <<= 6;
        data /= 64;

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
