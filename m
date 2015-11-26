From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: spi: tests driver to test basic alignment/length issues via
 loopback
Date: Thu, 26 Nov 2015 10:48:17 +0100
Message-ID: <5656D561.3010007@martin.sperl.org>
References: <753FCC7B-67D9-495B-A6C1-D49793502C90@martin.sperl.org>
 <CAMuHMdVpds0hOD=4uh1ZA+pfk9wHQJiuJodgXJDG0VcmYRXkeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdVpds0hOD=4uh1ZA+pfk9wHQJiuJodgXJDG0VcmYRXkeQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 26.11.2015 10:32, Geert Uytterhoeven wrote:
> On Wed, Nov 25, 2015 at 7:56 PM, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org> wrote:
>> So I had to write a small test driver that allows for generate all sorts
>> of spi_messages with different length, rx/tx_buf alignments and more to
>> get generated - right now it submits something like 360 distinct
>> spi_messages:
>
> Thanks!

So I take that as a yes...

>> * transfers starting on a page with rx and tx_buf set
>>    * length: 1, 16, 32, 64, 128, 256, 1024, 4096, 128k
>
> I think you should add a few lengths that are not powers of two
> (e.g. prime numbers).
it is just requires to assign more values to .iterate_len.
(on top of the default length).

One of the tests looks like this:
         {
                 .description    = "tx/rx-transfer - crossing PAGE_SIZE",
                 .fill_option    = FILL_COUNT_8, /* 8-bit counter */
                 .iterate_len    = {16, 32, 64, 128, 256, 1024,
				   PAGE_SIZE, SPI_TEST_MAX_SIZE, },
                 .iterate_tx_align = sizeof(int),
                 .iterate_rx_align = sizeof(int),
                 .transfers              = {
                         {
                                 .len = 1,
                                 .tx_buf = TX(PAGE_SIZE - 4),
                                 .rx_buf = RX(PAGE_SIZE - 4),
                         },
                 },
         },
and it produces 144 variations in the case of sizeof(int) == 4

Adding additional transfers is as simple as adding more descriptions to
.transfers (which is an array of spi_transfers)...

Adding additional tests is as simple as adding another such structure...

I will add some more features (making alignment and length iterateable
per transfer) and then I will submit it as:
drivers/spi/spi-test.c
If it should be called differently then please tell me.

Ciao,
	Martin

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
