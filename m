From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: [PATCH 0/6] spi: bcm2835: collection of driver-optimizations
Date: Sun, 29 Mar 2015 16:03:21 +0200
Message-ID: <79109B49-E2CF-4498-A038-D51538789E50@martin.sperl.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Here a set of optimizations for the spi-bcm2835 driver that implements
some of the remaining "low-hanging fruit" to improve the driver
responsiveness and reduce CPU utilization.

In short: 
with all the patches applied the whole transfer of 4 bytes
at 10MHz finishes after 6.16us (CS down to up) with the real transfer
(clock running) taking 3.56us.
The un-patched driver instead runs a similar transfer in 39.56us for
2 bytes not 4!

See also: 
https://github.com/msperl/spi-bcm2835/wiki/spi_bcm2835situation
for some measurements showing the overall improvements achieved
with the following patch-sequence.

All of the patches apply against spi - topic/bcm2835

Some comments:
* Patch 1 - fixed a compile issue that came from the fact that
  the driver was built against spi - for-next and not mainline
  so it was using some error-handling features in the for-next tree.
* Patch 2 - fixed formating for string.
* Patch 3 - "fill FIFO before enabling interrupts to reduce..."
  prefills the FIFO before enabling interrupts which reduces
  the number of interrupts necessary for a single transfer by one.
* Patch 4 - "warn about native-chip-selects being used" - 
  has an implicit dependency on patch 3, as patch 3 limits some
  optimization to cs_gpios.
  this may instead be replaced by an implicit "change" to cs_gpio if
  someone can figure out how to change the mode of the GPIO itself
  from ALT4 to OUT.
  Essentially something along those lines would be needed in probe:
	if (!gpio_is_valid(spi->gpio_cs)) {
		if (spi->chip_select == 0) {
			spi->gpio_cs = 8;
			gpio_set_output(spi->gpio_cs);
		}
		if (spi->chip_select == 1) {
			spi->gpio_cs = 7;
			gpio_set_output(spi->gpio_cs);
		}
	}
  But I do not know what is the correct call to use instead of the
  "guessed" gpio_set_output()... 
  Also it leaves open the question if such a change in behavior is
  really accepted.
* patch 5 - "add polling mode for transfers below 30us" -
  requires patch 3 - "fill FIFO before enabling interrupts to reduce...".
* Patch/RFC 6 - "set gpio-cs to high state prior to any device..."
  is a patch/rfc that is setting up pins before ANY spi-device gets
  added via spi_add_device.
  Unfortunately - at least on the RPI - the GPIOs get
  set to low on initialization of the direction via pinctl 
  (my guess), so this forces the CS to high, which seems a sensible
  default, but misses the cases where spi-cspol is set in the DT.
  this needs to be enhanced and possibly should go into core,
  so this is more of an RFC...

Overall this improves the situation of the driver quite a lot spending
less CPU cycles, interrupts and context-switches for "typical" use-cases.

All the patches have been tested against the following setup:
* mcp2515 with native CS
* mcp2515 with gpio CS
* fb_st7735r with native CS
* enc28j60 with gpio-CS

Martin Sperl (6):
  spi: bcm2835: remove dependency on handle_err which is in
    spi-for-next
  spi: bcm2835: fix code formatting issue
  spi: bcm2835: fill FIFO before enabling interrupts to reduce
    interrupts/message
  spi: bcm2835: warn about native-chipselects being used
  spi: bcm2835: add polling mode for transfers below 30us
  spi: bcm2835: set gpio-cs to high state prior to any device
    initialization

 drivers/spi/spi-bcm2835.c |   97 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 87 insertions(+), 10 deletions(-)

-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
