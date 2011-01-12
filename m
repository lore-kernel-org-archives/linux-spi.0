From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH V2] spi: Enable SPI driver for S5P6440 and S5P6450
Date: Wed, 12 Jan 2011 15:16:16 +0900
Message-ID: <AANLkTi=hp0eWu2yYfJ9G8V2Nid39DYq6RjVaOqtA0kcO@mail.gmail.com>
References: <1294809658-13974-1-git-send-email-kgene.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-samsung-soc@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	Sangbeom Kim <sbkim73@samsung.com>,
	dbrownell@users.courceforge.net, ben-linux@fluff.org,
	Abhilash Kesavan <a.kesavan@samsung.com>
To: Kukjin Kim <kgene.kim@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1294809658-13974-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jan 12, 2011 at 2:20 PM, Kukjin Kim <kgene.kim@samsung.com> wro=
te:
> From: Abhilash Kesavan <a.kesavan@samsung.com>
>
> This patch enables the existing S3C64XX series SPI driver for S5P64X0
> and removed dependency on EXPERIMENTAL because we don't need it now.
>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
> Cc: Jassi Brar <jassi.brar@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> Changes since v1:
> - Removed dependency on EXPERIMENTAL
>
> Hi David and Grant,
>
> I missed that send to you when I have got this via Linux Samsung SoC =
mailing list.
> Hmm...I know, it's 38 merge winodw...so I'm not sure can be handled n=
ow.
>
> Anyway if any problems, please let me know.
>
> Thanks and Happy New year :)
>
> Best regards,
> Kgene.
>
> =C2=A0drivers/spi/Kconfig | =C2=A0 =C2=A04 ++--
> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 1906840..37aec5e 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -310,8 +310,8 @@ config SPI_S3C24XX_GPIO
>
> =C2=A0config SPI_S3C64XX
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "Samsung S3C64XX series type SPI"
> - =C2=A0 =C2=A0 =C2=A0 depends on ARCH_S3C64XX && EXPERIMENTAL
> - =C2=A0 =C2=A0 =C2=A0 select S3C64XX_DMA
> + =C2=A0 =C2=A0 =C2=A0 depends on (ARCH_S3C64XX || ARCH_S5P64X0)
> + =C2=A0 =C2=A0 =C2=A0 select S3C64XX_DMA if !ARCH_S5P64X0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0help
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SPI driver for Samsung S3C64XX and =
newer SoCs.

Since SoCs newer than S3C64xx use different DMAC, it would be
more efficient to do
     select S3C64XX_DMA if ARCH_S3C64XX
otherwise we would have to add lots of !ARCH_S5Pxxx as more SoCs
are enabled.
