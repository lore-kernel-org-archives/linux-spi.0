From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] spi: Add the flag indicate to registe new device as
 children of master or not.
Date: Tue, 18 Dec 2012 15:26:26 +0000
Message-ID: <20121218152623.GA26077@sirena.org.uk>
References: <1355848174.1435.25.camel@chenjun-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: grant.likely@secretlab.ca, linux-kernel@vger.kernel.org,
	Bi Chao <chao.bi@intel.com>,
	spi-devel-general@lists.sourceforge.net
To: Jun Chen <jun.d.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1355848174.1435.25.camel@chenjun-workstation>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Dec 18, 2012 at 11:29:34AM -0500, Jun Chen wrote:

>   * @master: Controller to which device is connected
> + * device_was_children_of_master is flag which the device is registed
> + * as the children of the bus

This isn't a kerneldoc style comment (it needs the @XXX: format).  The
name is also extremely long, can't we think of something more concise?

> -	spi->dev.parent = &master->dev;
> +	if (device_was_children_of_master == true)
> +		spi->dev.parent = &master->dev;
> +	else
> +		spi->dev.parent = dev;

Can you provide an example of where this is useful?  Your changelog
didn't make it clear and the code doesn't make it obvious either.
