From: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: spi-ti-qspi: Fix FLEN and WLEN settings if
 bits_per_word is overridden
Date: Tue, 12 Apr 2016 12:07:29 +0100
Message-ID: <1460459249.32355.4.camel@codethink.co.uk>
References: <1459885528.26669.5.camel@codethink.co.uk>
	 <20160412013014.GR3351@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	CT kernel <linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160412013014.GR3351-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, 2016-04-12 at 02:30 +0100, Mark Brown wrote:
> On Tue, Apr 05, 2016 at 08:45:28PM +0100, Ben Hutchings wrote:
> 
> > +	frame_length = 0;
> > +	list_for_each_entry(t, &m->transfers, transfer_list)
> > +		frame_length += t->len / (t->bits_per_word >> 3);
> > +	frame_length = min_t(unsigned int, frame_length, QSPI_FRAME);
> >  
> 
> This doesn't seem obviously correct - what exactly is the frame length
> here and why doesn't it change per transfer like the word length does?
> There's nothing in the changelog about this.

The frame_length is the number of words in the frame, as it was before
this change.  Shall I insert a preparatory patch to give the variables
better names?

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
