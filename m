From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2 1/3] bindings: spi: Add devicetree binding for
 spi-xilinx
Date: Thu, 17 Mar 2016 16:46:04 +0000
Message-ID: <20160317164604.GI2566@sirena.org.uk>
References: <1457513242-11202-1-git-send-email-shubhraj@xilinx.com>
 <20160310033027.GJ3898@sirena.org.uk>
 <20160317164321.GB8920@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DHioQtdaSVZskSfq"
Cc: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160317164321.GB8920@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--DHioQtdaSVZskSfq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 17, 2016 at 11:43:21AM -0500, Rob Herring wrote:
> On Thu, Mar 10, 2016 at 10:30:27AM +0700, Mark Brown wrote:

> > Please use subject lines matching the style for the subsystem.

> You are wanting "spi: ..."? This is bindings though and my preference=20
> would be "dt-bindings: spi: "... That said, I don't really try to=20
> enforce anything given bindings currently get merged thru many trees.

Yes, given that they go in with the driver I'd expect them to match the
style for the driver (the bulk of changes do do that).

--DHioQtdaSVZskSfq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW6t9KAAoJECTWi3JdVIfQPGcH/1KeeZLtHQKFIf2KXD0YqGJp
uhiicIGyVarO++Qd+WcypLaTV3eLF1vQ7f0JoeF8iwKRyi2wKvOFIvn6ZwkVYHC2
FfAjno3jZ4vqy7WEADZ7a8tP5ghNCn/xe/PM4C7p1jiYiQe9QY9sKWjyprCsKkIi
iefcykRESLzI0Lr2yFhA7pnMIX3n10c6dHkN2FJVDZkOmIDksUQqq1nvmz5alAnH
7JnhWVAmWzyD++7YNGp1pWBjOA71fKdnuBFCYR4LnMPiTknTfmIggOWGFqOR+ATn
v+2jO7IC17fHAzeWpM8sCfDXu/Ye3aPZeLD/8ZeRDNEyHYP8qf7xadkC5u1O4ss=
=UNJ8
-----END PGP SIGNATURE-----

--DHioQtdaSVZskSfq--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
