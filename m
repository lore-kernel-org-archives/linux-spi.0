From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH v6 2/4] spi: bcm2835: add bcm2835 auxiliary spi device
 driver
Date: Tue, 6 Oct 2015 13:38:10 +0200
Message-ID: <5613B2A2.9020309@martin.sperl.org>
References: <1441970527-2403-1-git-send-email-kernel@martin.sperl.org>
 <1441970527-2403-3-git-send-email-kernel@martin.sperl.org>
 <20151006112320.GP12635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	eEric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151006112320.GP12635-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 06.10.2015 13:23, Mark Brown wrote:
> On Fri, Sep 11, 2015 at 11:22:04AM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
>
>> +	bs->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
>> +	if (bs->irq <= 0) {
>> +		dev_err(&pdev->dev, "could not get IRQ: %d\n", bs->irq);
>> +		err = bs->irq ? bs->irq : -ENODEV;
>> +		goto out_master_put;
>> +	}
>
> Why are we using this unusual DT specific API here?  I'd expect to see
> just use platform_get_irq() here and this seems to be the only DT
> dependency in the driver.

I copied it from spi-bcm2835.c, where it is also used in exactly that
fashion.

You want me to move to your recommended api instead for both drivers?

>
>> +	err = devm_request_irq(&pdev->dev, bs->irq,
>> +			       bcm2835aux_spi_interrupt,
>> +			       IRQF_SHARED,
>> +			       dev_name(&pdev->dev), master);
>> +	if (err) {
>> +		dev_err(&pdev->dev, "could not request IRQ: %d\n", err);
>> +		goto out_clk_disable;
>> +	}
>> +
>> +	/* reset SPI-HW block */
>> +	bcm2835aux_spi_reset_hw(bs);
>
> I'd expect to request the IRQ after we reset the hardware in order to
> ensure that the hardware is in a known good state

Same copy/paste in this case - i can change the order for both
drivers if you want.

Martin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
