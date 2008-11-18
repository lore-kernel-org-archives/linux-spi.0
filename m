From: Andrea Paterniani <a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org>
Subject: Re: [patch 2.6.28-rc5] SPI -- Freescale iMX SPI
	controller driver
Date: Tue, 18 Nov 2008 09:30:07 +0100
Message-ID: <49227D0F.1030806@swapp-eng.it>
References: <49217ACF.7080904@swapp-eng.it>
	<200811171218.47550.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2656380032836902400=="
Cc: SPI Devel General <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Linux ARM Kernel <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200811171218.47550.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This is a multi-part message in MIME format.
--===============2656380032836902400==
Content-Type: multipart/alternative;
	boundary="------------030006090004000604020206"

This is a multi-part message in MIME format.
--------------030006090004000604020206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

It's ok.
The only difference I see is a character * added a the beginning of a 
comment:

+	/* NULL rx means write-only transfer and no map needed
+	 * since rx DMA will not be used */

should be

+	/* NULL rx means write-only transfer and no map needed
+	   since rx DMA will not be used */


Regards,
- Andrea


David Brownell ha scritto:
> On Monday 17 November 2008, Andrea Paterniani wrote:
>   
>> Fix unsafe order in dma mapping operation.
>>     
>
> This arrived horribly mangled.  Can you verify that the
> appended patch is an appropriate un-mangled version?
>
> ======= CUT HERE
> From: Andrea Paterniani <a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org>
>
> Fix unsafe order in dma mapping operation: always flush data from
> the cache *BEFORE* invalidating it, to allow full duplex transfers
> where the same buffer may be used for both writes and reads.
>
> Signed-off-by: Andrea Paterniani <a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org>
> ---
>  drivers/spi/spi_imx.c |   45 ++++++++++++++++++++++-----------------------
>  1 file changed, 22 insertions(+), 23 deletions(-)
>
> --- a/drivers/spi/spi_imx.c
> +++ b/drivers/spi/spi_imx.c
> @@ -506,20 +506,6 @@ static int map_dma_buffers(struct driver
>  	if (!IS_DMA_ALIGNED(drv_data->rx) || !IS_DMA_ALIGNED(drv_data->tx))
>  		return -1;
>  
> -	/* NULL rx means write-only transfer and no map needed
> -	   since rx DMA will not be used */
> -	if (drv_data->rx) {
> -		buf = drv_data->rx;
> -		drv_data->rx_dma = dma_map_single(
> -					dev,
> -					buf,
> -					drv_data->len,
> -					DMA_FROM_DEVICE);
> -		if (dma_mapping_error(dev, drv_data->rx_dma))
> -			return -1;
> -		drv_data->rx_dma_needs_unmap = 1;
> -	}
> -
>  	if (drv_data->tx == NULL) {
>  		/* Read only message --> use drv_data->dummy_dma_buf for dummy
>  		   writes to achive reads */
> @@ -533,18 +519,31 @@ static int map_dma_buffers(struct driver
>  					buf,
>  					drv_data->tx_map_len,
>  					DMA_TO_DEVICE);
> -	if (dma_mapping_error(dev, drv_data->tx_dma)) {
> -		if (drv_data->rx_dma) {
> -			dma_unmap_single(dev,
> -					drv_data->rx_dma,
> -					drv_data->len,
> -					DMA_FROM_DEVICE);
> -			drv_data->rx_dma_needs_unmap = 0;
> -		}
> +	if (dma_mapping_error(dev, drv_data->tx_dma))
>  		return -1;
> -	}
>  	drv_data->tx_dma_needs_unmap = 1;
>  
> +	/* NULL rx means write-only transfer and no map needed
> +	 * since rx DMA will not be used */
> +	if (drv_data->rx) {
> +		buf = drv_data->rx;
> +		drv_data->rx_dma = dma_map_single(dev,
> +						buf,
> +						drv_data->len,
> +						DMA_FROM_DEVICE);
> +		if (dma_mapping_error(dev, drv_data->rx_dma)) {
> +			if (drv_data->tx_dma) {
> +				dma_unmap_single(dev,
> +						drv_data->tx_dma,
> +						drv_data->tx_map_len,
> +						DMA_TO_DEVICE);
> +				drv_data->tx_dma_needs_unmap = 0;
> +			}
> +			return -1;
> +		}
> +		drv_data->rx_dma_needs_unmap = 1;
> +	}
> +
>  	return 0;
>  }
>  
>
>
>   

-- 


 

------------------------------------------------------------------------

*Ing. Andrea Paterniani*

*SWAPP* - Studio Professionale
Via degli Abeti, 312 - 61100 Pesaro
Tel 0721 24256
Fax 178 220 8730
 
a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org
www.swapp-eng.it 
<mailto:%0d%0aa.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org%0d%0awww.swapp-eng.it>

------------------------------------------------------------------------

--------------030006090004000604020206
Content-Type: multipart/related;
	boundary="------------000701070907030708040702"


--------------000701070907030708040702
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
It's ok.<br>
The only difference I see is a character * added a the beginning of a
comment:<br>
<pre wrap="">
+	/* NULL rx means write-only transfer and no map needed
+	 * since rx DMA will not be used */</pre>
should be<br>
<pre wrap="">+	/* NULL rx means write-only transfer and no map needed
+	   since rx DMA will not be used */</pre>
<br>
Regards,<br>
- Andrea<br>
<br>
<br>
David Brownell ha scritto:
<blockquote cite="mid:200811171218.47550.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org"
 type="cite">
  <pre wrap="">On Monday 17 November 2008, Andrea Paterniani wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Fix unsafe order in dma mapping operation.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
This arrived horribly mangled.  Can you verify that the
appended patch is an appropriate un-mangled version?

======= CUT HERE
From: Andrea Paterniani <a class="moz-txt-link-rfc2396E" href="mailto:a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org">&lt;a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org&gt;</a>

Fix unsafe order in dma mapping operation: always flush data from
the cache *BEFORE* invalidating it, to allow full duplex transfers
where the same buffer may be used for both writes and reads.

Signed-off-by: Andrea Paterniani <a class="moz-txt-link-rfc2396E" href="mailto:a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org">&lt;a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org&gt;</a>
---
 drivers/spi/spi_imx.c |   45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -506,20 +506,6 @@ static int map_dma_buffers(struct driver
 	if (!IS_DMA_ALIGNED(drv_data-&gt;rx) || !IS_DMA_ALIGNED(drv_data-&gt;tx))
 		return -1;
 
-	/* NULL rx means write-only transfer and no map needed
-	   since rx DMA will not be used */
-	if (drv_data-&gt;rx) {
-		buf = drv_data-&gt;rx;
-		drv_data-&gt;rx_dma = dma_map_single(
-					dev,
-					buf,
-					drv_data-&gt;len,
-					DMA_FROM_DEVICE);
-		if (dma_mapping_error(dev, drv_data-&gt;rx_dma))
-			return -1;
-		drv_data-&gt;rx_dma_needs_unmap = 1;
-	}
-
 	if (drv_data-&gt;tx == NULL) {
 		/* Read only message --&gt; use drv_data-&gt;dummy_dma_buf for dummy
 		   writes to achive reads */
@@ -533,18 +519,31 @@ static int map_dma_buffers(struct driver
 					buf,
 					drv_data-&gt;tx_map_len,
 					DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, drv_data-&gt;tx_dma)) {
-		if (drv_data-&gt;rx_dma) {
-			dma_unmap_single(dev,
-					drv_data-&gt;rx_dma,
-					drv_data-&gt;len,
-					DMA_FROM_DEVICE);
-			drv_data-&gt;rx_dma_needs_unmap = 0;
-		}
+	if (dma_mapping_error(dev, drv_data-&gt;tx_dma))
 		return -1;
-	}
 	drv_data-&gt;tx_dma_needs_unmap = 1;
 
+	/* NULL rx means write-only transfer and no map needed
+	 * since rx DMA will not be used */
+	if (drv_data-&gt;rx) {
+		buf = drv_data-&gt;rx;
+		drv_data-&gt;rx_dma = dma_map_single(dev,
+						buf,
+						drv_data-&gt;len,
+						DMA_FROM_DEVICE);
+		if (dma_mapping_error(dev, drv_data-&gt;rx_dma)) {
+			if (drv_data-&gt;tx_dma) {
+				dma_unmap_single(dev,
+						drv_data-&gt;tx_dma,
+						drv_data-&gt;tx_map_len,
+						DMA_TO_DEVICE);
+				drv_data-&gt;tx_dma_needs_unmap = 0;
+			}
+			return -1;
+		}
+		drv_data-&gt;rx_dma_needs_unmap = 1;
+	}
+
 	return 0;
 }
 


  </pre>
</blockquote>
<br>
<div class="moz-signature">-- <br>
<title></title>
<meta http-equiv="Content-Type" content="text/html; ">
<meta content="MSHTML 6.00.2800.1609" name="GENERATOR">
<p><br>
<font face="Arial">&nbsp;</font> </p>
<hr>
<p><b><font color="#000080" face="Arial" size="3">Ing. Andrea Paterniani</font></b>
</p>
<p><font color="#000080" size="2"><b><font face="Arial">SWAPP</font></b><font
 face="Arial"> - Studio Professionale</font> <br>
<font face="Arial">Via degli Abeti, 312 - 61100 Pesaro</font> <br>
<font face="Arial">Tel 0721 24256</font> <br>
<font face="Arial">Fax 178 220 8730</font> <br>
<font face="Arial">&nbsp;</font> <a
 href="mailto:%0d%0aa.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org%0d%0awww.swapp-eng.it"><br>
<font face="Arial">a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org</font> <br>
<font face="Arial">www.swapp-eng.it</font> </a></font></p>
<p><img src="cid:part1.05040404.00040205-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org" border="0"
 height="54" width="200"> </p>
<hr>
</div>
</body>
</html>

--------------000701070907030708040702
Content-Type: image/jpeg;
 name="logo.jpg"
Content-Transfer-Encoding: base64
Content-ID: <part1.05040404.00040205-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org>
Content-Disposition: inline;
 filename="logo.jpg"

/9j/4AAQSkZJRgABAgAAZABkAAD/7AARRHVja3kAAQAEAAAAZAAA/+4AJkFkb2JlAGTAAAAA
AQMAFQQDBgoNAAApZwAAXgcAAIFZAACrC//bAIQAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB
AQEBAQEBAQEBAQEBAQEBAQEBAQICAgICAgICAgICAwMDAwMDAwMDAwEBAQEBAQECAQECAgIB
AgIDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMD/8IA
EQgAtgKrAwERAAIRAQMRAf/EAUcAAQACAgIDAQAAAAAAAAAAAAAICQcKBQYCAwQBAQEAAgID
AQEBAAAAAAAAAAAABgcFCAIDBAEJChAAAAUCAwUHAwIGAwEBAAAAAAIDBAUBBhUWBxMzFDQX
ECAwERIIGDEyNkA3UGAhQiQ1cIAmQSMRAAEDAgIDBgsSCwYCBgsAAAIBAwQABREGIRITMSKT
lDU2QVFhcdEyM9MU1NUQIDCBkbFCcpLSI7M0dHW1lqbB4VJioqS0FZV2N6GCsnMkB0BgUMJT
Y4QWcIBDg6PDRFQlZoYSAAECAwMGCwUFBwMDBQEAAAEAAjEyAxGREhAhcaGxMyAwQVFhgcHR
IkITcpJDcwTw4VLSI0Bg8WKishRQggVwgIPCU2OzRAYTAQACAQEFCQEBAQEBAQEAAAEAESEx
8EFRYXEQMIGRobHB0fEg4UBgUHCA/9oADAMBAAIRAxEAAAG/wAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAHy8+HQclj+t+rzcF6PP4/QAAA8fvz38OWRsXksgY3IgAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAADrfq8tXVvVZXzZledEyHh4nu6vx8AAAH6cr1dndPB7pkwKb
XQUTdP3cOYAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAr6suvKMNhaJw9SlpzA08tvksV6AAA
APHs4YVuGJY33DpDt8gwdrOu19XH1nYgAAAAAHG9vVwXo6D4AAAAAPw+zh2dk8vp43t6uC9H
n8X3uPi9gAHFd3Twfo6Pfw5dq8nrAA4D0+fiu7p5Pp7uw+b0Aer784T0dHp5cQAAABzHR3fd
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
SiCuA9n3t4ZjFIW69QWUShO61KKK11Xnq16rTw6rTw6rTw6rTw6rTw6rTw6rTw6rTw6rTw6r
Tw6rTw6rTw6rTwmtTpuNnEzlVJrLcL6BkV9VZ71e1OWeS99d3WK5n8BcL7VOfO29oT1w/hO7
qJfEtCz89qfPuYr2rrqOdJw8fN2CV06oMYksxra3UOvrBLKV6tTQ6tTQ6tTQ6tTQ6tTQ6tTQ
6tTQ6tTQ6tTQ6ry9QlqoYR+r0qzPpjqpFahthrN+Wyv+v9saRU9LfE1FapO7dnmVWa1z8m1v
dePtSK1UtZ+pStDU8DUa5SxSF43Q7uCRkpwjI6Nvaqu0sq6vjKur4yrq+Mq6vjKur4yrq+Mq
6vjKur4yrq+Mq6vjKur4yrq+K2pq+LI9v+pd6XEPcDzy+89n/wCZ93X/APInO69mn473dXvy
eU5H2oftE5cJNG+pWpSrMkhJOpBZ5cTRtVivdcyXC9SBhepAwvUgYXqQML1IGF6kDC9SBhep
AwvUgYXqQEZlZN0Uwg7tfWPc7V0g9a6zflsr/r/bP+1XiXwYuG36lsHt0V8md97Vvp2jcL4g
0w1ndWdIpqJrJ9/XKTUTuow9p9tRkrff6D3A88vvPZ/+Z93X/wDInO69mn473dXvyeU5H2of
tFqlM4fFXVKqSsvIYjKyOlntysyxmBS0LTwtSNOIDUeAozXapTtP8DQ6RUldJNZvy2V/1/tn
/arxJRzjk1f78j64n7JxPTut1iXK9ttk84oipfWn7Y76UuC1u/7mWDiLub6jTWcfWjccfqwk
5S6ktB1JZjqSzHUlmOpLMdSWY6ksx1JZjqSzHUlmOpLMH1PYpiG1AtebX7PcDzy+89n/AOZ9
3X/8ic7r2afjvd1e/J5Tkfah+0WuMns5tQ3qN7W4JKd1Z8W/mlGsxPf6728fszrN+WyJKqMt
Bpptb+mGeWwzy2GeWwzy2GeWwzy2GeWwzy2GeWwzy2Gd/WFM4XBS9buhLQiHjv009r1lrXdq
EPcTYjaAu81PTX29TRoTWjv6hWPG6hWvcsTcOnk4g+bLUJIOUxjEgMYkBjEgMYkBjEgMYkBj
EgMYkBjEgMYkBjEgCTMoWpLjdql0T1ncOpEe4Hnl957P/wAz7uv/AOROd17NPx3u6vfk8pyP
tQ/aLXo/ldxvt9nFPKd8XU7/AHs9/rvbx+zOs35aLc1McW8165Px1yfjrk/HXJ+OuT8dcn46
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
Nixv4VFzolqP1Dc7mo1KkxyWNXhbavEQFncVEqJUSolRKiVEqJUSszivC5Ya7QRziKjioOge
w9O3JQ0HaVU9lFp8tGmNp7eN/wCP+pYbMP1lK32XPDH3scQjpQPSiLSFiYMbeiN3dbxRq82Y
aV/MvTYMVRfDCjT+3Wo0/t1qNP7dajT+3Wo0/t1qNP7dajT+3Wo0/t1qNP7dajT+3Wo0/t1q
NP7dajT+3WsdR2J3Jkq6W9q6kfa4Tvm9gTtCv4VD2U/RkDWxKsMgj0qxuZqws8T1ma0L4a+G
vhr4a+Gvhr4a+Gvhr4awVRYcmEwKsVDQdpVTQn/KpbON+kDBaf8AKo//AGNRPSgOlG3nVrcx
X+RRFn1Y/q09PMb1YY8Q1385yOxcrv2Grpb2rqR9rhO+b2BO0K/hUPZT9GQ1PwjWUByr/HYb
OdZszeMD+S1AdCJR0qhoO0qpoT/lUtnG0/r6zT6VH9Q6fhjTiz6GlC2JTafMLVjBWLlRCLxB
23iHfTPma+3qP3jIW1G5+cRC8LtX3qbUptSm1KbUptSm1KbUptSm1KbUptSzO1LG5ttPnGfL
V0t7V1I+1wnfN7AnaFfwqHsp+jIX89TYBkeed3HUjz0m7AnIqhoO0p7RGxVKdGk/B6NPxYTZ
DWpT7rlKfdcpT7rlKfdcpT7rlKfdcpT7rlKfdcpT7rlKfdchhp1CDzU3nsTav1owN539jI26
cOlNo0G4aAzm2LjzlY3ZmgJz+Vx1ZHUjMzYch4j1aasqyq1jgvKoNUGqDVBqg1QaoNUGqDVB
qg1ShWsX+Z9KLB5m9o7clXS3tXUj7XCd83sCdoV/Coeyn6Mn/lPZkPtHjqPyW/2hORVDQdpy
Yi4qdTqdTqdTqdTqdTrO4q0NtPSsTyA0LC3NQGtYjkcOQ0jtCBX+3ibWrOF5r15r15r15r15
r15r15r15r15r15r15r15r0G4jnPKg4q0ot6VV0t7V1I+1wnfN7AjoV/Co+yn6Mj6fmbUtvA
7shqiFvHUfkt/tCciqGg7Si8wCsptBCkbepG3qRt6kbepG3qRt6kbepG3qRt6kbeswYFvANC
tcXOPSrXZXO5MHaEERzN/ZwGzIv5EUdKrDlBb25HfUMFrQbTo4Qp/ifbs7lYvXA/Tt4TGfha
nk82TAZKgs6+TtHWrQi2pAr8X0/I7v5uNo/Jb/aE5FUNB2lP0ZAEUHcd/M7YugBPdzu4g2Sh
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
pX/mXMisT86S2CbBG1R6Ll+M+KbePFc3Hri8mIvSE0auLbe9Uyc8yRl7McXbxHfhGH2lFubb
5YoqNTYEhRPYSWsekokKqJIQqqLIkQYb2bcsgREzdbWwb0hljofvO2tbWVCMB7Y0Rxj8/oVq
SIhgQqokibokmhUUSwVFRa3xOB121X1q7sXBH2K7sXBH2K7sXBH2K7sXBH2K7sXBH2K7sXBH
2K7sXBH2K7sXBH2K0Omq9JGiq7X5tt4bdacvzBkPadltrjIjMwojioiirjwNOuIOjuKr0PMz
fCcfVJA5tvyEKBjhs7vLQurTjLLhEZbibMk/tWsjfMZ/11cqzdHkSQbeWTETUX6PhL1tynwC
U2REGCCi4qtQ/p29/HN1L+bP/FFUPrl61IYLgSbi0jbM8hFNxNVK5RP3I1yifuRrlE/cjXKJ
+5GuUT9yNcon7ka5RP3I1yifuRrlE/cjXKTnpCNYOXaTgvSPV9alOVL116Kuu4+utKEVdu7u
Yj2g9cqif7iZ+hGzAjm3My9ZJjeq9cZAqjke6To56WbdHXfMtkmL5YEvwaJtfQJNsu0KLcbd
Nb2MuFNYbkRpDeKLqusuoQEiEiKnSVMaIyySKKaqSoGYM1NBiv5Lbd8BsE6iIiVzK+8ebfL1
cyvvHm3y9XMr7x5t8vVzK+8ebfL1cyvvHm3y9XMr7x5t8vVzK+8ebfL1cyvvHm3y9XMr7x5t
8vVzK+8ebfL1cyvvHm3y9XMr7x5t8vVzK+8ebfL1C83khkjBcUSResyy2unvmJV5eYNOuK0k
GwWe2WWGmC+DWuDGgskSJhrmEZttHHOmS4qvndpmXKtmusjBB8NeiA3cNVNwP3jH2M5ATpbT
CuZX3jzb5ermV9482+Xq5lfePNvl6uZX3jzb5eoSTJKYiqEmtmHNZjii474DvpAadRUwWiby
xly0WXXHUdegwmW5T4ouKDImaqy5KIu5rmWHmbXMuVbNdZGCJ4a9EFq4aqJggfvGNsZ2on5O
0wrmV9482+Xq5lfePNvl6uZX3jzb5ermV9482+XqFwckgpCuKI5fs0PB/eaevZtGnXRaWFlu
x2uyRiVFcbtsJiJtiTQhyCaATkOYeyNSLz2F8y/ZLymjRdbVAuKaEwT5Ww9uJWtIyLbW1xx/
/HyrtaR6PsLVcIYYb7cwwrmV9482+Xq5lfePNvl6uZX3jzb5ermV9482+Xq5lfePNvl6uZX3
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
--------------000701070907030708040702--

--------------030006090004000604020206--


--===============2656380032836902400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============2656380032836902400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============2656380032836902400==--
