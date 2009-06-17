From: John Lists <johnlsts-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: ADC SPI kernel driver and latency
Date: Wed, 17 Jun 2009 14:21:09 +0200
Message-ID: <247792820906170521r4f3b525aq98f3d60fa8dd3bab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2285405949436766806=="
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

--===============2285405949436766806==
Content-Type: multipart/alternative; boundary=00235452eebc8655ae046c8a53e0

--00235452eebc8655ae046c8a53e0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi

I would like to interface from an OMAP3530 running linux 2.6.29 with an ADC
slave device via SPI but not sure if it is realistic.

The ADC is externally clocked and alerts the master (the OMAP) that a sample
is ready for retrieval by pulling a DataReady line low.
The ADC pulls the DataReady line low every 19 us (52kSamples/s) and then
expects the Master to retrieve 96 bits from it with a 25MHz SCLK before the
next sample becomes ready.

Is it possible/realistic to write a new kernel protocol driver that uses the
mcspi controller driver and be sure that the sample will be retrieved every
time before the 19us lapses?

Basically my question is, what is the best/easiest way to ensure that the
OMAP retrieves all the data over SPI within 19us from when the DataReady
line has been pulled low by the ADC?

Thanks in advanced,

John

--00235452eebc8655ae046c8a53e0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi <br><br>I would like to interface from an OMAP3530 running linux 2.6.29 with an ADC
slave device via SPI but not sure if it is realistic.<br><br>The ADC is externally
clocked and alerts the master (the OMAP) that a sample is ready for
retrieval by pulling a DataReady line low.<br>
The ADC pulls the DataReady line low every 19 us (52kSamples/s) and then expects the
Master to retrieve 96 bits from it with a 25MHz SCLK before the next
sample becomes ready.<br><br>Is it possible/realistic to write a new kernel protocol driver that uses the mcspi controller driver and be sure
that the sample will be retrieved every time before the 19us lapses? <br><br>Basically
my question is, what is the best/easiest way to ensure that the OMAP
retrieves all the data over SPI within 19us from when the DataReady line has
been pulled low by the ADC?<br>
<br>Thanks in advanced,<br><font color="#888888"><font color="#888888"><font color="#888888"><br>John</font>
</font>
</font>

--00235452eebc8655ae046c8a53e0--


--===============2285405949436766806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
--===============2285405949436766806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============2285405949436766806==--
