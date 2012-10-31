From: =?iso-8859-1?Q?S=F8rensen=2C_Stefan?= <Stefan.Sorensen-I0ystx/e7NpBDgjK7y7TUQ@public.gmane.org>
Subject: [REGRESSION] d7b4394e breaks bi-directional DMA transfers on
	omap2-mcspi
Date: Wed, 31 Oct 2012 12:16:26 +0000
Message-ID: <651D981E4B29F74ABD63CE74C2E4788E08A612E22A@SLOMAILPRD01.polycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org"
	<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	"shubhrajyoti-l0cyMroinI0@public.gmane.org" <shubhrajyoti-l0cyMroinI0@public.gmane.org>
To: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Bi-directional SPI transfers using DMA no longer works on omap2-mcspi after
this commit:

commit d7b4394e780b02511c8a7a499380cdd56316c770
Author: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Date:   Tue Sep 11 12:13:20 2012 +0530

    spi: omap2-mcspi: Cleanup the omap2_mcspi_txrx_dma function
    
    Currently in omap2_mcspi_txrx_dma the tx and the rx support is
    interleaved. Make the rx related code in omap2_mcspi_rx_dma
    and the tx related code omap2_mcspi_tx_dma and call the functions.
    
    While at it remove the braces in the if statements which has only
    one line.
    Also fix ["foo * bar" to "foo *bar"] warn for the rx and tx variables.
    
    Only a cleanup no functional change.
    
    Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
    Tested-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
    Signed-off-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>


Basically the patch changes the pattern
        start_tx();
        start_rx();
        wait_for_completion(tx);
        wait_for_completion(tx);
into
        start_tx();
        wait_for_completion(tx);
        start_rx();
        wait_for_completion(tx);
which will stall the transfer since the rx channel is not serviced.


  Stefan
------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
