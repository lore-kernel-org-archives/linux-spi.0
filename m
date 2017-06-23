From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH][spi-next] spi: stm32: fix range limit checks on div
Date: Fri, 23 Jun 2017 12:11:17 +0100
Message-ID: <20170623111117.yj33dqr4eg4v43wt@sirena.org.uk>
References: <20170622154142.22481-1-colin.king@canonical.com>
 <0133c805-c919-f115-7c94-65d88bed8ca2@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cpbv432ypy7adrwo"
Cc: Colin King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>,
        Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Amelie DELAUNAY <amelie.delaunay-qxv4g6HH51o@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0133c805-c919-f115-7c94-65d88bed8ca2-qxv4g6HH51o@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--cpbv432ypy7adrwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 22, 2017 at 05:49:10PM +0200, Amelie DELAUNAY wrote:

> I'm preparing a v2 for the initial patchset introducing spi-stm32, if you
> agree, I can directly add your fix.

Please don't resubmit patches that have already been applied, you should
submit patches against current code in the tree you're expecting things
to be applied to.  If any updates are needed to a patch that's already
been applied you should submit incremental patches which make those
updates.  This avoids having to change published git commits which could
cause problems for people working against git.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--cpbv432ypy7adrwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllM91IACgkQJNaLcl1U
h9AMiwf/ZDVix5Gpa85aSIgX0I8O+40zuxf0t8oivixjWBUP1/2vUeQhlud/Hwm0
VawRNm6rsQ8GoZkF1ZVvGRjjTHyvchxXhvJtX4VjYbUtYq+13uecN+AM5STr4EtD
7Yb6BKhr9EBAtudQH4fBX9azEbEd7aNUYqcCXMeu7A6Ya7ES3B/Uzd1QtZUT4gYt
iCvROTsRi1EOa546UTVEKucf/YVJrgzMY2jQcCO5FTAug5AK7+h3sG3/OpzD+0B3
k/ALQPYLqjPGBNAxP1mRUXYp+vW08c55puiQZjHn23yf5eg4kZAvmP9AveuC9OpF
hMlplpuXv/joCslD9PEtdymaYhUvJg==
=diu2
-----END PGP SIGNATURE-----

--cpbv432ypy7adrwo--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
