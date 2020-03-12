From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/2] spi: dt-bindings: spi-controller: Fix
 spi-[rt]x-bus-width for slave mode
Date: Thu, 12 Mar 2020 14:17:36 -0500
Message-ID: <20200312191736.GA15869@bogus>
References: <20200306085038.8111-1-geert+renesas@glider.be>
 <20200306085038.8111-3-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200306085038.8111-3-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri,  6 Mar 2020 09:50:38 +0100, Geert Uytterhoeven wrote:
> The descriptions for the spi-rx-bus-width and spi-tx-bus-width
> properties refer to "MISO" and "MOSI", which are not explained in the
> document.  While these abbreviations are fairly common when talking
> about SPI, and thus may not need an explanation, they are not entirely
> correct in this context, as the SPI controller may be used in slave mode
> instead of master mode.
> 
> Fix this by replacing them by "read transfers" resp. "write transfers",
> like is done for the spi-rx-delay-us and spi-tx-delay-us properties.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> ---
> v3:
>   - No changes,
> 
> v2:
>   - New.
> 
> This issue was present in the .txt version of the bindings, too, so
> technically it needs
> Fixes: a8830cb19cfea04e ("spi: Document DT bindings for SPI controllers in slave mode")
> but of course it won't apply to that version.
> ---
>  Documentation/devicetree/bindings/spi/spi-controller.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
