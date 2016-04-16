From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v3] spi: orion.c: Add direct access mode
Date: Sat, 16 Apr 2016 22:06:50 +0200
Message-ID: <10734204.V6uBDOOZ6M@wuerfel>
References: <1460030811-13787-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460030811-13787-1-git-send-email-sr-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thursday 07 April 2016 14:06:51 Stefan Roese wrote:
> v3:
> - Used static MBus windows again, as suggested by Arnd
> - No new DT bindings needed for this. The MBus windows need to be
>   configured in the 'reg' property of the SPI controller. This is
>   done in a separate patch for the Armada platforms.
> - The direct mapping is configured and enable by adding the
>   specific MBus entry to the 'ranges' property of the 'soc' node
>   in the board dts file.

The new approach looks good to me, thanks!

As Mark pointed out, you still need to document the fact that
the SPI controller can now have additional entries in its 'reg'
property, and it would be nice to reference the mbus binding
from the spi controller binding as a help for people that
want to enable the direct mode.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
