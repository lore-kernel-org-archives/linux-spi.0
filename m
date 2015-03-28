From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: spi: bcm2835: strange observation with cs_gpios low after reboot
Date: Sat, 28 Mar 2015 13:12:02 +0100
Message-ID: <DFD4303D-1BE7-4B34-88CB-985699787A1F@sperl.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
 linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
 linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

I found the following strange situation with cs_gpios after a reboot
of my raspberry-pi.

Essentially on first load one of my devices does not get detected.
Only when I reload the spi-bcm2835 driver the second device gets
correctly detected.

The reason behind this is that at one point (probably during 
pin-control) the GPIOs that are set to output, but the level is
not modified in the register, so it is pulled low.

They only get set to the correct polarity when spi_setup is running
during the initialization of the device itself, which results in
the 2 identical devices getting configured at the same time while the
first device is running with spi_setup having run while the second
is still pending a call to spi_setup which sets up gpio with the 
correct polarity and thus is also responding even if not intended.

The second time I load the spi-bcm2835 driver it works fine
as the levels have been set already and the levels are not modified.

Is this something that has been observed before?

My dt has the following:

&gpio {
	spi_cs_pins: spi_cs_pins {
		brcm,pins = <4 5 6>;
		brcm,function = <1>; /* output */
	};
}

&spi {
	cs-gpios = <0>, <0>, <&gpio 6 0>, <&gpio 5 0>, <&gpio 4 0>;
};

I have also tried:
	cs-gpios = <0>, <0>, <&gpio 6 1>, <&gpio 5 1>, <&gpio 4 1>;
but it makes no difference.

The following in my driver solves the problem for now, but ignores
the configured CS polarity initially, but it handles the "typical"
case of normal CS polarity:

static int spi_initialsetup_gpio(struct spi_master* master)
{
	int i;
	bool level;
	if (!master->cs_gpios)
		return 0;

	for (i = 0; i < master->num_chipselect; i++) {
		if (gpio_is_valid(master->cs_gpios[i])) {
			/* actually we need to figure out the
			 * configured CSPOL of that device here,
			 * not sure how to do that...
			 */
			level = true;
			gpio_set_value(master->cs_gpios[i], level);
		}
	}
	return 0;
}

and call it inside spi_probe after spi_register_master.

I wonder if this is some oversight either on the spi side or on
the bcm2835-pinctrl side.

Note that the same thing may happen if a spi-device is:
	status = "disabled";
in the device-tree but still connected to the bus electrically.

In my experience this may make the bus unusable, but that might
get attributed to a bad device-tree itself - still it is a possible
pitfall that we might want to avoid...

Martin
