From: stefano babic <sbabic-ynQEQJNshbs@public.gmane.org>
Subject: Race condition in mpc52xx_psc_spi
Date: Mon, 08 Dec 2008 12:57:55 +0100
Message-ID: <493D0BC3.4060003@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Hi,

I have found a race condition in the PSC driver for the MPC5200.
The effect is that the processor let the RXFIFO interrupt pending and
the interrupt handler is called as soon as the IRQ is enabled again, not
after receiving the number of bytes set with the FIFO Alarm (~400).

In fact:

	   recv_at_once = in_be16(&fifo->rfnum);
                             ^---RFNUM is read only once
		[...]
                if (rx_buf) {
                    for (; recv_at_once; rb++, recv_at_once--)
			[FIFO wird gelesen] <-- now further bytes are coming

Enabling the traces, I can check that the driver writes only 20-30 Bytes
into the FIFO instead of 400 as set by the Alarm.
Because the FIFO does not become empty, according to the MPC5200 manual
the RXRDY/FFULL interrupt is not removed and a new interrupt is
generated at the next iteration.
This causes a lot of interrupts, much more as expected, generating an
higher CPU load as the usage of the RXFIFO really requires.

I will send a patch for review in short time to fix this issue.

Stefano

-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office-ynQEQJNshbs@public.gmane.org
=====================================================================

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
