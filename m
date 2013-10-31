From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Wed, 30 Oct 2013 17:10:04 -0700
Message-ID: <20131031001004.GW2493@sirena.org.uk>
References: <F70C4469-6325-48D5-A7CA-52CC1FC404BD@sperl.org>
 <CACRpkdb6y=o4__snBs2DR1f=xW_u7KdkHg3fb7XN5e2gicBJeg@mail.gmail.com>
 <CACRpkdb7y88oq7XyVFc_0Nx4pXtaebPe7KB2yizBRJGwWLqJig@mail.gmail.com>
 <06C7F4D3-EC91-46CF-90BE-FC24D54F2389@sperl.org>
 <02BFF0F6-3836-4DEC-AA53-FF100E037DE9@sperl.org>
 <20131030171902.GL2493@sirena.org.uk>
 <8D8B0BAD-0E00-4147-B4C8-FBB18F060C96@sperl.org>
 <20131030215716.GV2493@sirena.org.uk>
 <3342FD19-4438-463B-89B2-A83D3475AC22@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cxfMsoqvp1jUizWj"
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3342FD19-4438-463B-89B2-A83D3475AC22-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--cxfMsoqvp1jUizWj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2013 at 11:52:33PM +0100, Martin Sperl wrote:

Please fix your mailer to word wrap within paragraphs, it makes things
much more legible.

> After a lot of digging I found the API you are referring to in:
> http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/incl=
ude/linux/spi/spi.h

> So when will this go in?

During the v3.13 merge window.

> How would you recommend to connect your prepared structure to a specific =
 message?
> There is no flag/field in spi_message to link that.

I'm working on the basis that we should add what we need to the
structure as we add code using it, right now there's no real usage so
nothing to do.

> Would this mean that I would keep an internal list with the address of
> the SPI message any my "prepared data" and I need to iterate over that
> list every time I need it?  This search might - worsted case - become
> a scaling issue if too many prepared=20
> statements are created...=20

Like I say just add stuff to the core as needed.  If we're getting
scaling problems due to too many transfers in flight we can probably
arrange to limit how many we do.  Hopefully that won't be too much of an
issue, though - we're mostly concerned with the last few entries and
with the ones currently in flight with the hardware.

I'd like to see all this stuff done in the framework as much as
possible, like I say a lot of this is very common and even where we
can't offload everything to hardware we can push a lot down into hard
IRQ context which will help avoid scheduling time.  We should build
things up piece by piece though rather than trying to do everything in
one fell swoop.

My general plan had been to start off by factoring out the prepare and
unprepare of DMA transfers for dmaengine based devices, including things
like the cache flushing, then add support for coalscing scatter/gather
operations - right now I think only one driver can do any form of gather
though a large proportion of the hardware with DMA has that support.

> It could lead to all drivers starting "simple" and then at some point it =
becomes
> an issue as one driver makes heavy use of this showing it becomes a bottl=
e-neck
> and then all spi-bus-drivers would need to get touched to optimize things=
=2E..

That's why I want to get as much into the core as possible, like was
done with Linus' work on the queue.  dmaengine helps a lot here since
it means all the DMA controllers look the same and hopefully we can also
model the operations we want to do at the hardware interaction level so
all the fancy queue/transfer management stuff is shared in the core.

> Why not provide a lookup function for the prepared data immediately and m=
ake=20
> sure the drivers use this one. Then we only have to change it later in on=
e place
> and reduce code-replication across drivers.
> (obviously you would also need put/delete methods to make that interface =
complete.)

That's the sort of stuff I'm talking about, yes (though I'm not 100%
sure what the "prepared data" is here). =20

> Also those function pointers do not have wrappers functions for ease of u=
se,=20
> so that they can get used in the individual drivers that know that they c=
an=20
> prepare the spi_message, as they do not change the transfer structure....

This is part of pushing things into the core - the idea is that we
should have little if any code using these things in the driver and
instead the core could have the code for working out when to do things.

--cxfMsoqvp1jUizWj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScZ/UAAoJELSic+t+oim9hH8P/3Lv/woaKZumzwEGxEOGmug1
oz9QmhL3xboWKUaE4CVNFIuv4O/li0d87k+SZSzMDKm/QOyil+BwKzh6A3RT3qcJ
jDo5EtqWXmt/gw78Nb3ED3WAHT7z2klnzumYenQT5IYvHeamgibmFAqesPUkZ68X
oLAhmKZydPDTgCv0G157Fx6Hwhx3cimuXluEt7cXgRxELShj9QumQR9rTSl6FhWo
DqsYLnqAUSol4DkWNRdkewS99oqBmFfEIm122O+TXNROH2AlT1V7aqGkP1YF0X/P
N/VC8tjLW8z7u2pm/mxRBDxM49dh7GJNHOP299HiHuXOIaqdF5vx6UP2lAbJ1b+k
1nombeN5XjyR/RQt5zmAuPsSkkMdwUZiDsAEHpRh1wdApDCgkG7NqMW1y2WqWevT
UFcRsqLHPAxfq0WhaYM3hC1dLprVAoKKklR6pXRmJORvsvJpnb9mb7l3ncFe1+9U
vmWLiJQ0Stl+B0b+SWIVA0QnNMvkBVHQo44a0fYQ6Bp7irdCZltJYanIeOxT1Bqw
QSmEAuIvJMI5njDYefyyB3mI9Uyn0I6O2qQiuNROkJ1RtvSVVFRwEa0dEi+G20lI
2qqhxoeunhmmRGWtGySBUv9AEv5TJCnC/kY9O4zZ8pzMkqAN3O89fzYtls7iSX2G
sh41xbJD2FSzyWHvvRpE
=z1XN
-----END PGP SIGNATURE-----

--cxfMsoqvp1jUizWj--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
