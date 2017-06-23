From: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Subject: Re: Applied "spi: atmel: fix corrupted data issue on SAM9 family
 SoCs" to the spi tree
Date: Fri, 23 Jun 2017 18:18:30 +0100
Message-ID: <20170623171830.GV4902@n2100.armlinux.org.uk>
References: <d174da00f48503eba84dd0f4068749b968628bbb.1498231873.git.cyrille.pitchen@microchip.com>
 <E1dORFW-00037E-N8@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Cyrille Pitchen <cyrille.pitchen-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1dORFW-00037E-N8@debutante>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Jun 23, 2017 at 05:15:58PM +0100, Mark Brown wrote:
> +#ifdef CONFIG_SOC_SAM_V4_V5
> +	/*
> +	 * Atmel SoCs based on ARM9 (SAM9x) cores should not use spi_map_buf()
> +	 * since this later function tries to map buffers with dma_map_sg()
> +	 * even if they have not been allocated inside DMA-safe areas.
> +	 * On SoCs based on Cortex A5 (SAMA5Dx), it works anyway because for
> +	 * those ARM cores, the data cache follows the PIPT model.
> +	 * Also the L2 cache controller of SAMA5D2 uses the PIPT model too.
> +	 * In case of PIPT caches, there cannot be cache aliases.
> +	 * However on ARM9 cores, the data cache follows the VIVT model, hence
> +	 * the cache aliases issue can occur when buffers are allocated from
> +	 * DMA-unsafe areas, by vmalloc() for instance, where cache coherency is
> +	 * not taken into account or at least not handled completely (cache
> +	 * lines of aliases are not invalidated).

There is a solution to this - code (iow, callers of functions that perform
IO) are expected to use flush_kernel_vmap_range() and
invalidate_kernel_vmap_range() as documented in Documentation/cachetlb.txt
to ensure that their "special" views are properly handled.

These are no-ops for PIPT caches, but aliasing caches have to implement
them.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
