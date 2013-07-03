From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH v2 07/11] spi: spi-ep93xx: remove 'dss' from per chip
 private data
Date: Wed, 3 Jul 2013 21:06:57 +0300
Message-ID: <20130703180657.GF26568@mwesterb-mobl.lan>
References: <201307021009.30230.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net,
	Ryan Mallon <rmallon@gmail.com>, broonie@kernel.org,
	grant.likely@linaro.org, hsweeten@visionengravers.com
To: H Hartley Sweeten <hartleys@visionengravers.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201307021009.30230.hartleys@visionengravers.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jul 02, 2013 at 10:09:29AM -0700, H Hartley Sweeten wrote:
> This value is only needed to set the bits per word for each transfer
> of a message. There is no reason to set the value in ep93xx_spi_enable()
> because ep93xx_spi_process_transfer() sets it again for each transfer.
> 
> Just pass the t->bits_per_word directly to ep93xx_spi_chip_setup() in
> ep93xx_spi_process_transfer() and remove 'dss' from the per chip private
> data.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>
> Cc: Mika Westerberg <mika.westerberg@iki.fi>

Acked-by: Mika Westerberg <mika.westerberg@iki.fi>
