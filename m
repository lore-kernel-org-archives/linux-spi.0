From: Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
Subject: Re: right bit shift error in ad7314.c ?
Date: Thu, 18 Dec 2014 15:01:05 +0100 (CET)
Message-ID: <587522043.29349555.1418911265245.JavaMail.root@telenet.be>
References: <1193269024.16018525.1418311626515.JavaMail.root@telenet.be> <1214473234.24918772.1418739665627.JavaMail.root@telenet.be> <CAMuHMdW2fxx7EvY2dn4ouacNwNGVZfTudsxEf9HYPQN3Wdxhwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	thomas de schampheleire <thomas.de.schampheleire-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdW2fxx7EvY2dn4ouacNwNGVZfTudsxEf9HYPQN3Wdxhwg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Geert,

----- Original Message -----
> From: "Geert Uytterhoeven" <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
> To: "Jeroen De Wachter" <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
> Cc: "linux-spi" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "thomas de schampheleire" <thomas.de.schampheleire-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Sent: Tuesday, December 16, 2014 3:53:14 PM
> Subject: Re: right bit shift error in ad7314.c ?
> 
> Hi Jeroen,
> 
> On Tue, Dec 16, 2014 at 3:21 PM, Jeroen De Wachter
> <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org> wrote:
> > That driver reads a status from the SPI bus that contains the temperature
> > read by the sensor. There's some other information in that status too, so
> > some bit manipulation is done to get the temperature data:
> >
> > s16 data;
> > int ret;
> > ...
> > data = (ret & AD7314_TEMP_MASK) >> AD7314_TEMP_SHIFT;
> > data = (data << 6) >> 6;
> >
> > Before that last line is executed, the temperature data is in the lowest
> > 10 bits of the data variable. To be able to handle negative temperatures,
> > those 10 bits get shifted to the left (discarding higher bits) and then
> > shifted back to the right, with what is assumed to be an Arithmetic Shift
> > Right, which takes into account the 2's complement content of the lowest
> > 10 bits.
> >
> > However, the implementation of right shift on a signed integer is not
> > defined in the C standard and is implementation-dependent [1].
> 
> Have you tried using a signed division instead?
> 
> The following seems to work for me:
> 
>         data = (s16)(data << 6) / 64;
> 
> Without the cast, "data << 6" seems to be promoted to an unsigned type.
> 
> Alternatively, you can split it in two parts, to force a signed intermediate
> result:
> 
>         data <<= 6;
>         data /= 64;
> 

Your code should have the same outcome as mine. I had a look at the generated
assembly though and it looks a lot more complicated:

                data = (ret & AD7314_TEMP_MASK) >> AD7314_TEMP_OFFSET;
                data = (s16)(data << 6) / 64;
 154:   e1a03083        lsl     r3, r3, #1

                return sprintf(buf, "%d\n", 250 * data);
 158:   e6bf3073        sxth    r3, r3
 15c:   e283203f        add     r2, r3, #63     ; 0x3f
 160:   e3530000        cmp     r3, #0
 164:   b1a03002        movlt   r3, r2
 168:   e1a02343        asr     r2, r3, #6

vs mine:

                data = (ret & AD7314_TEMP_MASK) >> AD7314_TEMP_OFFSET;
 148:   e1a032a3        lsr     r3, r3, #5
                if (data & 0x0200) {
 14c:   e3130c02        tst     r3, #512        ; 0x200
                  data |= 0xfc00;
 150:   13833b3f        orrne   r3, r3, #64512  ; 0xfc00

I only looked at this on my ARM target (with gcc 4.4.3 and gcc 4.8.3 generating
pretty much the same assembly in both cases), so I don't know what the binary
would look like on other architectures...

There's a conditional instruction there in both solutions (orrne vs. movlt), so
that's not a reason to prefer one over the other.

I do think your version is slightly more readable, although both solutions could
do with a clarifying comment.

So: what do we go for? performance or readability? I don't have a strong
preference, but if I *have* to choose, I'd go with the bitwise manipulation...

Regards,
Jeroen
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
