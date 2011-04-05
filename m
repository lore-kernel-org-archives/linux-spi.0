From: =?ISO-8859-1?Q?Fl=E1vio_Alberto_Lopes_Soares?= <flavioalsoares-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: how to access spi ADC on high sample rate ?
Date: Tue, 5 Apr 2011 02:39:45 -0300
Message-ID: <BANLkTin2zT9Wp3EUHLrdthuoU50S8cry2A@mail.gmail.com>
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

Hello all, I'm using an ads8320 analog/digital converter connected to a
2S3C2440 Samsung ucontroller by a SPI bus, I'm using spidev driver on kernel
2.6.32 to access it from user space and this works fine.
The problem occurs because I want to access this adc in your max sample rate
possible (100K Samples/s according datasheet, 50% of this for me will be
great) saving this data, reading using an application in user space only
reach 200 Samples/s in linux kernel, this is for me was not surprising
because the application runs in user space and process scheduler time slice
prevents achieve a faster sample rate. I want to know the best way to access
this adc (I believe I need write a kernel driver), there's some reference
example or documentation to do this ? Some audio capture driver can serve as
reference ?

Thanks in advance

Flavio Alberto Lopes Soares
------------------------------------------------------------------------------
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
