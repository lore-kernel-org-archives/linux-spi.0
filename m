From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: spi: tests driver to test basic alignment/length issues via
 loopback
Date: Thu, 26 Nov 2015 11:02:17 +0100
Message-ID: <5656D8A9.20102@martin.sperl.org>
References: <753FCC7B-67D9-495B-A6C1-D49793502C90@martin.sperl.org>
 <CAMuHMdX6AVqhDUyvxgPGOdVYi4LPAm7CCGD-M7sUQCbXZJ+49w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdX6AVqhDUyvxgPGOdVYi4LPAm7CCGD-M7sUQCbXZJ+49w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 26.11.2015 10:54, Geert Uytterhoeven wrote:
> Hi Martin,
>
> On Wed, Nov 25, 2015 at 7:56 PM, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org> wrote:
>> For complete testing the only thing it requires is  MOSI connected to MISO.
>> and then it can detect lots of situations:
>
> BTW, with several SPI drivers, you can set SPI_LOOP instead.
> This can be useful on boards where the SPI pins are not available on
> expansion headers, or where the pins are used for other functions.
I thought of adding spi_msg to the spi_test structure as well,
but as spi_message_init clears all the data in spi_message,
I did not want to take that step...

Also I fear that with SPI_LOOP some drivers may take some short-cuts
copying the data directly without going via the HW, which would result
in testing a different code-path than in reality and thus resulting
in bogus positive results.

Anyway: we can always extend it to include these kinds of things later.
(maybe even add auto-detection if there is a flag for it...)

Martin






--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
