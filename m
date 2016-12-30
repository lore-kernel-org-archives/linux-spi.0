From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: bcm53xx: (re)license code to the GPL v2
Date: Fri, 30 Dec 2016 09:08:30 +0100
Message-ID: <CACna6ryPsJgS3595rtbPJNSZVWp9SddgtFZ=dwc4OCKNuucEAQ@mail.gmail.com>
References: <20161229191313.21577-1-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Vaishali Thakkar <vthakkar1994-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>,
        Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>,
        Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>,
        Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161229191313.21577-1-zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 29 December 2016 at 20:13, Rafa=C5=82 Mi=C5=82ecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wr=
ote:
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

Hi Mark,

For some reason patchwork missed Han's reply:
https://patchwork.kernel.org/patch/9491361/
but all other ones are there.

Could you get patch as mbox from patchwork:
https://patchwork.kernel.org/patch/9491361/mbox/
and add Han's "Acked-by" manually?

This would give you a patch acked by every contributor which should be
enough to push is safely/legally.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
