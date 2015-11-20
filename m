From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: RfC: Handle SPI controller limitations like maximum message
 length
Date: Thu, 19 Nov 2015 16:07:46 -0800
Message-ID: <20151120000746.GQ64635@google.com>
References: <564CEB61.2000601@gmail.com>
 <20151118215755.GL31303@sirena.org.uk>
 <564D0098.4030107@gmail.com>
 <20151119114057.GN31303@sirena.org.uk>
 <F224F5F3-FAD5-47FE-9419-39E53BCBB8C6@sperl.org>
 <20151119171538.GO31303@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>,
	Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151119171538.GO31303-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Nov 19, 2015 at 05:15:38PM +0000, Mark Brown wrote:
> On Thu, Nov 19, 2015 at 04:00:45PM +0100, Martin Sperl wrote:
> > On the bcm2835 there are also some =E2=80=9Climitations=E2=80=9D (w=
hen transfers are not aligned
> > to word, transfers>65535 can=E2=80=99t DMA) which we work around ri=
ght now inefficiently.
>=20
> Alignment is a general issue which all clients should be trying to
> ensure as a matter of course - never mind individual blocks of hardwa=
re,
> some common CPU architectures suffer noticable penalties from unalign=
ed
> accesses so it's just generally good practice to try to avoid them.
>=20
> You shouldn't be doing anything about transfer size limitations in yo=
ur
> driver, if you have this restriction you should be adding code to the
> core and just flagging the limit in your driver.

So for transfer size limitations, are you speaking of the same thing as
Heiner (who began this post mentioning *message* size limitations)? I
read a difference between the two, where a transfer size limitation
might mean that one could improve the SPI core to just split transfers
up into multiple sub-transfers, and still complete the whole
spi_message (and therefore the protocol driver has less to worry about)=
=2E
But if we're talking about spi_message limitations, then this would be
more exposed to the protocol driver.

Or maybe I'm just reading this all wrong and am confused. Please
enlighten.

Regards,
Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
