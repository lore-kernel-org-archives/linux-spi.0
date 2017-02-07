From: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: s3c64xx: fix inconsistency between binding and
 driver
Date: Tue, 7 Feb 2017 22:33:36 +0200
Message-ID: <20170207203336.3oetygxh4eofqlml@kozik-lap>
References: <CGME20170207080820epcas5p3a680e8126abf88d53106b23c3aab9958@epcas5p3.samsung.com>
 <20170207080748.9524-1-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
        linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
To: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170207080748.9524-1-andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Feb 07, 2017 at 05:07:48PM +0900, Andi Shyti wrote:
> Commit a92e7c3d82a1 ("spi: s3c64xx: consider the case when the CS
> line is not connected") introduced an inconsistency between the
> binding where the disconnected CS line was marked as
> 'no-cs-readback' while the driver was erroneously checking for
> 'broken-cs'.

Please describe in one sentence the visible output of this error to
justify backporting and then:
Fixes: a92e7c3d82a1 ("spi: s3c64xx: consider the case when the CS line is not connected")
Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Reviewed-by: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Best regards,
Krzysztof

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
