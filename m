From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: spi-rspi I/O errors
Date: Thu, 9 Jan 2014 12:26:18 +0900
Message-ID: <CANqRtoRj_CybzDY3h1Caz=G=R7R-GVBxJ86xr5isWnWn1mDb2A@mail.gmail.com>
References: <alpine.DEB.2.02.1401072116370.27579@ayla.of.borg>
	<6231184.EMt0gDqh7K@avalon>
	<CAMuHMdWDwF+KcNPrKgjvH6w7Uxn-iON+nQz_+Z_RTU_yV7SVog@mail.gmail.com>
	<30872348.jm2GxWdDk6@avalon>
	<CAMuHMdVzFeymxW2CZUyKgZ-fxsektE1EpLQksfSzoekj2ex53Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdVzFeymxW2CZUyKgZ-fxsektE1EpLQksfSzoekj2ex53Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Jan 8, 2014 at 10:13 PM, Geert Uytterhoeven
<geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> On Wed, Jan 8, 2014 at 9:41 AM, Laurent Pinchart
> <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:
>> On Wednesday 08 January 2014 09:28:59 Geert Uytterhoeven wrote:
>>> On Wed, Jan 8, 2014 at 1:27 AM, Laurent Pinchart wrote:
>>> > On Tuesday 07 January 2014 21:27:18 Geert Uytterhoeven wrote:
>>> >> I was regularly getting I/O errors when using the Renesas RSPI/QSPI
>>> >>
>>> >> driver on r8a7791:
>>> >>     m25p80 spi0.0: error -110 reading SR
>>> >>
>>> >> Until I applied the following patch, which re-reads RSPI_SPSR on a
>>> >> time-out, and continues if the condition has become true:
>>> >>
>>> >> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
>>> >> index 4b31d89e8568..e63e30c500da 100644
>>> >> --- a/drivers/spi/spi-rspi.c
>>> >> +++ b/drivers/spi/spi-rspi.c
>>> >> @@ -442,8 +442,13 @@ static int rspi_wait_for_interrupt(struct rspi_data
>>> >> *rspi, u8 wait_mask, rspi->spsr = rspi_read8(rspi, RSPI_SPSR);
>>> >>
>>> >>       rspi_enable_irq(rspi, enable_bit);
>>> >>       ret = wait_event_timeout(rspi->wait, rspi->spsr & wait_mask, HZ);
>>> >>
>>> >> -     if (ret == 0 && !(rspi->spsr & wait_mask))
>>> >> -             return -ETIMEDOUT;
>>> >> +     if (ret == 0 && !(rspi->spsr & wait_mask)) {
>>> >> +             u8 spsr = rspi_read8(rspi, RSPI_SPSR);
>>> >> +             printk("*** rspi->spsr = 0x%02x, real spsr = 0x%02x,
>>> >> wait_mask =>
>>> > 0x%02x
>>> >
>>> >> ***\n",
>>> >> +                    rspi->spsr, spsr, wait_mask);
>>> >> +             if (!(spsr & wait_mask))
>>> >> +                     return -ETIMEDOUT;
>>> >> +     }
>>> >>
>>> >>       return 0;
>>> >>
>>> >>  }
>>> >>
>>> >> Now it prints from time to time:
>>> >>     *** rspi->spsr = 0x20, real spsr = 0xa0, wait_mask = 0x80 ***
>>> >>
>>> >> which shows that rspi->spsr (as set from the interrupt handler) didn't
>>> >> have bit 7 set, while RSPI_SPSR does have bit 7 set.
>>> >>
>>> >> So this looks like a race condition in the interrupt handling.
>>> >
>>> > What happens if you print rspi->spsr in the interrupt handler ? Does it
>>> > have bit 7 set ?
>>>
>>> I haven't tried that yet. The driver is extremely interrupt-heavy (O(n),
>>> with n the number of bytes transfered), so adding a printk() as-is won't be
>>> a good idea.
>>>
>>> Will think a bit more about a better approach...
>>
>> Just limit it to the first 10 interrupts then :-)
>
> That assumes the issue happens during the first 10 interrupts, which is
> usually not the case ;-)
>
>> What I'd like to know is whether the interrupt is trigerred before bit 7 gets
>> set by the hardware, or if the rspi_wait_for_interrupt() function gets a stale
>> value of rspi->spsr.
>
> It seems to get a stale value. I ended up doing the printk() anyway, and
> when reading using small buffer sizes, the issues is more likely to happen.
>
> If I add a second copy of rspi->spsr, and make that copy volatile OR add
> a few calls to smp_mb() around the places where it's written and read,
> the copy has the right value inside rspi_wait_for_interrupt(), BUT only if
> I also print the spsr value inside rspi_irq(). Note that the original rspi->spsr
> still has the stale value.
>
> I'd expect wake_up() and wait_event_timeout() to have the right memory
> barriers (cfr. Documentation/memory-barriers.txt), so I don't have to add
> my own. And why does it need the extra printk()? What extra
> synchronization does that give?
>
> Note that the interrupt handler always runs on CPU core 0,
> while rspi_wait_for_interrupt() can run on core 0 or 1.
> Is there a cache-coherency issue between the two CPU cores?
>
> Am I missing something?

What happens if you run on a uniprocessor system or in case of R-Car
disable SMP and run with a single CPU core?

Cheers,

/ magnus
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
