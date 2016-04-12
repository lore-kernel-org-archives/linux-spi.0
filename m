From: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: spi-ti-qspi: Handle truncated frames properly
Date: Tue, 12 Apr 2016 12:09:24 +0100
Message-ID: <1460459364.32355.6.camel@codethink.co.uk>
References: <1459885528.26669.5.camel@codethink.co.uk>
	 <1459885728.26669.7.camel@codethink.co.uk>
	 <20160412015809.GS3351@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	CT kernel <linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160412015809.GS3351-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, 2016-04-12 at 02:58 +0100, Mark Brown wrote:
> On Tue, Apr 05, 2016 at 08:48:48PM +0100, Ben Hutchings wrote:
> 
> > We clamp frame_length to a maximum of 4096, but do not limit the
> > number of words written or read properly.  This causes 4K reads (which
> > some m25p80-like flash chips support) to return garbage for the last
> > few bytes.
> 
> > Recalculate the length of each transfer, taking the frame length into
> > account.  Use this length in qspi_{read,write}_msg(), and to increment
> > spi_message::actual_length.
> 
> I'm having a hard time understanding what's actually wrong here or how
> this change is intended to fix it,

"4K reads...return garbage"  That's wrong, no?

> I think again because I don't know
> what frame_length is intended to be.  As far as I can tell frame_length
> is the number of words we're going to transfer in the entire message

Yes.

> and the driver has in some places been mixing up words and bytes

No, it's been completely ignoring the (potentially truncated)
frame_length and using the original transfer lengths for each transfer.

> which is
> causing the breakage so the intention is to consistently use words
> throught the driver.  Is that correct?

No.

I'll add a renaming of variables to make it clearer.

Ben.

> > -		ret = qspi_transfer_msg(qspi, t);
> > +		wlen = t->bits_per_word >> 3;
> 
> For the benefit of readers:
> 
> 	wlen = t->bits_per_word / 8.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
