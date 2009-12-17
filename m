From: RReid-bzdhNXfUkCO9cZYRalvpnEEOCMrvLtNR@public.gmane.org
Subject: ICH10 SPI controller not found
Date: Thu, 17 Dec 2009 14:54:11 -0500
Message-ID: <OF2F455626.B16B14E0-ON8525768F.006D0737-8525768F.006D54C4@overlandstorage.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0991642873806795111=="
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

This is a multipart message in MIME format.
--===============0991642873806795111==
Content-Type: multipart/alternative;
	boundary="=_alternative 006D4FA98525768F_="

This is a multipart message in MIME format.
--=_alternative 006D4FA98525768F_=
Content-Type: text/plain; charset="US-ASCII"

I am working on a platform with an ICH10 acting as a spi controller to an 
atmel flash device. (linux kernel = 2.6.27.19)  The mtd device driver 
m25p80 supports our atmel flash but I seem to be lacking an spi driver for 
the ICH10.  (I am not finding the spi master support for ICH10)  Does 
anyone know whether there even is such support or where I might find it? 
(or could point me in a better direction?)



----------------------------------------------------
Tiered Data Protection Made Simple
http://www.overlandstorage.com/
----------------------------------------------------


--=_alternative 006D4FA98525768F_=
Content-Type: text/html; charset="US-ASCII"


<br>
<form action=http://sourceforge.net/mailarchive/forum.php>
<table width=100%>
<tr>
<td width=100%><font size=2 face="sans-serif">I am working on a platform
with an ICH10 acting as a spi controller to an atmel flash device. (linux
kernel = 2.6.27.19) &nbsp;The mtd device driver m25p80 supports our atmel
flash but I seem to be lacking an spi driver for the ICH10. &nbsp;(I am
not finding the spi master support for ICH10) &nbsp;Does anyone know whether
there even is such support or where I might find it? &nbsp;(or could point
me in a better direction?)</font></table>
<br>
<br></form><FONT SIZE=3><BR>
<BR>
----------------------------------------------------<BR>
Tiered Data Protection Made Simple<BR>
http://www.overlandstorage.com/<BR>
----------------------------------------------------<BR>
</FONT>

--=_alternative 006D4FA98525768F_=--


--===============0991642873806795111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
--===============0991642873806795111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============0991642873806795111==--
