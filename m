From: "Ahmed, Suhail" <suhail.ahmed-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: SPI core support for Master
Date: Fri, 6 Jun 2008 16:09:03 -0700
Message-ID: <AF358A0C5B36EC4486D1A764A171904D03701267@fmsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0753211842=="
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

--===============0753211842==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8C82A.4FCC9A52"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8C82A.4FCC9A52
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

=20

I am newbie on SPI, and subscribed to the mailing list just today!

=20

I did some reading on the linux SPI support and here is my
understanding:

=20

1.       The controller drivers manages the SPI controller on the host

2.       The protocol driver manages the SPI devices on the other side
of the SPI link.

3.       Currently, there is support only for SPI master mode on the
host with devices connected as Slaves. This essentially means,
currently, we can have Master controller driver(s) and protocol slave
drivers

=20

Is the above correct understanding? I will appreciate any correction.

=20

Now, if I have a need to support Slave mode on the host with device
connected in Master mode:

=20

1.       Is there any plan to support this configuration?

2.       If not, how much work would it be? Can the existing core be
extended to accommodate this, or is it a re-design?

=20

Thanks in advance,

=20

~Suhail

=20

=20


------_=_NextPart_001_01C8C82A.4FCC9A52
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hello,</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am newbie on SPI, and subscribed to the mailing =
list just
today!</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I did some reading on the linux SPI support and here =
is my understanding:</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:.25in;text-indent:-.25in'><font size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'>1.<font =
size=3D1
face=3D"Times New Roman"><span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></span></font><span dir=3DLTR><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>The controller drivers =
manages the
SPI controller on the host</span></font></span></p>

<p class=3DMsoNormal =
style=3D'margin-left:.25in;text-indent:-.25in'><font size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'>2.<font =
size=3D1
face=3D"Times New Roman"><span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></span></font><span dir=3DLTR><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>The protocol driver manages =
the SPI
devices on the other side of the SPI link.</span></font></span></p>

<p class=3DMsoNormal =
style=3D'margin-left:.25in;text-indent:-.25in'><font size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'>3.<font =
size=3D1
face=3D"Times New Roman"><span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></span></font><span dir=3DLTR><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>Currently, there is support =
only for
SPI master mode on the host with devices connected as Slaves. This =
essentially means,
currently, we can have Master controller driver(s) and protocol slave =
drivers</span></font></span></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Is the above correct understanding? I will appreciate =
any
correction.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Now, if I have a need to support Slave mode on the =
host with
device connected in Master mode:</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:.25in;text-indent:-.25in'><font size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'>1.<font =
size=3D1
face=3D"Times New Roman"><span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></span></font><span dir=3DLTR><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>Is there any plan to =
support this
configuration?</span></font></span></p>

<p class=3DMsoNormal =
style=3D'margin-left:.25in;text-indent:-.25in'><font size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'>2.<font =
size=3D1
face=3D"Times New Roman"><span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></span></font><span dir=3DLTR><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>If not, how much work would =
it be? Can
the existing core be extended to accommodate this, or is it a =
re-design?</span></font></span></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks in advance,</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>~Suhail</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C8C82A.4FCC9A52--


--===============0753211842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============0753211842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============0753211842==--
