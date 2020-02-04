From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 2/2] spi: Add generic SPI multiplexer
Date: Tue, 4 Feb 2020 13:07:48 +0200
Message-ID: <CAHp75VdRYDrTeBy9+TbbE8y3jt_Fntr6fnXon3CuqCZFYQ7Maw@mail.gmail.com>
References: <20200131023433.12133-1-chris.packham@alliedtelesis.co.nz>
 <20200131023433.12133-3-chris.packham@alliedtelesis.co.nz>
 <CAHp75VfT=KNM6J1bP5cPsLw7Z776opcB9Kf6qhNCZukY-7g=pQ@mail.gmail.com> <86509a5e6656c4f560ee6f6514ab00a232994957.camel@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <86509a5e6656c4f560ee6f6514ab00a232994957.camel-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Feb 3, 2020 at 11:12 PM Chris Packham
<Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org> wrote:
> On Mon, 2020-02-03 at 11:50 +0200, Andy Shevchenko wrote:

...

> > > +       priv->mux = devm_mux_control_get(&spi->dev, NULL);
> > > +       ret = PTR_ERR_OR_ZERO(priv->mux);
> >
> > This is a bit complicated.
> >
> > > +       if (ret) {
> >
> > Why not simple do
> >
> >   if (IS_ERR(priv->mux)) {
> >     ret = PTR_ERR(...);
> >     ...
> >   }
> >
> > ?
>
> I've had other maintainers/reviewers suggest the opposite for patches
> I've submitted to other subsystems which is why I went with
> PTR_ERR_OR_ZERO. It also works well with the goto err_put_ctlr; which
> needs ret to be set. It's not exactly a common pattern in the spi code
> so I'd be happy to go the other way if that's the desired convention
> for spi.

Either way is the same amount of lines. The slight difference, that we
don't check for 0. Can you check if generated code is different in
these cases?

-- 
With Best Regards,
Andy Shevchenko
