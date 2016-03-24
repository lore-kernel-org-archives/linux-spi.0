From: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v2] spi: orion.c: Add direct access mode
Date: Thu, 24 Mar 2016 13:05:29 +0100
Message-ID: <56F3D809.5060803@denx.de>
References: <20160322173546.40d24cc2@free-electrons.com>
 <56F17684.2010307@denx.de> <20160323113316.GH2566@sirena.org.uk>
 <56F2852C.5010006@denx.de> <20160323125448.GM2566@sirena.org.uk>
 <56F295E1.4030505@denx.de> <20160323132732.GN2566@sirena.org.uk>
 <56F2D19A.7020604@denx.de> <20160323183952.GK5250@lunn.ch>
 <56F37EFF.2090605@denx.de> <20160324112308.GY2566@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
	Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160324112308.GY2566-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 24.03.2016 12:23, Mark Brown wrote:
> On Thu, Mar 24, 2016 at 06:45:35AM +0100, Stefan Roese wrote:
> 
>> Right. It is of course possible to use this direct mode to access
>> SPI flash. Its just not the way how the SPI MTD driver uses the
>> SPI controller. All information that is written to the SPI flash
>> (e.g. commands, addresses) are passed as plain tx-data in the SPI
>> message to the SPI controller. And it would be not easy to detect
>> commands / addresses vs. "real data" in this orion SPI driver
>> to put these values into the specific registers.
> 
> We now have extensions for passing commands through directly (see
> spi_flash_read()).

Interesting. So this direct access mode can be used to interface
with SPI flash using these extensions. Great.

But I hope that its not a requirement that I add this SPI flash
support (via direct access mode) to the orion SPI driver to get
this patch accepted. As it really was not the scope of my project.
I can try to get this added later, but I can't make any promises
here. Perhaps someone else finds the time to implement this?

Thanks,
Stefan

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
