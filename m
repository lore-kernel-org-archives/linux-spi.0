From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/4] spi: imx: checkpatch cleanup
Date: Thu, 12 Feb 2015 09:44:38 -0800
Message-ID: <1423763078.15343.32.camel@perches.com>
References: <1423742848-15369-1-git-send-email-a.bouin@gmail.com>
	 <1423742848-15369-2-git-send-email-a.bouin@gmail.com>
	 <1423744938.15343.29.camel@perches.com>
	 <CAFeThoBqepd8WO4=zqxc2H3SQ+XgbgKATwCO=n3W3B0dpwR9Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: broonie <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?aur=E9lien?= bouin <a.bouin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFeThoBqepd8WO4=zqxc2H3SQ+XgbgKATwCO=n3W3B0dpwR9Rw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, 2015-02-12 at 14:03 +0100, aur=E9lien bouin wrote:
> Hello,

Rehi

> It does not change readability ... Often breaks are in functions para=
meters ...

[please don't top post, more below]

> > > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> > []
> > > @@ -282,7 +282,8 @@ static unsigned int mx51_ecspi_clkdiv(unsigne=
d int fin, unsigned int fspi,
[]
> > > -static void __maybe_unused mx51_ecspi_intctrl(struct spi_imx_dat=
a *spi_imx, int enable)
> > > +static void __maybe_unused mx51_ecspi_intctrl(struct spi_imx_dat=
a *spi_imx,
> > > +             int enable)
> > Perhaps it'd be better to use this style:
> > __maybe_unused
> > static void foo(...)
> > ie:
> > __maybe_unused
> > static void mx51_ecspi_intctrl(struct spi_imx_data *spi_imx, int en=
able)

It's not the break in the function parameters that
matters much, it's the more difficult mechanism to
find the function itself.

typical is:

[static] [const] <type> <function>(params...)

inserting <attribute> between <type> and <function>
breaks that pattern and can make it harder for
less comprehensive code parsers to identify the
function names.


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
