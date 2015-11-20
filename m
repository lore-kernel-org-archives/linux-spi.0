From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: RfC: Handle SPI controller limitations like maximum message
 length
Date: Thu, 19 Nov 2015 16:02:26 -0800
Message-ID: <20151120000226.GP64635@google.com>
References: <564CEB61.2000601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <564CEB61.2000601-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Nov 18, 2015 at 10:19:29PM +0100, Heiner Kallweit wrote:
> There have been few discussions in the past about how to handle SPI controller
> limitations like max message length. However they don't seem to have resulted
> in accepted patches yet.
> I also stumbled across this topic because I own a device using Freescale's
> ESPI which has a 64K message size limitation.
> 
> At least one agreed fact is that silently assembling chunks in protocol
> drivers is not the preferred approach.

Hmm, are you referring to this sort of approach [1], where the
spi_message::acutal_length informs the spi_nor layer that the transfer
was truncated?

[1] [PATCH v4 7/7] mtd: spi-nor: add read loop
    http://lists.infradead.org/pipermail/linux-mtd/2015-August/061062.html

> Maybe a better approach would be to introduce a new member of spi_master
> dealing with controller limitations.
> My issue is just the message size limitation but most likely there are more
> and different limitations in other controllers.
> 
> I'd introduce a struct spi_controller_restrictions and add a member to spi_master
> pointing to such a struct. Then a controller driver could do something like this:
> 
> static const struct spi_controller_restrictions fsl_espi_restrictions = {
> 	.max_msg_size	= 0xffff,
> };
> 
> master->restrictions = &fsl_espi_restrictions;

OK, so I think Mark suggested we not move to a 'restrictions' struct,
but otherwise it doesn't sound like he's opposed to this.

> I also add an example how a protocol driver could use this extension.
> Appreciate any comment.

One question I have: is it necessary to push the handling out into the
protocol driver? I feel like I've seen a partial answer to this: the
'actual_legnth' return field suggests that the protocol driver already
has to deal with shorter-than-desired transfers.

Then I have another one: is the 'actual_length' field really
insufficient? For instance, is it non-kosher for a spi_master to just
cutoff the message at (for instance) 64K, and expect the protocol
driver to handle that (e.g., with Michal's patch from [1])? And if that
is kosher, then is there a good reason for the protocol driver to know
the exact maximum for its spi_master?

[snip example]

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
