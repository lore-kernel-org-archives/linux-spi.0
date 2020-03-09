From: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/6] spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
Date: Mon, 9 Mar 2020 20:09:44 +0200
Message-ID: <CA+h21hquwbP-qg21EJKW6BpAVRSm0WE6OUWeg-zsorZrCFT=dQ@mail.gmail.com>
References: <20200309145624.10026-1-olteanv@gmail.com> <20200309145624.10026-2-olteanv@gmail.com>
 <c35b3c34123b43b26204a2cf360e7ec1@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Esben Haabendal <eha-/iRVSOupHO4@public.gmane.org>,
        angelo-BIYBQhTR83Y@public.gmane.org, andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        "Gustavo A. R. Silva" <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>,
        Wei Chen <weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mohamed Hosny <mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
        peng.ma-3arQi8VN3Tc@public.gmane.org
To: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c35b3c34123b43b26204a2cf360e7ec1-QKn5cuLxLXY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, 9 Mar 2020 at 20:05, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org> wrote:
>
> Am 2020-03-09 15:56, schrieb Vladimir Oltean:
> > From: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
> >
> > The SPI_MCR_PCSIS macro assumes that the controller has a number of
> > chip
> > select signals equal to 6. That is not always the case, but actually is
> > described through the driver-specific " signals equal to 6. That is not
> > always the case, but actually is described through the driver-specific
> > "spi-num-chipselects" device tree binding.
>
> Repeated sentence? Was this your intention?
>

No, I must have tripped over my vim shortcuts. Sorry.

-Vladimir
