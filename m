From: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH RFC] Remove "spi-cs-high" property for GPIO-based
 chipselects
Date: Mon, 2 Dec 2013 17:31:24 +0100
Message-ID: <20131202163124.GW2982@book.gsilab.sittig.org>
References: <1385884756-31373-1-git-send-email-shc_work@mail.ru>
 <20131202145911.GT2982@book.gsilab.sittig.org>
 <1385997862.727371043@f24.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385997862.727371043-/wTItXjRvv7WO3iv0lnsqw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Dec 02, 2013 at 19:24 +0400, Alexander Shiyan wrote:
> 
> Using GPIO flags is basically better. 
> Imagine that tomorrow we may want the option to define open-drain
> output on the CS pin. Specific pullup or pulldown.
> Another separate properties?

This does not answer the actual concerns raised.  Do you change
the semantics without making users notice it?  Do you fragment
configuration by putting the same piece of information that is
specific to the SPI slave into totally different properties in
rather distant locations depending on how the CS signal gets
generated?  Shouldn't you update users when you change the
service?

Can you please address those concerns I raised, or clarify where
I'm wrong in my interpretation and why there is no issue?  A mere
"but it's better" is not convincing to me.  (Note that I trimmed
the above quotation because I feel that your response should be a
direct followup of the concerns raised, not buried here deep in
several response levels.)


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
