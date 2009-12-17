From: RReid-bzdhNXfUkCO9cZYRalvpnEEOCMrvLtNR@public.gmane.org
Subject: spi dd ICH10
Date: Wed, 16 Dec 2009 21:15:29 -0500
Message-ID: <OF6E3F3B85.3E309D49-ON8525768F.000BE576-8525768F.000C67B3@overlandstorage.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6856167959432353148=="
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
--===============6856167959432353148==
Content-Type: multipart/alternative;
	boundary="=_alternative 000C655F8525768F_="

This is a multipart message in MIME format.
--=_alternative 000C655F8525768F_=
Content-Type: text/plain; charset="US-ASCII"

I am working on a platform with Tylersburg chip set with an ICH10 south 
bridge acting as the spi controller to an atmel flash device. (linux 
kernel = 2.6.27.19)  The mtd device driver m25p80 supports our atmel flash 
but I seem to be lacking an spi driver for the ICH10.  (I am not finding 
the spi master support for ICH10)  Does anyone know whether there even is 
such support or where I might find it?  (or could point me in a better 
direction?)

----------------------------------------------------
Tiered Data Protection Made Simple
http://www.overlandstorage.com/
----------------------------------------------------


--=_alternative 000C655F8525768F_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">I am working on a platform with Tylersburg
chip set with an ICH10 south bridge acting as the spi controller to an
atmel flash device. (linux kernel = 2.6.27.19) &nbsp;The mtd device driver
m25p80 supports our atmel flash but I seem to be lacking an spi driver
for the ICH10. &nbsp;(I am not finding the spi master support for ICH10)
&nbsp;Does anyone know whether there even is such support or where I might
find it? &nbsp;(or could point me in a better direction?)</font><FONT SIZE=3><BR>
<BR>
----------------------------------------------------<BR>
Tiered Data Protection Made Simple<BR>
http://www.overlandstorage.com/<BR>
----------------------------------------------------<BR>
</FONT>

--=_alternative 000C655F8525768F_=--


--===============6856167959432353148==
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
--===============6856167959432353148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============6856167959432353148==--
