From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH 6/8] spi: spi-ep93xx: don't bother calculating the
 divisors in ep93xx_spi_setup()
Date: Sun, 30 Jun 2013 19:27:29 +0300
Message-ID: <20130630162729.GE786@mwesterb-mobl.lan>
References: <201306281145.02815.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net,
	Ryan Mallon <rmallon@gmail.com>, broonie@kernel.org,
	grant.likely@linaro.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201306281145.02815.hartleys@visionengravers.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jun 28, 2013 at 11:45:02AM -0700, H Hartley Sweeten wrote:
> The divisors needed to generate the SPI clock are calculated per
> transfer based on the t->speed_hz. There is no reason to calculate
> them in ep93xx_spi_setup().
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>
> Cc: Mika Westerberg <mika.westerberg@iki.fi>

Acked-by: Mika Westerberg <mika.westerberg@iki.fi>
