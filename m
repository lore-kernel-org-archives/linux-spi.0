Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071433B0AFD;
	Mon, 13 Apr 2026 10:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077103; cv=none; b=efAC1l2DK8PZARTG4TnmqfvmexJ70qQNAsIkG6Vm+AKYVxeug3I/Ili+QS7tKGA1U1YqFTJ/Z9GYnC8OWy/QyPq4XHiBHHsUvLM6tJFRk/zhPs9UXE1OIUrj9/RPW2bOTQdx5LjsnmhlSgWlOe176MCz135aBHjvsPFj8pa9ZGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077103; c=relaxed/simple;
	bh=QnB20GMBsTAE5vdQlnDv33Uqy9ISYS0NazsTV1hGnFw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WKhY/pdkkXg5qeO/mEBNLFdYeT89uciu27OnuDBYKKB0S1cZ+XqlHVG62IZIBP57+KJX9T914VLuvQ4gZlEIUuyAXrijmKIy/D9BfzpWW+Q48wwi8IxQxAGPEc0BCQWDM6+9T6FBwzxi5y2RAkuEicQ9tae23cVVEmrZeaF4VPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mF81/xMQ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mF81/xMQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776077102; x=1807613102;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QnB20GMBsTAE5vdQlnDv33Uqy9ISYS0NazsTV1hGnFw=;
  b=mF81/xMQ2ojkePgVsLzqz4QNuA7yyYr44zU8j9ucuF6LBNtyrEkRwYHe
   yY63qipOcoc4kkPDjCsUJMSyeOssm9oo9etcLPHIP5ihbCLR19Geqe2mm
   Sn9icMbyTK3cRWvUPQ2XXd9UbtS1u6gAsemJYG5dIwG6fWS+xZ3mT383q
   Y7NpJDHOS40ify6gqCUrPypWGBJmyKX5jZ/2uwu4BEYNnuVF8ABLkJfRb
   u5yBX7j2f5443vWfz5UsmGoLIU7OBQ5oWgPKkIP9BxROR/GrD4B3vGqzl
   T75/PQh6G3IvjCQic2r84GR5nfWdNFRP70FqwPz2Ih3fikyDVzdru0waJ
   g==;
X-CSE-ConnectionGUID: uelK3hUjS/6k5BuhAJ+myQ==
X-CSE-MsgGUID: jlxpuNG/QjaC0a9YJUDrIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="64538457"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="64538457"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 03:45:01 -0700
X-CSE-ConnectionGUID: yUzdwGT0S9OVU2YHeBD46Q==
X-CSE-MsgGUID: IuEAirhCTVeBttD0NrF0cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="231480885"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.63])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 03:44:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 Apr 2026 13:44:52 +0300 (EEST)
To: Khalil <khalilst@gmail.com>
cc: broonie@kernel.org, Hans de Goede <hansg@kernel.org>, 
    rf@opensource.cirrus.com, linux-spi@vger.kernel.org, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Khalil <khalil@rentman.nl>
Subject: Re: [PATCH v2 2/3] platform/x86: serial-multi-instantiate: Fix SPI
 chip select on platforms with incomplete ACPI cs-gpios
In-Reply-To: <20260413100530.580649-3-khalil@rentman.nl>
Message-ID: <a46ead79-5951-1dfc-4a7f-833a29819228@linux.intel.com>
References: <20260413100530.580649-1-khalil@rentman.nl> <20260413100530.580649-3-khalil@rentman.nl>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 13 Apr 2026, Khalil wrote:

> Some HP laptops with Intel Lunar Lake and dual Cirrus Logic CS35L56
> amplifiers over SPI have an incomplete cs-gpios property in the SPI
> controller's _DSD - it only declares the first chip select. The
> remaining chip select GPIOs are defined as GpioIo resources in the
> peripheral's ACPI node but are not referenced by the controller.
> 
> This causes the SPI framework to reject devices whose chip select
> exceeds num_chipselect with -EINVAL, preventing the second amplifier
> from probing.
> 
> Fix this on known affected platforms by:
> 
> 1. Adding a DMI quirk table to identify affected systems
> 2. For devices with chip selects outside the controller's range,
>    acquiring the GPIO from the peripheral's ACPI GpioIo resource
> 3. Extending num_chipselect and reallocating the controller's
>    cs_gpiods array to install the GPIO descriptor
> 4. Setting SPI_CONTROLLER_GPIO_SS so the framework calls both
>    the GPIO toggle and controller->set_cs (needed for clock
>    gating on Intel LPSS controllers)
> 
> Only chip selects beyond the controller's num_chipselect are fixed up.
> Chip selects within range with a NULL cs_gpiods entry are left alone,
> as NULL means "native chip select" which is intentional.
> 
> Tested on HP EliteBook 8 G1i 16 inch (board 8D8A) with 2x CS35L56
> Rev B0 amplifiers. Both amplifiers probe and produce audio.
> 
> Signed-off-by: Khalil <khalilst@gmail.com>
> ---
>  .../platform/x86/serial-multi-instantiate.c   | 168 ++++++++++++++++++
>  1 file changed, 168 insertions(+)
> 
> diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
> index 1a369334f..0d30bd0a7 100644
> --- a/drivers/platform/x86/serial-multi-instantiate.c
> +++ b/drivers/platform/x86/serial-multi-instantiate.c
> @@ -8,6 +8,10 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/dmi.h>

Will this build with all configs since you didn't add any depends on?

> +#include <linux/gpio/consumer.h>
> +#include <linux/gpio/machine.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> @@ -46,6 +50,53 @@ struct smi {
>  	int spi_num;
>  	struct i2c_client **i2c_devs;
>  	struct spi_device **spi_devs;
> +	struct gpio_desc *cs_gpio;
> +};
> +
> +/*
> + * Quirk data for platforms with broken ACPI SPI chip select descriptions.
> + * cs_gpio_idx: index of the GpioIo resource in the ACPI _CRS that provides
> + *              the chip select GPIO for devices missing a proper cs-gpios
> + *              entry on the SPI controller.
> + */
> +struct smi_cs_gpio_quirk {
> +	int cs_gpio_idx;
> +};
> +
> +static const struct smi_cs_gpio_quirk hp_elitebook_8g1i_quirk = {
> +	.cs_gpio_idx = 0,
> +};
> +
> +/*
> + * DMI table of platforms with broken SPI chip select ACPI descriptions.
> + *
> + * These systems have multiple SPI peripherals (e.g., dual CS35L56
> + * amplifiers) but the SPI controller's _DSD cs-gpios property is
> + * incomplete - it only declares the first chip select. The remaining
> + * chip select GPIOs are defined as GpioIo resources in the peripheral's
> + * ACPI node but are not referenced by the controller.
> + */
> +static const struct dmi_system_id smi_cs_gpio_dmi_table[] = {
> +	{
> +		.ident = "HP EliteBook 8 G1i 16 inch",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> +			DMI_MATCH(DMI_BOARD_NAME, "8D8A"),
> +		},
> +		.driver_data = (void *)&hp_elitebook_8g1i_quirk,

Cast looks unnecessary.

> +	},
> +	{ }
> +};
> +
> +/*
> + * ACPI GPIO mapping for the chip select GpioIo resource.
> + * Maps "cs-gpios" to the GpioIo resource at index 0 of the ACPI _CRS.
> + */
> +static const struct acpi_gpio_params smi_cs_gpio_params = { 0, 0, false };
> +
> +static const struct acpi_gpio_mapping smi_cs_gpio_mapping[] = {
> +	{ "cs-gpios", &smi_cs_gpio_params, 1 },
> +	{ }
>  };
>  
>  static int smi_get_irq(struct platform_device *pdev, struct acpi_device *adev,
> @@ -99,6 +150,101 @@ static void smi_devs_unregister(struct smi *smi)
>  	}
>  }
>  
> +/*
> + * smi_spi_setup_cs_gpio - Fix up chip select for a device on a platform
> + * with broken ACPI cs-gpios description.
> + *
> + * On affected platforms, the SPI controller's cs-gpios property is incomplete,
> + * so the framework has no GPIO descriptor for some chip selects. This causes
> + * __spi_add_device() to reject the device with -EINVAL (cs >= num_chipselect).
> + *
> + * This function:
> + * 1. Extends num_chipselect if the device's CS is out of range
> + * 2. Reallocates cs_gpiods to match, preventing out-of-bounds access
> + *    in __spi_add_device()
> + * 3. Installs the GPIO from the peripheral's ACPI node into the
> + *    controller's cs_gpiods array so __spi_add_device() propagates
> + *    it to the device
> + * 4. Sets SPI_CONTROLLER_GPIO_SS so the framework calls both the GPIO
> + *    toggle and controller->set_cs (needed for clock gating on Intel
> + *    LPSS controllers)
> + */
> +static int smi_spi_setup_cs_gpio(struct device *dev,
> +				 struct spi_device *spi_dev,
> +				 struct smi *smi,
> +				 const struct smi_cs_gpio_quirk *quirk)
> +{
> +	struct spi_controller *ctlr = spi_dev->controller;
> +	struct gpio_desc **new_gpiods;
> +	u16 cs = spi_get_chipselect(spi_dev, 0);

Could you place this assignment right before the if () below.

> +
> +	/*
> +	 * Only fix up chip selects that the controller doesn't know about.
> +	 * A NULL cs_gpiods[cs] within the controller's num_chipselect range
> +	 * means "native chip select" - that's intentional, not broken.
> +	 * The broken case is when cs >= num_chipselect, meaning the ACPI
> +	 * cs-gpios property on the controller was incomplete.
> +	 */
> +	if (cs < ctlr->num_chipselect)
> +		return 0;
> +
> +	/* Extend num_chipselect to cover this device */
> +	dev_info(dev, "Extending num_chipselect from %u to %u for CS%u\n",

Add include for dev_*() printing (I know it's also a pre-existing problem 
but lets add it finally here).

> +		 ctlr->num_chipselect, cs + 1, cs);
> +	ctlr->num_chipselect = cs + 1;
> +
> +	/* Acquire the CS GPIO from the ACPI GpioIo resource if not yet done */
> +	if (!smi->cs_gpio) {
> +		int ret;
> +
> +		ret = devm_acpi_dev_add_driver_gpios(dev, smi_cs_gpio_mapping);
> +		if (ret) {
> +			dev_warn(dev, "Failed to add CS GPIO mapping: %d\n", ret);
> +			return ret;
> +		}
> +
> +		smi->cs_gpio = devm_gpiod_get(dev, "cs", GPIOD_OUT_HIGH);
> +		if (IS_ERR(smi->cs_gpio)) {

Add include.

> +			dev_warn(dev, "Failed to get CS GPIO: %ld\n",
> +				 PTR_ERR(smi->cs_gpio));
> +			smi->cs_gpio = NULL;
> +			return -ENOENT;

Should this pass the error code instead?

> +		}
> +		dev_info(dev, "Acquired CS GPIO for CS%u from ACPI GpioIo[%d]\n",
> +			 cs, quirk->cs_gpio_idx);
> +	}
> +
> +	/*
> +	 * Reallocate the controller's cs_gpiods array to accommodate the
> +	 * new num_chipselect, and install the GPIO descriptor. This is
> +	 * necessary because __spi_add_device() unconditionally reads
> +	 * ctlr->cs_gpiods[cs] to set the device's cs_gpiod.
> +	 */
> +	new_gpiods = devm_kcalloc(&ctlr->dev, ctlr->num_chipselect,
> +				  sizeof(*new_gpiods), GFP_KERNEL);
> +	if (!new_gpiods)
> +		return -ENOMEM;
> +
> +	if (ctlr->cs_gpiods) {
> +		unsigned int i;
> +
> +		for (i = 0; i < cs; i++)
> +			new_gpiods[i] = ctlr->cs_gpiods[i];
> +	}
> +	new_gpiods[cs] = smi->cs_gpio;
> +	ctlr->cs_gpiods = new_gpiods;
> +
> +	/*
> +	 * SPI_CONTROLLER_GPIO_SS ensures the framework calls both the
> +	 * GPIO CS toggle and controller->set_cs(). This is required on
> +	 * Intel LPSS controllers where set_cs handles clock gating.
> +	 */
> +	ctlr->flags |= SPI_CONTROLLER_GPIO_SS;
> +
> +	dev_info(dev, "Installed GPIO CS on controller for CS%u\n", cs);

Normally, the expectation is that success remains silent.

> +	return 0;
> +}
> +
>  /**
>   * smi_spi_probe - Instantiate multiple SPI devices from inst array
>   * @pdev:	Platform device
> @@ -112,10 +258,19 @@ static int smi_spi_probe(struct platform_device *pdev, struct smi *smi,
>  {
>  	struct device *dev = &pdev->dev;
>  	struct acpi_device *adev = ACPI_COMPANION(dev);
> +	const struct dmi_system_id *dmi_id;
> +	const struct smi_cs_gpio_quirk *quirk = NULL;
>  	struct spi_controller *ctlr;
>  	struct spi_device *spi_dev;
>  	char name[50];
>  	int i, ret, count;
> +	u16 cs;
> +
> +	dmi_id = dmi_first_match(smi_cs_gpio_dmi_table);
> +	if (dmi_id) {
> +		quirk = dmi_id->driver_data;
> +		dev_info(dev, "Applying CS GPIO quirk for %s\n", dmi_id->ident);
> +	}
>  
>  	ret = acpi_spi_count_resources(adev);
>  	if (ret < 0)
> @@ -139,6 +294,19 @@ static int smi_spi_probe(struct platform_device *pdev, struct smi *smi,
>  		}
>  
>  		ctlr = spi_dev->controller;
> +		cs = spi_get_chipselect(spi_dev, 0);
> +
> +		/*
> +		 * On quirked platforms, fix up the chip select GPIO for
> +		 * devices that would otherwise fail due to incomplete
> +		 * ACPI cs-gpios on the SPI controller.
> +		 */
> +		if (quirk) {
> +			ret = smi_spi_setup_cs_gpio(dev, spi_dev, smi, quirk);
> +			if (ret)
> +				dev_dbg(dev, "CS GPIO setup returned %d for CS%u\n",
> +					ret, cs);
> +		}
>  
>  		strscpy(spi_dev->modalias, inst_array[i].type);
>  
> 

-- 
 i.

