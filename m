From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] gpio: 74x164: remove unnecessary defines and prototype
Date: Fri, 3 Jun 2011 11:37:25 -0600
Message-ID: <20110603173725.GC15616@ponder.secretlab.ca>
References: <201105271635.59593.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net
To: H Hartley Sweeten <hartleys@visionengravers.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201105271635.59593.hartleys@visionengravers.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, May 27, 2011 at 04:35:59PM -0700, H Hartley Sweeten wrote:
> Remove the #define GEN_74X164_GPIO_COUNT since it's only used in
> one place and it's meaning is obvious.  Also remove the #define
> GEN_74X164_DRIVER_NAME and use spi->modalias to set the gpio chip's
> label and the string "74x164" for the driver name.
> 
> Reorder the code slightly to remove the need to prototype
> gen_74x164_set_value.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>

Applied, thanks.

g.
