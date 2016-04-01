From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Issues with cros_ec and "spi: rockchip: check return value of dmaengine_prep_slave_sg"
Date: Sat, 02 Apr 2016 01:52:19 +0200
Message-ID: <5681888.LvkE41Ux3K@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Shawn,

it looks like commit ea9849113343 ("spi: rockchip: check return value of
dmaengine_prep_slave_sg") negatively affects the cros_ec spi backend.

During boot on the most recent mainline kernel I get:

[    1.025480] cros-ec-spi spi0.0: Chrome EC device registered
[    1.641636] input: cros_ec as /devices/platform/ff110000.spi/spi_master/spi0/spi0.0/ff110000.spi:ec@0:keyboard-controller/input/input0
[    2.340214] cros-ec-spi spi0.0: EC failed to respond in time
[    2.357735] cros-ec-spi spi0.0: packet too long (249 bytes, expected 4)
[    2.470353] cros-ec-spi spi0.0: EC failed to respond in time
[    2.508495] cros-ec-spi spi0.0: packet too long (249 bytes, expected 4)
[    2.620176] cros-ec-spi spi0.0: EC failed to respond in time
[    2.637345] cros-ec-spi spi0.0: packet too long (249 bytes, expected 4)
[    2.750245] cros-ec-spi spi0.0: EC failed to respond in time
[    2.767519] cros-ec-spi spi0.0: packet too long (249 bytes, expected 4)

The cros-ec works ok after boot without further errors [aka keyboard
and everything working correctly] and I haven't been able to figure out
what goes wrong, but was able to bisect the issue down to the commit
mentioned above.

Reverting the patch silences the cros-ec again. I'll try to look into it
further, but maybe you also have an idea what might go wrong.


Heiko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
