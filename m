From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 07/11] spi-dw: Set number of available chip selects correctly
Date: Wed, 22 Jun 2011 21:53:40 -0600
Message-ID: <BANLkTin5hF7rZvC_AAUpX_-tR7TxdjEw+Q@mail.gmail.com>
References: <1308794413-11069-1-git-send-email-dirk.brandewie@gmail.com> <1308794413-11069-8-git-send-email-dirk.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: dirk.brandewie@gmail.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308794413-11069-8-git-send-email-dirk.brandewie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jun 22, 2011 at 8:00 PM,  <dirk.brandewie@gmail.com> wrote:
> From: Dirk Brandewie <dirk.brandewie@gmail.com>
>
> Only four chip selects are available directly off the pins of the
> master.
>
> Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
> ---
> =A0drivers/spi/spi-dw-mid.c | =A0 =A04 +++-
> =A01 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
> index 78e64d3..1d11268 100644
> --- a/drivers/spi/spi-dw-mid.c
> +++ b/drivers/spi/spi-dw-mid.c
> @@ -211,7 +211,9 @@ int spi_dw_mid_init(struct spi_dw *dws)
> =A0 =A0 =A0 =A0dws->max_freq =3D MRST_SPI_CLK_BASE / (clk_cdiv + 1);
> =A0 =A0 =A0 =A0iounmap(clk_reg);
>
> - =A0 =A0 =A0 dws->num_cs =3D 16;
> + =A0 =A0 =A0 dws->num_cs =3D 4; =A0 =A0 =A0 =A0/* spi_dw_chip_sel() =
bits 0-3 are
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* va=
lid in the slave enable register
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/

I thought someone had told me that the dw spio core supported using
the 4 cs lines in a multiplex mode to create up to 15 cs lines, but I
may be misremembering.

g.
