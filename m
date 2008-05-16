From: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: Add OF binding support for
	SPI busses
Date: Sat, 17 May 2008 02:03:38 +0400
Message-ID: <20080516220338.GA3255@zarina>
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<20080516193613.28030.13950.stgit@trillian.secretlab.ca>
Reply-To: cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
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
> +			continue;
> +		}
> +		spi->chip_select = *prop;
> +
> +		/* Mode (clock phase/polarity/etc. */
> +		if (of_find_property(nc, "spi,cpha", NULL))
> +			spi->mode |= SPI_CPHA;
> +		if (of_find_property(nc, "spi,cpol", NULL))
> +			spi->mode |= SPI_CPOL;
> +
> +		/* Device speed */
> +		prop = of_get_property(nc, "max-speed", &len);
> +		if (prop && len >= sizeof(*prop))
> +			spi->max_speed_hz = *prop;
> +		else
> +			spi->max_speed_hz = 100000;
> +
> +		/* IRQ */
> +		spi->irq = irq_of_parse_and_map(nc, 0);
> +
> +		/* Select device driver */
> +		sprop = of_get_property(nc, "linux,modalias", &len);
> +		if (sprop && len > 0)
> +			strncpy(spi->modalias, sprop, KOBJ_NAME_LEN);
> +		else
> +			strncpy(spi->modalias, "spidev", KOBJ_NAME_LEN);
> +
> +		/* Store a pointer to the node in the device structure */
> +		of_node_get(nc);
> +		spi->dev.archdata.of_node = nc;
> +
> +		/* Register the new device */
> +		rc = spi_register_device(spi);
> +		if (rc) {
> +			dev_err(&master->dev, "spi_device register error %s\n",
> +				np->full_name);
> +			spi_device_release(spi);
> +		}

No way to pass platform data... can you suggest any idea to use
this for things like
"[POWERPC] 86xx: mpc8610_hpcd: add support for SPI and MMC-over-SPI"
I've sent just recently...?

Maybe this code could do something like
spi->dev.platform_data = nc->data;
and board code would fill nc->data at early stages? This needs to be a
convention, not just random use though.. Maybe we can expand the struct
device_node to explicitly include .platform_data for such cases?

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
irc://irc.freenode.net/bd2

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
