From: Ravi Shekhar <Ravi.Shekhar-Qn3oZ/JxBW9Wk0Htik3J/w@public.gmane.org>
Subject: spi fram help
Date: Tue, 3 Nov 2009 10:51:44 +0530
Message-ID: <OF0B152BDC.21E50BCC-ON65257663.001D500F-65257663.001D66FE@lntemsys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7612756905323508750=="
Cc: ravs.spirit-DVMQ0Vekzmh0ubjbjo6WXg@public.gmane.org, Ravi Shekhar <Ravi.Shekhar-Qn3oZ/JxBW9Wk0Htik3J/w@public.gmane.org>
To: spi-devel-general <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

This is a multipart message in MIME format.
--===============7612756905323508750==
Content-Type: multipart/alternative;
	boundary="=_alternative 001D66F565257663_="

This is a multipart message in MIME format.
--=_alternative 001D66F565257663_=
Content-Type: text/plain; charset="US-ASCII"

Hi
 
I am using MPC8313 and trying to attach Ramtron FRAM to my board. I am 
using 2.6.29 linux and i have updated spi_mpc8xxx.c driver. I am able to 
see the master driver register and detecting my device as spi3276. But now 
the problem is with FRAM part. I am trying to port at25 eeprom driver from 
drivers/misc/eeprom/at25.c to be used by FRAM. Once my mpc8xxx_spi driver 
gets registered, I also get following message : bus: 'spi': add device 
spi32766.0 
 I am not sure how to attach my device with at25 driver and how to access 
it. Please help. It's urgent.
 
Thanks in advance

    --- Ravi 
--=_alternative 001D66F565257663_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=3>Hi</font>
<p><font size=3>&nbsp;</font>
<p><font size=3>I am using MPC8313 and trying to attach Ramtron FRAM to
my board. I am using 2.6.29 linux and i have updated spi_mpc8xxx.c driver.
I am able to see the master driver register and detecting my device as
<b>spi3276</b>. But now the problem is with FRAM part. I am trying to port
at25 eeprom driver from drivers/misc/eeprom/at25.c to be used by FRAM.
Once my mpc8xxx_spi driver gets registered, I also get following message
: <b>bus: 'spi': add device spi32766.0 </b></font>
<p><font size=3>&nbsp;I am not sure how to attach my device with at25 driver
and how to access it. Please help. It's urgent.</font>
<p><font size=3>&nbsp;</font>
<p><font size=3>Thanks in advance</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; --- Ravi </font>
--=_alternative 001D66F565257663_=--


--===============7612756905323508750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--===============7612756905323508750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============7612756905323508750==--
