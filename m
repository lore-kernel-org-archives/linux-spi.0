From: "Matt Gessner" <mgessner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: AT91RM9200 spi, linux 2.6.25, and MOSI
Date: Tue, 20 Jan 2009 10:12:16 -0500
Message-ID: <85a5c2010901200712y5a74ac5fta578c9a2741a4237@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4223115535447158579=="
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

--===============4223115535447158579==
Content-Type: multipart/alternative;
	boundary="----=_Part_24971_24540437.1232464336759"

------=_Part_24971_24540437.1232464336759
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I have behaviour on my spi channel that seems odd.

I'm trying to communicate with a PROSlic 3210 from Silicon Labs.  Simply,
the device allows a read on a register by first writing (0x80 | reg) (a 1
followed by the 7 bit address of the register to be read), and then the next
time the chip is activated, it is supposed to drive the results onto the
MISO line.

I'm using spidev on top of atmel_spi.  What I'm seeing from the Atmel spi
controller is that it's driving MOSI to all zeros.  I've issued an
spi_ioc_transfer.  It closely matches the example in the Documentation/spi
directory (.tx_buf is set in the first element of the array, and the .rx_buf
is set in the second element, everything zero'd by memset at the start), but
I have set .cs_change after the transfer occurs, because that's what the
3210 wants.

I can't find any documentation as to why this might be happening.  The
PROSlic docs say that it will ignore MOSI during this time, but it's not
driving MISO at all, and I"m wondering if for some reason this behaviour is
confusing the device.  Is this normal for the SPI controller on reads?

Thank you.

Regards,

Matt

------=_Part_24971_24540437.1232464336759
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I have behaviour on my spi channel that seems odd.<br><br>I&#39;m trying to communicate with a PROSlic 3210 from Silicon Labs.&nbsp; Simply, the device allows a read on a register by first writing (0x80 | reg) (a 1 followed by the 7 bit address of the register to be read), and then the next time the chip is activated, it is supposed to drive the results onto the MISO line.<br>
<br>I&#39;m using spidev on top of atmel_spi.&nbsp; What I&#39;m seeing from the Atmel spi controller is that it&#39;s driving MOSI to all zeros.&nbsp; I&#39;ve issued an spi_ioc_transfer.&nbsp; It closely matches the example in the Documentation/spi directory (.tx_buf is set in the first element of the array, and the .rx_buf is set in the second element, everything zero&#39;d by memset at the start), but I have set .cs_change after the transfer occurs, because that&#39;s what the 3210 wants.<br>
<br>I can&#39;t find any documentation as to why this might be happening.&nbsp; The PROSlic docs say that it will ignore MOSI during this time, but it&#39;s not driving MISO at all, and I&quot;m wondering if for some reason this behaviour is confusing the device.&nbsp; Is this normal for the SPI controller on reads?<br>
<br>Thank you.<br><br>Regards,<br><br>Matt<br><br>

------=_Part_24971_24540437.1232464336759--


--===============4223115535447158579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
--===============4223115535447158579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============4223115535447158579==--
