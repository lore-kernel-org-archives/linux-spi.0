From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Fix hung task timeout when initialization fails
Date: Thu, 1 May 2014 09:09:21 -0700
Message-ID: <20140501160921.GB3245@sirena.org.uk>
References: <1398932115-11646-1-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XoSOsMJQ8mz74oyx"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1398932115-11646-1-git-send-email-ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--XoSOsMJQ8mz74oyx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 01, 2014 at 10:15:15AM +0200, Ricardo Ribalda Delgado wrote:

> If kthread_run on spi_init_queue() fails, spi_destroy_queue can lead to
> hang timeout.

...

> When this happens, spi_destroy_queue() leads to a hung process that
> outputs a error message and avoids the computer to be halted/rebooted.

Why is the fix for this not to avoid running spi_destroy_queue() in the
first place?  I would not in general expect it to be robust to call the
destructor function if the init function failed (and indeed this looks
like what's happening with the kthread code here) - even if it works now
it seems like it will be a source of bugs in the future.

> -	flush_kthread_worker(&master->kworker);
> -	kthread_stop(master->kworker_task);
> +	if (!IS_ERR(master->kworker_task)) {
> +		flush_kthread_worker(&master->kworker);
> +		kthread_stop(master->kworker_task);
> +	}

This still just looks like a race condition.

--XoSOsMJQ8mz74oyx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTYnGuAAoJELSic+t+oim9FZoQAI2KyjLFaH8IBaptkuI/EK6s
/wr/8FyjEe+igVVnrGlZPNuJ92aJlKqOck/KaQocDfS+5CigXLwsgDUSi7R2tjXl
OjXCdbgzlQyQDJHTxk9v4UNHAZEeH0MVq9znvAag4f2/xj2Tws8I3hcovvJ3Iev7
pIAHWrBTvxQW6+fM2nh8BdbwpM63KC36EiovOItDXT/2Iurk6WFbnK9s1WdfFTyb
T0RUSyrXGiknRqB9deeYyPSMJHdlHIIIaeH/thoYtoWrUpJ+fJrFUZpAHHKbSEwb
ruBFrSucVdrCMVV5+tVI+6YtpZyvfYnB0zNdZw6q6BXL2M9DvjGYUR3Ulz+cPrKh
jVqNVEZzDlba06YwfxWmXweEdJZNC/d8Yte3KTFyXsOIlnCvuOgM+qlxEOgOQDl8
dJnhRJqZDAQ8bDCGguvpzEkHkTYvGBpxXL8dZnNRnPacfNE8bIJDX2vNQVjeLAw5
txO3nU1uX4HWqctepx9LtD6CZlkl2yRgMaUUnIws7IrTske2jq3lneCwjqpyuA3K
X+y9MbvpwIRmXYwTs0kwwK3LybZzoAN4QVA4MfV9cgzgHZyDaZ/wT6LXHOsZtVFh
v+RZ/aedV+33zlcUPn/+tRDEq3gJHHeRro+sYNs2MdbUVGX5pVklib3zdEWlzPtr
uqvNj/78mOfP9k9/h/yF
=FuJj
-----END PGP SIGNATURE-----

--XoSOsMJQ8mz74oyx--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
