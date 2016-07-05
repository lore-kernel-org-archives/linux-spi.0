From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 5/5] spi: s3c64xx: use unsigned type for fifo handling
 variables
Date: Tue, 5 Jul 2016 16:55:56 +0200
Message-ID: <20160705145556.GD6247@sirena.org.uk>
References: <1467081676-8442-1-git-send-email-andi.shyti@samsung.com>
 <1467081676-8442-6-git-send-email-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2W4Na7kn/Mq3HLmY"
Cc: Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
To: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1467081676-8442-6-git-send-email-andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--2W4Na7kn/Mq3HLmY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 28, 2016 at 11:41:15AM +0900, Andi Shyti wrote:
> The 'quirks' variable cannot ever be negative, therefore use u8
> instead of int. The 8 bit size is given from the fact that
> currently the quirks variable has very few statuses.
>=20
> The rx_lvl_offset and tx_st_done store shift values, so that u8
> is a proper size.
>=20
> fifo_lvl_mask stores a series of masks, to be in we will keep the
> 32 bit size.

What's the advantage of these changes?  This feels like microptimisation
of something that shouldn't be a big performance issue and it's not
always the case that the compiler does something more sensible with
smaller or unsigned types.  I'm not saying don't do it, I'm just saying
that it's not clear to me what the win is.

--2W4Na7kn/Mq3HLmY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXe8p7AAoJECTWi3JdVIfQUQMH/2i/+wOC+tAv38rAt4MWdG6E
oD7dzOgD64VKpejv3yuNWDyLZhMiTeN8S8SBIDYYB7wfydMDhKtYgR2OWSyBvPJh
cf8cHzIMlTx/EEEMYrMRJZi6sm+ZwQ4g4cF2i5tkVT8X+zfhQ6Cq+HYbM83MYT7n
wCPNzfB8cSgzNOEw4O8yY4HMIgGB5DNIzINQ5w8SlazAB68wQgrSjoc3smWHl7lS
fwLR4FNiec3AVqC/70jDWCvI/PGaJEi7rtZx+IboAm5CST05IESPkYowHA6kIP+L
BvcVf65amIBXl5UtWxWa6EWP9OmC6TnVtS44DyU7pvTGlp8SxDWDW6M+Cwpei9A=
=xArA
-----END PGP SIGNATURE-----

--2W4Na7kn/Mq3HLmY--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
