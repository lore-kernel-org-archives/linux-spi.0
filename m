From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH, V4, 2/5] spi: bcm-qspi: Add SPI flash and MSPI driver
Date: Thu, 28 Jul 2016 19:28:03 +0100
Message-ID: <20160728182803.GI11806@sirena.org.uk>
References: <20160622160726.GQ28202@sirena.org.uk>
 <CAKekbevYN3CLvqQs3stUXDFEMREMOJ0g4+w7Zsno1kV-ieYEiw@mail.gmail.com>
 <20160701160753.GX6247@sirena.org.uk>
 <CAC=U0a3WN9TGw7zwwP3qFf5MUsRteUcVLytFgjnP4zScZS0xXA@mail.gmail.com>
 <20160713111053.GG9976@sirena.org.uk>
 <5786B401.2050306@gmail.com>
 <20160713223638.GI9976@sirena.org.uk>
 <578EA695.1030909@gmail.com>
 <20160720112547.GE6509@sirena.org.uk>
 <578FD3D7.9030402@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ut0KX4oafLh8aNyr"
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
In-Reply-To: <578FD3D7.9030402-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Ut0KX4oafLh8aNyr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 20, 2016 at 12:41:11PM -0700, Florian Fainelli wrote:

> Now, as to whether it makes sense to model the IDM enable/disable
> (intr_regs resource) and the 7 32-bits interrupt status/acknowledge
> words at the end of the MSPI+BSPI block (intr_status_regs resource) as
> an interrupt controller makes sense or not, it is kind of hard to say,
> because really the IDM IO_CONTROL aggregates more than just interrupt
> enable/disable bits here, but the overall ownership of this IDM
> IO_CONTROL is clear and it belongs to the SPI function of the system.

TBH if that's all it's doing then I'm surprised it's not simple to
handle it with irq_setup_generic_chip() - have you looked at that at
all?

--Ut0KX4oafLh8aNyr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXmk6qAAoJECTWi3JdVIfQNzYH+wbVr6mDCsOwtQLPbg78ewlK
4tY/klJ92bQgS2FSYHbzFbk6GBrqj17IBFaBbqYU2snQCyrO3OpBl9ZZsYUfx9qu
RjFRYTKy6DomOEte+bJHl/lv6TvlQhM0oicWLuphq55rTDpupd0XCp6rHDq7rifR
humZ420mdBWQmCesoiw8gJ4dDrfdc9CKZ/HQl8GC9ZiVVbGVtzLbGmuiJFz60YGD
pdJWcZcqQR0O4GIpUyOUkCauSH9gczwo9WUquqwvKh+VsPKdKD8NQCX+LkQtWCQs
I6xMPHgQaZ3jZIpt546SKLrTKzLNj8rVd58PkyP0Txjsl7+f7Iq/EdUaHgJuBt4=
=vXn6
-----END PGP SIGNATURE-----

--Ut0KX4oafLh8aNyr--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
