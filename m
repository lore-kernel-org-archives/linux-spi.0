From: Andrey Smirnov <andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC, PATCH, RESEND] spi, spidev: Add support for long SPI transfers
Date: Tue, 25 Nov 2014 05:30:04 -0800
Message-ID: <CAHQ1cqGvDft1t5MkaqT-xsfBygdghA3mK_a7x+Z3L6HtvqrwhA@mail.gmail.com>
References: <1416853893-1993-1-git-send-email-andrew.smirnov@gmail.com>
	<20141125124229.GY7712@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrey Yurovsky <yurovsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141125124229.GY7712-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

>> As things are right now both SPI subsystem and SPIDEV driver are
>> limited by their APIs to SPI transactions that are no longer than 255
>> bits and that problem is exacerbated by the fact that transction
>> length validity verification code does not have provisions for
>> anything bigger than 32 bits.
>
> No, that's not the case at all.  A spi_transfer can have a length that's
> an unsigned integer number of bytes which is much larger than 255 bits.
> What is the actual problem you're trying to solve here?  I suspect the
> driver you are using is just badly implemented...

Yes, and you're absolutely right about spi_transfer, however I wasn't
talking about spi_transfer at all. My point was about SPI transaction
which is all the bits shifted out on the bus(and shifted in as well)
during the duration of the CS/SS signal assertion.

>
>> +             if (!u_tmp->bits_per_word && u_tmp->bits_per_burst)
>> +                     k_tmp->bits_per_word = u_tmp->bits_per_burst;
>> +             else
>> +                     k_tmp->bits_per_word = u_tmp->bits_per_word;
>
> This is setting the number of bits per word which is nothing to do with
> FIFOs or the lengths of transfers but instead concerns the formatting of
> data onto the bus.

I don't believe I said that this commit had anything to do with FIFO.
I did acknowledge that fact that modern SoC have large FIFO and this
is relevant because often times the size of that FIFO is what
determines the size of a single SPI transaction. I tried to be careful
in my wording of the summary and not use the word "transfer" anywhere,
but it looks like I slipped twice and that might have contributed to
this confusion. I apologize for this and hope that my comments
clarified my meaning/intent

Andrey
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
