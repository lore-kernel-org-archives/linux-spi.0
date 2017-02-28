From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] spi: allocate spi_board_info entries one by one
Date: Tue, 28 Feb 2017 18:54:55 +0000
Message-ID: <20170228185455.mdmvuc232chlveve@sirena.org.uk>
References: <20170228041857.13292-1-dmitry.torokhov@gmail.com>
 <20170228041857.13292-3-dmitry.torokhov@gmail.com>
 <20170228091650.eiypppxblfhh33pb@sirena.org.uk>
 <20170228182417.GA20776@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aqisfuaw7cs7kkca"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170228182417.GA20776@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--aqisfuaw7cs7kkca
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 28, 2017 at 10:24:17AM -0800, Dmitry Torokhov wrote:
> On Tue, Feb 28, 2017 at 09:16:50AM +0000, Mark Brown wrote:
> > On Mon, Feb 27, 2017 at 08:18:56PM -0800, Dmitry Torokhov wrote:
> > > Lists of spi_board_info entries registered with spi_register_board_info()
> > > can be quite long; instead of forcing memory allocator find contagious

> > Do you have numbers on that?

> Hm, so the largest array seems to be in
> arch/blackfin/mach-bf537/boards/stamp.c at max of 43 entries. The new
> board info is ether 60 or 72 bytes, so we get 2 or 3K table. Not above
> page, but still could be packed I think.

Oh wow, that's impressively large.  Still not sure the optimization is
particularly worth it though, it's small change in the grand scheme of
things.  OTOH it's a small change.

> If we decide that we want to keep single chunk I'll just change the
> allocation to kcalloc. Let me know.

I'd be inclined to do that because it requires less thinking about the
value of what should be a very small optimization either way but
whatever :)

> We should probably redo patch #1 to avoid allocating empty property sets
> anyway.

Yeah.

--aqisfuaw7cs7kkca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAli1x34ACgkQJNaLcl1U
h9ANogf7BbmS/T8SjnsfT5HnDJHvMP/fy6qyeQDFo8oGiVpTwNtotZ7XB3NyKqUn
O9L1wJWoQognlfZ+Z1iGNTtAYzp9d5tOr+eXOj50aWEd/IAEsVQuOx3GGy9PKi2c
Z6R0f4rE6MPDmCccQiIDS7OH/UgQPCRmFUAFaxc3JDjlq6NDl2f828YGZzcuYuqd
rMg61VJWBuafdu2aflxkDU3VVnzClK1tDkxFltG9WhUcrcUd7GLrPvsjezOLeNbI
+iszFeSGXKLHdEKoRBBEpAqCdBSFyIe0foJnu0fzJaxyORMXYMfLskawoomL38Lq
8vU+ct0fxWmpEfkTQmKbGnAoIGp2ZA==
=7DmR
-----END PGP SIGNATURE-----

--aqisfuaw7cs7kkca--
