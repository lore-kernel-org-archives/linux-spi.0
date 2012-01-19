From: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] spi-topcliff-pch: Modify pci-bus number dynamically
	to get DMA device info
Date: Thu, 19 Jan 2012 11:34:43 +0900
Message-ID: <CANKRQniO55ZO+15Wt63Jtj4_MJk3b04_KXZT4bcrOaJjBedzyQ@mail.gmail.com>
References: <1323403905-3432-1-git-send-email-tomoya.rohm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1323403905-3432-1-git-send-email-tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Grant.

More than a month has been passed since I posted the following patches.
However still not reviewed yet.

[PATCH 1/4] spi-topcliff-pch: Modify pci-bus number dynamically to get
DMA device info
[PATCH 2/4] spi-topcliff-pch: Fix issue for transmitting over 4KByte
[PATCH 3/4][RESEND] spi-topcliff-pch: supports a spi mode setup and
bit order setup by IO control
[PATCH 4/4] spi-topcliff-pch: add recovery processing in case wait-event ti=
meout

Could you review these ?

thanks,
tomoya

2011/12/9 Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Signed-off-by: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> =A0drivers/spi/spi-topcliff-pch.c | =A0 =A03 ++-
> =A01 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pc=
h.c
> index 99ec279..fcd9462 100644
> --- a/drivers/spi/spi-topcliff-pch.c
> +++ b/drivers/spi/spi-topcliff-pch.c
> @@ -920,7 +920,8 @@ static void pch_spi_request_dma(struct pch_spi_data *=
data, int bpw)
> =A0 =A0 =A0 =A0dma_cap_set(DMA_SLAVE, mask);
>
> =A0 =A0 =A0 =A0/* Get DMA's dev information */
> - =A0 =A0 =A0 dma_dev =3D pci_get_bus_and_slot(2, PCI_DEVFN(12, 0));
> + =A0 =A0 =A0 dma_dev =3D pci_get_bus_and_slot(data->board_dat->pdev->bus=
->number,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0PCI_DEVFN(12, 0));
>
> =A0 =A0 =A0 =A0/* Set Tx DMA */
> =A0 =A0 =A0 =A0param =3D &dma->param_tx;
> --
> 1.7.4.4
>

---------------------------------------------------------------------------=
---
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
