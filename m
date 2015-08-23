From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 4/4 RESEND v2] spi: s3c64xx: replace clock disabling with
 runtime PM suspend call in remove function
Date: Sun, 23 Aug 2015 12:41:25 +0900
Message-ID: <55D940E5.4030901@samsung.com>
References: <55D7614C.6040309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55D7614C.6040309-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

W dniu 22.08.2015 o 02:35, Heiner Kallweit pisze:
> Simplify s3c64xx_spi_remove by replacing the clock disabling with calling
> runtime PM suspend which does the same.
> Waking up the device if it was suspended wouldn't be strictly needed
> for this driver but using pm_runtime_get_sync is cleaner and makes
> s3c64xx_spi_remove more consistent with the runtime PM handling in
> s3c64xx_spi_setup.
> 
> pm_runtime_force_suspend does most of the work for us:
> disabling the clocks, disabling runtime PM and setting it to
> "suspended" state.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> Changed:
> - Added to the patch set
> v2:
> - Don't use runtime_pm_force_suspend. Technically it works but it's not
>   intuitive as we don't intend to suspend here.
> 
>  drivers/spi/spi-s3c64xx.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Best regards,
Krzysztof


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
