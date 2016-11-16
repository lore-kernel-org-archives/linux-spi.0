From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [Patch V2 1/2] spi: imx: add lpspi bus driver
Date: Wed, 16 Nov 2016 17:32:28 +0000
Message-ID: <20161116173228.cqtt5j5eczgg26gn@sirena.org.uk>
References: <1479216831-8709-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wc4vnbob4tertehs"
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, frank.li-3arQi8VN3Tc@public.gmane.org,
        fugang.duan-3arQi8VN3Tc@public.gmane.org
To: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1479216831-8709-1-git-send-email-pandy.gao-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--wc4vnbob4tertehs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 15, 2016 at 09:33:50PM +0800, Gao Pan wrote:

> +static int
> +fsl_lpspi_prepare_message(struct spi_master *master, struct spi_message *msg)
> +{
> +	struct fsl_lpspi_data *fsl_lpspi = spi_master_get_devdata(master);
> +
> +	return clk_enable(fsl_lpspi->clk);
> +}

Why are we not also unpreparing the clock when the driver is idle?

> +static void fsl_lpspi_copy_to_buf(struct spi_message *m,
> +					struct fsl_lpspi_data *fsl_lpspi)
> +{
> +	struct spi_transfer *t;
> +	u8 *buf = fsl_lpspi->local_buf;
> +
> +	list_for_each_entry(t, &m->transfers, transfer_list) {
> +		if (t->tx_buf)
> +			memcpy(buf, t->tx_buf, t->len);
> +		else
> +			memset(buf, 0, t->len);
> +		buf += t->len;
> +	}
> +}

Why are we doing this linearization into a single buffer?

> +static int fsl_lpspi_check_message(struct spi_message *m)
> +{

If there's any checks in here that aren't done by the core then extend
the core to support them (or drop them).

> +static int fsl_lpspi_transfer_one_msg(struct spi_master *master,
> +					struct spi_message *m)
> +{

Why are we doing transfer_one_msg() and not transfer_one()?

> +	m->actual_length = ret ? 0 : trans.len;

Please write normal if statements, people should be able to read the
code.

> +out:
> +	if (m->status == -EINPROGRESS)
> +		m->status = ret;

Why not for other errors?

--wc4vnbob4tertehs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYLJgrAAoJECTWi3JdVIfQ/h8H/2KzfQOMwhkICxRS7yhHFBRa
J0SbmNJdbPmyxiKM4Xq9NNM7HUjmQcEBDJ3Ii7QfTwrvJJkE/w7kxXZvc6jV0mpP
UD+8i4uEhTKJnRevtKGxZiRT0IbunxPtpPfBq4hcgtmjlAt2kOpmoNNUJ6YnqhZV
OnlX3PT2AKCcO+TKPusnswovtL54DAZleL917bkcH+E7UQJO8j9tId2OoVtdosns
L6EYlV/3Ya2CeKx4vw7gxUpKTH6HWfmU/fU5iWmlkJ9AURWK48WnPzp1M0bYhS62
efYhAK8/NXtmjduBvI3qth4E386Hcbi/tRlHsKBV1cbGnx9LWlJvDUdU0xK8Sn4=
=uMgA
-----END PGP SIGNATURE-----

--wc4vnbob4tertehs--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
