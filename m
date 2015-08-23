From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/4 RESEND v2] spi: s3c64xx: extend driver to make full
 use of runtime PM autosuspend
Date: Sun, 23 Aug 2015 12:39:37 +0900
Message-ID: <55D94079.6000307@samsung.com>
References: <55D76003.8070608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55D76003.8070608-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

W dniu 22.08.2015 o 02:29, Heiner Kallweit pisze:
> Extend the driver to make full use of runtime PM autosuspend.
> Before only the SPI core was instructed to use autosuspend
> by setting master->auto_runtime_pm. Nevertheless due to the missing
> pm_runtime_use_autosuspend call autosuspend wasn't active.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> Changed:
> - Let driver autosuspend also after leaving s3c64xx_spi_setup
> - Enable runtime PM earlier in s3c64xx_spi_probe and prevent
>   suspending in the relevant part of probe
> v2:
> - Don't init runtime PM before the driver has a reference to the clocks
> 
>  drivers/spi/spi-s3c64xx.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)

Looks good to me now:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Best regards,
Krzysztof



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
