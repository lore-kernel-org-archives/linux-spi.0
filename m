From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] SST25L (non JEDEC) SPI Flash driver
Date: Wed, 24 Jun 2009 19:40:05 -0700
Message-ID: <20090624194005.2f9574ce.akpm@linux-foundation.org>
References: <4A42BDF3.10901@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Linus Walleij <linus.ml.walleij@gmail.com>,
	linux kernel <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net,
	David Woodhouse <dwmw2@infradead.org>
To: Ryan Mallon <ryan@bluewatersys.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753995AbZFYClD@vger.kernel.org>
In-Reply-To: <4A42BDF3.10901@bluewatersys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 25 Jun 2009 11:59:47 +1200 Ryan Mallon <ryan@bluewatersys.com> wrote:

> Add support for the non JEDEC SST25L SPI Flash devices.
> 
> Signed-off-by: Andre Renaud <andre@bluewatersys.com>
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>

It looks OK to my inexperienced eye.

> ...
>
> +		bytes = min(mtd->writesize, (u32)(len - i));

The conventional way of suppressing the warning is min_t().

> +static int __init sst25l_probe(struct spi_device *spi)
> +{
> +	struct flash_info *flash_info;
> +	struct sst25l_flash *flash;
> +	struct flash_platform_data *data;
> +	int i;
> +
> +	flash_info = sst25l_match_device(spi);
> +	if (!flash_info)
> +		return -ENODEV;
> +
> +	flash = kzalloc(sizeof(struct sst25l_flash), GFP_KERNEL);
> +	if (!flash)
> +		return -ENOMEM;
> +
> +	flash->spi = spi;
> +	mutex_init(&flash->lock);
> +	dev_set_drvdata(&spi->dev, flash);
> +
> +	data = spi->dev.platform_data;
> +	if (data && data->name)
> +		flash->mtd.name = data->name;
> +	else
> +		flash->mtd.name = dev_name(&spi->dev);
> +
> +	flash->mtd.type		= MTD_NORFLASH;
> +	flash->mtd.flags	= MTD_CAP_NORFLASH;
> +	flash->mtd.erasesize	= flash_info->erase_size;
> +	flash->mtd.writesize	= flash_info->page_size;
> +	flash->mtd.size		= flash_info->page_size * flash_info->nr_pages;
> +	flash->mtd.erase	= sst25l_erase;
> +	flash->mtd.read		= sst25l_read;
> +	flash->mtd.write 	= sst25l_write;
> +
> +	dev_info(&spi->dev, "%s (%lld Kbytes)\n", flash_info->name,
> +		 (long long)flash->mtd.size >> 10);
> +
> +	DEBUG(MTD_DEBUG_LEVEL2,
> +	      "mtd .name = %s, .size = 0x%llx (%lldMiB) "
> +	      ".erasesize = 0x%.8x (%uKiB) .numeraseregions = %d\n",
> +	      flash->mtd.name,
> +	      (long long)flash->mtd.size, (long long)(flash->mtd.size >> 20),
> +	      flash->mtd.erasesize, flash->mtd.erasesize / 1024,
> +	      flash->mtd.numeraseregions);
> +
> +	if (flash->mtd.numeraseregions)
> +		for (i = 0; i < flash->mtd.numeraseregions; i++)
> +			DEBUG(MTD_DEBUG_LEVEL2,
> +			      "mtd.eraseregions[%d] = { .offset = 0x%llx, "
> +			      ".erasesize = 0x%.8x (%uKiB), "
> +			      ".numblocks = %d }\n",
> +			      i, (long long)flash->mtd.eraseregions[i].offset,
> +			      flash->mtd.eraseregions[i].erasesize,
> +			      flash->mtd.eraseregions[i].erasesize / 1024,
> +			      flash->mtd.eraseregions[i].numblocks);
> +
> +	if (mtd_has_partitions()) {
> +		struct mtd_partition *parts = NULL;
> +		int nr_parts = 0;
> +
> +		if (mtd_has_cmdlinepart()) {
> +			static const char *part_probes[] =
> +				{"cmdlinepart", NULL};
> +
> +			nr_parts = parse_mtd_partitions(&flash->mtd,
> +							part_probes,
> +							&parts, 0);
> +		}
> +
> +		if (nr_parts <= 0 && data && data->parts) {
> +			parts = data->parts;
> +			nr_parts = data->nr_parts;
> +		}
> +
> +		if (nr_parts > 0) {
> +			for (i = 0; i < nr_parts; i++) {
> +				DEBUG(MTD_DEBUG_LEVEL2, "partitions[%d] = "
> +				      "{.name = %s, .offset = 0x%llx, "
> +				      ".size = 0x%llx (%lldKiB) }\n",
> +				      i, parts[i].name,
> +				      (long long)parts[i].offset,
> +				      (long long)parts[i].size,
> +				      (long long)(parts[i].size >> 10));
> +			}
> +
> +			flash->partitioned = 1;
> +			return add_mtd_partitions(&flash->mtd,
> +						  parts, nr_parts);
> +		}
> +
> +	} else if (data->nr_parts) {
> +		dev_warn(&spi->dev, "ignoring %d default partitions on %s\n",
> +			 data->nr_parts, data->name);
> +	}
> +
> +	return add_mtd_device(&flash->mtd) == 1 ? -ENODEV : 0;

If this returns -ENODEV, did we leak the memory at *flash?

> +}
> +
