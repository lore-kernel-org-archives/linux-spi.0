From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] spi: add check_finished() callback
Date: Tue, 10 Jan 2017 12:34:29 +0000
Message-ID: <20170110123429.t6vsyqtnavranbdn@sirena.org.uk>
References: <20161211200350.13590-1-hauke@hauke-m.de>
 <20161211200350.13590-2-hauke@hauke-m.de>
 <20161214152156.uehjhqoxpng47pnh@sirena.org.uk>
 <7b420e94-3c33-3304-f7a0-ed87c8db425a@hauke-m.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7hxnjv2sglapeioi"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, daniel.schwierzeck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, nbd-Vt+b4OUoWG0@public.gmane.org
To: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7b420e94-3c33-3304-f7a0-ed87c8db425a-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--7hxnjv2sglapeioi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 17, 2016 at 11:16:17PM +0100, Hauke Mehrtens wrote:
> On 12/14/2016 04:21 PM, Mark Brown wrote:

> > Why not just have your interrupt handler schedule something on a
> > workqueue to check whatever it is needs checking here?

> 2. When something went wrong and I got an error IRQ for example, I would
> like to add this information to the spi message that was transfered, but
> the only way I see it to not wake the completion and let it run into a
> timeout.

Just set an error status in the message and then complete the current
transfer or the message.

> I would like to have a function in which I can do some busy waiting till
> the last word is really written to the wire and also return if the
> transfer was successful or what error occurred.

The busy waiting really is pretty specialist.

--7hxnjv2sglapeioi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlh01NQACgkQJNaLcl1U
h9B49Af+Mr2mqyTqlWpPYWOaAk4COkcvbQ7WFN9Of3MAqBKshkfoz4O6lECz6Syx
qr3FURIpP+W8JyrVkDdSIb/GCUmEPq7PftPjxbwnI/YDLmaXIsiZqDXb3KhcL6LI
iQNmYthFktrrHxR/RXMZ1bxaDncE1/5WGP3JXxTGpSCiudtHgggpeLaSLXSpOgOW
cYdEzESgCB9/rewvlgQ3Sj/eRbXwN3EFVahg8GCiWZYqanJkbUzoYUqJosDOtjfX
uNzBbkEHv51Fas2fSS+Da2BWdp1Xkn7BYg9IMQHkoAp0qE0T6e/X16H9T+ryPKjS
LHg8CgrEdEHoVCEcRtDQTxOtAebVHw==
=XOMG
-----END PGP SIGNATURE-----

--7hxnjv2sglapeioi--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
