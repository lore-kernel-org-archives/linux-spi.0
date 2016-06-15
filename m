From: Kamal Dasu <kamal.dasu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [V3, 2/4] spi: bcm-qspi: Add SPI flash and MSPI driver
Date: Wed, 15 Jun 2016 18:56:10 -0400
Message-ID: <CAKekbesG+_9wOuP4HXGKJdK-kmEn443g=vUdyu6Zdn==NO-YHw@mail.gmail.com>
References: <1465589171-25575-1-git-send-email-kdasu.kdev@gmail.com>
 <1465589171-25575-2-git-send-email-kdasu.kdev@gmail.com> <20160613101352.GF2282@sirena.org.uk>
 <CAKekbesr2i3N+yw0VV1aYqJONbBraKTNpibzm7NO_+sBbwENyw@mail.gmail.com> <20160614165816.GT2282@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	Vikram Prakash <vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Andy Fung <andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Yendapally Reddy Dhananjaya Reddy
	<yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160614165816.GT2282-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Mark,

I have  implemented most of your suggestions.  A few of them, actually
just a couple,  I wanted to discuss further. More importantly related
to the spi_flash_read(). Please see my questions inline.

On Tue, Jun 14, 2016 at 12:58 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Jun 14, 2016 at 11:43:56AM -0400, Kamal Dasu wrote:
>> On Mon, Jun 13, 2016 at 6:13 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> > On Fri, Jun 10, 2016 at 04:06:09PM -0400, Kamal Dasu wrote:
>
>> >> +     /* deassert CS on the final byte */
>> >> +     if (fnb & FNB_BREAK_DESELECT) {
>> >> +             mspi_cdram = read_cdram_slot(qspi, slot - 1) &
>> >> +                     ~MSPI_CDRAM_CONT_BIT;
>> >> +             write_cdram_slot(qspi, slot - 1, mspi_cdram);
>> >> +     }
>
>> > Let the core handle asserting and deasserting chip select.
>
>> Its actually a peripheral CS (PCS) bit in the MSPI block. Peripheral
>> chip selects are used to select an external device for serial data
>> transfer. PCS[i] corresponds to pin SS[i].
>
> That doesn't appear to address the issue, what you're describing sounds
> like the normal function of the chip select?

This bit has no effect and  is not connected actually although
software is manipulating it. The real CS is the one we use via the dt
cs_reg. I will fix the comments/code to reflect this accordingly.

>
>> >> +             switch (command) {
>> >> +             case SPINOR_OP_READ4_FAST:
>> >> +                     if (!bcm_qspi_is_4_byte_mode(qspi))
>
>> > No, this is not a good idea. You should not be attempting to parse
>> > the data stream.  If your controller has flash support it should
>> > implement the flash interfaces, otherwise it should just pass the data
>> > streams through.
>
>> This is only for read command we need to setup both tx and rx at the
>> same time for improved performance.
>
> No, to repeat what I said if you want to support accelerated flash reads
> implement the standard accelerated flash read operation we have
> (spi_flash_read()).  This is a fairly common feature and trying to open
> code this in individual drivers would at the very least lead to a lot of
> duplicated code and is the source of most of the problems in the code.

I was looking at spi_flash_read() caled from m25p80_read()  and spi
core implementation. I have a case where when we have very small reads
or  unaligned buffers and addresses passed then I have to fall back to
using standard MSPI reads. How best to handle this ?. One of the
options without having to replicate code  involves a minor change to
m25p80 driver as shown below.
---
diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 9d68544..e98b4fa 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -149,8 +149,11 @@ static int m25p80_read(struct spi_nor *nor,
loff_t from, size_t len,
                msg.data_nbits = m25p80_rx_nbits(nor);

                ret = spi_flash_read(spi, &msg);
-               *retlen = msg.retlen;
-               return ret;
+               /* check we need to fallback to normal spi read */
+               if (ret != -EAGAIN) {
+                       *retlen = msg.retlen;
+                       return ret;
+               }
        }

        spi_message_init(&m);
---

I am open to any other suggestion that I can implement in my driver.
In the previous version of using transfer_one_message() I could
fallback in such cases.

>> >> +     spi_message_init(&m);
>> >> +     m.spi = &spi;
>
>> > I don't know why your driver is creating and trying to do SPI transfers
>> > but that is completely inappropriate for a SPI controller.  Whatever
>> > functionality this is implementing should be in a separate SPI device
>> > driver.
>
>> Currently not used. But I did not see a good way to be able to send
>> commands, like finding the ID, setting 3/4 byte addressing mode , quad
>> mode, on a PM resume(). Are you suggesting I make a driver similar to
>> m25p80  ?.
>
> I am suggesting you implement the standard flash interfaces and as a
> result directly use m25p80.

Are you suggesting to use something like spi_read_then_write() in
cases where I want to set the addressing and single/quad modes ?.

Thanks
Kamal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
