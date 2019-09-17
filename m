From: Aurabindo Jayamohanan <mail@aurabindo.in>
Subject: Re: [PATCH] spi: sifive: check return value for platform_get_resource()
Date: Tue, 17 Sep 2019 09:58:13 +0000
Message-ID: <7kLa83nF-ufh-AGA_LpBQ6M-ErUf-LEVXANxL2LmirJAh-snvVtJLTVFkBKFxaHvIH9Vi1E3iXDmxW6Ijktoo6k1S7pyFrwmVVLkhKr4Q_Q=@aurabindo.in>
References: <20190917085627.4562-1-mail@aurabindo.in>
 <CAMz4kuJczzjTPSohQ=kbZ0Pr7U_9-hzXk-jPgKk79PENOM1-dA@mail.gmail.com>
Reply-To: Aurabindo Jayamohanan <mail@aurabindo.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Mark Brown <broonie@kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMz4kuJczzjTPSohQ=kbZ0Pr7U_9-hzXk-jPgKk79PENOM1-dA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Tuesday, September 17, 2019 2:53 PM, Baolin Wang <baolin.wang@linaro.org=
> wrote:

> On Tue, 17 Sep 2019 at 17:12, Aurabindo Jayamohanan mail@aurabindo.in wro=
te:
>
> > platform_get_resource() may return NULL. If it is so, return -ENXIO
> >
> > Signed-off-by: Aurabindo Jayamohanan mail@aurabindo.in
> >
> > -------------------------------------------------------
> >
> > drivers/spi/spi-sifive.c | 6 ++++++
> > 1 file changed, 6 insertions(+)
> > diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
> > index 93ec2c6cdbfd..67485067a694 100644
> > --- a/drivers/spi/spi-sifive.c
> > +++ b/drivers/spi/spi-sifive.c
> > @@ -308,6 +308,12 @@ static int sifive_spi_probe(struct platform_device=
 *pdev)
> > platform_set_drvdata(pdev, master);
> >
> >         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >
> >
> > -         if (!res) {
> >
> >
> > -                 dev_err(&pdev->dev, "no IOMEM resource found\\n");
> >
> >
> > -                 ret =3D -ENXIO;
> >
> >
> > -                 goto put_master;
> >
> >
> > -         }
> >
> >
>
> Seems unnecessary, the devm_ioremap_resource() already validated if
> the resource is available.
>

Okay, thanks for the headsup
