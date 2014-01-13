From: Philippe De Muyter <phdm-KobBqTBAxd8@public.gmane.org>
Subject: Re: spi_write_then_read with different tx/rx bits_per_word
Date: Mon, 13 Jan 2014 14:35:18 +0100
Message-ID: <20140113133518.GA6613@frolo.macqel>
References: <20140108223538.GA2861@frolo.macqel> <20140110102745.GA29039@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140110102745.GA29039-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Jan 10, 2014 at 10:27:45AM +0000, Mark Brown wrote:
> On Wed, Jan 08, 2014 at 11:35:38PM +0100, Philippe De Muyter wrote:
> 
> > Is there a convenience function similar to spi_write_then_read
> > to handle that case or must I roll my own one in my driver ?
> 
> Try regmap?

Thanks.

Actually it was late in the evening and I was confusing read in
`spi_write_then_read' with read as in 'read a register'.

`spi_write_then_read' should probably better be named `spi_xmit_then_rcv'

Best regards

Philippe

-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
