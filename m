From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] spi: SuperH MSIOF SPI Master driver
Date: Thu, 26 Nov 2009 15:43:16 +0900
Message-ID: <20091126064315.GA6580@linux-sh.org>
References: <20091124125531.14957.41264.sendpatchset@rxone.opensource.se> <20091125121152.4ccf03dc.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Magnus Damm <magnus.damm@gmail.com>,
	spi-devel-general@lists.sourceforge.net,
	dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932911AbZKZGoJ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091125121152.4ccf03dc.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Nov 25, 2009 at 12:11:52PM -0800, Andrew Morton wrote:
> On Tue, 24 Nov 2009 21:55:31 +0900
> Magnus Damm <magnus.damm@gmail.com> wrote:
> > +struct sh_msiof_spi_priv {
> > +	struct spi_bitbang bitbang; /* must be first for spi_bitbang.c */
> 
> Well if that's the case then spi_bitbang.c needs smacking.  What causes
> this requirement?
> 
spi_bitbang causes this requirement by being lazy with regards to
private data stashing. Both the drivers and the bitbang code use
spi_master_get_devdata() for getting their private data, which wraps
in to a dev_get_drvdata().

This needs to be reworked so that struct spi_master has its own private
data pointer which helper code like spi_bitbang can use, while freeing up
the struct device private data pointer so it can be freely used by
drivers as normal.

This is the same sort of private data through casting whimsy that the
framebuffer drivers used to employ, only fortunately that behaviour never
made it out of 2.3.x kernels -- until now!

> > +	void __iomem *mapbase;
> > +	struct clk *clk;
> > +	struct platform_device *pdev;
> > +	struct sh_msiof_spi_info *info;
> > +	struct completion done;
> > +	unsigned long flags;
> > +	int tx_fifo_size;
> > +	int rx_fifo_size;
> > +};
> > +
> >
> > ...
> >
> > +static void sh_msiof_modify_ctr_wait(struct sh_msiof_spi_priv *p,
> > +				     unsigned long clr, unsigned long set)
> > +{
> > +	unsigned long mask = clr | set;
> > +	unsigned long data;
> > +
> > +	data = sh_msiof_read(p, CTR);
> > +	data &= ~clr;
> > +	data |= set;
> > +	sh_msiof_write(p, CTR, data);
> > +
> > +	while ((sh_msiof_read(p, CTR) & mask) != set)
> > +		;
> 
> hm, confidence.  No timeout needed here?
> 
This definitely needs a timeout, nothing involving SPI inspires
confidence. A cpu_relax() to prevent the compiler from optimizing the
loop out would help, too.
