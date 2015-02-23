From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] spi: sirf: add reset controller dependency
Date: Mon, 23 Feb 2015 23:01:18 +0100
Message-ID: <6170208.Z0Upu48JrX@wuerfel>
References: <4553005.HBquOfbqXe@wuerfel> <7767301.zaEX63gvjp@wuerfel> <20150221094458.GM6236@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150221094458.GM6236-bheZrs9scGb3/WHNxyQH9YN0K6Il/+VY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Saturday 21 February 2015 18:44:58 Mark Brown wrote:
> On Thu, Feb 19, 2015 at 04:01:29PM +0100, Arnd Bergmann wrote:
> 
> > So the stubs are provided for all functions except device_reset() and
> > reset_control_get(), and drivers using the API need to either call the
> > stubbed-out _optional() versions of these functions or have the explicit
> > dependency.
> 
> In that case a dependency seems wrong, I'd expect to see a select - it's
> a bit obscure to have to grovel around to figure out what magic options
> are needed to make things turn on and resets feel more like a utility
> thing than a control bus (which tend to be the things we depend on).
> Dunno, perhaps I'm wrong?

Mixing 'select' and 'depends on' causes recursive dependencies, and
there are already lots of drivers that do 'depends on RESET_CONTROLLER'.

Most users of this symbol seem to follow the strategy of selecting
RESET_CONTROLLER when a driver is there to provide the functionality,
but depending on it when a driver uses it. We are however a bit
inconsistent here and it would be nice to clean it up.

In this particular patch, I'm just following what others do.

We should probably 'select ARCH_HAS_RESET_CONTROLLER' unconditionally
for ARM ARCH_MULTIPLATFORM, as it's a bit silly to select both
ARCH_HAS_RESET_CONTROLLER and RESET_CONTROLLER from platform code.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
