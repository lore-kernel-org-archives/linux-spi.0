From: Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/4] spi: Add 'last' flag to spi_transfer structure
Date: Tue, 18 Nov 2014 23:55:46 +0100
Message-ID: <20141118225546.GA27182@gmail.com>
References: <1416264471-774-1-git-send-email-b.galvani@gmail.com>
 <1416264471-774-2-git-send-email-b.galvani@gmail.com>
 <20141118140658.GI22111@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Jerry Cao <jerry.cao-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>,
	Victor Wan <victor.wan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141118140658.GI22111-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Nov 18, 2014 at 02:06:58PM +0000, Mark Brown wrote:
> It's incredibly sad to iterate through the entire list in order to find
> the last entry, especially given that it's a doubly linked list and this
> is a bit of a hot path.  We should look at the previous entry for the
> list head instead, or perhaps better yet by doing this as part of
> spi_validate() which already itereates over the entire list and is where
> we do other similar fixups.
> 
> Though looking at this I'm not sure that a flag is the best approach at
> all - why not just have the driver call list_is_last() in the transfer
> function or ideally provide an inline function that does that so that we
> can change the implementation later?

I didn't realize that the master structure passed to transfer_one()
has a reference to the current message and thus to the transfer
list. Then yes, the additional flag in the transfer structure probably
doesn't make much sense.

Would it be better to introduce something like:

static inline bool
spi_transfer_is_last(struct spi_master *master, struct spi_transfer *xfer)
{
        return list_is_last(&xfer->transfer_list, &master->cur_msg->transfers);
}

or open code it in the driver?

Beniamino
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
