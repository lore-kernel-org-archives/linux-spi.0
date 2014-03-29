From: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH RFT] spi: mpc512x-psc: Refactor to use core message
 parsing
Date: Sat, 29 Mar 2014 15:18:51 +0100
Message-ID: <20140329141851.GB2775@book.gsilab.sittig.org>
References: <1395932757.17331.1.camel@phoenix>
 <20140327172416.GW3998@book.gsilab.sittig.org>
 <20140327182049.GT30768@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140327182049.GT30768-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, 2014-03-27 at 18:20 +0000, Mark Brown wrote:
> 
> Can you try turning the
> tracepoints on and see if they show where the delays are?  Both the
> message pump and transfer loops have a reasonable number of tracepoints
> in them.

I did a 'dd if=/dev/mtd6 bs=1K' on an m25p80 chip.  Gathered
traces suggest that each 1KB block leads to two transfers.  The
second (the data part) takes several milliseconds (saw some
3-10ms for 1024 bytes :-O ).  But I fail to see what might take
this long.  Will need to dig deeper.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office-ynQEQJNshbs@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
