From: jassi brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: s3c24xx SPI without Bitbang interface?
Date: Tue, 30 Jun 2009 10:27:28 +0900
Message-ID: <1b68c6790906291827i1f7bce49q520e9950ba623e9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6097290944868720399=="
Cc: jassi brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

--===============6097290944868720399==
Content-Type: multipart/alternative; boundary=001485eafe8cb34302046d86b5e1

--001485eafe8cb34302046d86b5e1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,
  I see drivers/spi/spi_s3c24xx.c uses bitbang i/f eventhough 24xx has a
dedicated SPI controller. Wasn't bitbang is supposed to be for SOCs which
don't have a SPI controller.
 I was wondering why cudn't we make it work without the Bitbang abstraction?
Any potential issues that I am failing to fathom?
And, s3c24xx.c doesn't make use of DMA. Any particular reason against it?

I am willing to contribute my code, if need be.

Regards,
Jassi

--001485eafe8cb34302046d86b5e1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br>=A0 I see drivers/spi/spi_s3c24xx.c uses bitbang i/f eventhough 2=
4xx has a dedicated SPI controller. Wasn&#39;t bitbang is supposed to be fo=
r SOCs which don&#39;t have a SPI controller.<br>=A0I was wondering why cud=
n&#39;t we make it work without the Bitbang abstraction? Any potential issu=
es that I am failing to fathom?<br>
And, s3c24xx.c doesn&#39;t make use of DMA. Any particular reason against i=
t?<br><br>I am willing to contribute my code, if need be.<br><br>Regards,<b=
r>Jassi<br>

--001485eafe8cb34302046d86b5e1--


--===============6097290944868720399==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============6097290944868720399==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============6097290944868720399==--
