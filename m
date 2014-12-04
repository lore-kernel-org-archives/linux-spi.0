From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: spi-fsl-spi: Return an error code in fsl_spi_do_one_msg()
Date: Thu, 4 Dec 2014 12:12:28 -0200
Message-ID: <CAOMZO5Dfs=+UP=76gzG1LisoWAZaYALxmXg0N+evTVCkFhSs5Q@mail.gmail.com>
References: <1417698947-4273-1-git-send-email-fabio.estevam@freescale.com>
	<CAFSsGVv5=gJ2t-sWwTGqDcWaaYVU7o6VqZEL4mvxgohkkvBxmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFSsGVv5=gJ2t-sWwTGqDcWaaYVU7o6VqZEL4mvxgohkkvBxmw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Dec 4, 2014 at 11:25 AM, Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Right, missed that. However the code was bogus before, the status = -EINVAL
> didn't make sense as the value of variable status isn't used before the
> return.
> Therefore we can remove the "status = -EINVAL".

Yes, I noticed that as well.

> Shall I submit a patch or what would be your preferred approach?

Yes, may be it would be better if you could submit a fix for this as
separate patch, after Mark applies this one, so that we avoid
conflicts.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
