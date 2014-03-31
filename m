From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFT] spi: mpc512x-psc: Refactor to use core message
 parsing
Date: Mon, 31 Mar 2014 10:41:32 +0100
Message-ID: <20140331094132.GK2269@sirena.org.uk>
References: <1395932757.17331.1.camel@phoenix>
 <20140327172416.GW3998@book.gsilab.sittig.org>
 <20140327182049.GT30768@sirena.org.uk>
 <20140329141851.GB2775@book.gsilab.sittig.org>
 <20140331075403.GF2775@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z+vV71AWp02Mr0PV"
Cc: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140331075403.GF2775-kDjWylLy9wD0K7fsECOQyeGNnDKD8DIp@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Z+vV71AWp02Mr0PV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 31, 2014 at 09:54:03AM +0200, Gerhard Sittig wrote:

> No progress here.

> Eyeballing the code reveals that there is a 50 times 10-100us
> retry loop at the end of a transfer, waiting for RX to complete
> after TX has drained.  Instrumenting the code shows that the loop
> is run one or two times at most (longer timeouts are required for
> lower SPI wire speeds).  So I still can't see what might take
> several milliseconds.

Can you identify where in the code the delay is occurring (tracepoints
are often good for that) or is it just generally slower?

--Z+vV71AWp02Mr0PV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTOThJAAoJELSic+t+oim9pl4P/ifBBzBHEsDM2UsTTCHUecwn
LdXsBnSg2fUUgcH/cFngjOYe6uZdNLdsKZB69LlsUFa6IPfXBawbcs60kJh9YEaO
MWrIhJVzCNhGlaWpoxyMyyab9R7t0WxdFn0ZQNYzIbwLCG7Rx0aM/JO9NPQf/h9G
oD8sYobtmVQglSHgEygKVEcsNS770w7DUjnWZ3/mCA+vSDs0Z6jnATr+nA7l6Xao
qOl5g/Nfk92cgF6aMC1F4CR3q0jgWKcFkzpv5S0/2veAmStMRIe7NrBCq17l6qQq
mWM+WHtXekHTWJy764pwwZJkhe+OJpx4n16jOREOGJWuytRyifDnfekm14XeP8zR
Fl/WlyMJPwl9hNGdXCRIRqRRuFRfkWcnXuq6MgXshGEHAv6JPzZ/L6eKbYN7xTc8
lw0OlnH9mqH0yuW2WXuaj4K3fV6Q/5Td91XQI2Kc8tkDQ10Efj+CcUOL1CWMMt6W
WMq75aHRmjHJo3hB0uZ8tRnzxXHNHOAOyhRkEDO1aahhfT5sOSv3eDg+UWsmo1ZD
v/9F6keQ0eOW5836SrUxNPKtYe6IBKr4W5cxG3DiRdafxSK8c66BjjHx3JdNn9aa
nQ9Bvm6L6yCffySc08WBg/acQzpx1poUUaD0mhXRSjoF+7kagUjRZh7M4nLZxUnQ
SthHc8/2L1aKk08HTyEy
=tMkK
-----END PGP SIGNATURE-----

--Z+vV71AWp02Mr0PV--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
