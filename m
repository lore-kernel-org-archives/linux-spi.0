From: arjun rath <rath.arjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: SPI-ADC
Date: Thu, 22 Apr 2010 11:50:21 +0530
Message-ID: <o2idc6d3181004212320neaf99b0az27938c369e1a5557@mail.gmail.com>
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

Hi Everybody,

I am using a SPI based 12 bit adc(max1241) from maxim.I am trying to read
the value from adc  using spi_read() in linux kernel.But every time i used
to read i am getting *0xff* only.(i have to read two consecutive bytes).To
the adc chip i am probing with CRO which always shows DOUT pin of ADC as
high provided the input to ADC is always 1.1 volt.
And the clock is also coming as seen in the CRO with Chip select line going
low.

Is it a delay problem since for adc's we have to wait for sometime for
conversion of data....????

Can anybody give some suggestion regarding this....

Thanks in advance
------------------------------------------------------------------------------
