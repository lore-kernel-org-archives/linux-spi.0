From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] spi: spi-bcm2835.c: Fix 3-wire mode
Date: Fri, 28 Jun 2019 21:00:22 +0200
Message-ID: <20190628190022.vya4h2lihm6x2xpb@wunner.de>
References: <20190628123023.4696-1-nuno.sa@analog.com>
 <1b932c61-982b-aae0-1fef-3c574e7d17eb@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        broonie@kernel.org, eric@anholt.net,
        Martin Sperl <kernel@martin.sperl.org>, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
To: Stefan Wahren <wahrenst@gmx.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1b932c61-982b-aae0-1fef-3c574e7d17eb@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jun 28, 2019 at 05:23:54PM +0200, Stefan Wahren wrote:
> Am 28.06.19 um 14:30 schrieb Nuno Sá:
> > As stated in
> > https://www.raspberrypi.org/documentation/hardware/raspberrypi/spi/README.md,
> > one of rx or tx buffer's must be null. However, if DMA is enabled, the
> > driver sets the SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX on the
> > controller flags. Hence, the spi core will provide dummy buffers even if
> > one of the buffers was set to null by the device driver. Thus, the
> > communication with the 3-wire device fails.
> >
> > This patch uses the prepare_message callback to look for the device mode
> > and sets/clears the SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX on a
> > per spi message basis. It also assumes that DMA is not supported on
> > half-duplex devices.
> >
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> 
> i never tested the 3-wire mode. Could you please describe your test setup?

__spi_validate() returns -EINVAL if 3-wire mode is used and both buffers
are non-NULL, I guess that's the problem.


> @Martin, @Lukas Are you fine with this patch?

I have a patch set in the pipeline to drop SPI_CONTROLLER_MUST_RX
and SPI_CONTROLLER_MUST_TX from spi-bcm2835.c.

Latest snapshot is available here (top-most 10 commits):
https://github.com/l1k/linux/commits/revpi_staging

@Nuno, could you give this branch a spin and see if it fixes the
issue for you?  If so, this might be a better solution.  Your patch
is fine in principle since it works around the problem, but the
patch set on the above-linked branch fixes it at the root.
It also provides a nice welcome speedup and reduces resource
consumption.

I've been working on this on-and-off for about half a year,
I think the patch set is in pretty good shape now so I was
planning to submit it probably in 2 weeks or so.

Thanks,

Lukas
