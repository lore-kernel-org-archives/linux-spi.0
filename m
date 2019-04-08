From: Vicente Bergas <vicencb@gmail.com>
Subject: Re: [PATCH] spi: rockchip: Revert "set min/max speed"
Date: Tue, 09 Apr 2019 00:35:34 +0200
Message-ID: <e9f5512c-238e-4da2-9caf-63c6be9b92be@gmail.com>
References: <21d83ed2-a8db-49cf-ba8c-c7844157d7b0@gmail.com>
 <20190407005759.2425-1-vicencb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Cc: Heiko Stuebner <heiko@sntech.de>,
        <linux-rockchip@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
To: Emil Renner Berthing <kernel@esmil.dk>,
        Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190407005759.2425-1-vicencb@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sunday, April 7, 2019 2:57:59 AM CEST, Vicente Bergas wrote:
> This reverts
> commit 420b82f84294 ("spi: rockchip: set min/max speed")
> commit 74b7efa82b11 ("spi: rockchip: precompute rx sample delay")
> The former breaks bursts of writes of 48 bytes or more.
> Both patches touch the same part of the file and it is not trivial to
> only revert the first. Reverting both just results in an easy to fix
> conflict.
>
> Tested-by: Vicente Bergas <vicencb@gmail.com>
> Signed-off-by: Vicente Bergas <vicencb@gmail.com>
> ---
>  drivers/spi/spi-rockchip.c | 80 ++++++++++++++++++++++----------------
>  1 file changed, 46 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index 3912526ead66..682f3567a8c8 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> ...

Hi Mark,
please, disregard this patch. It is the result of bisecting a bug which
may not be deterministically reproducible, so, the bisection point is
random.
Emil is helping me in the debug process, which is still ongoing.

Hi Emil,
yes, the platform is RK3399. Doing tests on the Sapphire board, but it is
also reproducible on gru-kevin. I prefer not testing on the chromebook
because when it fails it becomes unbootable (a brick) and need to take it
apart to connect an external programmer.

Now testing your suggestion:
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -720,5 +720,4 @@ static int rockchip_spi_probe(struct platform_device *)
        if (master->dma_tx && master->dma_rx) {
                rs->dma_addr_tx =3D mem->start + ROCKCHIP_SPI_TXDR;
                rs->dma_addr_rx =3D mem->start + ROCKCHIP_SPI_RXDR;
-               master->can_dma =3D rockchip_spi_can_dma;
        }
so far so good, but let me some time to make sure the results are
deterministic.
Now it works without dma and without the assigned-clock* props in the dts.

If that proves to fix the issue, which would be the next debugging step?

Regarding the spidev: if the spi1 dts is
&spi1 { status =3D "okay"; /* and nothing else */ };
then the /sys/bus/spi/devices directory is empty, so, it cant be bound.
What i am doing wrong?

Regards,
  Vicen=C3=A7.
