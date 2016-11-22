From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [Patch V3 2/2] spi: imx: add lpspi bus driver
Date: Tue, 22 Nov 2016 19:13:08 +0000
Message-ID: <20161122191308.uuuiea54oi65jbu4@sirena.org.uk>
References: <1479822737-8170-1-git-send-email-pandy.gao@nxp.com>
 <1479822737-8170-2-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2be5mmjh5t243ldd"
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, frank.li-3arQi8VN3Tc@public.gmane.org,
        fugang.duan-3arQi8VN3Tc@public.gmane.org
To: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1479822737-8170-2-git-send-email-pandy.gao-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--2be5mmjh5t243ldd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 22, 2016 at 09:52:17PM +0800, Gao Pan wrote:
> This patch adds lpspi driver to support new i.MX products which use
> lpspi instead of ecspi.

I'll apply this but there's some small issues, can you please fix them
up with incremental patches:

> +static int fsl_lpspi_prepare_message(struct spi_master *master,
> +				     struct spi_message *msg)
> +{
> +	struct fsl_lpspi_data *fsl_lpspi = spi_master_get_devdata(master);
> +
> +	return clk_prepare_enable(fsl_lpspi->clk);
> +}

Rather than doing this per message it's a bit better to do it in
prepare_transfer_hardware(), that way if there's a sequence of messages
queued one after another we don't turn the clock on and off all the
time.  In practice it's likely to make a negligable difference to
performance but it's just better practice.

> +static int fsl_lpspi_txfifo_empty(struct fsl_lpspi_data *fsl_lpspi)
> +{
> +	u32 txcnt;
> +	unsigned long orig_jiffies = jiffies;
> +
> +	do {
> +		txcnt = readl(fsl_lpspi->base + IMX7ULP_FSR) & 0xff;
> +
> +		if (time_after(jiffies, orig_jiffies + msecs_to_jiffies(500))) {
> +			dev_dbg(fsl_lpspi->dev, "txfifo empty timeout\n");
> +			return -ETIMEDOUT;
> +		}
> +		schedule();

Call cond_resched() instead, it has the effect you're looking for in a
more modern way.

--2be5mmjh5t243ldd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYNJjDAAoJECTWi3JdVIfQ4UAH/1TEqtktxzQcZVbWzpFFtdKd
7ePK8AQf1lJY+iAvULTHW42me/MeIToxcbYOWiA74kzwXYXChpOH05gnQA5R6czh
G/dSuQ1BbHV0X2nVvWHCNC633iG5B82bt3YE7gM4JgKLsVu9Boh8VZQQmTCJzwOK
Nh+HiMkHE+AYHHjJaU53DeMlCSaVv0iFFP6vmx52vDbrZ2Z02KvuNG9GNl0OrFha
s79298DGq8eqpucgDSgXtEi1V5sdvCC2/RwuULwapy/7ZGjtVkfNZxRUQZ98C/Fw
Cja4I9I7yzf37oIAEPpRypWAt09+byO9LlZhEt8VvYAIXXG54EW6riSQ/K517Q4=
=l1DY
-----END PGP SIGNATURE-----

--2be5mmjh5t243ldd--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
