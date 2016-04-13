From: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v3] spi: orion.c: Add direct access mode
Date: Wed, 13 Apr 2016 07:30:15 +0200
Message-ID: <570DD967.8010703@denx.de>
References: <1460030811-13787-1-git-send-email-sr@denx.de>
 <20160411105740.GB3351@sirena.org.uk> <570CDF5F.9070106@denx.de>
 <20160412192736.GC14664@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160412192736.GC14664-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 12.04.2016 21:27, Mark Brown wrote:
> On Tue, Apr 12, 2016 at 01:43:27PM +0200, Stefan Roese wrote:
>> On 11.04.2016 12:57, Mark Brown wrote:
>>> On Thu, Apr 07, 2016 at 02:06:51PM +0200, Stefan Roese wrote:

<snip>

>>>> +               spi->direct_access[cs].vaddr = devm_ioremap_resource(&pdev->dev,
>>>> +                                                                    r);
>>>> +               if (IS_ERR(spi->direct_access[cs].vaddr)) {
>
>>> I seem to be missing where we configure the hardware to connect the
>>> windows to the chip selects.  We just seem to map the windows but never
>>> otherwise interact with the hardware.
>
>> The connection between the CS and the window is done in the DT. All
>> is now implemented as Arnd has suggested:
>
> Writing something in the DT won't magically configure anything in the
> hardware which is (as I said) the bit I'm missing.

The MBus driver (drivers/bus/mvebu-mbus.c) takes care of the MBus
window mapping. This is done, if the board dts files has one (or
multiple) entries for the SPI device(s) added to the 'ranges'
property of the 'soc' node.

This is the common method to map such windows. So no new code and
no new bindings are needed for this to work.

Thanks,
Stefan

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
