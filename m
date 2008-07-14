From: "BRADWAY, Kevin" <kbradway-t/Sy+Gd0MBBBDgjK7y7TUQ@public.gmane.org>
Subject: mmc over spi
Date: Mon, 14 Jul 2008 16:20:32 -0500
Message-ID: <E92FEE65D4904D408A9BBE380F7E5E01014FA801@kramer.tem.drs.master>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1648400035=="
To: <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
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

This is a multi-part message in MIME format.

--===============1648400035==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8E5F7.72CF3284"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8E5F7.72CF3284
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


I am trying to use the mmc over spi in the 2.6.24 distro on a pxa25XX.

I have read and read the blackfin and the git pages for the 2.6.24 add ins f=
or this topic but I still can not seem to get it going.

I am using 
       gpio6 for the clock
       gpio12 for the CD
       gpio8 for the CS

questions:
        Do I need the pxa2XX_spi driver to make this work?

        Do I need to write my own init to get the thing to probe?

Thanks,
Kevin

This communication is intended only for use by the addressee(s) named herein=
 and may contain business confidential and/or legally privileged information=
. If you are not the intended recipient of this e-mail, you are hereby notif=
ied that any dissemination, distribution, disclosure or copying of this e-ma=
il and its contents is strictly prohibited. If you have received this e-mail=
 in error, kindly notify the sender by replying to this message. In addition=
, please permanently delete the message and any attachments without copying=
 or disclosing the contents. Thank you for your cooperation.               =
                                                                           =
              =0A=
THIS DOCUMENT AND/OR SHIPMENT MAY CONTAIN COMMODITY ITEMS, SOFTWARE OR TECHN=
ICAL DATA THAT IS CONTROLLED BY U.S. EXPORT LAW, AND MAY NOT BE EXPORTED OUT=
SIDE THE UNITED STATES OR TO NON U.S. PERSONS WITHOUT THE APPROPRIATE EXPORT=
 LICENSE FROM EITHER THE U.S. DEPARTMENT OF STATE OR DEPARTMENT OF COMMERCE.

------_=_NextPart_001_01C8E5F7.72CF3284
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Diso-8859-1=
">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.7652.24">
<TITLE>mmc over spi</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>I am trying to use the mmc over spi in the 2.6.24 distro o=
n a pxa25XX.<BR>
<BR>
I have read and read the blackfin and the git pages for the 2.6.24 add ins f=
or this topic but I still can not seem to get it going.<BR>
<BR>
I am using<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio6 for the clock<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio12 for the CD<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpio8 for the CS<BR>
<BR>
questions:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Do I need the pxa2XX_spi driver t=
o make this work?<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Do I need to write my own init to=
 get the thing to probe?<BR>
<BR>
Thanks,<BR>
Kevin<BR>
</FONT>
</P>

This communication is intended only for use by the addressee(s) named herein=
 and may contain business confidential and/or legally privileged information=
. If you are not the intended recipient of this e-mail, you are hereby notif=
ied that any dissemination, distribution, disclosure or copying of this e-ma=
il and its contents is strictly prohibited. If you have received this e-mail=
 in error, kindly notify the sender by replying to this message. In addition=
, please permanently delete the message and any attachments without copying=
 or disclosing the contents. Thank you for your cooperation.  <p>=0A=
THIS DOCUMENT AND/OR SHIPMENT MAY CONTAIN COMMODITY ITEMS, SOFTWARE OR TECHN=
ICAL DATA THAT IS CONTROLLED BY U.S. EXPORT LAW, AND MAY NOT BE EXPORTED OUT=
SIDE THE UNITED STATES OR TO NON U.S. PERSONS WITHOUT THE APPROPRIATE EXPORT=
 LICENSE FROM EITHER THE U.S. DEPARTMENT OF STATE OR DEPARTMENT OF COMMERCE.=
</BODY>
</HTML>
------_=_NextPart_001_01C8E5F7.72CF3284--


--===============1648400035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--===============1648400035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============1648400035==--
