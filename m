From: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: s3c64xx: fix potential division by zero
Date: Wed, 08 Feb 2017 13:19:08 +0900
Message-ID: <20170208041908.ncy7vwf4j6cednmj@gangnam.samsung>
References: <20170207081025.9671-1-andi.shyti@samsung.com>
 <CGME20170207081032epcas5p3af837bbe00278da4029fc7bb9eba6961@epcas5p3.samsung.com>
 <20170207081025.9671-2-andi.shyti@samsung.com>
 <20170207204924.4ns7di66fep3fwbi@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
        linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
To: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-disposition: inline
In-reply-to: <20170207204924.4ns7di66fep3fwbi@kozik-lap>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

> > This patch fixes '1397922 Division or modulo by zero' from
> > scan.coverity.com
> 
> It is a false positive.

Yes... sorry for these two spam/patches... they are just fast
after holiday "fixes"... please ignore them.

Andi
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
