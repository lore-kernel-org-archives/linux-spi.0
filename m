From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH V3 16/17] SPI: MIPS: lantiq: add FALCON spi driver
Date: Sat, 19 May 2012 23:16:51 -0600
Message-ID: <20120520051651.388013E03B8@localhost>
References: <1337025642-31194-1-git-send-email-blogic@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Thomas Langer <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1337025642-31194-1-git-send-email-blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, 14 May 2012 22:00:42 +0200, John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org> wrote:
> From: Thomas Langer <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>
> 
> The external bus unit (EBU) found on the FALCON SoC has spi emulation that is
> designed for serial flash access. This driver has only been tested with m25p80
> type chips. The hardware has no support for other types of spi peripherals.
> 
> Signed-off-by: Thomas Langer <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>
> Signed-off-by: John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
> Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> ---
> This patch was previously Acked in V2 by Grant
> http://www.mail-archive.com/spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org/msg07874.html

Which mostly stands except for (something I didn't notice before)....

> +static int __devinit falcon_sflash_probe(struct platform_device *pdev)
> +{
> +	struct falcon_sflash *priv;
> +	const __be32 *prop;
> +	struct spi_master *master;
> +	int ret, len;
> +
> +	if (ltq_boot_select() != BS_SPI) {
> +		dev_err(&pdev->dev, "invalid bootstrap options\n");
> +		return -ENODEV;
> +	}
> +
> +	master = spi_alloc_master(&pdev->dev, sizeof(*priv));
> +	if (!master)
> +		return -ENOMEM;
> +
> +	priv = spi_master_get_devdata(master);
> +	priv->master = master;
> +
> +	master->mode_bits = SPI_MODE_3;
> +	master->num_chipselect = 1;
> +	master->bus_num = -1;
> +	master->setup = falcon_sflash_setup;
> +	master->prepare_transfer_hardware = falcon_sflash_prepare_xfer;
> +	master->transfer_one_message = falcon_sflash_xfer_one;
> +	master->unprepare_transfer_hardware = falcon_sflash_unprepare_xfer;
> +	master->dev.of_node = pdev->dev.of_node;
> +
> +	prop = of_get_property(pdev->dev.of_node, "busnum", &len);
> +	if (prop && (len == sizeof(*prop)))
> +		master->bus_num = be32_to_cpup(prop);

Drop this bit.  spi bus numbers are dynamically assigned for DT usage.
Using a property to override the bus number should not be done.

Userspace can determine the bus number for a given device from sysfs.

If you still **really** need a bus to have a specific number, then the
correct way of handling it is to use a property in the /aliases node,
and there is some infrastructure in drivers/of/base.c.  Look for
of_alias_get_id().

g.


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
