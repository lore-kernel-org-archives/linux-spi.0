From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] spi: sifive: check return value for platform_get_resource()
Date: Tue, 17 Sep 2019 15:07:50 +0200
Message-ID: <CAMuHMdW5VgFG3NrYpPmr0VY-oG4AV3itT7mk6jbpT2w3BH0vOw@mail.gmail.com>
References: <20190917085627.4562-1-mail@aurabindo.in> <CAMz4kuJczzjTPSohQ=kbZ0Pr7U_9-hzXk-jPgKk79PENOM1-dA@mail.gmail.com>
 <alpine.DEB.2.21.9999.1909170514130.11980@viisi.sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Baolin Wang <baolin.wang@linaro.org>,
        Aurabindo Jayamohanan <mail@aurabindo.in>,
        Mark Brown <broonie@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.9999.1909170514130.11980@viisi.sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Paul,

On Tue, Sep 17, 2019 at 2:16 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> On Tue, 17 Sep 2019, Baolin Wang wrote:
> > On Tue, 17 Sep 2019 at 17:12, Aurabindo Jayamohanan <mail@aurabindo.in> wrote:
> > > platform_get_resource() may return NULL. If it is so, return -ENXIO
> > >
> > > Signed-off-by: Aurabindo Jayamohanan <mail@aurabindo.in>
> > > ---
> > >  drivers/spi/spi-sifive.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
> > > index 93ec2c6cdbfd..67485067a694 100644
> > > --- a/drivers/spi/spi-sifive.c
> > > +++ b/drivers/spi/spi-sifive.c
> > > @@ -308,6 +308,12 @@ static int sifive_spi_probe(struct platform_device *pdev)
> > >         platform_set_drvdata(pdev, master);
> > >
> > >         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +       if (!res) {
> > > +               dev_err(&pdev->dev, "no IOMEM resource found\n");
> > > +               ret = -ENXIO;
> > > +               goto put_master;
> > > +       }
> >
> > Seems unnecessary, the devm_ioremap_resource() already validated if
> > the resource is available.
>
> Just doublechecked lib/devres.c and I agree with you.
>
> Aurobindo, is this a patch for a real problem that you've encountered?

Probably not.

The sequence can be replaced by a single call to
devm_platform_ioremap_resource(), which BTW also doesn't check the
intermediate result, as that's unneeded.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
