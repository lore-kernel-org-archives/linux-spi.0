From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spi: race in spi_finalize_current_message starting
 queue_kthread_work before the message is unmapped
Date: Tue, 12 May 2015 17:50:53 +0100
Message-ID: <20150512165053.GE3066@sirena.org.uk>
References: <8C375B28-1C09-4545-8A5B-78F6CD04102F@martin.sperl.org>
 <20150508221309.GK2761@sirena.org.uk>
 <352560EA-A323-449B-8F37-6066328D2081@martin.sperl.org>
 <20150511180016.GU3458@sirena.org.uk>
 <8F4019F0-7C56-4C9C-9193-A2A23B533165@martin.sperl.org>
 <20150512102034.GM2761@sirena.org.uk>
 <5551ECF9.1050006@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gMR3gsNFwZpnI/Ts"
Cc: linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5551ECF9.1050006-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--gMR3gsNFwZpnI/Ts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2015 at 02:07:21PM +0200, Martin Sperl wrote:
> On 2015-05-12 12:20, Mark Brown wrote:

> >We essentially have that; anything looking at a DMA mapped transfer had
> >better cope.

> I believe you miss my point:

No, I don't.

> a) with SPI_MASTER_MUST_ we will always allocate the buffer - we do not

In the current implementation, we can always change that in the future.

> And inside __spi_map_msg we can just add some code to create the simple
> scatter-gather mapping using a single preallocated page - so something
> along the lines (assuming that either tx_buf or rx_buf must be set):

Yes, to repeat what I said earlier I'm hoping someone with a need for
this will implement it.

> So the extra flag seems to be to be a "safer" approach and it also
> states more explicitly the needs of the driver.

I think it's easier to either have drivers handle scatterlists or not
rely on the flags for PIO and work harder if the code is looking
complicated.

--gMR3gsNFwZpnI/Ts
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUi9tAAoJECTWi3JdVIfQ4I0H/3AdFtLBRsqkvmYhbJFlj3ib
mhSvCqa+UWiKt1lkt7cRQVjUZHnfX00OlSPwP3QctVLPVkCy3uwZB5swI0nzoY8a
w5Q5d1siPewftQO1nLsh3Jw7RYaBE/2KJoVniwYJpIvmPPbyAh2T0P2n3sVXo1m5
96lzE164tVJdDgL7ot56XudSmD6CJBsV2hhBmxJSTW59jI2SIr2VRaodDpNFFjdg
1/OaEGJbNKNieY0tIBt/XsZpUnmbEjFG/wd3JcLfWG+t8/SqkVdlu1VzM63gR2EA
sWMz8rLrzAHfTZ36pricNl4IAisiik416xkItLCiZE5u3k7bGdLRRLA2cagWcd4=
=V0T3
-----END PGP SIGNATURE-----

--gMR3gsNFwZpnI/Ts--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
