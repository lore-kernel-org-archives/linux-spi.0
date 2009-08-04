From: arjun rath <rath.arjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: XR20M1172 -SPI-UART
Date: Tue, 4 Aug 2009 18:48:14 +0530
Message-ID: <dc6d3180908040618n714df95v210cd14a07b1ec01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4234364673905053744=="
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

--===============4234364673905053744==
Content-Type: multipart/alternative; boundary=0016e6480840078e4c047050b80d

--0016e6480840078e4c047050b80d
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,

I am working on XR20M1172 which is a two channel SPI uart with 64 byte
FIFO.Currently i am working on S3C2450 Processor
where it has given HSPI instead of SPI.And there is no link between spi.c
file and hspi.c.And one more file is being given i.e spi_s3c24xx.c file
which is generic to all samsung .

So my question is  my XR20M1172(slave spi) will communicate with hspi or
spi_s3c24xx file because i am registering my slave chip with spi.c file
which is talking with spi_s3c24xx.c file.

I am using linux 2.6.21 kernel source.

Any help will be greatful.

Regards

Arjun

--0016e6480840078e4c047050b80d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,<br><br>I am working on XR20M1172 which is a two channel SPI uart wi=
th 64 byte FIFO.Currently i am working on S3C2450 Processor<br>where it has=
 given HSPI instead of SPI.And there is no link between spi.c file and hspi=
.c.And one more file is being given i.e spi_s3c24xx.c file which is generic=
 to all samsung .<br>
<br>So my question is=A0 my  XR20M1172(slave spi) will communicate with hsp=
i or spi_s3c24xx file because i am registering my slave chip with spi.c fil=
e which is talking with spi_s3c24xx.c file.<br><br>I am using linux 2.6.21 =
kernel source.<br>
<br>Any help will be greatful.<br><br>Regards<br><br>Arjun<br><br>

--0016e6480840078e4c047050b80d--


--===============4234364673905053744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============4234364673905053744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============4234364673905053744==--
