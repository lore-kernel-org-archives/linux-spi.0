From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: Add DT bindings documentation for Netlogic XLP
 SPI controller
Date: Wed, 19 Aug 2015 10:53:04 -0700
Message-ID: <20150819175304.GX10748@sirena.org.uk>
References: <1439960957-4213-1-git-send-email-kamlakant.patel@broadcom.com>
 <1439960957-4213-3-git-send-email-kamlakant.patel@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OTt47QqKl/5Pp5g2"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1439960957-4213-3-git-send-email-kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--OTt47QqKl/5Pp5g2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 19, 2015 at 10:39:17AM +0530, kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org wrote:

> +- clock-frequency : [OPTIONAL] Input clock frequency to the SPI block in Hz.
> +		    Default is 133333333 Hz.

I would expect this to be specifying the input clock to the block via
the standard clock binding rather than just hard coding a number in
here.  This means the binding will continue to work for more complex
sysetems with programmable clocks and is generally more standard.  SoCs
can still specify hard coded fixed frequency clocks as fixed clocks in
the DT.

--OTt47QqKl/5Pp5g2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV1MJ/AAoJECTWi3JdVIfQ6iIH/A5Fi98MHWvf66zBxy5N8wzy
JXYuAXBEnCE+vThLsht6HHUH7ZVb4rHRcogMJu9Jxtlvqn8umC+GKm80Qk1S7JE9
DvzyN/APS9tKUTdG9QRAYdZU9kGVvt3gzXyLtNG8qI4ykgHtuKAIUuXz+AUf8z+b
kS5qfjOplDhxsBhScu+7GGB0254VuWp4jkyQrAAj/jWX9VKML6ED62WBclqFw73h
ZItybDN0gSp0c86gWb/qcY/aA4Wf/dWz650A99UEAW6TsyBX789WWd9XtanplcsF
e0ncb5j3hvbRN9p4bT04CIYZepEHFt9mgE6PVvCUXd8P2QjPV82s0Dtzf1QB6ug=
=ydVL
-----END PGP SIGNATURE-----

--OTt47QqKl/5Pp5g2--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
