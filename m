From: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH] ARM: mvebu: use improved armada spi device tree compatible
 name
Date: Sun, 28 Sep 2014 23:19:00 +1000
Message-ID: <54280AC4.8010809@uclinux.org>
References: <1410147029-30067-1-git-send-email-gerg@uclinux.org> <20140909160043.GP30828@titan.lakedaemon.net> <20140928114353.GY27755@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140928114353.GY27755-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On 28/09/14 21:43, Mark Brown wrote:
> On Tue, Sep 09, 2014 at 12:00:43PM -0400, Jason Cooper wrote:
>> On Mon, Sep 08, 2014 at 01:30:29PM +1000, gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org wrote:
>>> Switch the Armada SoC SPI port device tree binding to use the new improved
>>> armada-370-spi compatible name. This allows for a wider range of baud rates
>>> to be used.
>> Applied to mvebu/dt.
> Note that the corresponding driver change hasn't been applied (or sent
> to me for review) so this will break users.

It still maintains the compatible "marvell,orion-spi" as well, so its
shouldn't break anyone with only that applied.

I will resend the spi-orion.c change.

Regards
Greg


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
