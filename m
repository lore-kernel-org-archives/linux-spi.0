From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH - v2] spi: davinci: add OF support for the spi controller
Date: Wed, 19 Dec 2012 13:18:50 +0000
Message-ID: <20121219131850.E421B3E0AD7@localhost>
References: <1355260839-29865-1-git-send-email-m-karicheri2@ti.com> <20121215002758.14D223E0BEC@localhost>
Cc: Murali Karicheri <m-karicheri2@ti.com>
To: Murali Karicheri <m-karicheri2@ti.com>, rob.herring@calxeda.com,
	rob@landley.net, devicetree-discuss@lists.ozlabs.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	davinci-linux-open-source@linux.davincidsp.com,
	linux-keystone@list.ti.com
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20121215002758.14D223E0BEC@localhost>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, 15 Dec 2012 00:27:58 +0000, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Tue, 11 Dec 2012 16:20:39 -0500, Murali Karicheri <m-karicheri2@ti.com> wrote:
> > This adds OF support to DaVinci SPI controller to configure platform
> > data through device bindings. Also replaces clk_enable() with
> > of clk_prepare_enable() as well as clk_disable() with
> > clk_disable_unprepare().
> > 
> > Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> > Reviewed-by : Grant Likely <grant.likely@secretlab.ca>
> 
> Applied, thanks.
> 
> I did remove the OF_ALIAS_N property though. I know the COMPATIBLE one
> uses it, but it is actually kind of redundant since it can also be
> determined by counting the number of OF_ALIAS_* entries, and having the
> _N one in there means extra work needs to be done to filter it out.
> 
> Also, I had to add a #ifndef _LINUX_OF_PRIVATE_H wrapper around the
> whole header file. This is needed for all header files to protect
> against multiple includes.

Ummm.... oops. I replied to the wrong email when applying another patch.
Sorry for the noise.

But I have applied your patch now. It will appear in linux-next after
the merge window closes.

g.

