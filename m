From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi: bcm53xx: (re)license code to the GPL v2
Date: Fri, 30 Dec 2016 10:48:23 +0800
Message-ID: <CAFRkauBBRrC7tk3nRB129dnhucjJP-UmGBwfzJqpzq4W7w-=ag@mail.gmail.com>
References: <20161229191313.21577-1-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Vaishali Thakkar <vthakkar1994-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>,
        Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>,
        Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161229191313.21577-1-zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2016-12-30 3:13 GMT+08:00 Rafa=C5=82 Mi=C5=82ecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> From: Rafa=C5=82 Mi=C5=82ecki <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
>
> My intention was to release this code under GPL v2 license. For some
> reason my initial commit 0fc6a323e191 ("spi: bcm53xx: driver for SPI
> controller on Broadcom bcma SoC") totally missed licensing info.
> MODULE_LICENSE was later added by Axel specifying "GNU Public License
> v2 or later".
>
> This patch clarifies situation by adding a proper header (with Copyright
> line) and adjusting MODULE_LICENSE. It should be acked by every driver
> contributor.
>
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
> ---
> Guys, can I have your Acked-by for this patch, please?
>
> Vaishali: you are author of commit 6774eea6d7a6 ("spi: bcm53xx: Adjust
> devm usage")
>
> Joe: you are author of commit f7219b527b57 ("treewide: Remove
> unnecessary BCMA_CORETABLE_END macro")
>
> Nicholas: you are author of commit b3e7766bc459 ("spi: bcm53xx: use
> msecs_to_jiffies for conversion")
>
> Axel: you are author of commit 61d38b9a823c ("spi: bcm53xx: Add missing
> module information")

Acked-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
