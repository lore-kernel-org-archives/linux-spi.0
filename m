From: Brian Niebuhr <BNiebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Subject: RE: [PATCH 0/3] davinci: spi: replace existing SPI driver
Date: Mon, 14 Jun 2010 14:15:00 -0500
Message-ID: <BA34378D1528D04CB3C865B8BAB2472B024CCA@transmx01.transcrypt.local>
References: <1275923348-8533-1-git-send-email-bniebuhr@efjohnson.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E744A8C4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "Brian Niebuhr" <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Content-Class: urn:content-classes:message
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

> Can you please post this series to SPI development list
> (spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org) CCing the maintainers
> David Brownell and Grant Likely?

Done
 
> > INTRODUCTION
> >
> > I have been working on a custom OMAP-L138 board that has 
> multiple spi
> > devices (seven) on one controller.  These devices have a 
> wide range of
> > transfer parameters (speed, phase, polarity, internal and gpio chip
> > selects).  During my testing I found multiple errors in the 
> davinci spi
> > driver as a result of this complex setup.  The primary issues were:
> >
> > 1. There is a race condition due to the SPIBUF read 
> busy-waits for slow
> >         devices
> > 2. I found some DMA transfer length errors under some conditions
> > 3. The chip select code caused extra byte transfers (with no chip
> >         select active) due to writes to SPIDAT1
> > 4. Several issues prevented using multiple SPI devices, especially
> >         the DMA code, as disucussed previously on the davinci list.
> 
> This should be replicated in patch description for patch 1/3 
> as a record
> of why the original driver was removed.

Will do.
 
> > The fixes to these problems were not simple.  I ended up 
> making fairly
> > large changes to the driver, and those changes are 
> contained in these
> > patches.  The full list of changes follows.
> >
> > CHANGE LIST
> >
> > 1. davinci_spi_chipelect() now performs both activation and 
> deactivation
> >         of chip selects.  This lets spi_bitbang fully control chip
> >         select activation, as intended by the SPI API.
> > 2. Chip select activation does not cause extra writes to the SPI bus
> > 3. Chip select activation does not use SPIDEF for control.  
> This change
> >         will also allow for implementation of inverted (active high)
> >         chip selects in the future.
> > 4. Added back gpio chip select capability from the old driver
> > 5. Fixed prescale calculation for non-integer fractions of spi clock
> > 6. Allow specification of SPI transfer parameters on a per-device
> >         (instead of per-controller) basis
> > 7. Allow specification of polled, interrupt-based, or DMA 
> operation on
> >         a per-device basis
> > 8. Allow DMA with when more than one device is connected
> > 9. Combined pio and dma txrx_bufs functions into one since 
> they share
> >         large parts of their functionality, and to simplify 
> item (8).
> > 10. Use only SPIFMT0 to allow more than 4 devices
> >
> > TESTING
> >
> > I have tested the driver using a custom SPI stress test on my
> > OMAP-L138-based board with three devices connected.  I have tested
> > configurations with all three devices polled, all three 
> interrupt-based,
> > all three DMA, and a mixture.
> 
> This should be replicated in patch description for patch 2/3 
> as a record
> of what the new driver provides.

Will do.

> > I have compiled with the davinci_all_defconfig, but I don't 
> have EVMs
> > for the other davinci platforms to test with.
> 
> DM6467, DM365 and OMAP-L137 EVMs have SPI devices as well. We can help
> test on at least some of those. No need to wait for test 
> results before
> posting to SPI list though, it can happen in parallel to the review.

Ok, thanks.

> > SUMMARY
> >
> > This patch solves a lot of issues that should save a lot of 
> people time
> > down the road.  Since I posted the original patch I have 
> had at least 5
> > people contact me personally to get help applying the patch 
> because SPI
> > was broken on their boards.  I have heard back from at 
> least 2 that the
> > original patch worked for them.
> 
> You can include an Acked-by: from those developers. This will 
> help build
> the case for the new driver.

I'll see if I still have the emails.
