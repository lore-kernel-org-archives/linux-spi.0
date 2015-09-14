From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: omap2-mcspi: Add calls for pinctrl state select
Date: Mon, 14 Sep 2015 17:10:43 +0100
Message-ID: <20150914161042.GV12027@sirena.org.uk>
References: <1431519316-30989-1-git-send-email-pascal.huerst@gmail.com>
 <20150513181536.GI2761@sirena.org.uk>
 <5559D4BC.6010606@gmail.com>
 <20150519121225.GM2761@sirena.org.uk>
 <5576CB11.7010905@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tcashZ9KqMwsKqGW"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pascal Huerst <pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5576CB11.7010905-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--tcashZ9KqMwsKqGW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2015 at 01:16:33PM +0200, Pascal Huerst wrote:
> On 19.05.2015 14:12, Mark Brown wrote:
> > On Mon, May 18, 2015 at 02:02:04PM +0200, Pascal Huerst wrote:
> >> On 13.05.2015 20:15, Mark Brown wrote:

> >>> We should still be checking if we succesfully changed the state when
> >>> there is a state provided shouldn't we?

> >> I agree, but if I git grep for such calls, nobody seems to check the
> >> return values of these functions. Shall I add a check and print a
> >> message if the call fails?

> > Yes, please.

> Sorry for the late reply.

> There is already a message printed on failure in the subsystem. See:
> http://lxr.free-electrons.com/source/drivers/pinctrl/core.c#L1250

> So I don't see the need for another message, right?

I was expecting to see us pass back an error code more than just
printing an error message.

--tcashZ9KqMwsKqGW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV9vGCAAoJECTWi3JdVIfQotgH/iNNIFh8JFL3+VryAuNh0nXb
3wpm852OOs4cTcb23m/AbYPZvdAipzV64j01sP+yK6CfCUXNg3UGbY/wRW+Pd9i6
FbZ0C9D2l1F5KByEFmtToLkePZtGpLq5tA7U1PE7Z48nuOIdwlFRMPYHXUlzUqJy
1UV8acuurEG8H7ZJoBN3J8BO/LNoz/wUFaOSIA+xQinGUhqkoG1W2nHkVtG5NqC9
1ov7wChZMb3n7XK2a/IAMsBbvxjQy5nhUiD1buI05YEsAmrPW7DRAB3jMEDGdBA0
QQDQn2oQUETc4KDmDBrsN3icr8+WKhrw6rD/NXqy27BpYDwQ4D+uAx1k6mFft3w=
=qQgA
-----END PGP SIGNATURE-----

--tcashZ9KqMwsKqGW--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
