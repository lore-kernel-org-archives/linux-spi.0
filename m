From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH v2 04/11] spi: spi-ep93xx: get platform resources early
 in (*probe)
Date: Wed, 3 Jul 2013 21:03:41 +0300
Message-ID: <20130703180341.GC26568@mwesterb-mobl.lan>
References: <201307021007.53590.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net,
	Ryan Mallon <rmallon@gmail.com>, broonie@kernel.org,
	grant.likely@linaro.org, hsweeten@visionengravers.com
To: H Hartley Sweeten <hartleys@visionengravers.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201307021007.53590.hartleys@visionengravers.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jul 02, 2013 at 10:07:53AM -0700, H Hartley Sweeten wrote:
> Get the platform resources early in the (*probe) to minimize the number
> of goto's in the error path.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>
> Cc: Mika Westerberg <mika.westerberg@iki.fi>

Acked-by: Mika Westerberg <mika.westerberg@iki.fi>
