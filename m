From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC] Remove "spi-cs-high" property for GPIO-based
 chipselects
Date: Mon, 2 Dec 2013 12:33:39 +0000
Message-ID: <20131202123339.GZ27568@sirena.org.uk>
References: <1385884756-31373-1-git-send-email-shc_work@mail.ru>
 <20131202114310.GP27568@sirena.org.uk>
 <1385985513.987194654@f113.i.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4tkssvp36SW1tyIS"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385985513.987194654-zxFGIbyeZotsdVUOrk1QfQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--4tkssvp36SW1tyIS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 02, 2013 at 03:58:33PM +0400, Alexander Shiyan wrote:

> Old method still remains (especially for integrated CS), we just warn the
> GPIO-CS users that it is better to use GPIO-bindings.
> Code is constructed so that there is no incompatibility between the
> use of old and new methods.

My point is that I don't think it's especially useful to deprecate the
existing method - telling people that they are using a deprecated
method is a kind of incompatibility and it suggests an intention to
remove in the future.

--4tkssvp36SW1tyIS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnH4gAAoJELSic+t+oim9nQIP+gP8CHH+TCivM2jG6JDVynTb
VUGG6BOAGAaAx2c48fvkKiDqSYgzk3LkxwY4AWDC6cR/rYgGLTC2ZPMgCkYF8CaZ
59GN0gKRejPtvwTbS0FNoBbyl9184MqmFYFcWQjaW4f9LaC7/OGTZ9qf5cM8qOxL
s4NoXVCJMANF/mhjeNiWD8XZZ3b+TEsdDQnczPspwzCrrb7wOA7uOlbPtwAD9zoH
evy0Ty/6k45/AZ+7qgALC4jdjKu2SjShaEs+yQ+vxvnRKaDgkVk/V0uBymNrUpE5
c0Fxs9xiNSOy9i0o/JDJ0S/Io3nkXMkWFzW7O5/I1F846gbAOVkM/q0C9IoLRV+w
k8KL90pVnYg++0sq+R3+AAJi97jcs1HewIhYGN2ulNj+LM/SQM+KcxNMALEONnEh
C9q6GGc2sxA8p/CRiOk4vIvNVphAJvcEGm8F/TYSRFMPw5FcUFoLb4JkmnznSRhr
mlf2Jt0PPF2+lRJuJoPf/5Vll/MJHHYNj61LNVITe3BPBXAbB5j8d23Af5UPe/q0
oTwawF7mohKtWAbxrpaaZlIO05uf+v0tYGT09A7jzY0c/rQgcqg/v3O5y14NGJuR
cIRMvv1K8pYXfRlvng1EDUqHuSOpIrgh811Wbi9eBgHOJu4ve5rxjvdFmv6D7x/W
NAatMjWxs67yGv1LMQ0o
=J4Th
-----END PGP SIGNATURE-----

--4tkssvp36SW1tyIS--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
