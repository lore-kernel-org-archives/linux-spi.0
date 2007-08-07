From: "=?euc-kr?B?sK2787/s?=" <ksw412-cum4M3oa/1ZBDgjK7y7TUQ@public.gmane.org>
Subject: =?euc-kr?q?I_can=27t_see_the_spi_device_file_?=
	=?euc-kr?q?in_/dev_folder=2E?=
Date: Tue, 07 Aug 2007 21:10:27 +0900
Message-ID: <1186488627778402.0.mail02@mail02>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1842453309=="
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

--===============1842453309==
Content-Type: text/html; charset=euc-kr
Content-Transfer-Encoding: quoted-printable

<style> BODY { background-color: #ffffff;}            BODY, TD, TH { colo=
r: black; font-family: =B1=BC=B8=B2; font-size: 12px; }            TD { b=
order: 0px}             P { margin: 0px; }     </style>Hi~&nbsp;=20
<P>&nbsp;</P>
<P>My developing Environment is below. </P>
<P><BR>Kernel-2.6.22 </P>
<P><FONT color=3D#ff9900>&nbsp;&nbsp;&nbsp;&nbsp; </FONT></P>
<P><FONT color=3D#ff9900>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT><FONT color=
=3D#5c585a>tar jxvf linux-2.6.22.1.tar.bz2</FONT></P>
<P><FONT color=3D#5c585a>&nbsp;&nbsp;&nbsp;&nbsp; cd linux-2.6.22.1</FONT=
></P>
<P><FONT color=3D#5c585a>&nbsp;&nbsp;&nbsp;&nbsp; zcat ../2.6.22-rc1-at91=
.patch.gz | patch -p1 &gt; patchresult.txt</FONT></P>
<P>&nbsp;</P>
<P>CPU-AT91SAM9260 </P>
<P>&nbsp;</P>
<P>&nbsp;</P>
<P>Through the web searching and kernel documentation, I know that use th=
e spidev kernel module. </P>
<P>And I modify arch/at-91/board_sam9260.c file as like below <BR><BR>sta=
tic struct spi_board_info ek_spi_devices[] =3D { <BR>{ //spi1.0-slot1 <BR=
>.modalias =3D "spidev", <BR>.chip_select =3D 0, <BR>.max_speed_hz =3D 15=
*1000*1000, <BR>.bus_num=3D1, <BR>}, <BR>{ //spi1.1-slot2 <BR>.modalias =3D=
 "spidev", <BR>.chip_select =3D 1, <BR>.max_speed_hz =3D 15*1000*1000, <B=
R>.bus_num=3D1, <BR>}, <BR>{ //spi1.2-slot3 <BR>.modalias =3D "spidev", <=
BR>.chip_select =3D 2, <BR>.max_speed_hz =3D 15*1000*1000, <BR>.bus_num=3D=
1, <BR>}, <BR>{ //spi1.3-slot4 <BR>.modalias =3D "spidev", <BR>.chip_sele=
ct =3D 3, <BR>.max_speed_hz =3D 15*1000*1000, <BR>.bus_num=3D1, <BR>}, <B=
R>} <BR><BR>After compiling the kernel, download kernel img to the target=
. </P>
<P>&nbsp;</P>
<P><FONT color=3D#5c585a>Kernel menu_config.</FONT></P>
<P>&nbsp;</P>
<P><FONT color=3D#5c585a>Device Drivers</FONT></P>
<P><FONT color=3D#5c585a>&nbsp;SPI support</FONT></P>
<P><FONT color=3D#5c585a>&nbsp;&nbsp;&nbsp; [*]SPI support</FONT></P>
<P><FONT color=3D#5c585a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [*]De=
bug support for SPI drivers</FONT></P>
<P><FONT color=3D#5c585a>&nbsp;&nbsp;&nbsp;&nbsp; SPI Master Controller D=
rivers</FONT></P>
<P><FONT color=3D#5c585a>&nbsp;&nbsp;&nbsp;&nbsp; [*]Atmel SPI controller=
</FONT></P>
<P><FONT color=3D#5c585a>&nbsp;&nbsp;&nbsp;&nbsp; [ ]Bitbanging SPI maste=
r</FONT></P>
<P><FONT color=3D#5c585a>&nbsp;&nbsp;&nbsp;&nbsp; SPI Protocol Masters</F=
ONT></P>
<P><FONT color=3D#5c585a>&nbsp;&nbsp;&nbsp;&nbsp; [ ]SPI EEPROMs from mos=
t vendors</FONT></P>
<P><FONT color=3D#5c585a>&nbsp;&nbsp;&nbsp;&nbsp; [*]User mode SPI device=
 driver support</FONT></P>
<P><BR><BR><BR>I execute the "/sbin/mdev -s" command into the target shel=
l as expecting the /dev/spidev. </P>
<P>But I can't see the device file for SPI in target /dev folder. And I e=
xamin my /sys folder at target. </P>
<P>&nbsp;</P>
<P>Of course, I can find the spi device nodes created from modified board=
_sam9260.c. <BR><BR>Hum...I don't know why did not populate the SPI devic=
e file in /dev file? <BR></P>
<P>&nbsp;</P>
<P>#dmesg | grep spi</P>
<P>atmel_spi atmel_spi.1: Atmel SPI Controller at 0xfffcc000 (irq 13) <BR=
>atmel_spi atmel_spi.1: registered master spi1 <BR>spi spi1.0: setup: 141=
89714 Hz bpw 8 mode 0x0 -&gt; csr0 0a0a0702 <BR>atmel_spi atmel_spi.1: re=
gistered child spi1.0 <BR>spi spi1.1: setup: 14189714 Hz bpw 8 mode 0x0 -=
&gt; csr1 0a0a0702 <BR>atmel_spi atmel_spi.1: registered child spi1.1 <BR=
>spi spi1.2: setup: 14189714 Hz bpw 8 mode 0x0 -&gt; csr2 0a0a0702 <BR>at=
mel_spi atmel_spi.1: registered child spi1.2 <BR>spi spi1.3: setup: 14189=
714 Hz bpw 8 mode 0x0 -&gt; csr3 0a0a0702 <BR>atmel_spi atmel_spi.1: regi=
stered child spi1.3 <BR></P>
<P><BR>Does root file system (NFS) has the problem ? or Kernel menu confi=
guration ?</P>
<P>Could you teach check point for this problem?</P>
<P>&nbsp;</P>
<P>This project name - Access control Unit</P>
<P>The system is configured two kind of board.</P>
<P>Main b'd has the AT91SAM9260 which has the Linux OS.</P>
<P>Sub b'd has the Atmega2560 which is developing the AVR32 studio.</P>
<P>One Main b'd is connected 5 Sub b'd by SPI</P>
<P>Sub b'd is connected door lock by wiegend.</P>
<P>Main b'd is connected ACU server by TCP/IP.</P>
<P>&nbsp;</P>
<P>And SPI Interface is very important!. Other communication interface is=
 done.</P>
<P>Please Help me.&nbsp;</P>
<P>Please Help me~. I had reported this problems to atmel and at91 but I =
did not receive any reply~<BR></P><br><br><table width=3D100% cellpadding=
=3D0 cellspacing=3D0 border=3D0><tr><td background=3D'http://mbox03.hanaf=
os.com/include_css/hanaro/dot.gif' style=3D'height: 1px; margin: 0 0 0 0;=
background-repeat: repeat-x;' ></td></tr></table><p><br><table width=3D10=
0% cellpadding=3D0 cellspacing=3D0 border=3D0><tr><td align=3D'right'><a =
href=3D"http://www.hanafos.com" target=3D"_blank"><img src=3D"http://madm=
01.hanafos.com/images/kor/skin/hanaro/images/hanofosLogo.gif" border=3D'0=
'/></a>
</td></tr></table></p>
<img src=3D"http://mbox03.hanafos.com/mail/PutAck.jsp?ack_args=3Dc2VudF9m=
aWxlPWtzdzQxMkBoYW5hZm9zLmNvbS8uU2VudC8xMTg2NDg4NjI3MTQzLjMzNzEyLmhhbmFmb=
3Mmc2VuZF9kYXRlPTIwMDcwODA3MjExMDI3JnN1YmplY3Q9SSBjYW4ndCBzZWUgdGhlIHNwaS=
BkZXZpY2UgZmlsZSBpbiAvZGV2IGZvbGRlci4=3D&to_email=3Dspi-devel-general@lis=
ts.sourceforge.net_______________________________________________________=
________________________________________________________" width=3D"1" bor=
der=3D"0" height=3D"1">




--===============1842453309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1842453309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============1842453309==--
