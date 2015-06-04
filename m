From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: pxa2xx: Differentiate Intel LPSS types
Date: Thu, 04 Jun 2015 16:54:50 +0300
Message-ID: <557058AA.8020802@linux.intel.com>
References: <1433328587-20797-1-git-send-email-jarkko.nikula@linux.intel.com> <20150603121135.GH14071@sirena.org.uk> <556F0A34.9010506@linux.intel.com> <20150603143909.GM14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150603143909.GM14071-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 06/03/2015 05:39 PM, Mark Brown wrote:
> On Wed, Jun 03, 2015 at 05:07:48PM +0300, Jarkko Nikula wrote:
>> On 06/03/2015 03:11 PM, Mark Brown wrote:
>
>> My idea to detect these newer platforms and set the type accordingly is to
>> check does the device have named resource "lpss_priv" in a code snip below
>
>> @@ -1299,6 +1319,13 @@ pxa2xx_spi_acpi_get_pdata(struct platform_device
>> *pdev)
>>   	if (IS_ERR(ssp->mmio_base))
>>   		return NULL;
>>
>> +	if (platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpss_priv")) {
>> +		type = LPSS_SPT_SSP;
>> +		pdata->tx_param = pdev->dev.parent;
>> +		pdata->rx_param = pdev->dev.parent;
>> +		pdata->dma_filter = pxa2xx_spi_idma_filter;
>> +	}
>> +
>
> Why not just pass some platform data?  The above seems like it's abusing
> the API a bit and might upset generic code.
>
I wanted to avoid that in order to keep MFD patch set and SPI changes 
independent from each other from both build and runtime. It would also 
need some code arrangements between pxa2xx_spi_probe() and 
pxa2xx_spi_acpi_get_pdata() but that's a minor reason.

Of course relying on "lpss_priv" is not fully future proof either but it 
looks platform after Sunrisepoint won't need any extra type but just 
looking at differences from device registers.

>>   	ssp->clk = devm_clk_get(&pdev->dev, NULL);
>>   	ssp->irq = platform_get_irq(pdev, 0);
>>   	ssp->type = type;
>
>> That made me thinking can I set the type to LPSS_SPT_SSP and needed DMA
>> filter directly when acpi_match_device() returns NULL. At quick look it
>> seems no any other platform device case than our new MFD registration enters
>> here but have to look at more carefully.
>
> That might work too, checking for DT as well would help defensiveness
> though you'd have to watch out for board file registraitons too since
> I'm not sure all the PXA platforms were DTified.  Or just register the
> device with a different ID and use that?
>
Looks like all users are arch/arm/mach-pxa/ board files (no ACPI 
handle), PCI enumarated that set platform data in pxa2xx_spi_pci_probe() 
and ACPI matched devices in pxa2xx_spi_acpi_match[] (no platform data).

Messing with device ID doesn't look clear either as we need to match the 
clock name and it's more clear to keep the host controller and DMA 
instance IDs the same.

I realized I really need to handle NULL from acpi_match_device() in this 
patch. Assuming our MFD set is in the tree before adding the SPI 
Sunrisepoint support. Then code gets through the ACPI_HANDLE() test in 
pxa2xx_spi_acpi_get_pdata() (no platform data but ACPI companion is set 
by the MFD core) and goes setting the enable_dma flag for instance.

This is not fatal but pxa2xx_spi_dma_setup() picks up then the any first 
available DMA channel because DMA filter function is not in place. It 
obviously won't work since SPI is hard-wired to its integrated DMA so 
transfers will be halted.

I'll send version 2 in a minute.

-- 
Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
