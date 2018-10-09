From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH V5 3/3] spi: spi-geni-qcom: Add SPI driver support for GENI based
 QUP
Date: Tue, 09 Oct 2018 09:12:06 -0700
Message-ID: <153910152600.119890.14820584405992384926@swboyd.mtv.corp.google.com>
References: <1538574265-30235-1-git-send-email-alokc@codeaurora.org>
 <1538574265-30235-4-git-send-email-alokc@codeaurora.org>
 <153904219713.119890.7463642233895152532@swboyd.mtv.corp.google.com>
 <CAD=FV=XnYucy4JmgATrB89RYHTbzRC_GaouaRjHAocD4-H0ncg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: alokc@codeaurora.org, Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>
To: Doug Anderson <dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=XnYucy4JmgATrB89RYHTbzRC_GaouaRjHAocD4-H0ncg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Quoting Doug Anderson (2018-10-08 16:52:36)
> Hi,
> =

> On Mon, Oct 8, 2018 at 4:43 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > +       mas->irq =3D platform_get_irq(pdev, 0);
> > > +       if (mas->irq < 0) {
> > > +               ret =3D mas->irq;
> > > +               dev_err(&pdev->dev, "Err getting IRQ %d\n", ret);
> > > +               goto spi_geni_probe_runtime_disable;
> > > +       }
> >
> > Nitpick: If you got the irq earlier before allocating anything then not=
hing has
> > to be put on failure path.
> =

> I think this might have been in response to previous feedback from you
> suggesting that we should get the irq as late as possible.  Ah, here
> ya go:
> =

> https://lkml.kernel.org/r/153780767551.119890.9339380838620508307@swboyd.=
mtv.corp.google.com

Yes I suggested we register for the irq as last as possible, but I
didn't suggest calling platform_get_irq() this late. It could be called
earlier so that if there isn't any irq then nothing to do besides return
failure.
