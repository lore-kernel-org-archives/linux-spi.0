From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH 8/8] spi: spi-ep93xx: convert to the queued driver
 infrastructure
Date: Sun, 30 Jun 2013 19:30:27 +0300
Message-ID: <20130630163027.GG786@mwesterb-mobl.lan>
References: <201306281145.56990.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net,
	Ryan Mallon <rmallon@gmail.com>, broonie@kernel.org,
	grant.likely@linaro.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201306281145.56990.hartleys@visionengravers.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jun 28, 2013 at 11:45:56AM -0700, H Hartley Sweeten wrote:
> The SPI core provides infrastructure for standard message queueing. Use
> that instead of handling it in the driver.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>
> Cc: Mika Westerberg <mika.westerberg@iki.fi>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Grant Likely <grant.likely@linaro.org>
> ---
>  drivers/spi/spi-ep93xx.c | 164 ++++++-----------------------------------------
>  1 file changed, 19 insertions(+), 145 deletions(-)

Nice reduction of code lines!

Thanks for doing this.

Acked-by: Mika Westerberg <mika.westerberg@iki.fi>
