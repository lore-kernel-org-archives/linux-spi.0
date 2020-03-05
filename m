From: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 07/12] spi: Do spi_take_timestamp_pre for as many times as necessary
Date: Thu, 5 Mar 2020 15:13:53 +0200
Message-ID: <CA+h21hrSe-jT_R9jCW1XA6aZ=vjMX=b7HLq3KJdfxi9OOFW5ag@mail.gmail.com>
References: <20200304220044.11193-1-olteanv@gmail.com> <20200304220044.11193-8-olteanv@gmail.com>
 <20200305121202.GB4046@sirena.org.uk> <CA+h21hq8c50AjuzgpxyPQDCFiAdezJuqgY0+u26qBRx9FnYnig@mail.gmail.com>
 <20200305130448.GC4046@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Esben Haabendal <eha-/iRVSOupHO4@public.gmane.org>, angelo-BIYBQhTR83Y@public.gmane.org,
        andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        "Gustavo A. R. Silva" <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>,
        Wei Chen <weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mohamed Hosny <mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200305130448.GC4046-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, 5 Mar 2020 at 15:04, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
> On Thu, Mar 05, 2020 at 03:00:22PM +0200, Vladimir Oltean wrote:
> > On Thu, 5 Mar 2020 at 14:12, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
> > > This is a fix and so should have been at the start of the series to make
> > > sure there aren't any dependencies.
>
> > My reasoning for not submitting it as a fix is:
> > - The only driver that uses the functionality so far - spi-fsl-dspi -
> > has worked thus far even with the limitation that only byte-by-byte
> > transfers were supported properly.
> > - I removed the limitation before actually changing the operating mode
> > of spi-fsl-dspi. Therefore the limitation is effectively never seen.
> > - New SPI drivers that would want to make use of software timestamping
> > would do so through your SPI for-next branch anyway, where the
> > limitation would be, again, fixed.
>
> That's mostly all true but it's still better to pull fixes like this (or
> the patch limiting the size) forwards and not have to think if it's safe
> to not apply them as a fix, it's less effort all round.

So do you want me to do something about it now?
