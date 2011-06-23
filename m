From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 06/11] spi-dw: Force error on out of range chip select.
Date: Wed, 22 Jun 2011 21:51:45 -0600
Message-ID: <BANLkTin5CFVm6rVM_c6RRranJEor_jPF=Q@mail.gmail.com>
References: <1308794413-11069-1-git-send-email-dirk.brandewie@gmail.com> <1308794413-11069-7-git-send-email-dirk.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: dirk.brandewie@gmail.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308794413-11069-7-git-send-email-dirk.brandewie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jun 22, 2011 at 8:00 PM,  <dirk.brandewie@gmail.com> wrote:
> From: Dirk Brandewie <dirk.brandewie@gmail.com>
>
> BUG_ON() if the selected chip select is out of range.
>
> Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
> ---
> =A0drivers/spi/spi-dw.h | =A0 =A03 +--
> =A01 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 860bc34..3fa4c13 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -178,8 +178,7 @@ static inline void spi_dw_set_clk(struct spi_dw *=
dws, u16 div)
>
> =A0static inline void spi_dw_chip_sel(struct spi_dw *dws, u16 cs)
> =A0{
> - =A0 =A0 =A0 if (cs > dws->num_cs)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 BUG_ON(cs >=3D dws->master->num_chipselect);

BUG is rather an over-reaction.  The transfer should be rejected if
the cs# is invalid, and a warning message is appropriate, but BUG() is
too extreme.

g.
