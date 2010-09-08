From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 1/2] spi/spi_s3c64xx: Fix timeout handling in wait_for_xfer()
Date: Wed, 8 Sep 2010 10:11:59 +0900
Message-ID: <AANLkTi=6voS7WXcXgVTdK614W0Epy_Ehf5QzufErV2tD@mail.gmail.com>
References: <1283873872-8633-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Grant Likely <grant.likely@secretlab.ca>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Jassi Brar <jassi.brar@samsung.com>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1283873872-8633-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Sep 8, 2010 at 12:37 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> In wait_for_xfer() for PIO transfer we are using val as both a
> counter variable to track the number of spins we've waited for
> completion and the value we read from the controller, causing
> us to fail to ever actually notice the timeout. Fix this by using
> a separate value to hold the register readback.
>
> Also warn when we hit the timeout.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> =C2=A0drivers/spi/spi_s3c64xx.c | =C2=A0 11 +++++++----
> =C2=A01 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
> index 6e48ea9..03b28e4 100644
> --- a/drivers/spi/spi_s3c64xx.c
> +++ b/drivers/spi/spi_s3c64xx.c
> @@ -321,7 +321,7 @@ static int wait_for_xfer(struct s3c64xx_spi_drive=
r_data *sdd,
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct s3c64xx_spi_info *sci =3D sdd->cntr=
lr_info;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem *regs =3D sdd->regs;
> - =C2=A0 =C2=A0 =C2=A0 unsigned long val;
> + =C2=A0 =C2=A0 =C2=A0 unsigned long val, reg;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int ms;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* millisecs to xfer 'len' bytes @ 'cur_sp=
eed' */
> @@ -333,13 +333,16 @@ static int wait_for_xfer(struct s3c64xx_spi_dri=
ver_data *sdd,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D wait_f=
or_completion_timeout(&sdd->xfer_completion, val);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D msecs_=
to_loops(ms);
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 val =3D readl(regs + S3C64XX_SPI_STATUS);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } while (RX_FIFO_L=
VL(val, sci) < xfer->len && --val);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 reg =3D readl(regs + S3C64XX_SPI_STATUS);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } while (RX_FIFO_L=
VL(reg, sci) < xfer->len && --val);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0 if (!val)
> + =C2=A0 =C2=A0 =C2=A0 if (!val) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_warn(&sdd->pde=
v->dev, "Transfer timeout\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;
> + =C2=A0 =C2=A0 =C2=A0 }

I have already submitted a patch a few days ago
https://patchwork.kernel.org/patch/151941/
(It's strange that Grant's id isn't there in the CC list, despite my wr=
iting it)
