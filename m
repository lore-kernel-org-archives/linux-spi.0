From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: spi-geni-qcom: Speculative fix of "nobody cared"
 about interrupt
Date: Tue, 17 Mar 2020 12:10:18 +0000
Message-ID: <20200317121018.GB3971@sirena.org.uk>
References: <20200316151939.1.I752ebdcfd5e8bf0de06d66e767b8974932b3620e@changeid>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Cc: Alok Chauhan <alokc@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>, skakit@codeaurora.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200316151939.1.I752ebdcfd5e8bf0de06d66e767b8974932b3620e@changeid>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 16, 2020 at 03:20:01PM -0700, Douglas Anderson wrote:

> +	/*
> +	 * We don't expect to hit this, but if we do we should try our best
> +	 * to clear the interrupts and return so we don't just get called
> +	 * again.
> +	 */
> +	if (mas->cur_mcmd == CMD_NONE)
> +		goto exit;
> +

Does this mean that there was an actual concrete message of type
CMD_NONE or does it mean that there was no message waiting?  If there
was no message then isn't the interrupt spurious?

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5wvikACgkQJNaLcl1U
h9CCWAf+NrJf9Q2fJM35MGcoGUs8HYyVUL+NopJOwpbgEbzsTaDN+rMUwFyy9/3t
EKFyp3Im6x70GXrpQHs5emVrYuNt8oDcn0CDY29pXq8qGuCkAFnlMufGj4dfrQA6
/XQD0gIuvduh6qKndbhRVeVUFdiTyKKeqiCim4eAld/CTfIyyulDPo6KEVVHYt4X
kJG/dz10WQ8oyRBckFTD1HtTPsA7TJT34V2ll71CvJcmCWZRAwLzmD9MbZRTdrv+
J3IHwcyJp9XSTIaSBJhxizMzdz4BH4fhLSR/yQDBruEFZIzbTBskk2QOJ77qZG8k
w0I9PWvjgN5EGCRPLk4M+HgIHbJTfw==
=eX8I
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
