From: Kyle Roeschley <kyle.roeschley-acOepvfBmUk@public.gmane.org>
Subject: spidev: Instantiating from DT as "spidev"
Date: Wed, 29 Nov 2017 09:04:36 -0600
Message-ID: <20171129150435.5npybjuu2ndmtx2v@senary>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

Since commit 956b200a846e ("spi: spidev: Warn loudly if instantiated from DT as
"spidev""), listing "spidev" directly in a device tree is not recommended.
Instead, what I see in the (many) past discussions is that I should change my
device tree to describe the actual hardware and add whatever new ID I create to
spidev_dt_ids. That seems perfectly reasonable.

However, our SPI master [1] is similar to the Raspberry Pi or Beaglebone in
that we don't know at kernel build time what device may be attached to the SPI
bus. Because the end users of our device are usually young students, we also
can't expect them to rebuild their kernel or mess with device tree overlays
just to interface with some arbitrary SPI device.

Is there a "correct" solution to this problem? Both the Raspberry Pi [2] and
Beaglebone [3] kernels have just added "spidev" back to the match table, but I
would rather not carry a patch around just for some printk spam.

Regards,

-- 
Kyle Roeschley
Software Engineer
National Instruments

[1] http://www.ni.com/en-us/support/model.roborio.html
[2] https://github.com/raspberrypi/linux/commit/dc08459ce87f0e73422c17abe20d0ac6c72153ad
[3] https://github.com/beagleboard/linux/commit/1596f3a6a0966969089be73c58e4a6294ffbcb09

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
