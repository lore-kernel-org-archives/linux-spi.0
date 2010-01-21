From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] link dw_spi.o with the kernel
	objects
Date: Thu, 21 Jan 2010 08:41:34 -0700
Message-ID: <fa686aa41001210741m456d6a07x6184f34bc621cc46@mail.gmail.com>
References: <20100121153254.18310.27155.stgit@station520.octasic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100121153254.18310.27155.stgit-PR71IgaHmJalNznWqnLNUK6RkeBMCJyt@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jan 21, 2010 at 8:33 AM, Jean-Hugues Deschenes
<jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org> wrote:
> The bulk of the dw_spi driver is contained in dw_spi.c, which was statica=
lly
> linked with the kernel, whether dw_spi_(pci|mmio) was requested to be bui=
lt
> as a module or not. This patch links dw_spi.o with the kernel module.

Why not just make dw_spi a kernel module on its own?

g.

>
> The kernel objects are renamed to dw_spi_(pic|mmio)_drv.ko in the process.
>
> Signed-off-by: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
> ---
> =A0drivers/spi/Makefile | =A0 =A07 ++++---
> =A01 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index c3e5ce7..e061b71 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -16,9 +16,10 @@ obj-$(CONFIG_SPI_BFIN) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 +=3D spi_bfin5xx.o
> =A0obj-$(CONFIG_SPI_BITBANG) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D spi_bitbang.o
> =A0obj-$(CONFIG_SPI_AU1550) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D au1550_spi.o
> =A0obj-$(CONFIG_SPI_BUTTERFLY) =A0 =A0 =A0 =A0 =A0 =A0+=3D spi_butterfly.o
> -obj-$(CONFIG_SPI_DESIGNWARE) =A0 =A0 =A0 =A0 =A0 +=3D dw_spi.o
> -obj-$(CONFIG_SPI_DW_PCI) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D dw_spi_pci.o
> -obj-$(CONFIG_SPI_DW_MMIO) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D dw_spi_mmio.o
> +obj-$(CONFIG_SPI_DW_PCI) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D dw_spi_pci_drv=
.o
> +dw_spi_pci_drv-objs =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0:=3D dw_spi_pci.o dw_spi.o
> +obj-$(CONFIG_SPI_DW_MMIO) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D dw_spi_mmio_dr=
v.o
> +dw_spi_mmio_drv-objs =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=3D dw_spi_mmi=
o.o dw_spi.o
> =A0obj-$(CONFIG_SPI_GPIO) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D spi_gpio.o
> =A0obj-$(CONFIG_SPI_IMX) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D spi_imx.o
> =A0obj-$(CONFIG_SPI_LM70_LLP) =A0 =A0 =A0 =A0 =A0 =A0 +=3D spi_lm70llp.o
>
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Confere=
nce
attendees to learn about information security's most important issues throu=
gh
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
