From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: spi-rspi I/O errors
Date: Thu, 09 Jan 2014 19:14:42 +0100
Message-ID: <1787813.oK07lvnr6k@avalon>
References: <alpine.DEB.2.02.1401072116370.27579@ayla.of.borg> <CAMuHMdVzFeymxW2CZUyKgZ-fxsektE1EpLQksfSzoekj2ex53Q@mail.gmail.com> <2820126.AWUstGfrNm@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: linux-spi@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <2820126.AWUstGfrNm@avalon>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Geert,

On Thursday 09 January 2014 19:13:04 Laurent Pinchart wrote:
> On Wednesday 08 January 2014 14:13:27 Geert Uytterhoeven wrote:
> > On Wed, Jan 8, 2014 at 9:41 AM, Laurent Pinchart wrote:
> > > On Wednesday 08 January 2014 09:28:59 Geert Uytterhoeven wrote:
> > >> On Wed, Jan 8, 2014 at 1:27 AM, Laurent Pinchart wrote:
> > >> > On Tuesday 07 January 2014 21:27:18 Geert Uytterhoeven wrote:
> > >> >> I was regularly getting I/O errors when using the Renesas RSPI/QSPI
> > >> >> 
> > >> >> driver on r8a7791:
> > >> >>     m25p80 spi0.0: error -110 reading SR
> > >> >> 
> > >> >> Until I applied the following patch, which re-reads RSPI_SPSR on a
> > >> >> time-out, and continues if the condition has become true:
> > >> >> 
> > >> >> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
> > >> >> index 4b31d89e8568..e63e30c500da 100644
> > >> >> --- a/drivers/spi/spi-rspi.c
> > >> >> +++ b/drivers/spi/spi-rspi.c
> > >> >> @@ -442,8 +442,13 @@ static int rspi_wait_for_interrupt(struct
> > >> >> rspi_data
> > >> >> *rspi, u8 wait_mask, rspi->spsr = rspi_read8(rspi, RSPI_SPSR);
> > >> >> 
> > >> >>       rspi_enable_irq(rspi, enable_bit);
> > >> >>       ret = wait_event_timeout(rspi->wait, rspi->spsr & wait_mask,
> > >> >>       HZ);
> > >> >> 
> > >> >> -     if (ret == 0 && !(rspi->spsr & wait_mask))
> > >> >> -             return -ETIMEDOUT;
> > >> >> +     if (ret == 0 && !(rspi->spsr & wait_mask)) {
> > >> >> +             u8 spsr = rspi_read8(rspi, RSPI_SPSR);
> > >> >> +             printk("*** rspi->spsr = 0x%02x, real spsr = 0x%02x,
> > >> >> wait_mask => 0x%02x ***\n",
> > >> >> +                    rspi->spsr, spsr, wait_mask);
> > >> >> +             if (!(spsr & wait_mask))
> > >> >> +                     return -ETIMEDOUT;
> > >> >> +     }
> > >> >> 
> > >> >>       return 0;
> > >> >>  
> > >> >>  }
> > >> >> 
> > >> >> Now it prints from time to time:
> > >> >>     *** rspi->spsr = 0x20, real spsr = 0xa0, wait_mask = 0x80 ***
> > >> >> 
> > >> >> which shows that rspi->spsr (as set from the interrupt handler)
> > >> >> didn't
> > >> >> have bit 7 set, while RSPI_SPSR does have bit 7 set.
> > >> >> 
> > >> >> So this looks like a race condition in the interrupt handling.
> > >> > 
> > >> > What happens if you print rspi->spsr in the interrupt handler ? Does
> > >> > it
> > >> > have bit 7 set ?
> > >> 
> > >> I haven't tried that yet. The driver is extremely interrupt-heavy
> > >> (O(n),
> > >> with n the number of bytes transfered), so adding a printk() as-is
> > >> won't
> > >> be a good idea.
> > >> 
> > >> Will think a bit more about a better approach...
> > > 
> > > Just limit it to the first 10 interrupts then :-)
> > 
> > That assumes the issue happens during the first 10 interrupts, which is
> > usually not the case ;-)
> > 
> > > What I'd like to know is whether the interrupt is trigerred before bit 7
> > > gets set by the hardware, or if the rspi_wait_for_interrupt() function
> > > gets a stale value of rspi->spsr.
> > 
> > It seems to get a stale value. I ended up doing the printk() anyway, and
> > when reading using small buffer sizes, the issues is more likely to
> > happen.
> > 
> > If I add a second copy of rspi->spsr, and make that copy volatile OR add
> > a few calls to smp_mb() around the places where it's written and read,
> > the copy has the right value inside rspi_wait_for_interrupt(), BUT only if
> > I also print the spsr value inside rspi_irq(). Note that the original
> > rspi->spsr still has the stale value.
> 
> Do I understand it correctly that the SPSR value read from the register in
> rspi_irq() is always correct on the first read, and that only the rspi->spsr
> value stored in memory and read in rspi_wait_for_interrupt() is wrong ?
> > I'd expect wake_up() and wait_event_timeout() to have the right memory
> > barriers (cfr. Documentation/memory-barriers.txt), so I don't have to add
> > my own. And why does it need the extra printk()? What extra
> > synchronization
> > does that give?
> 
> Have you tried adding explicit memory barriers without any extra printk ?
> 
> > Note that the interrupt handler always runs on CPU core 0, while
> > rspi_wait_for_interrupt() can run on core 0 or 1. Is there a
> > cache-coherency issue between the two CPU cores?
> 
> I'd be very surprised if that was the case, as there should be lots of other
> breakages, but let's not rule that out too fast. Magnus should be able to
> help you more than I can regarding that.

Could you verify that the SMP bit is set in ACTLR 
(http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0388e/CIHHDDHJ.html) 
?

> > Am I missing something?

-- 
Regards,

Laurent Pinchart

