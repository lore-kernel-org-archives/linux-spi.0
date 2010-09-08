From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] spi/spi_s3c64xx: Move to subsys_initcall()
Date: Wed, 8 Sep 2010 13:55:39 +0900
Message-ID: <AANLkTim=ArPyqC7K-aaer97deGeR6yU-FS1Hpm3D_1ER@mail.gmail.com>
References: <1283855357-15179-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jassi Brar <jassi.brar@samsung.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	David Brownell <dbrownell@users.sourceforge.net>,
	spi-devel-general@lists.sourceforge.net,
	patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1283855357-15179-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Sep 7, 2010 at 7:29 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> Allow the use of the S3C64xx SPI controller with things like PMICs by
> moving the init up to subsys_initcall().
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>
> Incidentally I don't seem to see anything in the current SPI tree for
> -next - should the tree being used be updated or something?
>
> =C2=A0drivers/spi/spi_s3c64xx.c | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
> index f72e1c0..6e48ea9 100644
> --- a/drivers/spi/spi_s3c64xx.c
> +++ b/drivers/spi/spi_s3c64xx.c
> @@ -1181,7 +1181,7 @@ static int __init s3c64xx_spi_init(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return platform_driver_probe(&s3c64xx_spi_=
driver, s3c64xx_spi_probe);
> =C2=A0}
> -module_init(s3c64xx_spi_init);
> +subsys_initcall(s3c64xx_spi_init);

Couldn't any user ever need to load it as a module?
If no, we might as well drop the s3c64xx_spi_exit and s3c64xx_spi_remov=
e
as well and save space. Rather going a step further, shouldn't then all
spi drivers be that way? Two steps further, why not every 'bus-driver' =
?
