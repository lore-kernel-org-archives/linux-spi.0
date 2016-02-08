From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: Fix incomplete handling of
 SPI_MASTER_MUST_RX/_MUST_TX
Date: Mon, 8 Feb 2016 16:15:42 +0000
Message-ID: <20160208161542.GF7265@sirena.org.uk>
References: <1454366363-10564-1-git-send-email-joshua.henderson@microchip.com>
 <20160201231733.GK4455@sirena.org.uk>
 <56B42C68.4030909@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TeJTyD9hb8KJN2Jy"
Cc: Joshua Henderson <joshua.henderson@microchip.com>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Purna Chandra Mandal <purna.mandal@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56B42C68.4030909@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--TeJTyD9hb8KJN2Jy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 05, 2016 at 10:30:24AM +0530, Purna Chandra Mandal wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> Idea is good, but not sufficient.
> Dummy buffers are _reallocated_ to accommodate larger size of transfer. In this if
> [originally NULL] .rx_buf/.tx_buf is not reset back to NULL after the transfer
> is over spi-core will find those .rx/tx_buf non-NULL in next _transfer() call and
> will pass the stale rx/tx_buf to spi controller driver which will definitely
> corrupt the memory and crash the system.

This needs to be clear to readers; a fairly obvious way of dealing with
this would be to rellocate down to a page rather than freeing.

> Above all the whole design depends on trust that core will not play with any data-structure
> which will break object-oriented/layered approach. So better to undo the modification
> (when needed to facilitate some functionality) unless core wants those information to be passed
> back to caller/client for reporting success or error or else.

That's really not the case, we already make a range of other
modifications to complete partially filled transfers in order to
simplify driver code.

--TeJTyD9hb8KJN2Jy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWuL8uAAoJECTWi3JdVIfQ46QH/1NnOqqDiFyIpmylR735oUJP
zHDMbSMfwKGXCqt3j6gKJes050zmoZEnyGcGgmGEgIZMYFlujm9lmnLEkfax+oHV
RzdX8pr0IiJcV5Nz0rvDNiu4Cv9NNEbL0siamATVha5arAh89/4e7QzpN1zSAlWt
D8c2UcZszc1/p/zF3ZmL4sTgjO/tbTU9IGumUkD0Tf9LPkUuJ1vA+wqHOW5cd+5V
wBSzDLy87wICxTPV+CMsj54pPh7U/+Z1eI++M6hekG/eg0SSpx14zcpH77B/Sd2F
CmCq/RugnlGKYnCnhcjetltKdYSH3emkOHcD0k9xhGAOPOYfL+KgZ6brcyxqqJQ=
=JZca
-----END PGP SIGNATURE-----

--TeJTyD9hb8KJN2Jy--
