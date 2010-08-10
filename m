From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2 2/6] eSPI: add eSPI controller
	support
Date: Tue, 10 Aug 2010 00:44:48 -0600
Message-ID: <AANLkTin3W4++cAFcksVBX3QxeV8QF3d5T2tGy_KbEkRs@mail.gmail.com>
References: <1280735524-17547-1-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-2-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-3-git-send-email-Mingkai.hu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, kumar.gala-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	tie-fei.zang-KZfg59tc24xl57MIdRCFDg@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1280735524-17547-3-git-send-email-Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Aug 2, 2010 at 1:52 AM, Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> Add eSPI controller support based on the library code spi_fsl_lib.c.
>
> The eSPI controller is newer controller 85xx/Pxxx devices supported.
> There're some differences comparing to the SPI controller:
>
> 1. Has different register map and different bit definition
> =A0 So leave the code operated the register to the driver code, not
> =A0 the common code.
>
> 2. Support 4 dedicated chip selects
> =A0 The software can't controll the chip selects directly, The SPCOM[CS]
> =A0 field is used to select which chip selects is used, and the
> =A0 SPCOM[TRANLEN] field is set to tell the controller how long the CS
> =A0 signal need to be asserted. So the driver doesn't need the chipselect
> =A0 related function when transfering data, just set corresponding regist=
er
> =A0 fields to controll the chipseclect.
>
> 3. Different Transmit/Receive FIFO access register behavior
> =A0 For SPI controller, the Tx/Rx FIFO access register can hold only
> =A0 one character regardless of the character length, but for eSPI
> =A0 controller, the register can hold 4 or 2 characters according to
> =A0 the character lengths. Access the Tx/Rx FIFO access register of the
> =A0 eSPI controller will shift out/in 4/2 characters one time. For SPI
> =A0 subsystem, the command and data are put into different transfers, so
> =A0 we need to combine all the transfers to one transfer in order to pass
> =A0 the transfer to eSPI controller.
>
> Signed-off-by: Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

I've not dug deep into this patch, but it seems pretty good.  I did
notice one thing below...
[...]

> diff --git a/drivers/spi/spi_fsl_lib.h b/drivers/spi/spi_fsl_lib.h
> index 774e1c8..0772c98 100644
> --- a/drivers/spi/spi_fsl_lib.h
> +++ b/drivers/spi/spi_fsl_lib.h
> @@ -22,10 +22,12 @@
> =A0struct mpc8xxx_spi {
> =A0 =A0 =A0 =A0struct device *dev;
> =A0 =A0 =A0 =A0struct fsl_spi_reg __iomem *base;
> + =A0 =A0 =A0 struct fsl_espi_reg __iomem *espi_base;

There's got to be a cleaner way to do this.  Rather than putting both
pointers into mpc8xxx_spi, I suggest each driver use its own
fsl_spi_priv and fsl_espi_priv wrapper structures that contain the
controller specific properties.

cheers,
g.

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by =


Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev =
