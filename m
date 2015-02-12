From: =?UTF-8?Q?aur=C3=A9lien_bouin?= <a.bouin@gmail.com>
Subject: Re: [PATCH 2/4] spi: imx: checkpatch cleanup
Date: Thu, 12 Feb 2015 14:03:45 +0100
Message-ID: <CAFeThoBqepd8WO4=zqxc2H3SQ+XgbgKATwCO=n3W3B0dpwR9Rw@mail.gmail.com>
References: <1423742848-15369-1-git-send-email-a.bouin@gmail.com>
	<1423742848-15369-2-git-send-email-a.bouin@gmail.com>
	<1423744938.15343.29.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: broonie <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	linux-spi <linux-spi@vger.kernel.org>,
	linux-kernel@vger.kernel.org
To: Joe Perches <joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423744938.15343.29.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello,
It does not change readability ... Often breaks are in functions parameters ...
Up to you

2015-02-12 13:42 GMT+01:00 Joe Perches <joe@perches.com>:
>
> On Thu, 2015-02-12 at 13:07 +0100, Aurelien BOUIN wrote:
> > This patch solve various issue detected by checkpatch.pl
>
> trivia:
>
> > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> []
> > @@ -282,7 +282,8 @@ static unsigned int mx51_ecspi_clkdiv(unsigned int fin, unsigned int fspi,
> >               (post << MX51_ECSPI_CTRL_POSTDIV_OFFSET);
> >  }
> >
> > -static void __maybe_unused mx51_ecspi_intctrl(struct spi_imx_data *spi_imx, int enable)
> > +static void __maybe_unused mx51_ecspi_intctrl(struct spi_imx_data *spi_imx,
> > +             int enable)
>
> Perhaps it'd be better to use this style:
>
> __maybe_unused
> static void foo(...)
>
> ie:
>
> __maybe_unused
> static void mx51_ecspi_intctrl(struct spi_imx_data *spi_imx, int enable)
>
> etc..
>
