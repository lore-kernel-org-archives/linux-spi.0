From: Domen Puncer <domen-CvScVCPLwOZg9hUCZPvPmw@public.gmane.org>
Subject: SPI devices that require lots of small
	transfers, how?
Date: Thu, 11 Dec 2008 16:35:36 +0100
Message-ID: <20081211153536.GM1924@domen-work>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello!

I'm writing a driver for a 2 Mbit/s wireless chip interfaced via SPI.
Now, transmit isn't a problem, I can push data out at full speed
(interrupt handler just signals with a semaphore that there's a free TX
buffer, then in process context I write the next one).

I'm having trouble with receiving lots of data.
The chip has 3 32-byte buffers, with interrupt per received buffer this
makes about 7800 interrupts/second at full speed.
Offloading RX transfers to userspace doesn't seem to be an option, since
it misses packets; those 3 buffers fill up pretty fast.

If I handle it in interrupt, with spi_async, then I'm not sure how can I
implement this RX loop (pseudocode, to get the idea):
	do {
		spi_device_read_payload()
		spi_device_clear_rx_interrupt()
	} while (spi_device_there_is_more_data())

A recursion with spi_async() callbacks doesn't sound safe.

(Handling in interrupt, without the above loop doesn't seem fast enough
either, I'm losing packets).


Any ideas, suggestions, comments are very much welcome.
Surely someone had to deal with something similar in the past?


	Domen

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
