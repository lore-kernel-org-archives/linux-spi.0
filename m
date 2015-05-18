From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] Documentation: dt: mtd: replace "nor-jedec" binding with
 "jedec,spi-nor"
Date: Mon, 18 May 2015 11:34:42 -0700
Message-ID: <20150518183442.GR11598@ld-irv-0074>
References: <1431624773-4165-1-git-send-email-computersforpeace@gmail.com>
 <20150515195541.GL11598@ld-irv-0074>
 <20150518104501.GD3551@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Marek Vasut <marex@denx.de>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	linux-spi@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150518104501.GD3551@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

+ linux-spi

On Mon, May 18, 2015 at 11:45:01AM +0100, Mark Rutland wrote:
> On Fri, May 15, 2015 at 08:55:41PM +0100, Brian Norris wrote:
> > It really helps if I test patches...
> > 
> > On Thu, May 14, 2015 at 10:32:53AM -0700, Brian Norris wrote:
[...]
> > > @@ -305,7 +305,7 @@ static const struct spi_device_id m25p_ids[] = {
> > >  	 * Generic support for SPI NOR that can be identified by the JEDEC READ
> > >  	 * ID opcode (0x9F). Use this, if possible.
> > >  	 */
> > > -	{"nor-jedec"},
> > > +	{"jedec,spi-nor"},
> > 
> > So I forgot (again; we hit this before) that the SPI/OF framework strips
> > everything before the first comma before binding devices. See
> > of_modalias_node(). So I'll have to squash in the patch below to get a
> > usable binding.
> 
> Is it not possible to use the of_match_table on spi_driver::driver? If
> not, we really should make it so.

Hmm, it does look like spi.c supports multiple matching mechanisms, so I
guess m25p80.c could match some with of_match_table and some with
modalias/spi_driver.id_table. See:

static int spi_match_device(struct device *dev, struct device_driver *drv)
{
	const struct spi_device *spi = to_spi_device(dev);
	const struct spi_driver *sdrv = to_spi_driver(drv);

	/* Attempt an OF style match */
	if (of_driver_match_device(dev, drv))
		return 1;
	// ^^^^ we aren't yet (but could be) using this

	/* Then try ACPI */
	if (acpi_driver_match_device(dev, drv))
		return 1;

	if (sdrv->id_table)
		return !!spi_match_id(sdrv->id_table, spi);
	// ^^^^ we're currently only using this

	return strcmp(spi->modalias, drv->name) == 0;
}

I'll see about patching this for 4.2. We have a working solution for
4.1 at least.

Brian
