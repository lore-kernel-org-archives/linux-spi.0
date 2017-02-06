From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 1/5] mtd: spi-nor: Added way to rescan spi-nor device
Date: Mon, 6 Feb 2017 12:46:48 +0100
Message-ID: <05a60f60-f404-7761-4079-c6e7d1d08aed@atmel.com>
References: <1486164676-12912-1-git-send-email-kdasu.kdev@gmail.com>
 <1486164676-12912-2-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Cc: <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <marex-ynQEQJNshbs@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1486164676-12912-2-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Kamal,

Le 04/02/2017 à 00:31, Kamal Dasu a écrit :
> On pm resume op spi-nor flash may need to be reconfigured on a power
> reset, however there is no need to go through a full spi_nor_scan().
> The driver might need to disable protection, program the address width and
> transfer mode where applicable. The spi-nor framework has all the generic
> code to do this. Refactored a few pieces and added a spi_nor_pm_rescan()
> to be called by the mtd device driver's pm resume() op.
> 
> Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 93 +++++++++++++++++++++++++++++++++++++------
>  include/linux/mtd/spi-nor.h   | 17 ++++++++
>  2 files changed, 98 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index da7cd69..e72233b 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1312,26 +1312,28 @@ static int spi_nor_check(struct spi_nor *nor)
>  	return 0;
>  }
>  
> -int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
> +static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
> +						       const char *name,
> +						       int *retval)
> +
>  {
>  	const struct flash_info *info = NULL;
>  	struct device *dev = nor->dev;
> -	struct mtd_info *mtd = &nor->mtd;
> -	struct device_node *np = spi_nor_get_flash_node(nor);
> -	int ret;
> -	int i;
> +	int ret = 0;
>  
>  	ret = spi_nor_check(nor);
>  	if (ret)
> -		return ret;
> +		goto info_out;
>  
>  	if (name)
>  		info = spi_nor_match_id(name);
>  	/* Try to auto-detect if chip name wasn't specified or not found */
>  	if (!info)
>  		info = spi_nor_read_id(nor);
> -	if (IS_ERR_OR_NULL(info))
> -		return -ENOENT;
> +	if (IS_ERR_OR_NULL(info)) {
> +		ret = -ENOENT;
> +		goto info_out;
> +	}
>  
>  	/*
>  	 * If caller has specified name of flash model that can normally be
> @@ -1342,7 +1344,8 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>  
>  		jinfo = spi_nor_read_id(nor);
>  		if (IS_ERR(jinfo)) {
> -			return PTR_ERR(jinfo);
> +			ret = PTR_ERR(jinfo);
> +			goto info_out;
>  		} else if (jinfo != info) {
>  			/*
>  			 * JEDEC knows better, so overwrite platform ID. We
> @@ -1357,8 +1360,15 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>  		}
>  	}
>  
> -	mutex_init(&nor->lock);
> +info_out:
> +
> +	*retval = ret;
> +	return info;
> +}
>  
> +static void spi_nor_unprotect(struct spi_nor *nor,
> +			      const struct flash_info *info)
> +{
>  	/*
>  	 * Atmel, SST, Intel/Numonyx, and others serial NOR tend to power up
>  	 * with the software protection bits set
> @@ -1372,6 +1382,35 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>  		write_sr(nor, 0);
>  		spi_nor_wait_till_ready(nor);
>  	}
> +}
> +
> +static inline void spi_nor_print_flash_info(struct spi_nor *nor,
> +					    const struct flash_info *info)
> +{
> +	struct mtd_info *mtd = &nor->mtd;
> +	struct device *dev = nor->dev;
> +
> +	dev_info(dev, "%s (%lld Kbytes)\n", info->name,
> +			(long long)mtd->size >> 10);
> +
> +}
> +
> +int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
> +{
> +	const struct flash_info *info;
> +	struct device *dev = nor->dev;
> +	struct mtd_info *mtd = &nor->mtd;
> +	struct device_node *np = spi_nor_get_flash_node(nor);
> +	int ret;
> +	int i;
> +
> +	info = spi_nor_get_flash_info(nor, name, &ret);
> +	if (ret)
> +		return ret;
> +
> +	mutex_init(&nor->lock);
> +
> +	spi_nor_unprotect(nor, info);
>  
>  	if (!mtd->name)
>  		mtd->name = dev_name(dev);
> @@ -1517,8 +1556,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>  
>  	nor->read_dummy = spi_nor_read_dummy_cycles(nor);
>  
> -	dev_info(dev, "%s (%lld Kbytes)\n", info->name,
> -			(long long)mtd->size >> 10);
> +	spi_nor_print_flash_info(nor, info);
>  
>  	dev_dbg(dev,
>  		"mtd .name = %s, .size = 0x%llx (%lldMiB), "
> @@ -1540,6 +1578,37 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>  }
>  EXPORT_SYMBOL_GPL(spi_nor_scan);
>  
> +int spi_nor_pm_rescan(struct spi_nor *nor, const char *name)
> +{
> +	int ret = 0;
> +	const struct flash_info *info;
> +	struct device *dev = nor->dev;
> +
> +	info = spi_nor_get_flash_info(nor, name, &ret);
> +	if (ret)
> +		return ret;

Why don't we save the info pointer in the spi_nor structure from
spi_nor_scan()?

in include/linux/mtd/spi-nor.h

+struct flash_info;

 struct spi_nor {
+	const struct flash_info	*info;
 	struct mtd_info		mtd;
 	struct mutex		lock;

I would avoid scanning the SPI flash again and again just to always
retrieve the very same settings.

Besides, when the parsing of the SFDP tables will be added, the scan
procedure will cost more than a single Read JEDEC ID command.

Hence if we can skip this step I guess it would be better!

> +
> +	spi_nor_unprotect(nor, info);
> +
> +	if (nor->flash_read == SPI_NOR_QUAD) {
> +		ret = set_quad_mode(nor, info);
> +		if (ret) {
> +			dev_err(dev, "quad mode not supported\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (nor->addr_width == 4 && JEDEC_MFR(info) != CFI_MFR_AMD)
> +		set_4byte(nor, info, 1);

You have forgotten the case where spi_nor_set_4byte_opcodes() is to be
called instead of set_4byte(), that is when we want to use the stateless
4-byte address instruction set instead of the stateful 4-byte address mode.

> +
> +	spi_nor_print_flash_info(nor, info);

IMHO, there is no reason to print this message a second time. It has
already been displayed from spi_nor_scan() then I guess it's enough.
Nothing has changed since spi_nor_scan().

> +	dev_dbg(dev, "addr width %d read mode %d",
> +		nor->addr_width, nor->flash_read);

Why should we display those settings here in spi_nor_pm_rescan() but not in
spi_nor_scan() ?

> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(spi_nor_pm_rescan);
> +

Actually most of the spi_nor_pm_rescan() code can be removed. We only need
to keep:
- unlock the flash
- check the Quad Enable requirement
- for memory > 128 Mbit, either make it enter its 4-byte address mode or
use the 4-byte address instruction set.

Moreover, for the ease of the maintenance, I think something like


int spi_nor_reset(...)
{
	/* unlock the flash */
	...

	/* check the Quad Enable requirement */
	...

	/* handle memory > 128 Mbit */
	...
}
EXPORT_SYMBOL_GPL(spi_nor_reset);

int spi_nor_scan(...)
{
	/* scan */
	...

	/* reset */
	spi_nor_reset();

	...
}
EXPORT_SYMBOL_GPL(spi_nor_scan);

could be better than

int func1()
{

}

int func2()
{

}

int func3()
{

}

int func4()
{

}

int spi_nor_scan(...)
{
	func1();
	func2();
	func3();
	func4();
	...
}
EXPORT_SYMBOL_GPL(spi_nor_scan);

int spi_nor_pm_rescan(...)
{
	func2();
	func3();
}
EXPORT_SYMBOL_GPL(spi_nor_pm_rescan);

because in the 2nd case it's more difficult to figure out whether some
piece of code should be called from either spi_nor_scan() or
spi_nor_pm_rescan() only or from both.

For instance, you have forgotten to call spi_nor_set_4byte_opcodes() when
needed from spi_nor_pm_rescan().

The reset function should only be a subset of spi_nor_scan().

IMHO, the spi_nor_pm_rescan() approach is a little bit more confusing.


Best regards,

Cyrille

>  static const struct flash_info *spi_nor_match_id(const char *name)
>  {
>  	const struct flash_info *id = spi_nor_ids;
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index c425c7b..487b473 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -213,4 +213,21 @@ static inline struct device_node *spi_nor_get_flash_node(struct spi_nor *nor)
>   */
>  int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode);
>  
> +/**
> + * spi_nor_pm_rescan() - rescan the SPI NOR
> + * @nor:	the spi_nor structure
> + * @name:	the chip type name
> + *
> + * The drivers can use this function to set the SPI NOR flash device to
> + * its initial scanned state, it shall use all nor information set on poweron
> + * for the read mode, address width and enabling write mode for certain
> + * manufacturers. This would be needed to be called for flash devices that are
> + * reset during power management.
> + *
> + * The chip type name can be provided through the @name parameter.
> + *
> + * Return: 0 for success, others for failure.
> + */
> +int spi_nor_pm_rescan(struct spi_nor *nor, const char *name);
> +
>  #endif
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
