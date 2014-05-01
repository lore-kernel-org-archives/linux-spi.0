From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: core: Don't destroy master queue if we fail to
 create it
Date: Thu, 1 May 2014 12:03:42 -0700
Message-ID: <20140501190342.GX3245@sirena.org.uk>
References: <1398966567-5182-1-git-send-email-broonie@kernel.org>
 <CAMuHMdXwX5He07h-peVPwgGYHUrPF5V7r9uH7s8BaaaFHMnQxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hTBKz6kaaD+o1h4U"
Cc: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linaro-kerne-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXwX5He07h-peVPwgGYHUrPF5V7r9uH7s8BaaaFHMnQxw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--hTBKz6kaaD+o1h4U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 01, 2014 at 08:55:42PM +0200, Geert Uytterhoeven wrote:
> On Thu, May 1, 2014 at 7:49 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > From: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

> > @@ -1162,6 +1161,7 @@ static int spi_master_initialize_queue(struct spi_master *master)
> >                 dev_err(&master->dev, "problem initializing queue\n");
> >                 goto err_init_queue;

> You can just "return ret;" here...

> >  err_start_queue:
> > -err_init_queue:
> >         spi_destroy_queue(master);
> > +err_init_queue:

> ... and kill the err_init_queue label.

Yeah, I know.  It's a stylistic thing - I tend to prefer to always use
labels if they're used at all in a function even if we could return
directly since it's more consistent.  Not that I'm 100% consistent about
that.

> Apart from that:
> Acked-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Thanks.

--hTBKz6kaaD+o1h4U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTYpqLAAoJELSic+t+oim9KOEP/0RBZ8Qf3r55rzueOPwyLYCf
Sq31iJTHr2XGluiD5lkRZQHmXnPOypM4hJJ1h0aAwN13v382y5t5BT8eIQilA+o2
PeQeG0g/VxZoINH0U1PVPGlU2fb7uF1JHfh6/XDuwXuVz8KnU7p1lQzx/ehG2/UN
tugZv8V1QGBUMPgG8kf498GddoChekvQ88G25/8YwnoSPdL2RqJFxqGC50EGja3l
2toYVzCnulR0x4uTk/CRXJb9mEDHk4fjo9DkcXDhClmWksB74qL7dWne4QAgtOqn
qjEzHbD9CH6wHJ63ZPukpFPGZ14/aXxR6JvYbSv06POMx5IdtXZmFSamq177pIN9
ZXanpl8WPSq3Yc3BIVh67qXlF9Gx/TMaqW+uIiJ0Xn3mYH6k6aSrfzMS9sUMCo3W
D39UmGBnVMWBykGNWzXtsX0ZXBkrfGm7MKCz4oUrCabF3ImjiQ0cDSl/JPPJzLG3
hfeeZIWFqVDO1/iQ4K8DOYJZgg6qGU9jBkrryFRucu6qp28BqOzLCJx2xgOKnmVW
woBLlUISPwIaSq64EoUIrLkIistjTvHg/g9vrNE2lRaNMyLXbBHgrxVasw2pHEPZ
2upIufjJUyT9EHoosFPgITNkdJofr6bQfjyW7xQ+vRULiK1NpzzMniSM45jpqqDw
Ovw+Tub6uYHjH0D1Mna7
=AcIB
-----END PGP SIGNATURE-----

--hTBKz6kaaD+o1h4U--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
