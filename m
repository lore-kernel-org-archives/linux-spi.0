From: Mingkai Hu <Mingkai.hu@freescale.com>
Subject: [PATCH v3 0/7] refactor spi_mpc8xxx.c and add eSPI controller support
Date: Thu, 30 Sep 2010 16:00:39 +0800
Message-ID: <1285833646-12006-1-git-send-email-Mingkai.hu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: kumar.gala@freescale.com
To: <linuxppc-dev@ozlabs.org>, <spi-devel-general@lists.sourceforge.net>,
	<linux-mtd@lists.infradead.org>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org

This patchset refactor the file spi_mpc8xxx.c to abstract some common 
code as a lib used by the SPI/eSPI controller driver, move the SPI 
controller driver code to spi_fsl_spi.c, and add the eSPI controller 
support with spi_fsl_espi.c.

Tested on P4080DS and MPC8536DS board based on latest Linux tree.

v3 main changes:
 - Update to the latest kernel base.
 - Change the file spi_mpc8xxx.c to spi_fsl_fsl.c verbatim.
 - Add the SPI flash partition code to the m25p80 probe function.
 - Add a quirks for SPI master to handle the contrains of the controller.

[PATCH v3 1/7] spi/mpc8xxx: rename spi_mpc8xxx.c to spi_fsl_spi.c
[PATCH v3 2/7] spi/mpc8xxx: refactor the common code for SPI/eSPI controller
[PATCH v3 3/7] eSPI: add eSPI controller support
[PATCH v3 4/7] powerpc/of: add eSPI controller dts bindings and DTS modification
[PATCH v3 5/7] mtd: m25p80: add support to parse the SPI flash's partitions
[PATCH v3 6/7] mtd: m25p80: add a read function to read page by page
[PATCH v3 7/7] DTS: add fsl,spi-quirk-trans-len-limit property

Thanks,
Mingkai
