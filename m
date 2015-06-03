From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: pxa2xx: Differentiate Intel LPSS types
Date: Wed, 03 Jun 2015 17:07:48 +0300
Message-ID: <556F0A34.9010506@linux.intel.com>
References: <1433328587-20797-1-git-send-email-jarkko.nikula@linux.intel.com> <20150603121135.GH14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150603121135.GH14071-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 06/03/2015 03:11 PM, Mark Brown wrote:
> On Wed, Jun 03, 2015 at 01:49:45PM +0300, Jarkko Nikula wrote:
>
>>   static bool is_lpss_ssp(const struct driver_data *drv_data)
>>   {
>> -	return drv_data->ssp_type == LPSS_SSP;
>> +	return drv_data->ssp_type == LPSS_LPT_SSP ||
>> +	       drv_data->ssp_type == LPSS_BYT_SSP;
>>   }
>
> switch statement please, it helps scale new types.
>
>> -	switch (drv_data->ssp_type) {
>> -	case QUARK_X1000_SSP:
>> +	if (is_quark_x1000_ssp(drv_data)) {
>>   		tx_thres = TX_THRESH_QUARK_X1000_DFLT;
>>   		tx_hi_thres = 0;
>>   		rx_thres = RX_THRESH_QUARK_X1000_DFLT;
>> -		break;
>> -	case LPSS_SSP:
>> +	} else if (is_lpss_ssp(drv_data)) {
>
> Why are we moving away from a switch statement here?  Half the point of
> using them for variant selection is that it makes it easier to adjust
> the set of cases later.
>
It looked clever to reuse is_lpss_ssp() here. Onto another hand I don't 
see we'll expand a lot LPSS types so I'll keep the swich-case.

>> +	const struct acpi_device_id *id;
>> +	int devid, type = SSP_UNDEFINED;
>
> Don't mix initialisations with other variable declarations please.
>
>>   	if (!ACPI_HANDLE(&pdev->dev) ||
>>   	    acpi_bus_get_device(ACPI_HANDLE(&pdev->dev), &adev))
>>   		return NULL;
>>
>> +	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
>> +	if (id)
>> +		type = (int)id->driver_data;
>
> It'd be a bit clearer if the error case was an else here, though - on
> first read I'd expected to return an error if we couldn't identify the
> device and the initialisation is far enough away to appear in a
> different hunk.
>
Above appears to deserve a comment at least. Code gets here when device 
is either probed using those ACPI IDs in pxa2xx_spi_acpi_match[] or if 
it's registered as an platform device without platform data but with 
ACPI companion being set.

Idea here is to set type from pxa2xx_spi_acpi_match[] only for current 
ACPI probed platforms and let the acpi_match_device() return NULL for 
the latter platform device case.

Upcoming platforms will integrate host controller (SPI, I2C and UART) 
and a dedicated integrated DMA engine into same device with single PCI 
or ACPI ID. Our plan is to register them as a MFD child devices:

http://marc.info/?l=linux-kernel&m=143317013403300&w=2

ACPI companion gets set through the MFD device registration. For 
spi-pxa2xx.c it means probe enters into pxa2xx_spi_acpi_get_pdata() 
because we don't set any platform data and the MMIO, clock and IRQ are 
still set there.

My idea to detect these newer platforms and set the type accordingly is 
to check does the device have named resource "lpss_priv" in a code snip 
below

@@ -1299,6 +1319,13 @@ pxa2xx_spi_acpi_get_pdata(struct platform_device 
*pdev)
  	if (IS_ERR(ssp->mmio_base))
  		return NULL;

+	if (platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpss_priv")) {
+		type = LPSS_SPT_SSP;
+		pdata->tx_param = pdev->dev.parent;
+		pdata->rx_param = pdev->dev.parent;
+		pdata->dma_filter = pxa2xx_spi_idma_filter;
+	}
+
  	ssp->clk = devm_clk_get(&pdev->dev, NULL);
  	ssp->irq = platform_get_irq(pdev, 0);
  	ssp->type = type;

That made me thinking can I set the type to LPSS_SPT_SSP and needed DMA 
filter directly when acpi_match_device() returns NULL. At quick look it 
seems no any other platform device case than our new MFD registration 
enters here but have to look at more carefully.

-- 
Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
