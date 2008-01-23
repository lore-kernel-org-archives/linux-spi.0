From: "Girish" <girishsg-l0cyMroinI0@public.gmane.org>
Subject: spi read issue
Date: Wed, 23 Jan 2008 20:00:34 +0530
Message-ID: <021301c85dcc$847300a0$988818ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi,

If the following program is performed for touch screen control, we expect
1 tx command for controlling SPI and 2 Rx commands for reading data

---------------------------------
 spi_message_init(m);

 /* y- still on; turn on only y+ (and ADC) */
 ts->read_y = READ_Y(vref);
 x->tx_buf = &ts->read_y;
 x->len = 1;
 spi_message_add_tail(x, m);

 x++;
 x->rx_buf = &ts->tc.y;
 x->len = 2;
 spi_message_add_tail(x, m);

 m->complete = ads7846_rx_val;
 m->context = ts;

 m++;
---------------------------------------

But we see 1 set of CLK for tx command and three sets of CLK for Rx read
Is it that the redundant clk set may cause slippage of data? 

Regards,
Girish


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
