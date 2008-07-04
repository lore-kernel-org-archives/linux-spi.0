From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2 4/5] spi: Add OF binding support
	for SPI busses
Date: Thu, 3 Jul 2008 22:17:58 -0600
Message-ID: <20080704041758.GH12945@secretlab.ca>
References: <20080703005749.26187.71719.stgit@trillian.secretlab.ca>
	<20080703010313.26187.99119.stgit@trillian.secretlab.ca>
	<58A20A281BAF1047B4EAE68DE5C0BDC2010121B7@zch01exm21.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org,
	fabrizio.garetto-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Chen Gong <G.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <58A20A281BAF1047B4EAE68DE5C0BDC2010121B7-bKEhWGtIRULiD3AT8lUqWFjVikpgYyvb5NbjCUgZEJk@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jul 04, 2008 at 11:54:57AM +0800, Chen Gong wrote:
> Grant Likely wrote:
> > +		/* Mode (clock phase/polarity/etc.) */
> > +		if (of_find_property(nc, "spi,cpha", NULL))
> > +			spi->mode |= SPI_CPHA;
> > +		if (of_find_property(nc, "spi,cpol", NULL))
> > +			spi->mode |= SPI_CPOL;
> 
> so becuase in function spi_alloc_deive, spi is allocated by kzalloc,
> how about writing as follows:
> 		/* Mode (clock phase/polarity/etc.) */
> 		prop = of_get_property(nc, "spi,cpha", NULL))
>                         if (prop)
> 			spi->mode |= *prop;
> 		prop = of_get_property(nc, "spi,cpol", NULL))
>                         if (prop)
> 			spi->mode |= *prop;

spi,cpha and spi,cpol are defined as empty properties.  The presence of
the property in the node means I need to set the flag in the spi_device.

> > +		/* Select device driver */
> > +		sprop = of_get_property(nc, "linux,modalias", &len);
> > +		if (sprop && len > 0)
> > +			strncpy(spi->modalias, sprop, KOBJ_NAME_LEN);
> > +		else
> > +			strncpy(spi->modalias, "spidev", KOBJ_NAME_LEN);
> > +
>  how about writing as follows:
> 
> 		if (sprop && len > 0)
> 			strncpy(spi->modalias, sprop, KOBJ_NAME_LEN -
> 1);
> 		else
> 			strncpy(spi->modalias, "spidev", KOBJ_NAME_LEN -
> 1);

Actually, neither are very good.  What it should really be is:

	if (sprop && len > 0)
		strlcpy(spi->modalias, sprop, sizeof (spi->modalias));
	else
		strlcpy(spi->modalias, "spidev", sizeof (spi->modalias));

This ensures that the string is always null terminated and always the
right size.

... But the whole argument is a bit moot.  The fact that I even defined
a "linux,modalias" property is a great big hairy hack that I would
never want my mother to see.  Instead, I need a method to bind to an SPI
driver based on the compatible list.  Jon Smirl has done some work
in this regard for i2c, but I haven't looked at it very deeply, and so
do not at all understand it (yet).

Thanks for the comments.
g.

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
