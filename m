From: Seraphime Kirkovski <kirkseraph@gmail.com>
Subject: [PATCH 1/2] spi: spidev: introduce SPI_IOC_WR_DEFAULT_MAX_SPEED_HZ
 command
Date: Mon, 15 May 2017 10:17:11 +0200
Message-ID: <20170515081711.fcvexppqkjzlc7at@macchiaveli>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

christophe.blaess@gmail.com, fred@haapie.com
Bcc: Subject: Re: [PATCH 1/2] spi: spidev: introduce
 SPI_IOC_WR_DEFAULT_MAX_SPEED_HZ command
Reply-To: 
In-Reply-To: <20170514092716.kqx634djffgj32r6@sirena.org.uk>

On Sun, May 14, 2017 at 06:27:16PM +0900, Mark Brown wrote:
> On Tue, May 09, 2017 at 02:24:00PM +0200, Seraphime Kirkovski wrote:
> 
> > I think, this change is necessary, on the one hand, because there are still
> > a lot of longterm[2] supported kernels out there, whose users may be relying on
> > SPI_IOC_WR_MAX_SPEED being system-wide and, on the other hand, this
> > same command has been exhibiting a different behaviour for 3 years now,
> > so its users may break, if 9169051617df7 is reverted in one way or
> > another.
> 
> Do we have any evidence that such users exist?  

I can't guarantee for other such users, but this change did disturb our 
workflow. We were using this feature to prototype and test 
hardware/firmware at different speeds.

I was thinking this morning that maybe a sysfs interface will be better 
for setting global settings. Do you prefer ?
