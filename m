From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] Fix long standing chip select issue for non-default CS-polarity setups
Date: Mon, 25 Nov 2013 20:13:57 +0100
Message-ID: <EE805C3B-7650-45CF-ACA7-5A83758B7F77@martin.sperl.org>
References: <A4EEA261-22E6-41A7-82C4-68E8606E0863@martin.sperl.org> <20131125111603.GC14725@sirena.org.uk> <52934420.1040603@martin.sperl.org> <20131125163840.GG14725@sirena.org.uk>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org, swarren-3lzwWm7+WeqjrCrn2yxA+g@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131125163840.GG14725-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark!

> It doesn't look like that, it looks like the update first resets things
> to a default and then writes in the new value.  It also appears to
> affect the entire array rather than just one value.

The problem is that there is only _ONE_ register in the SOC that affects
all Polarity flags.
#define BCM2835_SPI_CS_CSPOL2           0x00800000
#define BCM2835_SPI_CS_CSPOL1           0x00400000
#define BCM2835_SPI_CS_CSPOL0           0x00200000

and unfortunately this is the _same_ register that we use to start/stop/...
the SPI component and set up other things.

So the current code in bcm2835_spi_start_transfer runs this:
u32 cs = BCM2835_SPI_CS_INTR | BCM2835_SPI_CS_INTD | BCM2835_SPI_CS_TA;
...
if (spi->mode & SPI_CPOL)
	cs |= BCM2835_SPI_CS_CPOL;
if (spi->mode & SPI_CPHA)
 	cs |= BCM2835_SPI_CS_CPHA;
if (spi->mode & SPI_CS_HIGH) {
	cs |= BCM2835_SPI_CS_CSPOL;
	cs |= BCM2835_SPI_CS_CSPOL0 << spi->chip_select;
	cs |= spi->chip_select
}
...
bcm2835_wr(bs, BCM2835_SPI_CS, cs);

So this only EVER sets a single one of the following bits
#define BCM2835_SPI_CS_CSPOL2           0x00800000
#define BCM2835_SPI_CS_CSPOL1           0x00400000
#define BCM2835_SPI_CS_CSPOL0           0x00200000
(and only if the current device i running with inverse polarity)

Say this runs for CS=0 and it has CS_HIGH set with mode,
then the SPI Control register is set to BCM2835_SPI_CS_CSPOL0 afterwards.

Now take a transfer for CS=1 with normal polarity,
then the BCM2835_SPI_CS_CSPOL0 will no longer be set as soon as this 
transfer configures the SPI control register.

And that is why we need to make the Polarity change become effective
immediately or it is sufficient to do it the next time that the SPI
register is modified by any transfer

> The other thing is that as with all your other code this is full of
> coding style issues, these will need to be fixed.  Please, as previously
> requested, read and follow CodingStyle.
I had been reading the coding styles document and tried to implement
everything recommended there in the patch.

> 
> Yes, this is the point - the two aren't protected against each other,
> setup() is supposed to only take effect on the next transfer.
> 

The master->setup call in spi_setup requires that the settings take "action"
immediately - or at least when the NEXT spi message gets transmitted.
(not necessarily the next transfer to the specific device)

And that is what the code does: it prepares the flags when calling
the setup function. The computed values are only taken active the next
time the SPI Control registers are set, which happens only in 
bcm2835_spi_start_transfer and bcm2835_spi_transfer_one.

> This doesn't require a bus lock, it only affects the individual device.


It would require a bus_lock for ANY change to SPI_CS_HIGH.

Otherwise there _is_ a window of opportunity for a spi_message by a different
device-driver to get scheduled between the spi_async configuring the SPI 
device on the bus itself for a change in polarity and the spi_setup call,
which possibly happens in the complete callback or even more delayed in a 
totally separate kernel-thread if the sync interfaces is used.

Martin


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
