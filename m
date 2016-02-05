From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] SPI/ACPI: DesignWare: Add ACPI support for
 Designware SPI driver
Date: Fri, 5 Feb 2016 11:09:00 +0000
Message-ID: <20160205110900.GA12311@sirena.org.uk>
References: <1454656280-130658-1-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Cc: linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	haifeng.wei@huawei.com, charles.chenxin@huawei.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>
To: qiujiang <qiujiang@huawei.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454656280-130658-1-git-send-email-qiujiang@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 05, 2016 at 03:11:20PM +0800, qiujiang wrote:

> This patch added ACPI support for DesignWare SPI mmio driver. It
> was based the corresponding DT driver and compatible for this two
> way. This patch has been tested on Hisilicon D02 board. It relies
> on the GPIO patchset.

Intel are heavy users of this driver on their systems which also use
ACPI.  Have you discussed this binding with them?  I've copied Andy and
Jarkko who've worked on the driver recently.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

> +	char propname[32];

That's a magic number, where did it come from and why is it a magic
nummber?

> +	if (ACPI_COMPANION(&pdev->dev)) {
> +		for (i = 0; i < dws->num_cs; i++) {
> +			snprintf(propname, sizeof(propname), "cs%d", i);
> +			gpiod = devm_gpiod_get(&pdev->dev,
> +				propname, GPIOD_ASIS);
> +			if (IS_ERR(gpiod)) {
> +				dev_err(&pdev->dev, "Get gpio desc failed!\n");
> +				return PTR_ERR(gpiod);
> +			}
> +		}
> +	}

I'm not seeing anywhere where we store the GPIO in this loop.  It is
therefore unclear to me how the chip select is going to work?

> +static const struct acpi_device_id dw_spi_mmio_acpi_match[] = {
> +		{"HISI0171", 0},
> +		{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, dw_spi_mmio_acpi_match);

I really do wish ACPI had some more sensible system for allocating
device IDs so the tables were a little more legible. :(

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWtIKFAAoJECTWi3JdVIfQYZAH/RyCpp8PpxOlLXbbQlhRxvhZ
w9Fzv2PtxBzLgkbM54/t0qqCUhe2iEdKKrqK6J5uNujhAOTmHlY25ZshArCMsXB1
vAFF2Vh0e2RurXg1v69jRZA0dshoE7rzJDE+/g20wvx4EEg4jLP7pv6QwN68xFP4
I44MHTc8UIwckSQCdVegV8fscqKXQly8g4ZctiCtXjYg67alNlbbVG5dHEGASbbE
1wnKqIK4KeSA69vBtYwCIi2JQb6Ksp09G5ERU+8UD3AFOiDIe/gsLSMoKrWRlE2E
Ey5a1ekVRQyQSLvhQzkBddWi6CbKv7zyy5VjZj81sJMDdakttUIY+xaujgI3iaM=
=wY7W
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
