From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] spi: rockchip: add debug interface support
Date: Mon, 15 Feb 2016 17:26:32 +0000
Message-ID: <20160215172632.GQ18988@sirena.org.uk>
References: <1455524848-2646-1-git-send-email-shawn.lin@rock-chips.com>
 <1455524902-2780-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rUztinBX/EQDJOOk"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455524902-2780-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--rUztinBX/EQDJOOk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 15, 2016 at 04:28:22PM +0800, Shawn Lin wrote:

> +#ifdef CONFIG_DEBUG_FS
> +#include <linux/debugfs.h>
> +#endif

Just include the header.  Only add ifdefs if they do something.

> +static int rockchip_spi_debugfs_init(struct rockchip_spi *rs)
> +{
> +	rs->debugfs = debugfs_create_dir("rockchip_spi", NULL);
> +	if (!rs->debugfs)
> +		return -ENOMEM;
> +
> +	debugfs_create_file("regs", S_IFREG | S_IRUGO,
> +		rs->debugfs, (void *)rs, &rockchip_spi_dbg_ops);
> +	return 0;
> +}

This is completely separate to the core debugfs support for SPI, if
we're adding new debugfs stuff that's per device we should be extending
the core debugfs stuff so everything is in one place.

Your register dump stuff looks like you might want to consider using
regmap, it's got this and other register access diagnostics already.

--rUztinBX/EQDJOOk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWwgpHAAoJECTWi3JdVIfQgq4H/in00Ld6JFx7n2LUDtuXZVyW
qAumqHhgv0ncwn14U6DSOKJTswu+nOrNTZ9XQ2L8xVYz4+7Gg5fr/7Vsm+M8We02
L/mfkJLz/e2RMDpPuxVPz9r6QWSRU18KHVEO8jls1ovhNSgB4BSJ7UEIbFaPERVz
sqqsVSRvRfxelZwjTeh0w7gEGb7ujQRhQOxdYgj1x0q+nYHCwkF38gSnGTL/IvOt
I2still+0WUcm5Cv7QnJH1AsFMURvYmmOuXHCmqQmrcr6a2GOVoMGwxGMUVD8W7G
qNmVE4Nfa0XRvCvIVtE6vdwAtOmBFVfZ9//5whEI8exNplibBlreuiG5Z1XvejI=
=tZsL
-----END PGP SIGNATURE-----

--rUztinBX/EQDJOOk--
