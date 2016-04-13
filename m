From: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: spi-ti-qspi: Handle truncated frames
 properly
Date: Wed, 13 Apr 2016 10:31:33 +0100
Message-ID: <1460539893.32355.19.camel@codethink.co.uk>
References: <1460462185.32355.7.camel@codethink.co.uk>
	 <1460462294.32355.9.camel@codethink.co.uk>
	 <20160413071324.GP14664@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	CT kernel <linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160413071324.GP14664-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, 2016-04-13 at 08:13 +0100, Mark Brown wrote:
> On Tue, Apr 12, 2016 at 12:58:14PM +0100, Ben Hutchings wrote:
> 
> > -		ret = qspi_transfer_msg(qspi, t);
> > +		wlen = t->bits_per_word >> 3;
> 
> I did ask you to fix this to just / 8 so it's more readable :/

Not explicitly.  And that would be inconsistent with every other place
this driver bits_per_word to a byte count.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
