From: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Subject: Re: [PATCH] ARM: mvebu: use improved armada spi device tree
 compatible name
Date: Tue, 9 Sep 2014 12:00:43 -0400
Message-ID: <20140909160043.GP30828@titan.lakedaemon.net>
References: <1410147029-30067-1-git-send-email-gerg@uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410147029-30067-1-git-send-email-gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Sep 08, 2014 at 01:30:29PM +1000, gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org wrote:
> From: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
> 
> Switch the Armada SoC SPI port device tree binding to use the new improved
> armada-370-spi compatible name. This allows for a wider range of baud rates
> to be used.
> 
> Signed-off-by: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
> Tested-by: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Reviewed-by: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to mvebu/dt.

thx,

Jason.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
