From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH v2 1/2] spi: core: Use %zu for printing 'size_t' type
Date: Wed, 17 Feb 2016 19:23:18 +0100
Message-ID: <190FF4EA-35D3-498F-8153-C8A153E557E0@martin.sperl.org>
References: <1455730948-24938-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org
To: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455730948-24938-1-git-send-email-fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 17.02.2016, at 18:42, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org> wrote:
> 
> Use %zu for printing 'size_t' type in order to fix the following
> build warning on ARM64:
> 
> drivers/spi/spi.c: In function '__spi_split_transfer_maxsize':
> drivers/spi/spi.c:2278:2: warning: format '%i' expects argument of type 'int', but argument 4 has type 'size_t' [-Wformat=]
> 
> Signed-off-by: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
> Acked-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

Thanks, was busy with other stuff and thus could not 
create a patch myself.

Acked-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
