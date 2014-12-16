From: Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
Subject: right bit shift error in ad7314.c ?
Date: Tue, 16 Dec 2014 15:21:05 +0100 (CET)
Message-ID: <1214473234.24918772.1418739665627.JavaMail.root@telenet.be>
References: <1193269024.16018525.1418311626515.JavaMail.root@telenet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: thomas de schampheleire <thomas.de.schampheleire-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1193269024.16018525.1418311626515.JavaMail.root-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

We've run into some trouble while using the ad7314 driver on an ARM-based
board (big endian).

That driver reads a status from the SPI bus that contains the temperature
read by the sensor. There's some other information in that status too, so
some bit manipulation is done to get the temperature data:

s16 data;
int ret;
...
data = (ret & AD7314_TEMP_MASK) >> AD7314_TEMP_SHIFT;
data = (data << 6) >> 6;

Before that last line is executed, the temperature data is in the lowest
10 bits of the data variable. To be able to handle negative temperatures,
those 10 bits get shifted to the left (discarding higher bits) and then
shifted back to the right, with what is assumed to be an Arithmetic Shift
Right, which takes into account the 2's complement content of the lowest
10 bits.

However, the implementation of right shift on a signed integer is not
defined in the C standard and is implementation-dependent [1].

If I compile the driver from the latest stable kernel (3.17.4) with
gcc 4.8.3, the resulting code does not take the 2's complement content of
the lowest 10 bits into account and uses an *unsigned* bit field extract
instruction:

case ad7314:
        data = (ret & AD7314_TEMP_MASK) >> AD7314_TEMP_SHIFT;
        data = (data << 6) >> 6;
138:   e7e952d5        ubfx    r5, r5, #5, #10

I've tested this with 2 versions of gcc (4.8.3 because it's a recent one,
and 4.4.3 because that's the one we normally use) and they both have this
issue, although 4.4.3 doesn't use the ubfx instruction and does a separate
logical shift left and a *logical* shift right (which also disregards the
2's complement content).

As the standard doesn't specify how to handle a right shift on a signed
integer, the code shouldn't rely on it being an arithmetic shift right.
We've replaced the line

data = (data << 6) >> 6;

with

if (data & 0x0200)
{
        data |= 0xfc00;
}

to avoid the issue. I know this may result in slower code (there's a
branch in there now), but I haven't (yet) figured out a reliable way of
doing this with shift operations only.

I don't know if there's a generic way of performing a right shift that
is guaranteed to be arithmetic?

I can submit a patch if it's considered helpful? There is another spot
in the same driver where a similar operation is performed, I'd fix that
too.

"fun" fact: if I compile the driver without optimization, I get:

case ad7314:
        data = (ret & AD7314_TEMP_MASK) >> AD7314_TEMP_SHIFT;
1fc:   e51b2014        ldr     r2, [fp, #-20]
200:   e3073fe0        movw    r3, #32736      ; 0x7fe0
204:   e0023003        and     r3, r2, r3
208:   e1a032c3        asr     r3, r3, #5
20c:   e14b31b6        strh    r3, [fp, #-22]  ; 0xffffffea
        data = (data << 6) >> 6;
210:   e15b31f6        ldrsh   r3, [fp, #-22]  ; 0xffffffea
214:   e1a03303        lsl     r3, r3, #6
218:   e1a03343        asr     r3, r3, #6
21c:   e14b31b6        strh    r3, [fp, #-22]  ; 0xffffffea

So now it *is* using an Arithmetic Shift Right! This looks like a compiler
bug. The fact that optimized and non-optimized code produce functionally
different results is troublesome. I'll try to send something to the gcc
people soon.

Regards,
Jeroen

[1] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1570.pdf section 6.5.7
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
