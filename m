From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: bcm2835: Allow platform to set realtime priority
Date: Thu, 23 Mar 2017 14:00:21 +0100
Message-ID: <CACRpkdaqqUj54Py1KqufpUq4O1_x+HuWUq_uWtrBurqx+f-oKw@mail.gmail.com>
References: <c1ca8a5522272d06f5c3fb67d8442f148b2d6cfb.1490264661.git.lukas@wunner.de>
 <1503363fcfb92adfa765d1c1c3e69fc673e72dde.1490264661.git.lukas@wunner.de>
 <20170323110718.sncw32gspvls75u7@sirena.org.uk> <20170323120257.GC20546@h08.hostsharing.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mathias Duckeck <m.duckeck-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>,
        linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
        Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170323120257.GC20546-KMaqurgeqYRAE5l8fViCMtHuzzzSOjJt@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Mar 23, 2017 at 1:02 PM, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> wrote:
> On Thu, Mar 23, 2017 at 11:07:18AM +0000, Mark Brown wrote:

> Also, if you question setting the RT priority in the devicetree, why
> was that functionality allowed for pl022 in the first place?

It was for the same usecase as yours essentially: the U8500
PL022 is in one specific product connected to a 4G modem.
When the traffic on the system gets high, the thread submitting
new packets to the modem gets too low priority and Linux starts
to prioritize the wrong things over getting data in and out to the
modem.

What can happen otherwise is that the threads producing ever
more data get higher or same priority as the thread pushing
the data to the modem, eventually saturating all buffers and
causing buffer contention and long latencies.

On desktops we have a similar thing in userspace, where the
rt-daemon is asked by pulseaudio to elevate the priority of the
pulseaudio process to realtime to avoid skipping audio frames.

Assigning priorities is a kernelwide problem, so whether it is
the right thing to do or not, I do not know.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
