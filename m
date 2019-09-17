From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH] spi: sifive: check return value for
 platform_get_resource()
Date: Tue, 17 Sep 2019 07:11:16 -0700 (PDT)
Message-ID: <alpine.DEB.2.21.9999.1909170709070.8198@viisi.sifive.com>
References: <20190917085627.4562-1-mail@aurabindo.in> <CAMz4kuJczzjTPSohQ=kbZ0Pr7U_9-hzXk-jPgKk79PENOM1-dA@mail.gmail.com> <alpine.DEB.2.21.9999.1909170514130.11980@viisi.sifive.com>
 <ij_UksEXUomr_L7KQam02lHBryAppgwKDjG90VbVcRRUeXlKU8TAiBWc3aU8vt20Wvlwt_6NDgz5fuMSwwP1mm-1eP6GYWoR1Kbr0y0ElRk=@aurabindo.in>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1565122568-1568729476=:8198"
Cc: Baolin Wang <baolin.wang@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Aurabindo Jayamohanan <mail@aurabindo.in>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ij_UksEXUomr_L7KQam02lHBryAppgwKDjG90VbVcRRUeXlKU8TAiBWc3aU8vt20Wvlwt_6NDgz5fuMSwwP1mm-1eP6GYWoR1Kbr0y0ElRk=@aurabindo.in>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1565122568-1568729476=:8198
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Aurobindo,=20

On Tue, 17 Sep 2019, Aurabindo Jayamohanan wrote:

> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original =
Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
> On Tuesday, September 17, 2019 5:45 PM, Paul Walmsley <paul.walmsley@sifi=
ve.com> wrote:
>=20
> > On Tue, 17 Sep 2019, Baolin Wang wrote:
> >
> > > On Tue, 17 Sep 2019 at 17:12, Aurabindo Jayamohanan mail@aurabindo.in=
 wrote:
> > >
> > > > platform_get_resource() may return NULL. If it is so, return -ENXIO
> > > >
> > > > Signed-off-by: Aurabindo Jayamohanan mail@aurabindo.in
> > > >
> > > > -------------------------------------------------------
> > > >
> > > > drivers/spi/spi-sifive.c | 6 ++++++
> > > > 1 file changed, 6 insertions(+)
> > > > diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
> > > > index 93ec2c6cdbfd..67485067a694 100644
> > > > --- a/drivers/spi/spi-sifive.c
> > > > +++ b/drivers/spi/spi-sifive.c
> > > > @@ -308,6 +308,12 @@ static int sifive_spi_probe(struct platform_de=
vice *pdev)
> > > > platform_set_drvdata(pdev, master);
> > > >
> > > >         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > >
> > > >
> > > > -         if (!res) {
> > > >
> > > >
> > > > -                 dev_err(&pdev->dev, "no IOMEM resource found\\n")=
;
> > > >
> > > >
> > > > -                 ret =3D -ENXIO;
> > > >
> > > >
> > > > -                 goto put_master;
> > > >
> > > >
> > > > -         }
> > > >
> > > >
> > >
> > > Seems unnecessary, the devm_ioremap_resource() already validated if
> > > the resource is available.
> >
> > Just doublechecked lib/devres.c and I agree with you.
> >
> > Aurobindo, is this a patch for a real problem that you've encountered?
> >
> > -   Paul
>=20
> Geert is right. I was just breezing through the source and found it odd s=
ince
> I noticed other instances checking for return value. Apparently none of t=
hose
> use the managed api.
>=20
> If you didnt already do Geert's suggestion,

Mark Brown is the maintainer, so he'd be the one to apply anything=20
touching these drivers.

> here is a patch:

Could you please send this as a separate E-mail?

> ____
>=20
> spi: sifive: use device managed api to get plaform resource

"platform resource"

>=20
> calls to devm_ioremap_resource() preceeded by platform_get_resource()

"Calls"

"preceded"

> may be replaced by devm_platform_ioremap_resource().

Please explain why.  In this case "removing boilerplate from the code"=20
seems like a reasonable explanation.

>=20
> Signed-off-by: Aurabindo Jayamohanan <mail@aurabindo.in>
> ---
>  drivers/spi/spi-sifive.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
> index 93ec2c6cdbfd..c0925aa98aad 100644
> --- a/drivers/spi/spi-sifive.c
> +++ b/drivers/spi/spi-sifive.c
> @@ -292,7 +292,6 @@ sifive_spi_transfer_one(struct spi_master *master, st=
ruct spi_device *device,
>  static int sifive_spi_probe(struct platform_device *pdev)
>  {
>  =09struct sifive_spi *spi;
> -=09struct resource *res;
>  =09int ret, irq, num_cs;
>  =09u32 cs_bits, max_bits_per_word;
>  =09struct spi_master *master;
> @@ -307,8 +306,7 @@ static int sifive_spi_probe(struct platform_device *p=
dev)
>  =09init_completion(&spi->done);
>  =09platform_set_drvdata(pdev, master);
>=20
> -=09res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -=09spi->regs =3D devm_ioremap_resource(&pdev->dev, res);
> +=09spi->regs =3D devm_platform_ioremap_resource(pdev, 0);
>  =09if (IS_ERR(spi->regs)) {
>  =09=09ret =3D PTR_ERR(spi->regs);
>  =09=09goto put_master;
> --
> 2.23.0
>=20


- Paul
--8323329-1565122568-1568729476=:8198--
