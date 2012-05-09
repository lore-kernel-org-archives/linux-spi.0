From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 06/10] ARM: Samsung: Modify
 s3c64xx_spi{0|1|2}_set_platdata function
Date: Wed, 9 May 2012 15:33:30 +0100
Message-ID: <20120509143330.GV3955@opensource.wolfsonmicro.com>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
 <1336514694-22393-7-git-send-email-thomas.abraham@linaro.org>
 <20120509085617.GB28702@sirena.org.uk>
 <201205091110.15224.heiko@sntech.de>
 <20120509105500.GG3955@opensource.wolfsonmicro.com>
 <CAJuYYwSMant-44jvvyeefojmur7vCvKLeEPWEK52pqUTB4RZkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v7CWsE/Dy737oYst"
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org, kgene.kim@samsung.com,
	rob.herring@calxeda.com, grant.likely@secretlab.ca,
	jaswinder.singh@linaro.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJuYYwSMant-44jvvyeefojmur7vCvKLeEPWEK52pqUTB4RZkg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--v7CWsE/Dy737oYst
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2012 at 10:22:26PM +0800, Thomas Abraham wrote:
> On 9 May 2012 18:55, Mark Brown <broonie@opensource.wolfsonmicro.com> wro=
te:

> > Yes, that's the normal way of handling this and is actually what the
> > code was originally doing - there's a bunch of ifdefed devices in
> > plat-samsung/devs.c. =A0You usually have to do this anyway as the IPs m=
ove
> > about so the resources need changing.

> In addition to the setting the name, the platform data is also
> assigned at runtime. Adding multiple platform devices means that we
> add lot more code in setting up the platform data. And since we are
> moving towards adopting dt, these would anyway go away when we have
> all the platforms migrated to dt.

With your refactoring the only platform data that's left is the /CS?

--v7CWsE/Dy737oYst
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqoAyAAoJEBus8iNuMP3dnO4P/iT/FTw6s57ac46JucJ1IExP
TgXjJz+/fmZrlA/XBAGSCcSlA7iB4Zqi036f6u4kUBxYqzJXN34fuSvJwo7hzWwS
8r/hAvMwv4xhkoIXgLlv93RYT5q2TlZSCF/7Ykn2I7do39lF53KM19c+zrapmTUe
rNjToVGXbAnzxC1JkfsGDftoyM/Z6t+w/wFIZZXyd1D/U+hxKN3tkyahCz7vjQGA
avMyIoNQQwnT2+r8n2HgoCA1SOqpxoVTCzfTgH9iTa673Qwd4j2Q6YFA39cxRAjV
mAmxn5vmXggF3e5t/8AvJyfQxjcoPXDSZnr1RNjjXk4P+VpnYwf4xEO3OJf37+E/
CIuDiL0hFIYXyaX9s4uKRmK7+A9l5GrwxZnk/Yt2HtQyJDRcjDAiEuhG2mnJ4iMj
hXCBEFOtGaPLAhvwGyRJNoI5WhKOHc+s7jiyYj+b+u/b15/yGNWD+xMQjrdJW2XY
8doPbzgxmPP2lu3hpsb3KOokWHe/ZsXbIhgguI/nIwgDYyW73jydMWYFZRDhVJge
szV3DJ3xLLiDKNwwBocQDhFfvFtKTJ0hjK5US8EWoVLa2Ax6Uq5B8b6jIrJDPAHv
OdQRiiEuIXxreZqJeIi3Sjyt5B1wLihoPlyEYiW18S9fVmE7/B1IQOnK5omYhjSm
mYr0H15fPA3Axi0wUm+v
=nj9K
-----END PGP SIGNATURE-----

--v7CWsE/Dy737oYst--
