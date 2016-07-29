From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH, V4, 2/5] spi: bcm-qspi: Add SPI flash and MSPI driver
Date: Fri, 29 Jul 2016 12:44:56 +0100
Message-ID: <20160729114456.GB10376@sirena.org.uk>
References: <20160701160753.GX6247@sirena.org.uk>
 <CAC=U0a3WN9TGw7zwwP3qFf5MUsRteUcVLytFgjnP4zScZS0xXA@mail.gmail.com>
 <20160713111053.GG9976@sirena.org.uk>
 <5786B401.2050306@gmail.com>
 <20160713223638.GI9976@sirena.org.uk>
 <578EA695.1030909@gmail.com>
 <20160720112547.GE6509@sirena.org.uk>
 <578FD3D7.9030402@gmail.com>
 <20160728182803.GI11806@sirena.org.uk>
 <e3a069ad-ca2b-7c12-bde1-5566f5fe24d3@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Cc: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Kamal Dasu <kamal.dasu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Vikram Prakash <vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Andy Fung <andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Yendapally Reddy Dhananjaya Reddy
	<yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e3a069ad-ca2b-7c12-bde1-5566f5fe24d3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 28, 2016 at 05:34:50PM -0700, Florian Fainelli wrote:
> On 07/28/2016 11:28 AM, Mark Brown wrote:

> > TBH if that's all it's doing then I'm surprised it's not simple to
> > handle it with irq_setup_generic_chip() - have you looked at that at
> > all?

> The generic IRQ chip model assumes that the mask/unmask/ack logic will
> operate against the same register base address, which won't be the case
> for the NS/NSP/NS2 platforms where the mask/unmask is in one register
> set (coined IDM), and the ack is in another one (actually 7 * 32-bits
> words).

I'd been thinking of just implementing an irqchip with no masking in it
- the source level masking isn't really a part of the irqchip itself
here any more than it is when it's a real irqchip that's attached.

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXm0G3AAoJECTWi3JdVIfQi2wH/03It1LWtXTbLQDo/K7/3uNh
04k6aT3skA0gSWV2t8qynLCvvADKhsLtOAJopk4EBNzmvI4bdnOWoFE4LABFN7l4
v+J3F07jjQgwMk80FO9BHRy3cQOhEVI3d+rzT5s15q5Jk4nLIxwUX8fOJL9+0XN8
PjH781w0jTvxboxz888Ssb4ns5g2GwFZabmRuKPEBFxkbjUKX7C/8O3LWvptorge
/UkRikAoGJIxOCOwC5SLHLgv+ptC/VSgRJVgdihA3G/n/eRUqJWt3khTT6LxMRGv
cAK21it7SLQ152+uo9BPvEoqbal0EefHovsX5qXo3LEgyL8uPW/cwWZxK0Vhmrw=
=9Xa5
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
