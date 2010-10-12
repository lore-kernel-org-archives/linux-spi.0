From: Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH v4 0/5] refactor spi_mpc8xxx.c and add eSPI controller support
Date: Tue, 12 Oct 2010 18:18:29 +0800
Message-ID: <1286878714-13090-1-git-send-email-Mingkai.hu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, kumar.gala-KZfg59tc24xl57MIdRCFDg@public.gmane.org, tie-fei.zang-KZfg59tc24xl57MIdRCFDg@public.gmane.org
To: <linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	<linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patchset refactor the file spi_mpc8xxx.c to abstract some common 
code as a lib used by the SPI/eSPI controller driver, move the SPI 
controller driver code to spi_fsl_spi.c, and add the eSPI controller 
support with spi_fsl_espi.c.

v4 main change:
 - Update to the latest kernel base(Linux 2.6.36-rc7).
 - Add support to the transaction that the length is grater than 0xFFFF
   in the eSPI controller's driver.
 - Some changes according to Grant and Anton's comments.

Tested on P4080DS and MPC8536DS board.

[PATCH v4 1/5] spi/mpc8xxx: rename spi_mpc8xxx.c to spi_fsl_spi.c
[PATCH v4 2/5] spi/mpc8xxx: refactor the common code for SPI/eSPI controller
[PATCH v4 3/5] eSPI: add eSPI controller support
[PATCH v4 4/5] powerpc/of: add eSPI controller dts bindings and DTS modification
[PATCH v4 5/5] mtd: m25p80: add support to parse the partitions by OF node

Thanks,
Mingkai


------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
