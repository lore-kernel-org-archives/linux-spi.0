From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1] eSPI: add Aspeed AST2500 eSPI driver to boot a host
 with PCH runs on eSPI
Date: Wed, 3 Jan 2018 11:38:05 +0000
Message-ID: <20180103113805.GD5603@sirena.org.uk>
References: <1514512387-27113-1-git-send-email-haiyue.wang@linux.intel.com>
 <CAK8P3a2nZzc22FgupGjGeS7uQkrxH_W7=T7m_foejDMHtp70_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eheScQNz3K90DVRs"
Cc: Haiyue Wang <haiyue.wang-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>,
        gregkh <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a2nZzc22FgupGjGeS7uQkrxH_W7=T7m_foejDMHtp70_w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--eheScQNz3K90DVRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 31, 2017 at 12:10:51AM +0100, Arnd Bergmann wrote:
> On Fri, Dec 29, 2017 at 2:53 AM, Haiyue Wang
> <haiyue.wang-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> > When PCH works under eSPI mode, the PMC (Power Management Controller) in
> > PCH is waiting for SUS_ACK from BMC after it alerts SUS_WARN. It is in
> > dead loop if no SUS_ACK assert. This is the basic requirement for the B=
MC
> > works as eSPI slave.
> >
> > Also for the host power on / off actions, from BMC side, the following =
VW
> > (Virtual Wire) messages are done in firmware:
> > 1. SLAVE_BOOT_LOAD_DONE / SLAVE_BOOT_LOAD_STATUS
> > 2. SUS_ACK
> > 3. OOB_RESET_ACK
> > 4. HOST_RESET_ACK
>=20
> I have not looked at the driver contents yet, but I'm adding the SPI
> maintainer and
> mailing list to Cc here for further discussion. Can you clarify how

More generally:

As documented in SubmittingPatches please send patches to the=20
maintainers for the code you would like to change.  The normal kernel
workflow is that people apply patches from their inboxes, if they aren't
copied they are likely to not see the patch at all and it is much more
difficult to apply patches.

--eheScQNz3K90DVRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpMwJwACgkQJNaLcl1U
h9CrnQf8CWd6/GS0V9kEscGKec5RhPtDOeRrIFgcY9THNJfr0WBSQIt66sbX3wzD
25yjcVmri/OY/K/e74fBV0nfxe3b/HvM9XP6Fydl9K2pfQP+W27zOfD1xEBRvyRu
walIWrQdxWcngdgWIl7hf5zvHPwjvFqyWgYheagJv9D3zMPivU0HZrmVfIpudusL
bWqvxNKGidw8py9X7l30zoLma/nDk3TejdoFrP0Q9jSlXIVc8dlOPI3Xu56RJMSD
Q7niM77VPS7E0YHt3vml5hpA/zkT8Z17CZ83frVEG6GuLmxCKV9OPN0ct8qB8G4c
TC3vxGcLpZgE+LUQNDi17IToRYHrLA==
=FPZL
-----END PGP SIGNATURE-----

--eheScQNz3K90DVRs--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
