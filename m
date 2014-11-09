From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: meson: Add support for Amlogic Meson SPIFC
Date: Sun, 9 Nov 2014 10:17:12 +0000
Message-ID: <20141109101712.GM2722@sirena.org.uk>
References: <1415525113-25598-1-git-send-email-b.galvani@gmail.com>
 <1415525113-25598-3-git-send-email-b.galvani@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xtx0sNU5lZ46KfgK"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Jerry Cao <jerry.cao-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>,
	Victor Wan <victor.wan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
To: Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415525113-25598-3-git-send-email-b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--xtx0sNU5lZ46KfgK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 09, 2014 at 10:25:12AM +0100, Beniamino Galvani wrote:

> +static int meson_spifc_wait_ready(struct meson_spifc *spifc)
> +{
> +	unsigned long deadline = jiffies + msecs_to_jiffies(1000);
> +	u32 data;
> +
> +	do {
> +		regmap_read(spifc->regmap, REG_SLAVE, &data);
> +		if (data & SLAVE_TRST_DONE)
> +			return 0;
> +		cond_resched();
> +	} while (time_before(jiffies, deadline));

This will busy wait for up to a second, that seems like a long time to
busy wait.  We also appear to be using this for the entire duration of
the transfer which could be a fairly long time even during normal
operation if doing a large transfer such as a firmware download, or if
the bus speed is low.

> +	meson_spifc_setup_speed(spifc, xfer->speed_hz ? xfer->speed_hz :
> +				spi->max_speed_hz);
> +

Please avoid the ternery operator, it does nothing for legibility and in
this case it's not needed as the core will always ensure that there is a
per-transfer speed set.

> +	while (done < xfer->len && !ret) {
> +		len = min_t(int, xfer->len - done, SPIFC_BUFFER_SIZE);
> +		ret = meson_spifc_txrx(spifc, xfer, done, len,
> +				       last_xfer, done + len >= xfer->len);
> +		done += len;
> +	}

I noticed that the handling of /CS was done in the spifc_txrx() function
- will this do the right thing if the transfer needs to be split for the
buffer size?

> +	if (!ret && xfer->delay_usecs)
> +		udelay(xfer->delay_usecs);

The core will do this for you if you implement this as transfer_one().

> +static int meson_spifc_transfer_one_message(struct spi_master *master,
> +					    struct spi_message *msg)

This appears to do nothing that the core won't do - just implement
transfer_one() and remove this.

> +	spifc = spi_master_get_devdata(master);
> +	memset(spifc, 0, sizeof(struct meson_spifc));

There should be no need for this memset.

> +	spifc_regmap_config.max_register = resource_size(res) - 4;
> +	spifc_regmap_config.name = "amlogic,meson-spifc";

If you're dynamically initializing the structure you need to work with a
copy of it rather than directly since there may be multiple instances.
I'm not seeing a reason to override the regmap name here, this is only
really intended for devices with multiple register maps.

> +	ret = clk_prepare_enable(spifc->clk);
> +	if (ret) {
> +		dev_err(spifc->dev, "can't prepare clock\n");
> +		goto out_err;
> +	}

You should really implement runtime PM operations to disable this when
not in use and use auto_runtime_pm to make sure this happens.

> +	master->bus_num = pdev->id;

Leave this blank for DT only devices (and for non-DT devices this won't
work if you get two different buses).

--xtx0sNU5lZ46KfgK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUXz8nAAoJECTWi3JdVIfQ6uwH/iipw+JCAVDWomXsQxHD7y/m
G4yhQgLNoMR4sBTI+iSc9KeGONbTLagnAcjnwjpjT/Dm1wY6q3pj9lFvz5cf6UIX
XhLlI/moio0mtYlYYlEN54dn8Sm/29pvH2HRLibEdalY7QuK/3tEySvkj0BXNCpc
xKxVDyvZcnLFlO4Mrvwvp6CEkQGe2DqKnjcGJ/gAxsRiq9qydh3MpBAj99PWZK42
u1pb6YmuggL3fqhZvyoKyx5wrxEeV0kzpj0NHESSSEnFOjeV33JZusCziMRw+0rq
h8iHOMWtPc9w1NKjV0zNIK0IKzOQP56pYvEMvED+lj5EPdUVWMtr7vFy/F8VNHk=
=dTtp
-----END PGP SIGNATURE-----

--xtx0sNU5lZ46KfgK--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
