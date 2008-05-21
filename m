From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: Add OF binding support for
	SPI busses
Date: Wed, 21 May 2008 19:19:29 +0400
Message-ID: <20080521151928.GA28857@polina.dev.rtsoft.ru>
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<20080516193613.28030.13950.stgit@trillian.secretlab.ca>
Reply-To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: fabrizio.garetto-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080516193613.28030.13950.stgit-8FIgwK2HfyId2tlXD8uQ6/kpB+XfMlBf@public.gmane.org>
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

On Fri, May 16, 2008 at 01:36:13PM -0600, Grant Likely wrote:
> From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> 
> This patch adds support for populating an SPI bus based on data in the
> OF device tree.  This is useful for powerpc platforms which use the
> device tree instead of discrete code for describing platform layout.
> 
> Signed-off-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> ---
[...]
> diff --git a/drivers/spi/spi_of.c b/drivers/spi/spi_of.c
> new file mode 100644
> index 0000000..b5ae434
> --- /dev/null
> +++ b/drivers/spi/spi_of.c
> @@ -0,0 +1,86 @@
> +/*

I think better placement for this is drivers/of, no?

> + * SPI OF support routines
> + * Copyright (C) 2008 Secret Lab Technologies Ltd.
> + *
> + * Support routines for deriving SPI device attachments from the device
> + * tree.
> + */
> +
> +#include <linux/of.h>
> +#include <linux/device.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi_of.h>
> +
> +/**
> + * spi_of_register_devices - Register child devices onto the SPI bus
> + * @master:	Pointer to spi_master device
> + * @np:		parent node of SPI device nodes
> + *
> + * Registers an spi_device for each child node of 'np' which has a 'reg'
> + * property.
> + */
> +void spi_of_register_devices(struct spi_master *master, struct device_node *np)
> +{
> +	struct spi_device *spi;
> +	struct device_node *nc;
> +	const u32 *prop;
> +	const char *sprop;
> +	int rc;
> +	int len;
> +
> +	for_each_child_of_node(np, nc) {
> +		/* Alloc an spi_device */
> +		spi = spi_alloc_device(master);
> +		if (!spi) {
> +			dev_err(&master->dev, "spi_device alloc error for %s\n",
> +				np->full_name);
> +			continue;
> +		}
> +
> +		/* Device address */
> +		prop = of_get_property(nc, "reg", &len);
> +		if (!prop || len < sizeof(*prop)) {
> +			dev_err(&master->dev, "%s has no 'reg' property\n",
> +				np->full_name);

Should be nc->full_name.

> +			continue;
> +		}
[...]

-- 
Anton Vorontsov
email: cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
irc://irc.freenode.net/bd2

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
