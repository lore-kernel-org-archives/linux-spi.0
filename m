From: He Man <king.of.jungle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Spansion SPI Probe?
Date: Wed, 23 Dec 2009 10:12:03 +0000
Message-ID: <70af14ce0912230212p744d2fc4r5445887895dd532@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2487876582166867378=="
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

--===============2487876582166867378==
Content-Type: multipart/alternative; boundary=001636e904c6d02003047b628d7f

--001636e904c6d02003047b628d7f
Content-Type: text/plain; charset=ISO-8859-1

Hi,

  I have a ARM11 based SoC with SPI controller in it. The board
  contains Spansion S25 SPI flash chip. I am writing the driver
  for the SPI controller from scratch but i am missing something in
  getting the Spansion chip to be detected. Please help.

  Here are the steps.

  - Controller driver - I registered a platform_device in the SoC core code.

  For the same platform_device name i have a driver registered in
drivers/spi
  dir (similar to xilinx spi but no bitbang). The probe works fine. I have
  platform_data with bus num and cs set to 0 and mode to SPI_MODE_3. (This
is
  the default i use in u-boot and it works fine with Spansion)

  - Now for the discrete spansion chip, i found that m25p80 code can be used
  as it supports Spansion SPI as well. I loaded the driver but it does not
  call m25p80_probe. The name of this driver is "m25p80".

  I can understand why the driver did not start probing coz there is no
device
  of the name "m25p80" the kernel aware of. But how do i register that
  device and where

Thanks,
C

--001636e904c6d02003047b628d7f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br>Hi,<br><br>=A0 I have a ARM11 based SoC with SPI controller in it. The =
board<br>=A0 contains Spansion S25 SPI flash chip. I am writing the driver<=
br>=A0 for the SPI controller from scratch but i am missing something in<br=
>=A0 getting the Spansion chip to be detected. Please help. <br>
<br>=A0 Here are the steps.<br><br>=A0 - Controller driver - I registered a=
 platform_device in the SoC core code. <br>=A0 For the same platform_device=
 name i have a driver registered in drivers/spi<br>=A0 dir (similar to xili=
nx spi but no bitbang). The probe works fine. I have<br>
=A0 platform_data with bus num and cs set to 0 and mode to SPI_MODE_3. (Thi=
s is<br>=A0 the default i use in u-boot and it works fine with Spansion)<br=
><br>=A0 - Now for the discrete spansion chip, i found that m25p80 code can=
 be used<br>
=A0 as it supports Spansion SPI as well. I loaded the driver but it does no=
t<br>=A0 call m25p80_probe. The name of this driver is &quot;m25p80&quot;. =
<br><br>=A0 I can understand why the driver did not start probing coz there=
 is no device<br>
=A0 of the name &quot;m25p80&quot; the kernel aware of. But how do i regist=
er that<br>=A0 device and where<br><br>Thanks,<br>C<br>

--001636e904c6d02003047b628d7f--


--===============2487876582166867378==
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
--===============2487876582166867378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============2487876582166867378==--
