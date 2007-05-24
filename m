From: Bill Gatliff <bgat-uPd5UNENI//N9NzbbXoYwQ@public.gmane.org>
Subject: Re: problem with converting from at91_spi to
 atmel_spi (AT91RM9200)
Date: Thu, 24 May 2007 12:20:22 -0500
Message-ID: <4655C956.8080300@billgatliff.com>
References: <20070523143456.15fc49ab@newbox>
	<200705230906.13353.david-b@pacbell.net>
	<20070524133646.62bbc386@dhcp-255-175.norway.atmel.com>
	<200705240931.43663.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0187570783=="
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Nicolas Ferre <nicolas.ferre-XEyKDsrmbOsS+FvcfC7Uqw@public.gmane.org>,
	Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, andrew-eS41wJS13H5l57MIdRCFDg@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200705240931.43663.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This is a multi-part message in MIME format.
--===============0187570783==
Content-Type: multipart/alternative;
	boundary="------------090003010703050802000301"

This is a multi-part message in MIME format.
--------------090003010703050802000301
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David:

David Brownell wrote:
> Yet, I got the report (at91rm9200 specific).  Bill?  (I remember
> MODFDIS acting oddly, non-rm9200, but forget the details.)  And in
> any case there seem to be other folk reporting rm9200 + dataflash
> issues ... while mtd_dataflash doesn't seem to be at fault.  So
> maybe that combination of errata isn't the issue, but something
> else is making the problem. 
>   

Good recall!  :)

Rev. F of the AT91RM9200 manual says, in 41.9.4:

    "If Mode fault is disabled, Chip Select 0 cannot be driven by a
    component other than the SPI otherwise the transfer does not occur".

... but if you enable mode faulting, something else breaks IIRC.

IOW, CS0 for the 9200 doesn't work if the SPI controls it.  And SPI 
doesn't work for CS0 if the SPI controller _doesn't_ control it, 
either.  So I've just quit using CS0.  :( 

At least, that's where I left it with 2.6.20 during my investigations.  
Haven't come back to this topic since then.




b.g.

-- 
Bill Gatliff
bgat-uPd5UNENI//N9NzbbXoYwQ@public.gmane.org


--------------090003010703050802000301
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=iso-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
David:<br>
<br>
David Brownell wrote:
<blockquote cite="mid200705240931.43663.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org" type="cite">
  <pre wrap="">
Yet, I got the report (at91rm9200 specific).  Bill?  (I remember
MODFDIS acting oddly, non-rm9200, but forget the details.)  And in
any case there seem to be other folk reporting rm9200 + dataflash
issues ... while mtd_dataflash doesn't seem to be at fault.  So
maybe that combination of errata isn't the issue, but something
else is making the problem. 
  </pre>
</blockquote>
<br>
Good recall!&nbsp; :)<br>
<br>
Rev. F of the AT91RM9200 manual says, in 41.9.4:<br>
<blockquote>"If Mode fault is disabled, Chip Select 0 cannot be driven
by a component other than the SPI otherwise the transfer does not
occur".<br>
</blockquote>
... but if you enable mode faulting, something else breaks IIRC.<br>
<br>
IOW, CS0 for the 9200 doesn't work if the SPI controls it.&nbsp; And SPI
doesn't work for CS0 if the SPI controller _doesn't_ control it,
either.&nbsp; So I've just quit using CS0.&nbsp; :(&nbsp; <br>
<br>
At least, that's where I left it with 2.6.20 during my investigations.&nbsp;
Haven't come back to this topic since then.<br>
<br>
<br>
<br>
<br>
b.g.<br>
<pre class="moz-signature" cols="72">-- 
Bill Gatliff
<a class="moz-txt-link-abbreviated" href="mailto:bgat-uPd5UNENI//N9NzbbXoYwQ@public.gmane.org">bgat-uPd5UNENI//N9NzbbXoYwQ@public.gmane.org</a>
</pre>
</body>
</html>

--------------090003010703050802000301--


--===============0187570783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0187570783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============0187570783==--
