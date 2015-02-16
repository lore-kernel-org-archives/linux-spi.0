From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: only use up TX/RX bounce buffer space when
 needed
Date: Mon, 16 Feb 2015 22:23:02 +0900
Message-ID: <20150216132302.GO9110@finisterre.sirena.org.uk>
References: <1423743188-1821-1-git-send-email-abbotti@mev.co.uk>
 <20150214044910.GF9110@finisterre.sirena.org.uk>
 <54E0753E.30208@mev.co.uk>
 <20150216041321.GM9110@finisterre.sirena.org.uk>
 <54E1C3D9.2010406@mev.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QQNwO3VdVfodZayb"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ian Abbott <abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54E1C3D9.2010406-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--QQNwO3VdVfodZayb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 16, 2015 at 10:18:01AM +0000, Ian Abbott wrote:
> On 16/02/15 04:13, Mark Brown wrote:

> >Right, but it's not clear if you mean that this is something to do with
> >the device drivers for SPI controllers or spidev itself.

> Okay, how about if I used the term "spidev device" to distinguish it from
> the lower-level SPI device?

Or just spidev.

> >>Yes, the patch limits the total user-specified TX data and the total
> >>user-specified RX data to the pre-allocated buffer size individually rather
> >>than limiting the total sum of user RX and TX data.

> >Your commit message needs to say this rather than requiring the user to
> >reverse engineer it from the code - a key part of reviewing a code
> >change is making sure that it does what the commit message says that it
> >does to make sure that it is having the indended effect.

> I thought it said that (somewhat clumsily) in the first paragraph.

Not really, it repeats the what that can be seen from the code but
doesn't explain what the goal of the change is supposed to be.  This
means it's not really possible to tell if that goal is being achieved.

> >>The check against INT_MAX is there because a struct spi_ioc_transfer might
> >>have rx_buf==NULL, tx_buf==NULL and len!=0, in which case it would no longer
> >>use up space in either of the pre-allocated buffers so neither rx_total nor
> >>tx_total would increase.  Checking the sum of the len fields against INT_MAX
> >>prevents arithmetic overflow in the return value of the function.

> >If that's what the code is supposed to do then someone reading the code
> >needs to be able to tell that without too much effort, I'd not expect
> >that to be possible as things are.  Maintainability is very important.

> There was a whole paragraph about that in the commit message, but maybe it
> was too concise.

The commit message is not the code.  The code itself needs to be clear,
and even based on what's in the commit message it's not terribly obvious
(and with the above the return value that will be overflowed doesn't
jump out).

--QQNwO3VdVfodZayb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU4e8yAAoJECTWi3JdVIfQH/MH/1k7pNrCVh1MuZWOw+zbEre0
KbzQdgTjeZGrMjzlT8Ez74mPUfFtVMtdDldxSxXYVNJhpKYb3JdBkcQpEVEA9xzC
RGZtaUdPYXRuKuqtwABRSPHidT0tq2axcC2J1OI+al5QWR2C1nRr9gq9TObjxYPi
7a37aauqDZBEcWARkj/VboqnJAw76QruKnzMi4CE2P5rbo79nFJDszXabzpqNN+W
k51tDgcL83ujBhOGg6OYnk6MFVpkjeRPB/+dlM12oG9v8LVNzZltgN2e9IJznqEW
3ifN4eYbvnDdE8YLf3EUpefOfkASG3QKYZJLZY33rrOPWfOZpFj10paT3AirzMs=
=0qnV
-----END PGP SIGNATURE-----

--QQNwO3VdVfodZayb--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
