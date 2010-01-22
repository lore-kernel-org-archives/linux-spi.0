From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] dw_spi_mmio depends on HAVE_CLK
Date: Fri, 22 Jan 2010 10:31:51 -0700
Message-ID: <fa686aa41001220931r4ab1a2afy4ce8796e4a85d887@mail.gmail.com>
References: <20100122124515.2619.14103.stgit@station520.octasic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
To: Jean-Hugues Deschenes <jean-hugues.deschenes@octasic.com>
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20100122124515.2619.14103.stgit@station520.octasic.com>
Sender: linux-next-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jan 22, 2010 at 5:45 AM, Jean-Hugues Deschenes
<jean-hugues.deschenes@octasic.com> wrote:
> dw_spi_mmio is dependent on the clock framework. This marks it as suc=
h
> in Kconfig.
>
>
> Signed-off-by: Jean-Hugues Deschenes <jean-hugues.deschenes@octasic.c=
om>

applied, thanks.

g.

> ---
> =A0drivers/spi/Kconfig | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 505f1c2..c1ac092 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -319,7 +319,7 @@ config SPI_DW_PCI
>
> =A0config SPI_DW_MMIO
> =A0 =A0 =A0 =A0tristate "Memory-mapped io interface driver for DW SPI=
 core"
> - =A0 =A0 =A0 depends on SPI_DESIGNWARE
> + =A0 =A0 =A0 depends on SPI_DESIGNWARE && HAVE_CLK
>
> =A0#
> =A0# There are lots of SPI device types, with sensors and memory
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
