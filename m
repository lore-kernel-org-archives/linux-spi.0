From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Thu, 7 Nov 2013 20:31:27 +0000
Message-ID: <20131107203127.GB2493@sirena.org.uk>
References: <20131104184511.GR2493@sirena.org.uk>
 <5A55A832-5313-499C-A483-BF5A6649D69D@sperl.org>
 <20131106094854.GF11602@sirena.org.uk>
 <844EDAEA-3FDC-48D0-B59E-CECC0A83761E@sperl.org>
 <20131106113219.GJ11602@sirena.org.uk>
 <C6C68042-63A0-40FD-8363-B4553ECB4774@sperl.org>
 <20131106162410.GB2674@sirena.org.uk>
 <3B0EDE3F-3386-4879-8D89-2E4577860073@sperl.org>
 <20131106232605.GC2674@sirena.org.uk>
 <72D635F5-4229-4D78-8AA3-1392D5D80127@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kD5A6s5fH5u0LDZc"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <72D635F5-4229-4D78-8AA3-1392D5D80127-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--kD5A6s5fH5u0LDZc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 07, 2013 at 01:43:39AM +0100, Martin Sperl wrote:

> The problem is that you intend to do prepare/unprepare transparently.

Please be more concrete and specific, I'm still really struggling to
understand what your concern is.  Please do also reply to what's being
said rather than deleting the entire mail, it makes it easier to follow
the thread of conversation.

> OK - but I see problems with heuristics on when it is safe to assume
> that a message has not been changed since the last call (either xfers
> or tx/rx_buff pointer). If it has not changed then we can use the cached=
=20
> computations from the previous step ( equivalent to prepared).

Why would the SPI core assume that a message just passed into it is a
previously submitted message which has not been changed?  This seems
like something which would add extra complexity to the implementation
over the simpler approach of just treating each new message as a new
one.

Bear in mind that the goals here are to refactor the code so that the
DMA mapping is factored out of the drivers (and can be moved so that it
runs in parallel with transfers), factor out the handling of /CS and in
general the handling of message breaks and avoid all the drivers having
to implement the logic required to push transfers from interrupt context
where possible.

--kD5A6s5fH5u0LDZc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSe/ibAAoJELSic+t+oim9CbYP/0FO6mFS1mh98TLwieT+UiJU
ldU5q4tKik74z7gM5DF3yBH/uyIMYVASv/wCp88ntUVa7lOC/W22vl6MxP+Qcvja
YuX6Bn1Hp+MnxJqL5rKKGF3FhTZaC+l0imQQuLfm9+rMIsobTIDnh3KYMo3aacHh
emM5AjjxnodckX857vdk5KDziuS0fZtmelno7FPCWTjFhqQhbE+67mLytDpADZSt
Y1fRmBVTNvLePG23p2i9elk1tpnmNRB/zT+BtrjgcRI/xMmqbCCKbm8i8bG84WfF
hMDSSHIPJOctEBi84Y6YQ6fv66K3fVdrK8rkEViGATkzrkRrkP5JlXp25pAkw4e3
LbgDKsPEQssbyVYpu1PXxVFQQq3NRbuUzTl+MZTHpcYVLcw8UtwrdecC2+wpoTR3
ZcZHASbaOqpNjtBPTwXgYRpFP5zbX0JS8uZUf1Xg40LAsKbziR0GHPGZTnRbhUgD
3nvEwbFNlUVSRtAuzfwkIBeUrIkujCDfDaarAFyw99mdb1QasGD6ub+fp0HAKV6A
G7/c/YEs6p2rLmTSxZ7JGCqJKPGV9p0o6lWiV0uauUHaiV1Ca1d/o5/KphRFAxFL
jpXomYTIkzDb8+Q8oIQYgJpSl827y5P0MZFGUwZACdXHe1NmMu6t1jELiiecSYFf
eOxkMhm5fv58CrQATFyk
=6tOT
-----END PGP SIGNATURE-----

--kD5A6s5fH5u0LDZc--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
