From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH v2 0/2] spi: sh-hspi: Do not specifically request
 shyway_clk clock
Date: Fri, 11 Apr 2014 08:31:20 +0900
Message-ID: <20140410233120.GE4358@verge.net.au>
References: <1394783739-29168-1-git-send-email-horms+renesas@verge.net.au>
 <20140318003254.GB19571@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140318003254.GB19571-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Mar 18, 2014 at 09:32:55AM +0900, Simon Horman wrote:
> On Fri, Mar 14, 2014 at 04:55:37PM +0900, Simon Horman wrote:
> > Rather than requesting the shyway_clk call clk_get with
> > the device and a NULL con_id.
> > 
> > This is in keeping with the way that clk_get() is called
> > on other drivers used by Renesas Gen 1 SoCs. And I believe
> > it is compatible with supplying clocks via DT, unlike the current code.
> > 
> > 
> > This series supplies a fix for the r8a7779, a consumer of the driver,
> > so that the hspi clocks it supplies have the correct source.
> > 
> > And a fix for the sh-hspi driver to address the problem
> > described above.
> > 
> > Simon Horman (2):
> >   ARM: shmobile: r8a7779: Use clks as MSTP007 parent
> >   spi: sh-hspi: Do not specifically request shyway_clk clock
> > 
> >  arch/arm/mach-shmobile/clock-r8a7778.c | 2 +-
> >  drivers/spi/spi-sh-hspi.c              | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> Hi Mark,
> 
> as the first mach-shmobile patch is a run-time dependency for the
> second SPI driver patch could you consider taking both of them?
> 
> I have checked and I do not expect any conflicts anywhere beetween
> v3.14-rc1 and what I have queued up in the devel branch of my renesas tree.

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
