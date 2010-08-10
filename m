From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2 1/6] spi/mpc8xxx: refactor the
	common code for SPI/eSPI controller
Date: Tue, 10 Aug 2010 00:40:21 -0600
Message-ID: <AANLkTim=Qc-zA=9E0SfOB+8V48Y957MXkefD324xoq0w@mail.gmail.com>
References: <1280735524-17547-1-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-2-git-send-email-Mingkai.hu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, kumar.gala-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	tie-fei.zang-KZfg59tc24xl57MIdRCFDg@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1280735524-17547-2-git-send-email-Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Aug 2, 2010 at 1:51 AM, Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> Refactor the common code in file spi_mpc8xxx.c to spi_fsl_lib.c
> used by SPI/eSPI controller driver as a library, move the SPI
> controller driver to a new file spi_fsl_spi.c, and leave the
> QE/CPM SPI controller code in this file.
>
> Because the register map of the SPI controller and eSPI controller
> is so different, also leave the code operated the register to the
> driver code, not the common code.
>
> Signed-off-by: Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
> v2:
> =A0- Rename spi_mpc8xxx.c to spi_fsl_lib.c, also the config name
> =A0- Rename fsl_spi.c to spi_fsl_spi.c, also the config name
> =A0- Move register map definiton from spi_fsl_lib.c to spi_fsl_spi.c
> =A0- Break some funcions line in the arguments instead of the declaration
> =A0- Init bits_per_word to 0 to eliminate the else clause
> =A0- Add brace for the else clause to match if clause
> =A0- Drop the last entry's comma in the match table
> =A0- move module_init() immediately after the init fsl_spi_init() function
>
> =A0drivers/spi/Kconfig =A0 =A0 =A0 | =A0 20 +-
> =A0drivers/spi/Makefile =A0 =A0 =A0| =A0 =A03 +-
> =A0drivers/spi/spi_fsl_lib.c | =A0237 ++++++++
> =A0drivers/spi/spi_fsl_lib.h | =A0119 ++++
> =A0drivers/spi/spi_fsl_spi.c | 1173 +++++++++++++++++++++++++++++++++++++
> =A0drivers/spi/spi_mpc8xxx.c | 1421 -------------------------------------=
--------

This patch seems pretty good now.  However, the rename from
spi_mpc8xxx.c to spi_fsl_lib.c should be done in a separate patch.  It
is too difficult to track what has changed, when the file gets moved
at the same time.  Move the file in one patch verbatim (with the
required Makefile change), and then move out the fsl_spi specific bits
in a second patch.

g.

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by =


Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev =
