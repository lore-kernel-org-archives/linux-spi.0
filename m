From: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Subject: Re: [PATCH v3] spi: omap2-mcspi: Add support for GPIO chipselects
Date: Thu, 7 May 2015 14:38:52 -0500
Message-ID: <20150507193851.GA15313@deathray>
References: <1430955472-11409-1-git-send-email-mwelling@ieee.org>
 <20150507185831.GQ22845@sirena.org.uk>
 <20150507192019.GA15112@deathray>
 <20150507192758.GR22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150507192758.GR22845-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, May 07, 2015 at 08:27:58PM +0100, Mark Brown wrote:
> On Thu, May 07, 2015 at 02:20:19PM -0500, Michael Welling wrote:
> > On Thu, May 07, 2015 at 07:58:31PM +0100, Mark Brown wrote:
> 
> > > makes things easier to review and helps people trying to understand the
> 
> > Do you have any other suggestions or comments on the patch so that I
> > can incorporate those changes as well in the patch series?
> 
> No, that's part of the "easier to review" bit.

The first two hunks are the only GPIO related code.

The rest is all conversion to transfer_one.
 
> 
> > I noticed a few oddities in the code when converting.
> 
> > For instance:
> > http://lxr.free-electrons.com/source/drivers/spi/spi-omap2-mcspi.c#L1225
> 
> > What is the point of trying to print tx or rx given the if statement
> > insures that rx_buff and tx_buff are NULL?
> 
> I expect it's just a buggy test.

Not sure I understand what you mean.


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
