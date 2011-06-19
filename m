From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi/pxa2xx: Remove unavailable ssp_type from documentation
Date: Sat, 18 Jun 2011 22:39:17 -0600
Message-ID: <BANLkTimroWr+meX2hiXDe58HMgsJT2cGbw@mail.gmail.com>
References: <1308420126-19696-1-git-send-email-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Stefan Schmidt <stefan-OrPQZGeq07wqhVmZOOOmNx2eb7JE58TQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1308420126-19696-1-git-send-email-stefan-OrPQZGeq07wqhVmZOOOmNx2eb7JE58TQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Applied, thanks.

g.

On Sat, Jun 18, 2011 at 12:02 PM, Stefan Schmidt
<stefan-OrPQZGeq07wqhVmZOOOmNx2eb7JE58TQ@public.gmane.org> wrote:
> Since commit
>
> commit 2f1a74e5a2de0459139b85af95e901448726c375
> Author: eric miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Date: =A0 Wed Nov 21 18:50:53 2007 +0800
>
> =A0 =A0[ARM] pxa: make pxa2xx_spi driver use ssp_request()/ssp_free()
>
> the ssp_type field in struct pxa2xx_spi_master is no longer available.
>
> Signed-off-by: Stefan Schmidt <stefan-OrPQZGeq07wqhVmZOOOmNx2eb7JE58TQ@public.gmane.org>
> ---
> =A0Documentation/spi/pxa2xx | =A0 =A05 -----
> =A01 files changed, 0 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/spi/pxa2xx b/Documentation/spi/pxa2xx
> index 68a4fe3..641be56 100644
> --- a/Documentation/spi/pxa2xx
> +++ b/Documentation/spi/pxa2xx
> @@ -22,15 +22,11 @@ Typically a SPI master is defined in the arch/.../mac=
h-*/board-*.c as a
> =A0found in include/linux/spi/pxa2xx_spi.h:
>
> =A0struct pxa2xx_spi_master {
> - =A0 =A0 =A0 enum pxa_ssp_type ssp_type;
> =A0 =A0 =A0 =A0u32 clock_enable;
> =A0 =A0 =A0 =A0u16 num_chipselect;
> =A0 =A0 =A0 =A0u8 enable_dma;
> =A0};
>
> -The "pxa2xx_spi_master.ssp_type" field must have a value between 1 and 3=
 and
> -informs the driver which features a particular SSP supports.
> -
> =A0The "pxa2xx_spi_master.clock_enable" field is used to enable/disable t=
he
> =A0corresponding SSP peripheral block in the "Clock Enable Register (CKEN=
"). See
> =A0the "PXA2xx Developer Manual" section "Clocks and Power Management".
> @@ -61,7 +57,6 @@ static struct resource pxa_spi_nssp_resources[] =3D {
> =A0};
>
> =A0static struct pxa2xx_spi_master pxa_nssp_master_info =3D {
> - =A0 =A0 =A0 .ssp_type =3D PXA25x_NSSP, /* Type of SSP */
> =A0 =A0 =A0 =A0.clock_enable =3D CKEN_NSSP, /* NSSP Peripheral clock */
> =A0 =A0 =A0 =A0.num_chipselect =3D 1, /* Matches the number of chips atta=
ched to NSSP */
> =A0 =A0 =A0 =A0.enable_dma =3D 1, /* Enables NSSP DMA */
> --
> 1.7.5.4
>
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
