From: Martin Qiu <martin_sjtu-/E1597aS9LRv1O+Z8WTAqQ@public.gmane.org>
Subject: Question about pxa2xx_spi.c
Date: Wed, 25 Jun 2008 15:51:33 +0800 (CST)
Message-ID: <961055.62866.qm@web15812.mail.cnb.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0724021639=="
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

--===============0724021639==
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable

Hiall,

I am newcomer for SPI devleopment. Here is one
question regarding the pxa2xx_spi.c:

Why does it use tasklet to handle each spi_transfer,
as spi_message is already use work queue thread to
handle?=20

If one protocol driver wants to write a char to the
device, then one spi_msg with only one spi_transfer is
created, the spi_msg will first added to the
workqueue, when it scheduled to run, it will put the
spi_transfer to tasklet list waiting for handling,
here is a 2 step wating, will it be effective for
pxa2xx_spi.c? Is there any specail design thought for
it? Thanks!

Best Regards
Martin


      ___________________________________________________________=20
 =D1=C5=BB=A2=D3=CA=CF=E4=A3=AC=C4=FA=B5=C4=D6=D5=C9=FA=D3=CA=CF=E4=A3=A1=
=20
http://cn.mail.yahoo.com/


--===============0724021639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============0724021639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============0724021639==--
