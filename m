From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: remove redundant put_device
Date: Wed, 17 Jul 2019 12:11:36 +0100
Message-ID: <20190717111136.GB4459@sirena.org.uk>
References: <1563357944-24496-1-git-send-email-dingxiang@cmss.chinamobile.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Ding Xiang <dingxiang@cmss.chinamobile.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1563357944-24496-1-git-send-email-dingxiang@cmss.chinamobile.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 17, 2019 at 06:05:44PM +0800, Ding Xiang wrote:

> device_unregister will call put_device,
> so remove the redundant put_device

>  	child = device_find_child(&ctlr->dev, NULL, match_true);
> -	if (child) {
> +	if (child)
>  		/* Remove registered slave */
>  		device_unregister(child);
> -		put_device(child);
> -	}

That's to undo the extra get we have from device_find_child(),
not to undo part of the registration.

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0vAmgACgkQJNaLcl1U
h9BxeQgAgRydnwPM775pyEWvHZVBMnZKxO5KnJ44V8lw2qXRKK9Kz8z973ADoIWS
31b8shX3Ei9CHkC9eW334ha2stXGD316psiHzeo/7TAS/0VW88XfQ1c9Htn2rT1S
VmED80yhjqttGATYKeXSApnG5GFtM8geQ/hINWrtRc15RV/1z9ng/2gs5XURVfcC
y6DrZoYmOEywyA1NtsdTmUhh31cmovlwaGDWgaekIY/ZmSWF95al9jMLzJiL8V1W
BJNswwTcrlF93GvIddxA/LqjMe1/8xck6gik4y18Npw2qbnpqFpu6yujgOowmBW8
SuB872plg39gO2fiYBRLl2ytmx6P1Q==
=/MxI
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
