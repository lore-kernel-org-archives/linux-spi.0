From: sourav <sourav.poddar@ti.com>
Subject: Re: m25p80 quad support questions
Date: Fri, 10 Jan 2014 00:34:21 +0530
Message-ID: <52CEF2B5.3080503@ti.com>
References: <CAMuHMdXWZU=i9hY_p-oAVHhBskgcbZazLKi8QMLQ+p+t9opyMg@mail.gmail.com>
 <CAMuHMdU7Mj4uqZkYYRsLXqZP0w6cv+y1L4XZJ9j5c8722H6JnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: Brian Norris <computersforpeace@gmail.com>,
 MTD Maling List <linux-mtd@lists.infradead.org>, linux-spi@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <CAMuHMdU7Mj4uqZkYYRsLXqZP0w6cv+y1L4XZJ9j5c8722H6JnQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Thursday 09 January 2014 08:14 PM, Geert Uytterhoeven wrote:
> CC linux-spi, and more information below.
>
> On Thu, Jan 9, 2014 at 10:12 AM, Geert Uytterhoeven
> <geert@linux-m68k.org>  wrote:
>> Hi Sourav, Brian,
>>
>> I'm working on adding QSPI support to a SPI master driver, so I'm very
>> interested in your work to add quad read support to m25p80.
>> Thanks for that!
>>
>> However, I have a few questions/comments:
>>
>> 1. Up to version 2 of "drivers: mtd: m25p80: Add quad read support",
>> the driver set rx_nbits to indicate it wants to use Quad SPI transfers:
>>
>> + t[1].rx_nbits = flash->quad_read ? SPI_NBITS_QUAD : 1;
>>
>> (http://patchwork.ozlabs.org/patch/286109/).
>>
>> However, this is not present in later versions, nor in the current version
>> in -next.

May be, but I suppose all the quad related patches are pushed to l2-mtd. 
You can
check it in that  branch.
>>
>> It's my understanding the default (single transfer mode) will be used if
>> rx_nbits is zero, cfr. drivers/spi/spi.c:__spi_async():
>>
>>                  if (xfer->tx_buf&&  !xfer->tx_nbits)
>>                          xfer->tx_nbits = SPI_NBITS_SINGLE;
>>                  if (xfer->rx_buf&&  !xfer->rx_nbits)
>>                          xfer->rx_nbits = SPI_NBITS_SINGLE;
>>
>> Does it really use quad transfers without setting rx_nbits to SPI_NBITS_QUAD?
> I can confirm that the SPI master driver is called with rx_nbits == 1, while
> using the 0x6b QOR command.
>
>> 2. IMHO checking for Quad support in the SPI master (master->mode_bits)
>> and in the SPI FLASH chip is not sufficient. A quad-capable SPI FLASH
>> may be wired to a quad-capable SPI master using 4-wire mode, either
>> physically or through pin control.
>> So I think we need a m25p,quad-read property in DT.
We need the following to support quad,
1. controller side support -- > spi->mode should be set
2. flash support ---> provided as a flag.
3. Individuall transfer set --> done by t. rx/tx_nbits.
> Sorry, this issue is moot. I missed that spi_device.mode (as set from DT
> spi-rx-bus-width and spi-tx-bus-width) is also taken into account.
>
> Thanks again!
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
