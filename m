From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v3 2/2] spi: Introduce new driver for Qualcomm QuadSPI controller
Date: Fri, 28 Sep 2018 17:45:25 -0700
Message-ID: <153818192522.119890.9441387074333006354@swboyd.mtv.corp.google.com>
References: <20180926205204.184898-1-ryandcase@chromium.org>
 <20180926205204.184898-2-ryandcase@chromium.org>
 <153803059441.119890.891880266219521584@swboyd.mtv.corp.google.com>
 <CACjz--=Qj8Jd9yCvox1MGh1PFkHAzpt1L0OwPkMhtV30_jCDWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Mark Brown <broonie@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Trent Piepho <tpiepho@impinj.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Ryan Case <ryandcase@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACjz--=Qj8Jd9yCvox1MGh1PFkHAzpt1L0OwPkMhtV30_jCDWA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Quoting Ryan Case (2018-09-28 11:19:51)
> On Wed, Sep 26, 2018 at 11:43 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > Quoting Ryan Case (2018-09-26 13:52:04)
> > > From: Girish Mahadevan <girishm@codeaurora.org>
> > > +#include <asm/unaligned.h>
> > > +
> > > +#define AHB_MIN_HZ             9600000UL
> >
> > Is this used?
> =

> Nope. Do you want all currently unused defines removed or specifically th=
is
> one? I saw precedent in other drivers for defining registers/flags/values=
 of
> supported but unused functionality so I left these (big endian, DDR, ...).

I guess it's fine but I don't know if it will ever be used so remove it?
I'd leave the others if they help someone know what register bits exist.
That's usually how I handle it.

> =

> =

> > > +       speed_hz =3D slv->max_speed_hz;
> > > +       if (xfer->speed_hz)
> > > +               speed_hz =3D xfer->speed_hz;
> > > +
> > > +       ret =3D clk_set_rate(ctrl->clks[QSPI_CLK_CORE].clk, speed_hz =
* 4);
> >
> > Why 4? Is that related to the number of wires?
> =

> In normal operation the core clock should be running at 4x the rate of the
> transfer clock regardless of number of wires used.

Ok. Maybe add a comment so we understand that.

> =

> > > +                       put_unaligned(rd_fifo, word_buf++);
> > > +               }
> > > +               ctrl->xfer.rx_buf =3D word_buf;
> > > +       }
> > > +
> > > +       if (bytes_to_read) {
> > > +               byte_buf =3D ctrl->xfer.rx_buf;
> >
> > Does this need to move forward by words_to_read bytes so that the left
> > over bytes are tacked onto the end? Or this should be an else if
> > statement?
> =

> When the words block completes it updates the rx_buf location so it is al=
ready
> at the correct offset for bytes.
> =


Ok I see. Subtle!
