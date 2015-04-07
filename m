From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 3/6] spi: bcm2835: fill FIFO before enabling interrupts to
Date: Tue, 7 Apr 2015 08:25:05 +0200
Message-ID: <B9B4E3CA-D9F2-4A79-BC78-C3BD4B3844F2@martin.sperl.org>
References: <3628E5E2-7EA9-488F-AF5F-A2E43D2D1E3E@martin.sperl.org> <551A1185.6060502@wwwdotorg.org> <20150331052519.GZ2869@sirena.org.uk> <552094B5.3050109@wwwdotorg.org> <20150406172130.GU6023@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150406172130.GU6023-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 06.04.2015, at 19:21, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> Right, and I have to say I do suspect that the underlying thing is that
> the FIFO is underrunning, but as far as the optimization is concerned
> that's a separate thing.  The reason this isn't enabled for native chip
> selects is that it's not working, the reason it's not working is
> something that should indeed probably be investigated.
Actually it happens exactly when setting the CS-register with the
interrupt flags enabled - typically observed in the middle of a transmit
of a byte the CS jumps, but the clock and data continue the transfers
correctly

As the CS register contains the interrupt flags as well as the 
control for the native-chip-selects this is impacting the chip select
lines in native mode.

I have never seen a glitch on the CLK or MISO/MOSI line in my logic
analyzer only CS jumps in the order of 1 sample in the logic analyzer
- @20MHz sample rate, so in the order of 50ns, probably less...

On top that happens only under some rare circumstances and can get rarely
observed - lots of samples (and memory) are needed to catch that one,
which typically results in a message in dmesg due to some unexpected
response crc checksum errors stalled processing.

This is from my experience from over a year ago with a fully DMA
pipelined driver that did all the programming of SPI in DMA as well and
there were some reports of people seeing "glitches" before I moved to
GPIO-CS (equivalents)

See also:
http://www.raspberrypi.org/forums/viewtopic.php?f=44&t=19489&start=125#p451817
for some observations mostly related to CLEAR_TX/CLEAR_RX that also
de-assert CS for short periods.

I also saw it _once_ in one of my traces when using native_cs 2-3 weeks
ago, but unfortunately I did not keep the capture...

Hence the requirement to use of gpio-cs when running this optimization,
as then the CS is not managed by the HW itself.

I have been filling (dd if=/dev/zero) a 2GB SD card repeatedly (more
than 9 times) for the last  12 hours and I have seen no issues -
besides the spi bus being occupied and spi_bus_locked for 17ms for
the data-transfers, which obviously impacts packet-reception (packet
loss) on CAN and ethernet network - but that is expected due to this
heavy load and long transfers.

Note that this test was executed using the latest patches I have sent
running at 16k interrupts/s and 4400 context-switches/second at 4MHz 
SPI-bus-speed for the SD-card.
The transfer of 1.6GB to the SD-card (filling up the partition) took
about 4350 seconds or 366kB/s - 3600s would be the ideal situation
without overheads, latencies or similar.


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
