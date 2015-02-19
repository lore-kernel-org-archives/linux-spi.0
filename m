From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] spi: sirf: add reset controller dependency
Date: Thu, 19 Feb 2015 16:01:29 +0100
Message-ID: <7767301.zaEX63gvjp@wuerfel>
References: <4553005.HBquOfbqXe@wuerfel> <20150219094155.GA3198@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150219094155.GA3198-bheZrs9scGb3/WHNxyQH9YN0K6Il/+VY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thursday 19 February 2015 18:41:55 Mark Brown wrote:
> On Wed, Feb 18, 2015 at 04:29:10PM +0100, Arnd Bergmann wrote:
> 
> > The adds a dependency in Kconfig to prevent it from being selected
> > if the resets are not available.
> 
> Why is this a better fix than making the reset controller API stub
> itself out?  It's probably not such a big deal here but for devices that
> could be integrated into SoCs with and without reset controllers it
> seems like we might want that.

I would prefer that too, but it's not what the reset maintainer decided
to have, citing b424080a9e0 ("reset: Add optional resets and stubs"):
    
    This patch adds device_reset_optional and (devm_)reset_control_get_optional
    variants that drivers can use to indicate they can function without control
    over the reset line. For those functions, stubs are added so the drivers can
    be compiled with CONFIG_RESET_CONTROLLER disabled.
    Also, device_reset is annotated with __must_check. Drivers ignoring the return
    value should use device_reset_optional instead.
    
    Signed-off-by: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
    Reviewed-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
    Reviewed-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
    Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

So the stubs are provided for all functions except device_reset() and
reset_control_get(), and drivers using the API need to either call the
stubbed-out _optional() versions of these functions or have the explicit
dependency.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
