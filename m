Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0010387358;
	Mon, 13 Apr 2026 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776080591; cv=none; b=asHu/B/wPte9IhO9s0pEw4IFoYNJgDmHNM7UbHHWsjWzg4RXlnab3y90K8cDjLn/r22D2VJXYDT7F3Aud4ZDaRScnnUmQ7bSFVdKCQ110oV2vYTmq2Dgf0lnDHJD918snvUMF0ZMOQXJ0HZzqPQd4gfCVdoSDDEihaIEIQ58bLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776080591; c=relaxed/simple;
	bh=ZNB7Sj5Z+IYgSQ+eeEMz9TwwUsIMOzWLV564POVgQDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwJRNXnRca68KB+Ggi46sfkoGQzAv26OkjRlF+3UAcpyojIzuxems6frJwnsDSU86qbDksNqIaEvRC/UOBBcG6kbG25LNRgxXQRLV4/ewGrwB3UiClO9FT6U7W87HjelbySyv1kKn7A9crKTVSADa1LNvTGXwzZ9kptzsQBeVWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdmMNh+U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdmMNh+U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8F0C116C6;
	Mon, 13 Apr 2026 11:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776080591;
	bh=ZNB7Sj5Z+IYgSQ+eeEMz9TwwUsIMOzWLV564POVgQDQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rdmMNh+UE+17n1lM8Bx6PXnnkhto7MPdY+CY15yxmypvWtYB7glgiD/YA3t5aYbpV
	 ZBKK0mzFbGWAwLQoyleoFbILnxlJzhOqDe5G4ow9zK+p9uNkC+GGW8Bs6miz6Ep+ED
	 3pzu81WC59Mvb3OqQHs5COuzRvYMmtHVPmKsSknKVP3pddXWzcy+wM7kADZRK/MP5N
	 0J27iSUr7sPC0P+a9zbGc1U8w0r5yMG2AfJNLSAsKnVpJPsMHCHbjQ8Kh3x5IVOUb4
	 XF6g7+ACasdDRKbtCrgHeRPSrmQyEUGovrENDSrvtd7XZjOXDI1eU26Gb5wEiCkdc3
	 xlKYWalhygOvw==
Message-ID: <6af0a67a-c028-45c5-b514-52570ecfcc68@kernel.org>
Date: Mon, 13 Apr 2026 13:43:06 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] platform/x86: serial-multi-instantiate: Fix SPI
 chip select on platforms with incomplete ACPI cs-gpios
To: Khalil <khalilst@gmail.com>, broonie@kernel.org,
 ilpo.jarvinen@linux.intel.com
Cc: rf@opensource.cirrus.com, linux-spi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Khalil <khalil@rentman.nl>
References: <20260413100530.580649-1-khalil@rentman.nl>
 <20260413100530.580649-3-khalil@rentman.nl>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260413100530.580649-3-khalil@rentman.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 13-Apr-26 12:05 PM, Khalil wrote:
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
> +	},
> +	{ }
> +};

Do we really need a DMI quirk here? I would expect on existing models
there already is a cs for both amplifiers and the "if (cs < ctlr->num_chipselect)"
+ early return 0 will trigger so this will be a no-op there.

Can't you just enable this through a flag in smi_instance.flags and drop
the DMI quirk?


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

I'm confused here you say that the chip-select for the second amplifier
is missing, but I would expect that to be the GpioIo resource at index 1
not 0?

I would expect the GpioIo resource at index 0 to be for the first
amplifier which does have a GPIO already in the _DSD cs-gpios property ?

Since this is a multi-serial device ACPI node, there is only one
set of resources for both amplifiers (with their also being 2 SPI
resources in the _CRS list).

So I would expect there to also be multiple GPIO entries in the
_CRS list, with the order of the chip-selects GPIOs resources matching
the order of the SPI resources.



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
> +		 ctlr->num_chipselect, cs + 1, cs);
> +	ctlr->num_chipselect = cs + 1;
> +
> +	/* Acquire the CS GPIO from the ACPI GpioIo resource if not yet done */
> +	if (!smi->cs_gpio) {

I'm confused shouldn't the gpio be a per spi_device thing not something
which you lookup only once. What if neither amplifier has a cs GPIO in
the _DSD should this then not do 2 lookups:

1. For the first spi_dev (using the first SPI resource in the _CRS list)
   lookup the first GPIO resources in the _CRS list 
2. For the second spi_dev lookup the second GPIO resources in the _CRS list 

?


> +		int ret;
> +
> +		ret = devm_acpi_dev_add_driver_gpios(dev, smi_cs_gpio_mapping);
> +		if (ret) {
> +			dev_warn(dev, "Failed to add CS GPIO mapping: %d\n", ret);
> +			return ret;
> +		}

So here I think you should dynamically fill the lookup using the index of
the spi_dev ('i' in the caller of this function) to fill in the offset of
the GPIO resource which should be looked up.

You can dynamically fill a local lookup and then non devm register the GPIO
lookup + remove it after the devm_gpiod_get() call.


> +
> +		smi->cs_gpio = devm_gpiod_get(dev, "cs", GPIOD_OUT_HIGH);
> +		if (IS_ERR(smi->cs_gpio)) {
> +			dev_warn(dev, "Failed to get CS GPIO: %ld\n",
> +				 PTR_ERR(smi->cs_gpio));
> +			smi->cs_gpio = NULL;
> +			return -ENOENT;
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

Regards,

Hans


