From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 00/10] spi: s3c64xx: add support for device tree
Date: Wed, 9 May 2012 13:47:09 +0530
Message-ID: <CABb+yY00+Et7sXgb0s6GinOdKu6PeQsWD9A_SoV2M3VKMejz7g@mail.gmail.com>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org, kgene.kim@samsung.com,
	rob.herring@calxeda.com, grant.likely@secretlab.ca,
	jaswinder.singh@linaro.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, May 9, 2012 at 3:34 AM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> This patch series adds device tree based discovery support for Samsun=
g's
> s3c64xx compatible spi controller. This is mainly tested for Exynos42=
10
> and Exynos5250 with onboard spi nor flash device.
>
> This patch series is based on Linux 3.4-rc5 with the following two
> patch series applied.
>
> [1] http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg=
10494.html
> =C2=A0 =C2=A0[PATCH 00/20] ARM: Samsung: Add support for Exynos5250 R=
ev1.0
>
> [2] http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg=
09640.html
> =C2=A0 =C2=A0[PATCH 0/6] S3C24XX: Add support for HSSPI on S3C2416/S3=
C2443
>
> Thomas Abraham (10):
> =C2=A0spi: s3c64xx: remove unused S3C64XX_SPI_ST_TRLCNTZ macro
> =C2=A0spi: s3c64xx: move controller information into driver data
> =C2=A0ARM: Samsung: Remove spi hardware controller information from p=
latform data
> =C2=A0ARM: Samsung: Remove pdev pointer paremeter from spi gpio setup=
 functions
> =C2=A0ARM: Samsung: Update the device names for spi clock lookup
> =C2=A0ARM: Samsung: Modify s3c64xx_spi{0|1|2}_set_platdata function
> =C2=A0spi: s3c64xx: Remove the 'set_level' callback from controller d=
ata
> =C2=A0ARM: Exynos4: Fix the incorrect hierarchy of spi controller bus=
 clock
> =C2=A0ARM: Exynos5: Add spi clock support
> =C2=A0spi: s3c64xx: add device tree support
>
Look ok to me.  FWIW,  Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
