From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH spi/for-next] spi: sh-msiof: Add R-Car Gen 2 and 3
 fallback bindings
Date: Tue, 20 Dec 2016 11:21:31 +0100
Message-ID: <20161220102131.GI19532@verge.net.au>
References: <1481536175-17238-1-git-send-email-horms+renesas@verge.net.au>
 <20161214173811.iporb5qqulmndvg3@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161214173811.iporb5qqulmndvg3-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Dec 14, 2016 at 05:38:11PM +0000, Mark Brown wrote:
> On Mon, Dec 12, 2016 at 10:49:35AM +0100, Simon Horman wrote:
> 
> > +	{ .compatible = "renesas,sh-msiof",        .data = &sh_data }, // Deprecated
> 
> C++ style comment here, please send a followup fixing this.

Thanks, done.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
