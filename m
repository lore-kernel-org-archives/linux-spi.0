From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi-imx: Add loopback mode support
Date: Sun, 6 Dec 2015 17:34:59 -0200
Message-ID: <CAOMZO5Ar3mqfmE94vuiWvveuby6SNV2=Ss5o8cdCmLEYrnVZhA@mail.gmail.com>
References: <1449192204-24877-1-git-send-email-festevam@gmail.com>
	<CAOMZO5AejRorUv6TKH90t-VpsSGd6NiH9cCTJC5-QuMpiGPOPw@mail.gmail.com>
	<20151206112407.GK5727@sirena.org.uk>
	<CAOMZO5BrOgOvupBXRcK=iLYmbViKMjQE6xYi6HwU71Twjt2O0A@mail.gmail.com>
	<56647929.4060202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56647929.4060202-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Anton,

On Sun, Dec 6, 2015 at 4:06 PM, Anton Bondarenko
<anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

>
> There is a small problem with this change. Loopback mode not enabled for
> first transaction in the system. This is happen because TEST reg written
> before controller taken out from the reset by writing to CTRL reg. The
> simple fix will be to move TEST reg read/write after write to CTRL reg.

Could you please fix this as part of your series?

Thanks
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
