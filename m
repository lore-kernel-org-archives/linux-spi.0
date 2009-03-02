From: sivakumar borela <borelaskumar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: DSPI slave linux driver
Date: Mon, 2 Mar 2009 09:20:09 -0500
Message-ID: <5a775e870903020620k56f84f7cwfa6c11cbb4a9277a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0619238904976362394=="
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

--===============0619238904976362394==
Content-Type: multipart/alternative; boundary=00221532c5b41cd04904642384c8

--00221532c5b41cd04904642384c8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

My selef, SivaKumar working as Embedded software engineer. One of our
products is based on MCF5485 coldfire processor. We are using Embedded linux
from Freescale on our board. The BSP does have DSPI(DMA enabled SPI) master
driver. But our requirement is to configure MCF5485 as DSPI slave to
communicate with the external master which is 68332 processor board. The
protocol demands request/response model to communicate with the master. We
could not able to succeed in making the DSPI slave to work.

"Changed the chip control register from master to salve by modifying the bit
in mode control register"

We are not getting any interrupts from the processor to call read and write
functions.

Freescale has done customization of coldfire_spi driver for MCF5485.

First of all my query is
1) is there any piece of linux spi slave driver till now?
2) If you have any slave driver implementation , could you please provide
the code for me to implement the SPI slave?


Thanks,
Siva

--00221532c5b41cd04904642384c8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div>
<div>=A0</div>
<div>My selef, SivaKumar working as Embedded software engineer. One of our =
products is based on MCF5485 coldfire processor. We are using Embedded linu=
x from Freescale on our board. The BSP does have DSPI(DMA enabled SPI) mast=
er driver. But our requirement is to configure MCF5485 as DSPI slave to com=
municate with the external master which is 68332 processor board. The proto=
col demands request/response model to communicate with the master. We could=
 not able to succeed in making the DSPI slave to work.</div>

<div>=A0</div>
<div>&quot;Changed the chip control register from master to salve by modify=
ing the bit in mode control register&quot;</div>
<div>=A0</div>
<div>We are not getting any interrupts from the processor to call read and =
write functions.</div>
<div>=A0</div>
<div>Freescale has done customization of coldfire_spi driver for MCF5485.</=
div>
<div>=A0</div>
<div>First of all my query is </div>
<div>1) is there any piece of linux spi slave driver till now?</div>
<div>2) If you have any slave driver implementation , could you please prov=
ide the code for me to implement the SPI slave?</div>
<div>=A0</div>
<div>=A0</div>
<div>Thanks,</div>
<div>Siva</div>

--00221532c5b41cd04904642384c8--


--===============0619238904976362394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
--===============0619238904976362394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============0619238904976362394==--
