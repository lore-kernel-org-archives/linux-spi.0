From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 06/12] spi: spi-fsl-dspi: Replace interruptible wait
 queue with a simple completion
Date: Mon, 16 Mar 2020 12:49:45 +0000
Message-ID: <20200316124945.GF5010@sirena.org.uk>
References: <20200314224340.1544-1-olteanv@gmail.com>
 <20200314224340.1544-7-olteanv@gmail.com>
 <20200316122613.GE5010@sirena.org.uk>
 <CA+h21hqRV+HmAz4QGyH9ZtcFWzeCKczitcn+mfTdwAC7ZobdDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w3uUfsyyY1Pqa/ej"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Esben Haabendal <eha-/iRVSOupHO4@public.gmane.org>,
        angelo-BIYBQhTR83Y@public.gmane.org, andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        "Gustavo A. R. Silva" <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>,
        Wei Chen <weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mohamed Hosny <mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
        Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>, peng.ma-3arQi8VN3Tc@public.gmane.org
To: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+h21hqRV+HmAz4QGyH9ZtcFWzeCKczitcn+mfTdwAC7ZobdDw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--w3uUfsyyY1Pqa/ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2020 at 02:29:09PM +0200, Vladimir Oltean wrote:

> Correct, the real problem is that I forgot to add a Fixes: tag for
> patch 5. I'll do that now.

OK.  The series otherwise looked fine but I'll wait for testing.
Michael, if there's issues remaining it might be good to get some
Tested-bys for the patches prior to whatever's broken so we can get
those fixes in (but obviously verifying that is work so only if you=20
have time).

--w3uUfsyyY1Pqa/ej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5vdekACgkQJNaLcl1U
h9AveQf+LOqJCuZK/In2NusDJBny94rpuyf/MG3uFk4SGh94eJKbw08H9ChimU5Q
c+Coa95XkLCJzoVX6rdw1yjTgAP0n/YfaG3R4rTr24IfwqmZ/ggVl5WVQfdGTk2+
AZKXqBmHiNgK7zizWDT6cH+1fMWbLoJS2mAz3imnwdpiLypTai/zwvb5SH6N0oyS
FhIshW56cRhYj8UNpxwUm7Zr5C8L41rb4Isda5R3fUzaXwT20DdJ3tpYgsaL0NtE
FkEvdxQjg4o3ssNJ15Mdt4yRGHEXVH7cnguTLZhqOogdWLs6NXvPjwtGJt0WVH24
vudvOfP8tvVP1BjdzkMaPg3Go3Y/Jw==
=NXWG
-----END PGP SIGNATURE-----

--w3uUfsyyY1Pqa/ej--
