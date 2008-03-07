From: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: bitbang & mpc83xx setup_transfer()
Date: Fri, 07 Mar 2008 17:41:04 +0100
Message-ID: <1204908064.29669.44.camel@gentoo-jocke.transmode.se>
Reply-To: joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

I am a bit confused where one should do spi HW setup. Currently both
mpc83xx_spi_setup_transfer() and mpc83xx_spi_chipselect() touches the
HW controller. I suspect that this is so because
mpc83xx_spi_setup_transfer() only gets called if one supply speed or
word size thereby forcing mpc83xx_spi_chipselect() do it too and I doubt
the speed and wordsize is correctly dealt with in
mpc83xx_spi_chipselect().

The current situation for mpc83xx is suboptimal and can cause gliches on
CLK as one must disable the controller before any change is to be
performed and then reenabled it. The SPI I/O pins is floating while
the controller is disabled.

 Jocke 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
