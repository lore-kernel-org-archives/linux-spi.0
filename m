From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH v2 06/11] spi: spi-ep93xx: remove dev_err() for kzalloc()
 failure
Date: Wed, 3 Jul 2013 21:05:15 +0300
Message-ID: <20130703180515.GE26568@mwesterb-mobl.lan>
References: <201307021009.00176.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net,
	Ryan Mallon <rmallon@gmail.com>, broonie@kernel.org,
	grant.likely@linaro.org, hsweeten@visionengravers.com
To: H Hartley Sweeten <hartleys@visionengravers.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201307021009.00176.hartleys@visionengravers.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jul 02, 2013 at 10:08:59AM -0700, H Hartley Sweeten wrote:
> The kzalloc() failure will have already output a message.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>
> Cc: Mika Westerberg <mika.westerberg@iki.fi>

Acked-by: Mika Westerberg <mika.westerberg@iki.fi>
